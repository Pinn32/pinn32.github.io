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

-- bullet tag prefixes ("feat: ...") grouped for coloring (see changes.css)
local TAG_CLASS = {
    contnt = 'content', proj = 'content', blg = 'content',
    tool = 'content', hobb = 'content', ttl = 'content',
    feat = 'feat',
    dev = 'dev', fix = 'dev', style = 'dev', script = 'dev',
}

local function colorize_tag(html)
    local tag, rest = html:match('^(%a+):%s*(.*)$')
    local cls = tag and TAG_CLASS[tag:lower()]
    if not cls then return html end
    return '<span class="cl-tag cl-tag-' .. cls .. '">' .. tag .. ':</span> ' .. rest
end

--------------------------------------------------
-- Daily activity heatmap (calendar grid above the
-- stats line; per-day data derived from the same
-- Notion-synced attributes the cards use)
--------------------------------------------------

local MONTHS = {
    jan = 1, feb = 2, mar = 3, apr = 4,  may = 5,  jun = 6,
    jul = 7, aug = 8, sep = 9, oct = 10, nov = 11, dec = 12,
}

local function iso_to_ts(iso)
    local y, m, d = iso:match('^(%d+)-(%d+)-(%d+)$')
    if not y then return nil end
    return os.time({ year = tonumber(y), month = tonumber(m),
                     day = tonumber(d), hour = 12 })
end

-- "Mar 31" + the entry's iso date -> "2026-03-31" (year taken from iso,
-- bumped when the label month wrapped past December)
local function label_to_iso(label, iso)
    local mon, day = label:match('^(%a+) (%d+)$')
    local m = mon and MONTHS[mon:lower()]
    local y, im = iso:match('^(%d+)-(%d+)')
    if not (m and y) then return nil end
    y = tonumber(y)
    if m < tonumber(im) - 6 then y = y + 1 end
    return string.format('%04d-%02d-%02d', y, m, tonumber(day))
end

local DAY = 86400

