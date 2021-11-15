---
layout: post
title: About
permalink: /about/
author: christopheradams
---

<p class="lead">
{% assign authorDetails = site.data.authors[page.author] %}
{{ authorDetails.bio }}
</p>

{% assign about_posts = site.posts | where: "category", "about" %}
{% include cards.html posts=about_posts %}

## Exhibitions

*Museum of Contemporary Art Taipei, Kuandu Museum of Fine Arts, Taiwan
Contemporary Culture Lab, Taipei Contemporary Art Center, Ars
Electronica, transmediale, IMPAKT, Beijing Design Week, Get It Louder*

## Contact

* [{{ site.email }}]({{ site.email | prepend: "mailto:" }})

## Links

{% if site.social %}
  {% assign socials = site.social | sort: "name" %}
  {%- for social in socials %}
  * [{{ social.url | remove_first: "https://" }}]({{ social.url }})
  {%- endfor -%}
{% endif %}

## Colophon

This website is written in [Emacs](https://www.gnu.org/software/emacs/),
built by [Jekyll](http://jekyllrb.com/),
styled with [Bootstrap](https://getbootstrap.com/),
and set in system fonts.
Every page includes a link to its source code.
