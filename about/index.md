---
layout: page
title: About
author: christopheradams
description: Bio, contact, and links
image: /images/live.staticflickr.com/65535/49241319873_7ee721ed6a_k.jpg
---

{% assign authorDetails = site.data.authors[page.author] %}

<p class="lead">
{{ authorDetails.description }}
</p>

I'm a software developer working on web, blockchain, and distributed systems,
and a photographer and visual artist working with film, digital, and AI.  Past
projects include [Launch Stage]({%post_url 2022-05-20-launch-stage %}) for
Taipei Dangdai, [Altar Space]({% post_url 2023-09-25-altar-space %}) with Yao
Jui-Chung, [All the Color in the World]({% post_url
2021-03-13-all-the-color-in-the-world %}) with Jun Yang, and [FREESOULS]({%
post_url 2008-12-03-freesouls %}) with Joi Ito. I publish my writing, works, and
photographs at [christopheradams.io](https://christopheradams.io).

## Exhibitions

*Museum of Contemporary Art Taipei, Kuandu Museum of Fine Arts, Taiwan
Contemporary Culture Lab, Taipei Contemporary Art Center, Treasure Hill Artist
Village, Gray Area, Ars Electronica, transmediale, IMPAKT, Beijing Design Week,
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

## Photos

{% assign about_posts = site.tags.christopheradams %}
{% include cards.html posts=about_posts %}

## Colophon

This website is written in [Emacs](https://www.gnu.org/software/emacs/),
built by [Jekyll](http://jekyllrb.com/),
styled with [Bootstrap](https://getbootstrap.com/),
and set in system fonts.
Every page includes a link to its source code.
