-- subtitle-typing.lua
-- Allow page subtitles to be either a string or a list.
--
-- A normal string remains Quarto's static subtitle. A multiline string, or a
-- list, is normalized to its first non-empty item for the HTML/no-JavaScript
-- fallback, while all lines are serialized for the global typewriter script.

local function split_lines(text)
  local lines = {}

  for line in text:gmatch("[^\r\n]+") do
    line = line:gsub("^%s+", ""):gsub("%s+$", "")
    if line ~= "" then
      table.insert(lines, line)
    end
  end

  return lines
end

local function trim(text)
  return text:gsub("^%s+", ""):gsub("%s+$", "")
end

local function subtitle_lines(value)
  local lines = {}
  local fallback = nil

  for _, item in ipairs(value) do
    local text = pandoc.utils.stringify(item)

    text = trim(text)

    if text ~= "" then
      table.insert(lines, text)
      fallback = fallback or item
    end
  end

  return lines, fallback
end

local function inline_lines(value)
  local lines = {}
  local current = ""

  for _, item in ipairs(value) do
    local item_type = item.t

    if item_type == "SoftBreak" or item_type == "LineBreak" then
      current = trim(current)
      if current ~= "" then
        table.insert(lines, current)
      end
      current = ""
    else
      current = current .. pandoc.utils.stringify(item)
    end
  end

  current = trim(current)
  if current ~= "" then
    table.insert(lines, current)
  end

  return lines
end

local function script_safe_json(value)
  return quarto.json.encode(value)
    :gsub("<", "\\u003c")
    :gsub(">", "\\u003e")
    :gsub("&", "\\u0026")
end

function Pandoc(doc)
  local subtitle = doc.meta.subtitle

  if not subtitle then
    return doc
  end

  local lines
  local fallback

  if pandoc.utils.type(subtitle) == "List" then
    lines, fallback = subtitle_lines(subtitle)
  elseif pandoc.utils.type(subtitle) == "Inlines" then
    lines = inline_lines(subtitle)
    fallback = lines[1]
  else
    local text = pandoc.utils.stringify(subtitle)
    lines = split_lines(text)
    fallback = lines[1]
  end

  if #lines == 0 then
    doc.meta.subtitle = nil
    return doc
  end

  if #lines < 2 then
    return doc
  end

  -- Quarto's title template expects one inline value, not a MetaList.
  doc.meta.subtitle = fallback

  if #lines > 1 and FORMAT:match("html") then
    local payload = '<script type="application/json" id="subtitle-typing-lines">' ..
      script_safe_json(lines) ..
      '</script>'

    doc.blocks:insert(pandoc.RawBlock("html", payload))
  end

  return doc
end
