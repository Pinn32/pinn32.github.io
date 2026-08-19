::: {.art-gallery .list}

<% for (const item of items) { %>
::: {.art-gallery-item <%= metadataAttrs(item) %>}
![<%= item.title %>](<%= item.image %>){.art-gallery-image .lightbox group="art"}\

::: {.art-gallery-caption}
::: {.art-gallery-title .listing-title}
<%= item.title %>
:::

::: {.art-gallery-meta}
::: {.art-gallery-date .listing-date}
<%= item.date %>
:::

::: {.art-gallery-categories}
<% const categoryLabels = { fanart: '同人', oc: '原创角色', visual: '视觉设计' }; %>
<% for (const category of item.categories || []) { %>
<span class="art-gallery-category"><%= categoryLabels[category] || category %></span>
<% } %>
:::
:::
:::
:::
<% } %>

:::
