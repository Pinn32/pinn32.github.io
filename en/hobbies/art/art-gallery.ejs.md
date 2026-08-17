<% const galleryGroup = templateParams['gallery-group']; %>

::: {.art-gallery .list}

<% for (const item of items) { %>
::: {.art-gallery-item <%= metadataAttrs(item) %>}
![<%= item.title %>](<%= item.image %>){.art-gallery-image .lightbox group="<%= galleryGroup %>"}\

::: {.art-gallery-caption .listing-title}
<%= item.title %>
:::
:::
<% } %>

:::
