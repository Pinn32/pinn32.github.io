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
--   bullet starting "Mon D · "                        -> grouped under one date label
-- headers without those attributes pass through untouched
--
-- the source markdown is chronological (old -> new); the filter renders
-- newest-first by default, each phase wrapped in <section class="cl-phase-group">,
-- and emits an order-toggle button + script that reverses the DOM on click

local function inlines_to_html(inl)
    return pandoc.write(pandoc.Pandoc({pandoc.Plain(inl)}), 'html',
        pandoc.WriterOptions({ wrap_text = 'none' })):gsub('%s+$', '')
end

-- format numbers like %g ("8" not "8.0", "7.75" stays)
local function fmt(n)
    return string.format('%g', n)
end

local ORDER_SCRIPT = [[
<script>
  (() => {
    const btn = document.querySelector('.cl-order-btn');
    const tl  = document.querySelector('.cl-timeline');
    if (!btn || !tl) return;
    btn.addEventListener('click', () => {
      // reverse group order, and card order within each group (pill stays first)
      Array.from(tl.querySelectorAll('.cl-phase-group')).reverse().forEach(group => {
        Array.from(group.querySelectorAll('details.cl-item')).reverse()
          .forEach(item => group.appendChild(item));
        tl.appendChild(group);
      });
      // reassign left/right alternation in display order, restarting per phase
      tl.querySelectorAll('.cl-phase-group').forEach(group => {
        let side = 'cl-left';
        group.querySelectorAll('details.cl-item').forEach(item => {
          item.classList.remove('cl-left', 'cl-right');
          item.classList.add(side);
          side = (side === 'cl-left') ? 'cl-right' : 'cl-left';
        });
      });
      const newest = btn.dataset.order !== 'newest';
      btn.dataset.order = newest ? 'newest' : 'oldest';
      btn.innerHTML = newest ? '&#8595; newest first' : '&#8593; oldest first';
    });
  })();
</script>
]]

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
    -- Parse: state machine over the flat block list,
    -- collecting phases and their entries as data
    --------------------------------------------------

    local out = pandoc.List()   -- blocks before the timeline
    local tail = pandoc.List()  -- non-timeline blocks found after it starts
                                -- (e.g. Quarto's hidden support divs)
    local started = false
    local phases = {}           -- { pill = html|nil, entries = { {head, body} } }
    local entry = nil           -- open entry being collected
    local totals = { commits = 0, hours = 0, days = 0 }

    local function current_phase()
        if #phases == 0 then
            table.insert(phases, { pill = nil, entries = {} })
        end
        return phases[#phases]
    end

    local function close_entry()
        if not entry then return end
        if not entry.has_summary then
            entry.head = entry.head .. entry.meta
        end
        table.insert(current_phase().entries, entry)
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
            table.insert(phases, {
                pill =
                    '<div class="cl-phase"><span class="cl-phase-pill">' ..
                    '<span class="cl-phase-name">' .. inlines_to_html(blk.content) .. '</span>' ..
                    '<span class="cl-phase-range">' .. blk.attr.attributes['range'] .. '</span>' ..
                    '</span></div>',
                entries = {},
            })

        elseif is_entry then
            started = true
            close_entry()
            local a = blk.attr.attributes
            local commits = tonumber(a['commits']) or 0
            local hours   = tonumber(a['hours']) or 0
            totals.commits = totals.commits + commits
            totals.hours   = totals.hours + hours
            totals.days    = totals.days + (tonumber(a['days']) or 0)
            local unit = (commits == 1) and ' commit' or ' commits'
            entry = {
                head =
                    '<time class="cl-date" datetime="' .. (a['iso'] or '') .. '">' ..
                    a['date'] .. '</time>' ..
                    '<span class="cl-title">' .. inlines_to_html(blk.content) .. '</span>',
                meta =
                    '<span class="cl-meta">' .. fmt(commits) .. unit ..
                    ' &middot; ' .. fmt(hours) .. ' h</span>',
                body = nil,
                has_summary = false,
            }

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
            -- group consecutive same-day bullets under one date label
            local parts = {}
            local plain = {}                 -- undated items before any day group
            local cur_date, cur_items = nil, {}

            local function flush_plain()
                if #plain > 0 then
                    table.insert(parts, '<ul>' .. table.concat(plain) .. '</ul>')
                    plain = {}
                end
            end
            local function flush_day()
                if cur_date then
                    table.insert(parts,
                        '<div class="cl-day"><span class="cl-d">' .. cur_date ..
                        '</span><ul>' .. table.concat(cur_items) .. '</ul></div>')
                    cur_date, cur_items = nil, {}
                end
            end

            for _, item in ipairs(blk.content) do
                local item_html = inlines_to_html(pandoc.utils.blocks_to_inlines(item))
                local d, rest = item_html:match('^(%a%a%a %d%d?) · (.*)$')
                if d then
                    flush_plain()
                    if d ~= cur_date then
                        flush_day()
                        cur_date, cur_items = d, {}
                    end
                    table.insert(cur_items, '<li>' .. rest .. '</li>')
                elseif cur_date then
                    -- undated bullet inside a day group: continuation
                    table.insert(cur_items, '<li>' .. item_html .. '</li>')
                else
                    table.insert(plain, '<li>' .. item_html .. '</li>')
                end
            end
            flush_plain()
            flush_day()
            entry.body = table.concat(parts)
            close_entry()

        elseif not started then
            out:insert(blk)

        else
            tail:insert(blk)
        end
    end

    close_entry()

    --------------------------------------------------
    -- Assemble newest-first: phases reversed, entries
    -- reversed within each phase, sides in display order
    --------------------------------------------------

    local html = {}
    for pi = #phases, 1, -1 do
        local ph = phases[pi]
        table.insert(html, '<section class="cl-phase-group">')
        if ph.pill then table.insert(html, ph.pill) end
        local side = 'cl-left'
        for ei = #ph.entries, 1, -1 do
            local e = ph.entries[ei]
            table.insert(html,
                '<details class="cl-item ' .. side .. '">' ..
                '<summary class="cl-head">' .. e.head ..
                '<span class="cl-chevron" aria-hidden="true"></span></summary>')
            if e.body then
                table.insert(html, '<div class="cl-body">' .. e.body .. '</div>')
            end
            table.insert(html, '</details>')
            side = (side == 'cl-left') and 'cl-right' or 'cl-left'
        end
        table.insert(html, '</section>')
    end

    local stats =
        '<p class="cl-stats">' ..
        fmt(totals.days) .. ' work days &middot; ' ..
        fmt(totals.commits) .. ' commits &middot; ' ..
        fmt(math.floor(totals.hours + 0.5)) .. ' hours logged</p>'

    local order_btn =
        '<div class="cl-order"><button type="button" class="cl-order-btn"' ..
        ' data-order="newest">&#8595; newest first</button></div>'

    out:insert(pandoc.RawBlock('html',
        stats .. order_btn ..
        '<div class="cl-timeline">' .. table.concat(html) .. '</div>' ..
        ORDER_SCRIPT))
    out:extend(tail)

    doc.blocks = out
    return doc

end
