---
layout: post
title: "Go to the Source"
description: "Linking each webpage to its code"
category: articles
tags: programming
location: Taipei
---

I recently wrote about [why I use static site generators][blog-as-a-coder].
Approaching blogging as a coder inspired another feature that makes this site
easier to use and share.

You may have noticed I include a **[ source ]** link at the bottom of every
page.
Since this is a static site hosted on a web-accessible Git repository, it is
simple to link each page to its counterpart source file.

I'll explain how I do this using [Jekyll][jekyll], but the same technique should
work with any static site generator that can output the path of the current file
relative to the root directory, and with any Git web host that preserves this
path for viewing.

For example, the `page.path` for the current file is `{{ page.path }}`, and its
corresponding page on GitHub is [here][source].

First, I add the repo URL to the [config][config] file. For GitHub, this takes
the form:

```yaml
# _config.yml
source_url: "https://github.com/USERNAME/REPO_NAME/blob/BRANCH/"
```

Then, in the [layout][layout], I build and render the source link:

{% raw %}
```html
<!-- _layouts/page.html -->
<a href="{{ page.path | prepend: site.source_url}}">
  source
</a>
```
{% endraw %}

These source links are the very definition of [free software][free-software], to
let you **use, study, change, and share** this work.
They also serve as shortcuts for the lazy or forgetful!

[source]: {{ page.path | prepend: site.source_url}}
[blog-as-a-coder]: {% post_url 2016-11-25-what-happens-when-you-blog-as-a-coder %}
[config]: {{ "_config.yml" | prepend: site.source_url }}
[layout]: {{ "_layouts/page.html" | prepend: site.source_url }}
[jekyll]: http://jekyllrb.com/
[free-software]: https://www.gnu.org/philosophy/free-sw.en.html
