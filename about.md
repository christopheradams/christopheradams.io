---
layout: post
title: About
permalink: /about/
---

{% assign about_posts = site.posts | where: "category", "about" %}
{% include cards.html posts=about_posts %}

{% assign author = site.author | first %}
{{ author.bio }}

## Contact

{% assign twitter_user = site.social | where: "name", "twitter" | first %}
{% assign github_user = site.social | where: "name", "github" | first %}
{% assign instagram_user = site.social | where: "name", "instagram" | first %}

* [{{ site.email }}]({{ site.email | prepend: "mailto:" }})
* [{{ instagram_user.url | remove_first: "https://" }}]({{ instagram_user.url }})
* [{{ github_user.url | remove_first: "https://" }}]({{ github_user.url }})
* [{{ twitter_user.url | remove_first: "https://" }}]({{ twitter_user.url }})

## Colophon

This website is written in [Emacs](https://www.gnu.org/software/emacs/),
built by [Jekyll](http://jekyllrb.com/),
styled with [Bootstrap](https://getbootstrap.com/),
and set in system fonts.
Every page includes a link to its source code.
