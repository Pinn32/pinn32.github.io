<%
const cols = templateParams['grid-columns'];
const youtubeId = (url) => {
  const match = url.match(/(?:youtu\.be\/|youtube(?:-nocookie)?\.com\/(?:embed\/|shorts\/|watch\?(?:[^#]*&)?v=))([A-Za-z0-9_-]{11})/);
  return match ? match[1] : null;
};
%>

::: {.video-production-gallery .list .grid .quarto-listing-cols-<%= cols %>}

<% for (const item of items) { %>
<% const youtubeVideoId = youtubeId(item.video); %>
::: {.g-col-1 <%= metadataAttrs(item) %>}
```{=html}
<article class="video-production-card">
<% if (youtubeVideoId) { %>
  <iframe
    class="video-production-player video-production-embed"
    src="https://www.youtube-nocookie.com/embed/<%= youtubeVideoId %>"
    title="<%= item.title.replace(/&/g, '&amp;').replace(/"/g, '&quot;') %>"
    loading="lazy"
    referrerpolicy="strict-origin-when-cross-origin"
    allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
    allowfullscreen>
  </iframe>
<% } else { %>
  <video class="video-production-player" controls preload="metadata" playsinline>
    <source data-video-src="<%= item.video.replace(/&/g, '&amp;') %>" type="video/mp4">
    你的浏览器不支持 HTML 视频。
  </video>
<% } %>
  <div class="video-production-card-body">
    <h3 class="video-production-title listing-title"><%= item.title %></h3>
    <p class="video-production-description listing-description"><%= item.description %></p>
    <div class="video-production-meta">
      <time class="video-production-date listing-date" datetime="<%= item.date %>"><%= item.date %></time>
    </div>
  </div>
</article>
```
:::
<% } %>

:::
