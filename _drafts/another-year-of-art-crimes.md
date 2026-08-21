---
layout: lead
title: Another Year of Art Crimes
description: Graffiti.org Gets Zola
location: Taipei
image: /assets/images/www.graffiti.org.png
related: https://www.graffiti.org
category: Projects
tags:
- Featured
---

Art Crimes *aka* [Graffiti.org] was founded in 1994 by Susan Farrell and is the
oldest and longest-running website of its kind on the Internet. (The
photographer Brett Webb was an important early collaborator.) The site has since
enjoyed three decades of contributions by thousands of graffiti artists and
writers from all over the world.

Today, Graffiti.org hosts over 200,000 images and over 30,000 HTML files. The
core of the site amounts to nearly 10,000 pages, most of which are devoted to a
specific artist, city, or train location. It also features scores of articles,
blackbooks, and murals, and lists hundreds of graffiti websites. Every caption,
page, link, and index was originally written and maintained using plain HTML and
CSS.

In recent years, the St. Louis-based [Fabricatorz Foundation] has stepped up to
host the website, and Jon Phillips, Landon Taylor, and I pitched in to improve
it. We pledged to follow Graffiti.org's mission and stay true to its roots,
while streamlining the publishing process. For this task we chose [Zola], a
modern static-site generator written in Rust. Jon engineered the server, while I
programmed the website, and Landon provided hundreds of new pictures.

The site's design has not changed since the 1990s! We kept all the original
static content intact, only adding updated pages, indexes, and taxonomies as we
went. We avoided needless changes to the site's style or layout, save for a new
image grid on the home page. City Walls are arranged in a hierarchy of
continents, countries, territories, and cities. Artists can be referenced on
related pages using Zola's internal link format. Publication dates were
calculated by scraping the list of monthly updates, and deciphering copyright
notices on older pages. All of the code and media files are tracked with Git. We
still accept submissions the old-fashioned way: by email. Only now we use
[FreeScout] to stay on top of things.

One challenge was dealing with link rot. If a domain was still online but had
been taken over by spam, I replaced it with the *earliest* recorded version from
the [Wayback Machine]. Over many months I wrote the templates, refactored the
markup, checked countless external links, and curated dozens of new pages. Much
of this work was aided by AI code generators writing scripts in Python, a
language I respect but prefer not to write. Graffiti.org gained another year of
updates this way from Summer 2025 to Summer 2026.

A few of the additions I'd like to highlight:

* [A tribute to John
  Howard](https://www.graffiti.org/john_howard/john_howard_1/), a pioneering
  American graffiti artist who lived in São Paulo
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

The Art Crimes [message to
Writers](https://www.graffiti.org/faq/story/#get-involved) is timeless:

> We have great respect for you and your work. If you want to get involved, we
> welcome you. Protect your history by making it digital. Tell your story,
> express your opinions and publish them. Make your own site and send us your
> Web address. Make the Internet work for you. Fight media with media. Be
> careful in forums and chatrooms online, since those are very public places and
> words once spoken have a life of their own.

Don't hesitate to reach out to <yo@graffiti.org> if you would like to contribute
or support the site. We are on the lookout for more artists, photographers,
curators, and patrons of *art crimes.*

[Graffiti.org]: https://www.graffiti.org/
[Fabricatorz Foundation]: https://fabricatorz.org/
[Zola]: https://www.getzola.org/
[Wayback Machine]: https://web.archive.org/
[FreeScout]: https://freescout.net/
