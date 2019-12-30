---
layout: post
title: About
---

<figure class="figure">
<img src="https://live.staticflickr.com/3094/2829609654_800aede242_k.jpg" class="figure-img img-fluid" alt="Christopher Adams by Joi Ito">
<figcaption class="figure-caption text-right">
<p>
<a href="https://www.flickr.com/photos/joi/2829609654/">
  CC-by Joi Ito
</a>
</p>
</figcaption>
</figure>

{% assign author = site.author | first %}
{{ author.bio }}

## Contact

{% assign twitter_user = site.social | where: "name", "twitter" | first %}
{% assign github_user = site.social | where: "name", "github" | first %}

* [{{ site.email }}]({{ site.email | prepend: "mailto:" }})
* [{{ github_user.url | remove_first: "https://" }}]({{ github_user.url }})
* [{{ twitter_user.url | remove_first: "https://" }}]({{ twitter_user.url }})

## Colophon

This website is written in [Emacs](https://www.gnu.org/software/emacs/),
built by [Jekyll](http://jekyllrb.com/),
styled with [Bootstrap](https://getbootstrap.com/),
and set in system fonts.
Every page includes a link to its source code.
