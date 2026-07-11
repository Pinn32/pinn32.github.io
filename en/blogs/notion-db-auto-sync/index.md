---
title: 'Notion Database Auto-Sync Tips'
author: 'Pinn Xu'
date: 2026-07-08
description: 'Tips for Notion database Formulas & Rollups when syncing via API.'
categories: [Notion, Database, Quarto, Web Dev, Tips]
image: ""
crossref:
    fig-title: "Fig"
    fig-prefix: "Fig"

draft: true
draft-mode: unlinked
---

# Introduction

I recently restructured the Notion databases behind this website’s change log. Originally, the site relied on a single database with mostly manual properties. Although AI agents helped generate much of the cell content, maintaining the database was still unnecessarily verbose.

Since I already used a separate database to track development tasks in Notion Calendar, I connected the two databases and leveraged [Rollups](https://www.notion.com/help/relations-and-rollups#rollups) and [Formulas](https://www.notion.com/help/formula-syntax) to automatically populate the change log’s properties.

@sec-db introduces the structure of the databases, while @sec-tips shares key lessones I've learned from building this auto-sync workflow.


# Database Structure {#sec-db}

:::{.macbook-frame style="width:40rem;"}
![Dev DB Overview](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260709123408098.png){#fig-devdb}
:::

<!-- :::{.macbook-frame style="width:40rem;"}
![](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260709123408098.png)
::: -->

<!-- [Dev Track Database Overview]{.caption} -->

:::{.macbook-frame style="width:40rem;"}
![Log DB Overview](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260709122533725.png){#fig-logdb}
:::

:::{.macbook-frame style="width:30rem;"}
![Dev DB Calendar View](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260709122817585.png){#fig-devdb-cal}
:::

:::{.macbook-frame style="width:40rem;"}
![Dev DB in Notion Calendar](https://raw.githubusercontent.com/Pinn32/img/main/img/pic-go/20260709123116845.png){#fig-devdb-nc}
:::

# Tips for Building Sync with Formulas {#sec-tips}
## Timezone
After replacing all manual-input properties with Formulas & Rollups, I observed an inconsistency in Formula properties of dates between Notion UI and API. For instance:

```js
prop("Timeline").dateStart().formatDate("YYYY-MM-DD").parseDate()
```

This is a Formula stripping the Timeline's start date, to drop its time and return a pure date. It works well in Notion UI, no matter which timezone your workplace is set to, whereas the API might returns a different date.

The cause is that `formatDate()` will parse the date input as UTC+0 and output the result in UTC+0. If your timezone is set to UTC-4, the date will be off by 4 hours.

To solve it, always add a timezone argument when calling `formatDate()` function if your timezone isn't UTC+0.

```js
prop("Timeline").dateStart().formatDate("YYYY-MM-DD", UTC-4).parseDate()
```

If your location uses Daylight Saving Time, you may want to use [IANA timezone names](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones), such as `America/New_York` instead of `UTC-4`.


## Data Type
When editing a Formula property, it's okay to not set a fallback when your source property is empty. If you want to set a fallback, use the same type as current property.

Moreover, avoid setting `empty()` as fallback, as it will cause an error when you want to set a Chart View. For example: 

```js
ifs(
    /* set empty() as fallback if $Timeline is empty */
    prop("Timeline") == empty(),
    empty(),

    /* if start time is before 5am, subtract 1 day */
    prop("Timeline").dateStart().hours() <= 5,
    prop("Timeline").dateStart().dateSubtract()
    .formatDate("YYYY-MM-DD", UTC-4).parseDate(),

    /* else: set start time */
    prop("Timeline").dateStart().formatDate("YYYY-MM-DD", UTC-4).parseDate()
)
```

This is a Formula showing the actual date of tasks recorded in the Timeline property, where tasks started before 5am should be counted into the previous day.

It works in normal database views (e.g. table, list, calendar), but if you want to set a Chart view and use this property as X-axis, it won't be available.

To fix it, avoid using `empty()` as fallback, instead, either leave it without fallback — the property will be both empty when the source property is empty, and available in Chart View; or use a date like `1900-01-01` or `today()` as fallback.

```js
ifs(
    /* date fallback if $Timeline is empty */
    prop("Timeline") == empty(),
    parseDate("1900-01-01"),

    /* if start time is before 5am, subtract 1 day */
    prop("Timeline").dateStart().hours() <= 5,
    prop("Timeline").dateStart().dateSubtract()
    .formatDate("YYYY-MM-DD", UTC-4).parseDate(),

    /* else: set start time */
    prop("Timeline").dateStart().formatDate("YYYY-MM-DD", UTC-4).parseDate()
)
```

Likewise, if your property's data type is string, use `""` as fallback, and `0` for number, `false` for boolean, `[]` for list, etc.


## Reduce Runtime
If your database contains too many Rollup properties, it re-request all content from the source database every time, which may cause high latency when you manage the database. Try to reduce the number of Rollup properties. Instead of retrieving related data from several Rollups, try to use one Rollup with Formulas.


