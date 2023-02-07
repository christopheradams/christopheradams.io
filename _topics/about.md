---
layout: post
title: About
permalink: /about/
author: christopheradams
description: Bio, contact, and links
---

<p class="lead">
{% assign authorDetails = site.data.authors[page.author] %}
{{ authorDetails.bio }}
</p>

{% assign about_posts = site.posts | where: "category", "about" %}
{% include cards.html posts=about_posts %}

## Exhibitions

*Museum of Contemporary Art Taipei, Kuandu Museum of Fine Arts, Taiwan
Contemporary Culture Lab, Taipei Contemporary Art Center, Gray Area
Festival, Ars Electronica, transmediale, IMPAKT, Beijing Design Week,
Get It Louder*

## Contact

<ul class="list-unstyled">
  <li>
    <a href="{{ site.email | prepend: "mailto:" }}">
      {{ site.email }}
    </a>
  </li>
</ul>

## Links

{% if site.social %}
  {% assign socials = site.social %}
  <ul class="list-unstyled">
  {%- for social in socials %}
  <li>
  <a rel="me" href="{{ social.url}}">
    {%- assign domain_path = social.url | remove_first: "https://www." | remove_first: "https://" -%}
    {%- assign domain = domain_path | split: '/' | first -%}
    {%- assign path = domain_path | remove_first: domain -%}
    <span class="link-domain">{{ domain }}</span><span class="link-path">{{path}}</span>
  </a>
  </li>
  {%- endfor -%}
  </ul>
{% endif %}

{% if site.newsletter %}
[Subscribe to the Newsletter]({{ site.newsletter }})
{% endif %}

## Colophon

This website is written in [Emacs](https://www.gnu.org/software/emacs/),
built by [Jekyll](http://jekyllrb.com/),
styled with [Bootstrap](https://getbootstrap.com/),
and set in system fonts.
Every page includes a link to its source code.
