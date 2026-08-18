<% const cols = templateParams['grid-columns']; %>

::: {.video-production-gallery .list .grid .quarto-listing-cols-<%= cols %>}

<% for (const item of items) { %>
::: {.g-col-1 <%= metadataAttrs(item) %>}
```{=html}
<article class="video-production-card">
  <video class="video-production-player" controls preload="metadata" playsinline>
    <source data-video-src="<%= item.video.replace(/&/g, '&amp;') %>" type="video/mp4">
    Your browser does not support HTML video.
  </video>
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
