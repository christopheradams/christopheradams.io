---
layout: lead
title: Another Year of Art Crimes
description: Graffiti.org Goes Zola
location: Taipei
image: /assets/images/www.graffiti.org.png
related: https://www.graffiti.org
category: Projects
tags:
- Featured
---

Art Crimes *aka* [Graffiti.org] was founded in 1994 by Susan Farrell and is the
oldest and longest-running website of its kind on the Internet. (The
photographer Brett Webb was an early collaborator.) The site has since enjoyed
over three decades of contributions from thousands of graffiti artists and
writers all over the world.

Today, Graffiti.org hosts over 200,000 images and over 30,000 HTML files. The
core of the site comprises around 10,000 pages, each one devoted to a specific
artist, city, or train graffiti. Every caption, page, and index was written and
maintained by hand over the decades.

Recently, the St. Louis-based non-profit [Fabricatorz Foundation] stepped up to
host the website, and Jon Phillips, Landon Taylor, and I all pitched in. We
pledged to follow Graffiti.org's mission and honor its spirit, while
streamlining the publishing process. For the task we chose [Zola], a modern
static-site generator written in Rust. Jon designed the overall server and
container architecture, while I did the bulk of the website development, and
Landon provided hundreds of new pictures. We still accept submissions the
old-fashioned way, however: by email.

We kept the original website's static content completely intact, and added newly
generated pages, sections, and taxonomies as we went along. We also resisted any
changes to the site's style or organization. City Walls are neatly arranged in a
hiearchy of continents, countries, states, and cities. Artists can be referenced
on related pages using internal links. Pagination within a section is generated
automatically. Publication dates were calculated by scraping the monthly updates
index, and deciphering copyright notices on older pages.

One challenge was dealing with deadlinks. I replaced URLs for unreachable
websites with their *earliest* recorded version from the [Wayback Machine] (that
wasn't either blank or a landing page). Over many months I wrote the templates,
reformatted the markup, checked thousands of external links, and curated scores
of new pages. Graffiti.org gained another year of updates this way from Summer
2025 to Summer 2026.

A few of the additions I'd like to highlight:

* [A tribute to John
  Howard](https://www.graffiti.org/john_howard/john_howard_1/), a pioneering
  American graffiti who lived in São Paulo
* [1980s New York graffiti](https://www.graffiti.org/nyc/newyork_176/) and [New
  York subway train](https://www.graffiti.org/trains/trains_388/) photographs by
  RLH/TEL Norway
* [DTC Da Tech Cru](https://www.graffiti.org/dtc/dtc_1/) from Saint Louis,
  [Pengo](https://www.graffiti.org/pengo_chi/pengo_chi_1/) from Chicago,
  [Scaner](https://www.graffiti.org/scaner/scaner_1/) from Montreal
* [Paint Louis
  2024](https://www.graffiti.org/stlouis/stlouis_2024_paintlouis_1/),
  [2023](https://www.graffiti.org/stlouis/stlouis_2023_paintlouis_1/),
  [2022](https://www.graffiti.org/stlouis/stlouis_2022_paintlouis_1/), and
  [2021](https://www.graffiti.org/stlouis/stlouis_2021_paintlouis_1/)
* [Street art legend Blek Le
  Rat](https://www.graffiti.org/blek_le_rat/blek_le_rat_1/)

Don't hesitate to reach out to <yo@graffiti.org> if you would like to contribute
or support the site in any way. We are on the lookout for more artists,
photographers, curators, and patrons of *art crimes.*

[Graffiti.org]: https://www.graffiti.org/
[Fabricatorz Foundation]: https://fabricatorz.org/
[Zola]: https://www.getzola.org/
[Wayback Machine]: https://web.archive.org/