-- daily: iso date -> { entries, commits, hours, approx }
local function build_heatmap(daily)
    local dates = {}
    for k in pairs(daily) do table.insert(dates, k) end
    if #dates == 0 then return '' end
    table.sort(dates)
    local first = iso_to_ts(dates[1])
    local last  = iso_to_ts(dates[#dates])
    if not (first and last) then return '' end

    -- back up to the Monday of the first week; columns are weeks Mon->Sun
    local dow = (os.date('*t', first).wday + 5) % 7   -- 0=Mon .. 6=Sun
    local start = first - dow * DAY
    local weeks = math.floor((last - start) / (7 * DAY)) + 1

    local max = { commits = 0, hours = 0, entries = 0 }
    for _, v in pairs(daily) do
        for k in pairs(max) do
            if v[k] > max[k] then max[k] = v[k] end
        end
    end
    local function level(v, m)
        if v <= 0 or m <= 0 then return 0 end
        return math.min(4, math.max(1, math.ceil(v / m * 4)))
    end
    local function round(v, mult)
        return math.floor(v * mult + 0.5) / mult
    end

    local cells, months = {}, {}
    local prev_month, last_label_col
    local ts, col = start, 0
    while ts <= last do
        local t = os.date('*t', ts)
        if (t.wday + 5) % 7 == 0 then
            col = col + 1
            local mon = os.date('%b', ts)
            if mon ~= prev_month then
                -- a label needs ~3 columns of room; drop the cramped one
                if last_label_col and col - last_label_col < 3 then
                    table.remove(months)
                end
                table.insert(months,
                    '<span style="grid-column:' .. col .. '">' .. mon .. '</span>')
                prev_month, last_label_col = mon, col
            end
        end
        if ts < first then
            table.insert(cells, '<span class="cl-hm-pad"></span>')
        else
            local label = os.date('%b', ts) .. ' ' .. t.day
            local v = daily[os.date('%Y-%m-%d', ts)]
            if v then
                local approx = v.approx and '~' or ''
                local e = math.floor(v.entries + 0.5)
                local c = math.floor(v.commits + 0.5)
                local tip = string.format('%s · %d %s · %s%d %s · %s%s h',
                    label, e, e == 1 and 'entry' or 'entries',
                    approx, c, c == 1 and 'commit' or 'commits',
                    approx, fmt(round(v.hours, 10)))
                table.insert(cells, string.format(
                    '<button type="button" class="cl-hm-cell" data-level="%d"' ..
                    ' data-c="%s" data-h="%s" data-e="%d"' ..
                    ' data-tip="%s" aria-label="%s"></button>',
                    level(v.commits, max.commits),
                    fmt(round(v.commits, 100)), fmt(round(v.hours, 100)), e,
                    tip, tip))
            else
                table.insert(cells,
                    '<span class="cl-hm-cell" data-level="0" data-c="0"' ..
                    ' data-h="0" data-e="0" data-tip="' .. label ..
                    ' · no activity"></span>')
            end
        end
        ts = ts + DAY
    end

    return table.concat({
        '<section class="cl-heatmap" aria-label="Daily activity heat map"',
        ' style="--hm-weeks:', weeks, '">',
        '<div class="cl-hm-top">',
        '<span class="cl-hm-title">daily activity</span>',
        '<div class="cl-hm-toggle" role="group" aria-label="Heatmap metric">',
        '<button type="button" class="cl-hm-btn" data-metric="c" aria-pressed="true">commits</button>',
        '<button type="button" class="cl-hm-btn" data-metric="h" aria-pressed="false">hours</button>',
        '<button type="button" class="cl-hm-btn" data-metric="e" aria-pressed="false">entries</button>',
        '</div></div>',
        '<div class="cl-hm-scroll"><div class="cl-hm-grid">',
        '<div class="cl-hm-months" aria-hidden="true">', table.concat(months), '</div>',
        '<div class="cl-hm-wdays" aria-hidden="true"><span>Mon</span><span>Wed</span><span>Fri</span></div>',
        '<div class="cl-hm-cells">', table.concat(cells), '</div>',
        '</div></div>',
        '<div class="cl-hm-legend" aria-hidden="true"><span>less</span>',
        '<span class="cl-hm-cell" data-level="0"></span>',
        '<span class="cl-hm-cell" data-level="1"></span>',
        '<span class="cl-hm-cell" data-level="2"></span>',
        '<span class="cl-hm-cell" data-level="3"></span>',
        '<span class="cl-hm-cell" data-level="4"></span>',
        '<span>more</span></div>',
        '<div class="cl-hm-tip" role="tooltip" hidden></div>',
        '</section>',
    })
end

local HEATMAP_SCRIPT = [[
<script>
  (() => {
    const hm = document.querySelector('.cl-heatmap');
    if (!hm) return;
    const cells = Array.from(hm.querySelectorAll('.cl-hm-cells .cl-hm-cell'));
    const tip = hm.querySelector('.cl-hm-tip');

    // metric toggle: recompute quartile levels from the cells' data attributes
    hm.querySelectorAll('.cl-hm-btn').forEach(btn => {
      btn.addEventListener('click', () => {
        hm.querySelectorAll('.cl-hm-btn').forEach(b =>
          b.setAttribute('aria-pressed', String(b === btn)));
        const k = btn.dataset.metric;
        const max = cells.reduce((m, c) => Math.max(m, +c.dataset[k] || 0), 0);
        cells.forEach(c => {
          const v = +c.dataset[k] || 0;
          c.dataset.level = (v <= 0 || max <= 0) ? 0
            : Math.min(4, Math.max(1, Math.ceil(v / max * 4)));
        });
      });
    });

    // one shared tooltip, shown above the hovered/focused cell
    const show = (cell) => {
      tip.textContent = cell.dataset.tip || '';
      tip.hidden = false;
      const hr = hm.getBoundingClientRect();
      const cr = cell.getBoundingClientRect();
      const x = cr.left - hr.left + cr.width / 2 - tip.offsetWidth / 2;
      tip.style.left = Math.max(0, Math.min(x, hr.width - tip.offsetWidth)) + 'px';
      tip.style.top = (cr.top - hr.top - tip.offsetHeight - 7) + 'px';
    };
    const hide = () => { tip.hidden = true; };
    cells.forEach(c => {
      c.addEventListener('pointerenter', () => show(c));
      c.addEventListener('pointerleave', hide);
      c.addEventListener('focus', () => show(c));
      c.addEventListener('blur', hide);
    });
  })();
</script>
]]

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
    local daily = {}            -- iso date -> { entries, commits, hours, approx }

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
        -- fold the entry into the per-day heatmap data: bullet counts are
        -- exact per day; commits/hours are the entry's totals, split across
        -- its days by bullet share (approx marks multi-day splits)
        if entry.iso and entry.iso ~= '' then
            local total, ndays = 0, 0
            for _, n in pairs(entry.day_counts) do
                total = total + n
                ndays = ndays + 1
            end
            local approx = ndays > 1
            local function add(key, n, share)
                local d = daily[key] or
                    { entries = 0, commits = 0, hours = 0, approx = false }
                d.entries = d.entries + n
                d.commits = d.commits + entry.commits * share
                d.hours   = d.hours   + entry.hours * share
                d.approx  = d.approx or approx
                daily[key] = d
            end
            if total > 0 then
                for key, n in pairs(entry.day_counts) do
                    add(key, n, n / total)
                end
            else
                add(entry.iso, 0, 1)
            end
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
                iso = a['iso'] or '',
                commits = commits,
                hours = hours,
                day_counts = {},    -- iso date -> bullet count
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

            local function count_day(key)
                if key then
                    entry.day_counts[key] = (entry.day_counts[key] or 0) + 1
                end
            end

            local cur_key = nil
            for _, item in ipairs(blk.content) do
                local item_html = inlines_to_html(pandoc.utils.blocks_to_inlines(item))
                local d, rest = item_html:match('^(%a%a%a %d%d?) · (.*)$')
                if d then
                    flush_plain()
                    if d ~= cur_date then
                        flush_day()
                        cur_date, cur_items = d, {}
                        cur_key = entry.iso ~= '' and label_to_iso(d, entry.iso) or nil
                    end
                    count_day(cur_key)
                    table.insert(cur_items, '<li>' .. colorize_tag(rest) .. '</li>')
                elseif cur_date then
                    -- undated bullet inside a day group: continuation
                    count_day(cur_key)
                    table.insert(cur_items, '<li>' .. colorize_tag(item_html) .. '</li>')
                else
                    count_day(entry.iso ~= '' and entry.iso or nil)
                    table.insert(plain, '<li>' .. colorize_tag(item_html) .. '</li>')
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
        build_heatmap(daily) .. stats .. order_btn ..
        '<div class="cl-timeline">' .. table.concat(html) .. '</div>' ..
        ORDER_SCRIPT .. HEATMAP_SCRIPT))
    out:extend(tail)

    doc.blocks = out
    return doc

end
