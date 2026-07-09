-- lazy-images.lua
-- Add native lazy loading + async decoding to body content images.
--
-- Quarto's `image-lazy-loading` option only covers the page preview/social
-- image and listing thumbnails — NOT the images in the article body. This
-- filter marks each content <img> with loading="lazy" (off-screen images fetch
-- only as they scroll into view, so they don't hog bandwidth on load) and
-- decoding="async" (decode off the main thread). Together with rendering
-- Mermaid diagrams at parse time (see src/scripts/site-fixes.html), this lets a
-- diagram appear first while large media streams in afterward. HTML output only.

function Image(img)
  if not FORMAT:match("html") then return nil end

  -- Respect an explicit author setting if one is already present.
  if not img.attributes["loading"] then
    img.attributes["loading"] = "lazy"
  end
  if not img.attributes["decoding"] then
    img.attributes["decoding"] = "async"
  end
  return img
end
