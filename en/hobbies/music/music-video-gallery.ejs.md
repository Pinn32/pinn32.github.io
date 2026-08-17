<% const cols = templateParams['grid-columns']; %>

::: {.music-video-gallery .list .grid .quarto-listing-cols-<%= cols %>}

<% for (const item of items) { %>
<%
  const fullDescription = String(item.description || '');
  const descriptionCharacters = Array.from(fullDescription);
  const visibleDescription = descriptionCharacters.length > 50
    ? `${descriptionCharacters.slice(0, 47).join('').trimEnd()}...`
    : fullDescription;
%>
::: {.g-col-1 <%= metadataAttrs(item) %>}
```{=html}
<article class="music-video-card">
  <video class="music-video-player" controls preload="metadata" playsinline>
    <source data-video-src="<%= item.video.replace(/&/g, '&amp;') %>" type="video/mp4">
    Your browser does not support HTML video.
  </video>
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
