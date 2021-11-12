---
layout: post
title: About
permalink: /about/
author: christopheradams
---

{% assign about_posts = site.posts | where: "category", "about" %}
{% include cards.html posts=about_posts %}

<p class="lead">
{% assign authorDetails = site.data.authors[page.author] %}
{{ authorDetails.bio }}
</p>

## Exhibitions

*Museum of Contemporary Art Taipei, Kuandu Museum of Fine Arts, Taiwan
Contemporary Culture Lab, Taipei Contemporary Art Center, Ars
Electronica, transmediale, IMPAKT, Beijing Design Week, Get It Louder*

## Contact

* [{{ site.email }}]({{ site.email | prepend: "mailto:" }})

## Links

{% assign twitter_user = site.social | where: "name", "twitter" | first %}
{% assign github_user = site.social | where: "name", "github" | first %}
{% assign instagram_user = site.social | where: "name", "instagram" | first %}
{% assign hen_user = site.social | where: "name", "hicetnunc" | first %}

* [{{ hen_user.url | remove_first: "https://" }}]({{ hen_user.url }})
* [{{ instagram_user.url | remove_first: "https://" }}]({{ instagram_user.url }})
* [{{ github_user.url | remove_first: "https://" }}]({{ github_user.url }})
* [{{ twitter_user.url | remove_first: "https://" }}]({{ twitter_user.url }})

## Colophon

This website is written in [Emacs](https://www.gnu.org/software/emacs/),
built by [Jekyll](http://jekyllrb.com/),
styled with [Bootstrap](https://getbootstrap.com/),
and set in system fonts.
Every page includes a link to its source code.
