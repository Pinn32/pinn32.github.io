-- changelog-timeline.lua
-- transforms conventional markdown into the change-log timeline HTML
-- (classes styled by en/changes/changes.css)
-- only runs when changelog-timeline: true is set in metadata
--
-- convention (see en/changes/_timeline.md, generated from Notion):
--   ## Phase name {range="Mar 31 - Apr 4"}            -> phase pill on the spine
--   ### Entry title {date=".." iso=".." commits=".." hours=".." days=".."}
--                                                     -> clickable card
--   first Para after an entry header                  -> card summary
--   first BulletList after an entry header            -> expandable detail list
--   bullet starting "Mon D · "                        -> day prefix span (.cl-d)
-- headers without those attributes pass through untouched

local function inlines_to_html(inl)
    return pandoc.write(pandoc.Pandoc({pandoc.Plain(inl)}), 'html',
        pandoc.WriterOptions({ wrap_text = 'none' })):gsub('%s+$', '')
end

-- format numbers like %g ("8" not "8.0", "7.75" stays)
local function fmt(n)
    return string.format('%g', n)
end

function Pandoc(doc)

    if not doc.meta['changelog-timeline'] then return doc end

    --------------------------------------------------
    -- Flatten section Divs (defensive: harmless when
    -- headers arrive at the top level already)
    --------------------------------------------------

    local blocks = pandoc.List()
    local function flatten(bs)
        for _, b in ipairs(bs) do
            if b.t == 'Div' and b.classes:includes('section') then
                flatten(b.content)
            else
                blocks:insert(b)
            end
        end
    end
    flatten(doc.blocks)

    --------------------------------------------------
    -- State machine over the flat block list
    --------------------------------------------------

    local out = pandoc.List()   -- blocks before the timeline
    local tail = pandoc.List()  -- non-timeline blocks found after it starts
                                -- (e.g. Quarto's hidden support divs)
    local html = {}             -- timeline HTML buffer
    local started = false
    local side = 'cl-left'
    local entry = nil           -- open entry: {head=..., summary=..., body=...}
    local totals = { commits = 0, hours = 0, days = 0 }

    local function close_entry()
        if not entry then return end
        if not entry.has_summary then
            entry.head = entry.head .. entry.meta
        end
        table.insert(html, '<details class="cl-item ' .. entry.side .. '">')
        table.insert(html, '<summary class="cl-head">')
        table.insert(html, entry.head)
        table.insert(html, '<span class="cl-chevron" aria-hidden="true"></span>')
        table.insert(html, '</summary>')
        if entry.body then
            table.insert(html, '<div class="cl-body">')
            table.insert(html, entry.body)
            table.insert(html, '</div>')
        end
        table.insert(html, '</details>')
        entry = nil
    end

    for _, blk in ipairs(blocks) do
        local is_phase = blk.t == 'Header' and blk.level == 2
            and blk.attr.attributes['range']
        local is_entry = blk.t == 'Header' and blk.level == 3
            and blk.attr.attributes['date']

        if is_phase then
            started = true
            close_entry()
            side = 'cl-left'
            table.insert(html,
                '<div class="cl-phase"><span class="cl-phase-pill">' ..
                '<span class="cl-phase-name">' .. inlines_to_html(blk.content) .. '</span>' ..
                '<span class="cl-phase-range">' .. blk.attr.attributes['range'] .. '</span>' ..
                '</span></div>')

        elseif is_entry then
            close_entry()
            local a = blk.attr.attributes
            local commits = tonumber(a['commits']) or 0
            local hours   = tonumber(a['hours']) or 0
            totals.commits = totals.commits + commits
            totals.hours   = totals.hours + hours
            totals.days    = totals.days + (tonumber(a['days']) or 0)
            local unit = (commits == 1) and ' commit' or ' commits'
            entry = {
                side = side,
                head =
                    '<time class="cl-date" datetime="' .. (a['iso'] or '') .. '">' ..
                    a['date'] .. '</time>' ..
                    '<span class="cl-title">' .. inlines_to_html(blk.content) .. '</span>',
                body = nil,
                has_summary = false,
            }
            side = (side == 'cl-left') and 'cl-right' or 'cl-left'
            entry.meta =
                '<span class="cl-meta">' .. fmt(commits) .. unit ..
                ' &middot; ' .. fmt(hours) .. ' h</span>'

        elseif entry and blk.t == 'Para' and not entry.has_summary then
            entry.has_summary = true
            entry.head = entry.head ..
                '<p class="cl-summary">' .. inlines_to_html(blk.content) .. '</p>' ..
                entry.meta

        elseif entry and blk.t == 'BulletList' then
            -- entries without a summary still need their meta line
            if not entry.has_summary then
                entry.head = entry.head .. entry.meta
                entry.has_summary = true
            end
            local items = {}
            for _, item in ipairs(blk.content) do
                local item_html = inlines_to_html(pandoc.utils.blocks_to_inlines(item))
                local d, rest = item_html:match('^(%a%a%a %d%d?) · (.*)$')
                if d then
                    table.insert(items,
                        '<li><span class="cl-d">' .. d .. '</span> ' .. rest .. '</li>')
                else
                    table.insert(items, '<li>' .. item_html .. '</li>')
                end
            end
            entry.body = '<ul>' .. table.concat(items) .. '</ul>'
            close_entry()

        elseif not started then
            out:insert(blk)

        else
            tail:insert(blk)
        end
    end

    close_entry()

    --------------------------------------------------
    -- Assemble: stats line + timeline wrapper
    --------------------------------------------------

    local stats =
        '<p class="cl-stats">' ..
        fmt(totals.days) .. ' work days &middot; ' ..
        fmt(totals.commits) .. ' commits &middot; ' ..
        fmt(math.floor(totals.hours + 0.5)) .. ' hours logged</p>'

    out:insert(pandoc.RawBlock('html',
        stats .. '<div class="cl-timeline">' .. table.concat(html) .. '</div>'))
    out:extend(tail)

    doc.blocks = out
    return doc

end
