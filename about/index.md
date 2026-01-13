---
layout: article
title: About
author: christopheradams
description: Bio, contact, and links
image: /assets/images/49241319873_7ee721ed6a_k.jpg
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

{% if site.social_links %}
  {% assign socials = site.social_links %}
  <ul class="list-unstyled">
  {%- for social in socials %}
  <li>
  <a rel="me" href="{{ social.url}}">
    {%- assign scheme = social.url | split: ":" | first -%}
    {%- if scheme == "https" -%}
    {%- assign social_path = social.url | remove_first: "https://www." | remove_first: "https://" -%}
    {%- assign social_name = social_path | split: '/' | first -%}
    {%- else %}
    {%- assign social_path = social.url | remove_first: scheme -%}
    {%- assign social_name = scheme -%}
    {%- endif %}
    {%- assign account_name = social_path | remove_first: social_name -%}
    <span class="link-domain">{{ social_name }}</span><span class="link-path">{{account_name}}</span>
  </a>
  </li>
  {%- endfor -%}
  </ul>
{% endif %}

{% if site.newsletter or site.feed %}

## News

{% endif %}

{% if site.newsletter %}

[Subscribe to the Newsletter]({{ site.newsletter }})

{% endif %}

{% if site.feed %}
{% assign feed_path = site.feed.path | default: "/feed.xml" %}

[Follow the RSS feed]({{ feed_path }})

{% endif %}

{% assign about_posts = site.tags[authorDetails.name] %}

{% if about_posts.size > 0 %}

## Photos

{% include cards.html posts=about_posts %}

{% endif %}

## Colophon

This website is written in [Emacs](https://www.gnu.org/software/emacs/),
built by [Jekyll](http://jekyllrb.com/),
styled with [Bootstrap](https://getbootstrap.com/),
and set in system fonts.
Every page includes a link to its source code.
