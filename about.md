---
layout: page
title: About
---

{% for post in site.categories.about %}
{% include summary.html post=post %}
{% if post.image %}
<p>
  <img src="{{ post.image }}" alt="{{ post.title }}" />
</p>
{% endif %}
{{ post.content }}
* * *
{% endfor %}

Christopher Adams is a writer, publisher, and software developer.  He works on
free software and free culture, and specializes in photography and web
technologies.

> I'm open to working with you and building great things. Please get in touch! -- C.A.

[{{ site.email }}]({{ site.email | prepend: "mailto:" }})
[{{ site.github_username | prepend: "github.com/" }}]({{ site.github_username | prepend: "https://github.com/" }})
[{{ site.twitter_username | prepend: "twitter.com/" }}]({{ site.twitter_username | prepend: "https://twitter.com/" }})

## Colophon

This website is written in [Emacs](https://www.gnu.org/software/emacs/),
built by [Jekyll](http://jekyllrb.com/),
styled with [ReMarkdown](https://fvsch.com/code/remarkdown/),
and set in your default monospace font.
Every page includes a link to its source code.
