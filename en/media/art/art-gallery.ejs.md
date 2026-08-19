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
<% for (const category of item.categories || []) { %>
<span class="art-gallery-category"><%= category === 'oc' ? 'OC' : category.charAt(0).toUpperCase() + category.slice(1) %></span>
<% } %>
:::
:::
:::
:::
<% } %>

:::
