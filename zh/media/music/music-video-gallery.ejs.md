<%
const cols = templateParams['grid-columns'];
const youtubeId = (url) => {
  const match = url.match(/(?:youtu\.be\/|youtube(?:-nocookie)?\.com\/(?:embed\/|shorts\/|watch\?(?:[^#]*&)?v=))([A-Za-z0-9_-]{11})/);
  return match ? match[1] : null;
};
%>

::: {.music-video-gallery .list .grid .quarto-listing-cols-<%= cols %>}

<% for (const item of items) { %>
<%
  const fullDescription = String(item.description || '');
  const descriptionCharacters = Array.from(fullDescription);
  const visibleDescription = descriptionCharacters.length > 50
    ? `${descriptionCharacters.slice(0, 47).join('').trimEnd()}...`
    : fullDescription;
  const youtubeVideoId = youtubeId(item.video);
%>
::: {.g-col-1 <%= metadataAttrs(item) %>}
```{=html}
<article class="music-video-card">
<% if (youtubeVideoId) { %>
  <iframe
    class="music-video-player music-video-embed"
    src="https://www.youtube-nocookie.com/embed/<%= youtubeVideoId %>"
    title="<%= item.title.replace(/&/g, '&amp;').replace(/"/g, '&quot;') %>"
    loading="lazy"
    referrerpolicy="strict-origin-when-cross-origin"
    allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
    allowfullscreen>
  </iframe>
<% } else { %>
  <video class="music-video-player" controls preload="metadata" playsinline>
    <source data-video-src="<%= item.video.replace(/&/g, '&amp;') %>" type="video/mp4">
    你的浏览器不支持 HTML 视频。
  </video>
<% } %>
  <div class="music-video-card-body">
    <h3 class="music-video-title listing-title"><%= item.title %></h3>
    <p class="music-video-description listing-description"<% if (descriptionCharacters.length > 50) { %> data-full-description="<%= fullDescription %>" tabindex="0"<% } %>><%= visibleDescription %></p>
    <div class="music-video-meta">
      <time class="listing-date" datetime="<%= item.date %>"><%= item.date %></time>
      <span class="music-video-instrument listing-instrument"><%= item.instrument %></span>
    </div>
  </div>
</article>
```
:::
<% } %>

:::

```{=html}
<script>
  document.querySelectorAll('.music-video-description[data-full-description]').forEach(description => {
    window.tippy(description, {
      content: description.dataset.fullDescription,
      delay: [100, 0],
      duration: 0,
      maxWidth: 350
    });
  });
</script>
```
