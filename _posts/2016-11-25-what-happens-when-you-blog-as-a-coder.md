---
title: What happens when you blog as a coder?
description: The uptick of static site generators
published_at: 2016-11-27 19:45:26 +0800
category: Writing
tags: [Programming]
image: /assets/images/8271084033_c56ced1cee_k.jpg
location: Taipei
---

> What would happen if I approached blogging from a software development
> perspective?

<figcaption class="blockquote-footer">
  <cite>Tom Preston-Werner</cite>
</figcaption>

### The Dynamic, Static Web

I made the [website]({{ site.url }}) where this post is published using
[Jekyll][jekyll], a static site generator written by Tom Preston-Werner. Jekyll
is probably the most commonly-used software in its class, since it drives
[GitHub Pages][github-pages].

Although the very first website comprised plain hypertext documents, today much
of the Web runs on dynamic software and data stores. This makes the recent
renaissance of static websites look like little more than a novelty.

<figure class="figure">
  <img src="/assets/posts/what-happens-when-you-blog-as-a-coder/static-sites.svg" />
  <figcaption class="figure-caption">
    This graph charts the Google search interest in "static site
    generator" since 2008.
  </figcaption>
</figure>

There are very real, practical advantages to making websites static,
specifically in terms of increased performance, security, and ease of deployment
and maintenance.

For these reasons, static websites make eminent sense from a business or
operations perspective. However, I do not believe this entirely explains the
popularity of static site generators. The best justification, in my mind, is the
one that announced [Jekyll][jekyll].

### Blogging Like a Hacker

Tom Preston-Werner introduced his new static website generator in 2008, in a
post titled [Blogging Like a Hacker][blogging-like-a-hacker]. At the time he
wanted to improve his personal writing and publishing practice, but found that
the contemporary blogging engines and services were too complicated or
encumbered.

Instead of giving up or giving in, he figured out an approach to the activity of
blogging as an author not just of prose but of code. To this end he created a
tool that worked the way he did, namely:

1. write with a text editor
1. manage from the command line
1. do not repeat yourself
1. make things customizable and extensible
1. store and distribute using version control

Finally: release it all and let others hack on it.

The upshot is to treat the blog as source code, using the same tools and
techniques. I believe this is the real reason that static site generators have
become and remain popular (if niche). They allow hackers to write the way they
work best: with code.

[jekyll]: http://jekyllrb.com/
[github-pages]: https://pages.github.com/
[blogging-like-a-hacker]: http://tom.preston-werner.com/2008/11/17/blogging-like-a-hacker.html
