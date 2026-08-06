-- subtitle-typing.lua
-- Allow page subtitles to be either a string or a list.
--
-- A string remains Quarto's normal static subtitle. A list is normalized to
-- its first non-empty item for the HTML/no-JavaScript fallback, while the full
-- list is serialized for the global typewriter script.

local function subtitle_lines(value)
  local lines = {}
  local fallback = nil

  for _, item in ipairs(value) do
    local text = pandoc.utils.stringify(item)

    if text ~= "" then
      table.insert(lines, text)
      fallback = fallback or item
    end
  end

  return lines, fallback
end

local function script_safe_json(value)
  return quarto.json.encode(value)
    :gsub("<", "\\u003c")
    :gsub(">", "\\u003e")
    :gsub("&", "\\u0026")
end

function Pandoc(doc)
  local subtitle = doc.meta.subtitle

  if not subtitle or pandoc.utils.type(subtitle) ~= "List" then
    return doc
  end

  local lines, fallback = subtitle_lines(subtitle)

  if #lines == 0 then
    doc.meta.subtitle = nil
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
