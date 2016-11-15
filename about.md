---
layout: page
title: About
---

{% for post in site.categories.about %}
{% include summary.html post=post %}
{{ post.content }}
* * *
{% endfor %}

Christopher Adams is a writer, publisher, and software developer.  He works on
free software and free culture, and specializes in photography and web
technologies.

## Colophon

This website is written in [Emacs](https://www.gnu.org/software/emacs/),
built by [Jekyll](http://jekyllrb.com/),
styled with [ReMarkdown](https://fvsch.com/code/remarkdown/),
and set in your default monospace font.
Every page includes a link to its source code.
