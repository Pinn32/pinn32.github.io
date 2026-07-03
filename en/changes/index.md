---
title: "Change Log"
author: "Pinn Xu"
date: 2026-07-03
description: "Development timeline of this website, from first commit to now."
sidebar: false
toc: false
code-tools: false
comments: false
format:
  html:
    css: changes.css
---

This page tracks how the site has been built, from the first `quarto render` to the features you see now. The work falls into six phases. Click any card to see the day-by-day changes behind it.

```{=html}
<p class="cl-stats">37 work days &middot; 158 commits &middot; 169 hours logged</p>

<div class="cl-timeline">

  <!-- ======================= Phase 1 ======================= -->
  <div class="cl-phase">
    <span class="cl-phase-pill">
      <span class="cl-phase-name">Phase 1 &middot; Initial setup</span>
      <span class="cl-phase-range">Mar 31 - Apr 4</span>
    </span>
  </div>

  <details class="cl-item cl-left">
    <summary class="cl-head">
      <time class="cl-date" datetime="2026-03-31">Mar 31 - Apr 1</time>
      <span class="cl-title">Project bootstrapped</span>
      <p class="cl-summary">Installed Quarto, tried RStudio, settled on VS Code, and put the site skeleton in place with the first four project documents.</p>
      <span class="cl-meta">12 commits &middot; 7.75 h</span>
      <span class="cl-chevron" aria-hidden="true"></span>
    </summary>
    <div class="cl-body">
      <ul>
        <li><span class="cl-d">Mar 31</span> installed Quarto; started in RStudio, then switched to VS Code</li>
        <li><span class="cl-d">Mar 31</span> added the first four project documents</li>
        <li><span class="cl-d">Apr 1</span> tracked CSV datasets with git LFS; added <code>.gitignore</code></li>
        <li><span class="cl-d">Apr 1</span> recorded the conda environment in <code>envs/environment.yml</code></li>
        <li><span class="cl-d">Apr 1</span> set up the layout config: <code>_quarto.yml</code>, <code>_metadata.yml</code></li>
        <li><span class="cl-d">Apr 1</span> shaped the document tree and the Catalan referendum page layout</li>
        <li><span class="cl-d">Apr 1</span> added custom <code>styles.css</code> and the <code>fix-code-fold</code> script</li>
      </ul>
    </div>
  </details>

  <details class="cl-item cl-right">
    <summary class="cl-head">
      <time class="cl-date" datetime="2026-04-02">Apr 2</time>
      <span class="cl-title">Catalan page finished</span>
      <p class="cl-summary">Rewrote and restructured the Catalan referendum project page, the site's first complete article.</p>
      <span class="cl-meta">3 commits &middot; 4 h</span>
      <span class="cl-chevron" aria-hidden="true"></span>
    </summary>
    <div class="cl-body">
      <ul>
        <li>refined YAML headers across project pages; added tables of contents</li>
        <li>cleaned up routes in <code>_quarto.yml</code></li>
        <li>finished rewriting <code>catalan-referendum/index.qmd</code></li>
      </ul>
    </div>
  </details>

  <details class="cl-item cl-left">
    <summary class="cl-head">
      <time class="cl-date" datetime="2026-04-03">Apr 3</time>
      <span class="cl-title">Python pipeline and repo restructure</span>
      <p class="cl-summary">The heaviest day of the setup phase. Python projects moved to the Jupyter renderer, notebooks became .qmd files, and static assets moved into /src/.</p>
      <span class="cl-meta">17 commits &middot; 11.75 h</span>
      <span class="cl-chevron" aria-hidden="true"></span>
    </summary>
    <div class="cl-body">
      <ul>
        <li>added sidebar and breadcrumb navigation styles</li>
        <li>converted notebooks to .qmd; switched Python projects from knitr to the Jupyter renderer</li>
        <li>added environment and package version chunks to all project pages (Python chunks need <code>#|</code> for YAML options)</li>
        <li>extracted images from base64 and styled their captions (<code>.caption</code> class)</li>
        <li>customized page tag styles; compressed code cells in global-visa</li>
        <li>restructured the tree into <code>/src/styles</code>, <code>/src/scripts</code>, <code>/src/img</code></li>
        <li>extracted inline HTML page styles into CSS</li>
        <li>added the 404 and home pages, a favicon, and the <code>fix-navbar-active</code> script</li>
        <li>initialized tutorial pages</li>
      </ul>
    </div>
  </details>

  <details class="cl-item cl-right">
    <summary class="cl-head">
      <time class="cl-date" datetime="2026-04-04">Apr 4</time>
      <span class="cl-title">Sidebar and link fixes</span>
      <p class="cl-summary">A small cleanup pass over sidebar active styles, external documentation links, and homepage wording.</p>
      <span class="cl-meta">4 commits &middot; 1 h</span>
      <span class="cl-chevron" aria-hidden="true"></span>
    </summary>
    <div class="cl-body">
      <ul>
        <li>customized the sidebar active style so it works on both localhost and the published site</li>
        <li>dropped the <code>fix-navbar-active</code> script from the About page in favor of <code>sidebar: false</code></li>
        <li>fixed URL references to pandas and Python docs</li>
        <li>refined wording and the homepage layout</li>
      </ul>
    </div>
  </details>

  <!-- ======================= Phase 2 ======================= -->
  <div class="cl-phase">
    <span class="cl-phase-pill">
      <span class="cl-phase-name">Phase 2 &middot; Tutorials &amp; cross-referencing</span>
      <span class="cl-phase-range">Apr 5 - Apr 8</span>
    </span>
  </div>

  <details class="cl-item cl-left">
    <summary class="cl-head">
      <time class="cl-date" datetime="2026-04-05">Apr 5</time>
      <span class="cl-title">Tutorials section added</span>
      <p class="cl-summary">All tutorial files came in at once: converted to .qmd, images extracted, and folders restructured for future en/zh versions.</p>
      <span class="cl-meta">5 commits &middot; 1.75 h</span>
      <span class="cl-chevron" aria-hidden="true"></span>
    </summary>
    <div class="cl-body">
      <ul>
        <li>added all tutorial files and converted them to .qmd</li>
        <li>extracted every embedded image</li>
        <li>restructured the tutorials folder into English and Chinese variants</li>
        <li>replaced caption spans with cross-ref options (<code>#| label</code>, <code>#| fig-cap</code>)</li>
      </ul>
    </div>
  </details>

  <details class="cl-item cl-right">
    <summary class="cl-head">
      <time class="cl-date" datetime="2026-04-07">Apr 7 - Apr 8</time>
      <span class="cl-title">Cross-reference system</span>
      <p class="cl-summary">In-text citations switched to Quarto cross-refs, and the bibliography moved into a .bib file with APA formatting.</p>
      <span class="cl-meta">4 commits &middot; 1.75 h</span>
      <span class="cl-chevron" aria-hidden="true"></span>
    </summary>
    <div class="cl-body">
      <ul>
        <li><span class="cl-d">Apr 7</span> refined wording in the amounts-and-distribution tutorial</li>
        <li><span class="cl-d">Apr 7</span> added <code>@fig-</code>/<code>@tbl-</code>/<code>@sec-</code> cross-refs for in-text citations</li>
        <li><span class="cl-d">Apr 7</span> extracted the bibliography to <code>reference.bib</code>; added the APA style file</li>
        <li><span class="cl-d">Apr 8</span> linked in-text citations to the appendix</li>
      </ul>
    </div>
  </details>

  <!-- ======================= Phase 3 ======================= -->
  <div class="cl-phase">
    <span class="cl-phase-pill">
      <span class="cl-phase-name">Phase 3 &middot; Style revamp &amp; i18n groundwork</span>
      <span class="cl-phase-range">Apr 10 - Apr 11</span>
    </span>
  </div>

  <details class="cl-item cl-left">
    <summary class="cl-head">
      <time class="cl-date" datetime="2026-04-10">Apr 10</time>
      <span class="cl-title">Full style revamp and en/zh switch</span>
      <p class="cl-summary">The whole stylesheet was rewritten as portfolio.css, and the site gained a Chinese mirror tree with a language switch.</p>
      <span class="cl-meta">14 commits &middot; 8.25 h</span>
      <span class="cl-chevron" aria-hidden="true"></span>
    </summary>
    <div class="cl-body">
      <ul>
        <li>rewrote the site CSS in <code>src/styles/portfolio.css</code>; added <code>_brand.yml</code></li>
        <li>fixed the copy button, nav toggle color, dropdown menu, and scrollbar styles</li>
        <li>added the hobbies page and Chinese tutorial drafts</li>
        <li>added the en/zh switch; moved Chinese pages into a <code>/zh/</code> mirror of the site tree</li>
        <li>moved shared datasets and images into <code>/src/</code> so both languages reuse them</li>
        <li>translated all English pages to Chinese</li>
      </ul>
    </div>
  </details>

  <details class="cl-item cl-right">
    <summary class="cl-head">
      <time class="cl-date" datetime="2026-04-11">Apr 11</time>
      <span class="cl-title">Data-processing tutorial in English</span>
      <p class="cl-summary">Finished the English version of the data-processing tutorial. The last entry before a seven-week pause.</p>
      <span class="cl-meta">1 commit &middot; 4 h</span>
      <span class="cl-chevron" aria-hidden="true"></span>
    </summary>
    <div class="cl-body">
      <ul>
        <li>finished <code>en/tutorials/data-processing</code></li>
      </ul>
    </div>
  </details>

  <!-- ======================= Phase 4 ======================= -->
  <div class="cl-phase">
    <span class="cl-phase-pill">
      <span class="cl-phase-name">Phase 4 &middot; Restart, translation &amp; first publish</span>
      <span class="cl-phase-range">May 31 - Jun 5</span>
    </span>
  </div>

  <details class="cl-item cl-left">
    <summary class="cl-head">
      <time class="cl-date" datetime="2026-05-31">May 31 - Jun 2</time>
      <span class="cl-title">Project restarted; translation push</span>
      <p class="cl-summary">Work resumed after seven weeks with a README, manual cross-refs for outputs, and a translation pass across most projects and tutorials.</p>
      <span class="cl-meta">11 commits &middot; 9.25 h</span>
      <span class="cl-chevron" aria-hidden="true"></span>
    </summary>
    <div class="cl-body">
      <ul>
        <li><span class="cl-d">May 31</span> added <code>README.md</code>; wrote a cross-ref SOP note</li>
        <li><span class="cl-d">May 31</span> added manual cross-refs for outputs in student-media-usage</li>
        <li><span class="cl-d">May 31</span> translated data-processing, student-media-usage, and catalan into Chinese</li>
        <li><span class="cl-d">Jun 2</span> translated and fixed the songs, visa, and catalan projects</li>
        <li><span class="cl-d">Jun 2</span> translated the amounts-and-distribution tutorial into English</li>
        <li><span class="cl-d">Jun 2</span> refined the Chinese multivariate-plots tutorial: figures, text, cross-refs</li>
        <li><span class="cl-d">Jun 2</span> added back-to-top navigation</li>
      </ul>
    </div>
  </details>

  <details class="cl-item cl-right">
    <summary class="cl-head">
      <time class="cl-date" datetime="2026-06-03">Jun 3</time>
      <span class="cl-title">First publish to GitHub Pages</span>
      <p class="cl-summary">The site went live. Same day: a reading-time filter written in Lua, language-switcher fixes, and a refined sankey tutorial.</p>
      <span class="cl-meta">7 commits &middot; 8.75 h</span>
      <span class="cl-chevron" aria-hidden="true"></span>
    </summary>
    <div class="cl-body">
      <ul>
        <li>published to gh-pages</li>
        <li>added reading time via a Lua filter</li>
        <li>fixed the language switcher and the homepage reroute</li>
        <li>fixed number-sections; tidied textual bugs and the hobbies placeholder</li>
        <li>translated the multivariate-plots tutorial into English; refined the Chinese sankey tutorial</li>
      </ul>
    </div>
  </details>

  <details class="cl-item cl-left">
    <summary class="cl-head">
      <time class="cl-date" datetime="2026-06-04">Jun 4 - Jun 5</time>
      <span class="cl-title">AI-tweets project and R-tips tutorial</span>
      <p class="cl-summary">Two new pieces of content, plus fixes for the language switcher, reading time, and homepage cards.</p>
      <span class="cl-meta">11 commits &middot; 8.5 h logged</span>
      <span class="cl-chevron" aria-hidden="true"></span>
    </summary>
    <div class="cl-body">
      <ul>
        <li><span class="cl-d">Jun 4</span> fixed lang-switcher reroutes to <code>root/en</code> and the zh/en reading-time bug</li>
        <li><span class="cl-d">Jun 4</span> translated the sankey tutorial into English; fixed the homepage card clickable area</li>
        <li><span class="cl-d">Jun 4</span> added the ai-tweets project and fixed its rendering bug</li>
        <li><span class="cl-d">Jun 5</span> fixed the language switch in the navbar</li>
        <li><span class="cl-d">Jun 5</span> refined all ai-tweets tables, added comments, translated it into Chinese</li>
        <li><span class="cl-d">Jun 5</span> added the Chinese R-tips tutorial, with a <code>==mark==</code> highlight rule</li>
      </ul>
    </div>
  </details>

  <!-- ======================= Phase 5 ======================= -->
  <div class="cl-phase">
    <span class="cl-phase-pill">
      <span class="cl-phase-name">Phase 5 &middot; Blogs, styling &amp; mobile</span>
      <span class="cl-phase-range">Jun 7 - Jun 21</span>
    </span>
  </div>

  <details class="cl-item cl-left">
    <summary class="cl-head">
      <time class="cl-date" datetime="2026-06-07">Jun 7 - Jun 9</time>
      <span class="cl-title">Listing polish and 404 fix</span>
      <p class="cl-summary">A round of small fixes: the 404 page finally respects language and route, listings got cover images, and the favicon became a spark.</p>
      <span class="cl-meta">8 commits &middot; 7 h</span>
      <span class="cl-chevron" aria-hidden="true"></span>
    </summary>
    <div class="cl-body">
      <ul>
        <li><span class="cl-d">Jun 7</span> fixed the sidebar toggle area; changed the favicon to a spark</li>
        <li><span class="cl-d">Jun 7</span> switched publishing to <code>quarto publish gh-pages --no-render</code></li>
        <li><span class="cl-d">Jun 7</span> renamed r-tips from .md to .qmd so it shows in listings</li>
        <li><span class="cl-d">Jun 9</span> fixed the 404 page (language and route); renamed ai-tweets to ai-discourse</li>
        <li><span class="cl-d">Jun 9</span> added env/version blocks and number-sections to projects</li>
        <li><span class="cl-d">Jun 9</span> refined global-visa and r-tips, with translation</li>
        <li><span class="cl-d">Jun 9</span> added a cover image field to listings; refined categories and descriptions</li>
      </ul>
    </div>
  </details>

  <details class="cl-item cl-right">
    <summary class="cl-head">
      <time class="cl-date" datetime="2026-06-11">Jun 11 - Jun 13</time>
      <span class="cl-title">Blog section opened</span>
      <p class="cl-summary">The blog section started with a post on misplaced system folders. Also fixed the long-standing navbar active-anchor bug.</p>
      <span class="cl-meta">4 commits &middot; 4 h logged</span>
      <span class="cl-chevron" aria-hidden="true"></span>
    </summary>
    <div class="cl-body">
      <ul>
        <li><span class="cl-d">Jun 11</span> fixed the navbar active anchor; brought all JS in line with one convention</li>
        <li><span class="cl-d">Jun 12</span> refined the homepage</li>
        <li><span class="cl-d">Jun 13</span> added the blog <code>fix-misplaced-sysfolders</code> and its listing page</li>
        <li><span class="cl-d">Jun 13</span> refined the sidebar YAML and layout; added a cover image</li>
        <li><span class="cl-d">Jun 13</span> fixed the search cancel button style</li>
      </ul>
    </div>
  </details>

  <details class="cl-item cl-left">
    <summary class="cl-head">
      <time class="cl-date" datetime="2026-06-14">Jun 14 - Jun 16</time>
      <span class="cl-title">Figure styles solved; image-hosting workflow</span>
      <p class="cl-summary">Three long days on the shellfolder blog and figure styling. The image sizing and centering fix became its own post, quarto-img-styles.</p>
      <span class="cl-meta">12 commits &middot; 20.5 h</span>
      <span class="cl-chevron" aria-hidden="true"></span>
    </summary>
    <div class="cl-body">
      <ul>
        <li><span class="cl-d">Jun 14</span> fixed sidebar search not showing; styled the navbar dropdown</li>
        <li><span class="cl-d">Jun 14</span> added Bootstrap icons to quicklinks; fixed inline code wrap and non-executable code cell styles</li>
        <li><span class="cl-d">Jun 14</span> refined the Chinese fix-misplaced-sysfolders post</li>
        <li><span class="cl-d">Jun 15</span> solved responsive image sizing and centering in Quarto</li>
        <li><span class="cl-d">Jun 15</span> set up PicGo with GitHub as the image host</li>
        <li><span class="cl-d">Jun 15</span> wrote the fix up as a blog post; styled the lightbox and line breaks</li>
        <li><span class="cl-d">Jun 16</span> refined and translated quarto-img-styles; refined both shellfolder versions</li>
      </ul>
    </div>
  </details>

  <details class="cl-item cl-right">
    <summary class="cl-head">
      <time class="cl-date" datetime="2026-06-17">Jun 17 - Jun 19</time>
      <span class="cl-title">Shellfolder blog finished; second publish</span>
      <p class="cl-summary">The shellfolder post reached its final structure in both languages, and the site was republished with cleaner routes.</p>
      <span class="cl-meta">7 commits &middot; 11.5 h</span>
      <span class="cl-chevron" aria-hidden="true"></span>
    </summary>
    <div class="cl-body">
      <ul>
        <li><span class="cl-d">Jun 17</span> refined shellfolder structure and TOC options</li>
        <li><span class="cl-d">Jun 18</span> style pass: dropdown items, listing tag counts, centered figure captions, title-block tags, spacing</li>
        <li><span class="cl-d">Jun 19</span> finished quarto-img-styles refinement and translation</li>
        <li><span class="cl-d">Jun 19</span> stripped <code>/index.html</code> from routes with a script; refined the listing sort and filter UI</li>
        <li><span class="cl-d">Jun 19</span> published to gh-pages</li>
      </ul>
    </div>
  </details>

  <details class="cl-item cl-left">
    <summary class="cl-head">
      <time class="cl-date" datetime="2026-06-20">Jun 20 - Jun 21</time>
      <span class="cl-title">Mobile pass</span>
      <p class="cl-summary">First proper mobile work: button layout, tag collapse, dropdown layering, and a host setting for testing on a phone.</p>
      <span class="cl-meta">4 commits &middot; 5.25 h</span>
      <span class="cl-chevron" aria-hidden="true"></span>
    </summary>
    <div class="cl-body">
      <ul>
        <li><span class="cl-d">Jun 20</span> made home buttons flex on mobile; collapsed listing page tags</li>
        <li><span class="cl-d">Jun 20</span> moved the nav dropdown menu above the sidebar layer</li>
        <li><span class="cl-d">Jun 20</span> added a default host and port so the site previews on a phone</li>
        <li><span class="cl-d">Jun 21</span> set up listing home pages in YAML</li>
      </ul>
    </div>
  </details>

  <!-- ======================= Phase 6 ======================= -->
  <div class="cl-phase">
    <span class="cl-phase-pill">
      <span class="cl-phase-name">Phase 6 &middot; Tools, dark mode &amp; features</span>
      <span class="cl-phase-range">Jun 22 - Jul 3</span>
    </span>
  </div>

  <details class="cl-item cl-left">
    <summary class="cl-head">
      <time class="cl-date" datetime="2026-06-22">Jun 22</time>
      <span class="cl-title">All-posts page and edit-this-page</span>
      <p class="cl-summary">An all-posts listing with post-type filters, plus an edit-this-page link on every article.</p>
      <span class="cl-meta">3 commits &middot; 2.5 h</span>
      <span class="cl-chevron" aria-hidden="true"></span>
    </summary>
    <div class="cl-body">
      <ul>
        <li>added the all-posts page and its post-type filter script</li>
        <li>fixed the responsive tag bar's render delay</li>
        <li>added edit-this-page</li>
      </ul>
    </div>
  </details>

  <details class="cl-item cl-right">
    <summary class="cl-head">
      <time class="cl-date" datetime="2026-06-23">Jun 23 - Jun 24</time>
      <span class="cl-title">Tools section</span>
      <p class="cl-summary">A new section for small web tools: a URL shortener, a cat image hub, and a news hub.</p>
      <span class="cl-meta">8 commits &middot; 10.25 h</span>
      <span class="cl-chevron" aria-hidden="true"></span>
    </summary>
    <div class="cl-body">
      <ul>
        <li><span class="cl-d">Jun 23</span> initialized the tools section; built url-shortener and cat-img-hub</li>
        <li><span class="cl-d">Jun 23</span> fixed the page tag redirect; refined tags and the home intro</li>
        <li><span class="cl-d">Jun 24</span> finished news-hub; refined the other two tools</li>
        <li><span class="cl-d">Jun 24</span> aliased ai-tweets; fixed mobile font sizes in nav, sidebar, and buttons</li>
        <li><span class="cl-d">Jun 24</span> published to gh-pages</li>
      </ul>
    </div>
  </details>

  <details class="cl-item cl-left">
    <summary class="cl-head">
      <time class="cl-date" datetime="2026-06-25">Jun 25 - Jun 26</time>
      <span class="cl-title">Dark mode</span>
      <p class="cl-summary">All styles merged into portfolio.scss, and the site gained a full dark theme in portfolio-dark.</p>
      <span class="cl-meta">4 commits &middot; 8 h</span>
      <span class="cl-chevron" aria-hidden="true"></span>
    </summary>
    <div class="cl-body">
      <ul>
        <li><span class="cl-d">Jun 25</span> restructured the styles</li>
        <li><span class="cl-d">Jun 26</span> combined every stylesheet into <code>portfolio.scss</code>; added <code>portfolio-dark</code> and dark mode</li>
        <li><span class="cl-d">Jun 26</span> refined all styles; moved notes in content into callout blocks</li>
        <li><span class="cl-d">Jun 26</span> published to gh-pages</li>
      </ul>
    </div>
  </details>

  <details class="cl-item cl-right">
    <summary class="cl-head">
      <time class="cl-date" datetime="2026-06-27">Jun 27 - Jun 28</time>
      <span class="cl-title">Mobile line breaks and a contribution graph</span>
      <p class="cl-summary">Mobile tables stopped overflowing, the homepage got a GitHub contribution graph, and every script moved into one structure.</p>
      <span class="cl-meta">7 commits &middot; 11.25 h</span>
      <span class="cl-chevron" aria-hidden="true"></span>
    </summary>
    <div class="cl-body">
      <ul>
        <li><span class="cl-d">Jun 27</span> fixed line breaks on mobile (the shellfolder table); noted the <code>&lt;wbr&gt;</code> lesson</li>
        <li><span class="cl-d">Jun 27</span> added a GitHub contribution graph to both homepages</li>
        <li><span class="cl-d">Jun 27</span> enabled mobile-only and mobile-hide utility classes</li>
        <li><span class="cl-d">Jun 28</span> added macbook-frame and img-frame components for blogs and tools</li>
        <li><span class="cl-d">Jun 28</span> added a copyright-year script; restructured all scripts</li>
        <li><span class="cl-d">Jun 28</span> styled code-with-filename; reset the site URL, which fixed a 404 render bug</li>
      </ul>
    </div>
  </details>

  <details class="cl-item cl-left">
    <summary class="cl-head">
      <time class="cl-date" datetime="2026-06-29">Jun 29 - Jul 1</time>
      <span class="cl-title">Comments and a reproduction guide</span>
      <p class="cl-summary">Giscus comments went live, and a new page documents how to reproduce the R and Python environments. README in both languages.</p>
      <span class="cl-meta">6 commits &middot; 11.75 h</span>
      <span class="cl-chevron" aria-hidden="true"></span>
    </summary>
    <div class="cl-body">
      <ul>
        <li><span class="cl-d">Jun 29</span> added giscus comments; styled hr and the dark-mode image shade</li>
        <li><span class="cl-d">Jun 29</span> built a visitor counter and bio playground</li>
        <li><span class="cl-d">Jun 29</span> documented the R and Python environments; wrote the Reproduce This Project page</li>
        <li><span class="cl-d">Jun 29</span> fixed readme page tag padding; re-initialized the About page</li>
        <li><span class="cl-d">Jul 1</span> wrote the Chinese README; finished the readme page in both languages</li>
      </ul>
    </div>
  </details>

  <details class="cl-item cl-right">
    <summary class="cl-head">
      <time class="cl-date" datetime="2026-07-02">Jul 2 - Jul 3</time>
      <span class="cl-title">Language-aware comments and this page</span>
      <p class="cl-summary">Giscus now follows the page language, active tags toggle off on a second click, and external links show an icon. This change log closes out the phase.</p>
      <span class="cl-meta">6 commits &middot; 10.5 h</span>
      <span class="cl-chevron" aria-hidden="true"></span>
    </summary>
    <div class="cl-body">
      <ul>
        <li><span class="cl-d">Jul 2</span> set giscus to English on <code>/en/</code> and Chinese on <code>/zh/</code></li>
        <li><span class="cl-d">Jul 2</span> made the tag bar revert to All when the active tag is clicked again</li>
        <li><span class="cl-d">Jul 2</span> added the external links YAML and link icons; fixed the icon on image links</li>
        <li><span class="cl-d">Jul 2</span> added GitHub Actions to keep supabase and mongodb from expiring</li>
        <li><span class="cl-d">Jul 2</span> refined <code>.gitignore</code>; added About to the nav</li>
        <li><span class="cl-d">Jul 3</span> added this change log page</li>
      </ul>
    </div>
  </details>

</div>
```
