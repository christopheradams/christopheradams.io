# [christopheradams.io](https://christopheradams.io)

## About

A website of articles and photographs by Christopher Adams. Built with [Jekyll].

The current theme is inspired by [Barber], and implemented using [Bootstrap].

The previous theme used [Remarkdown]. See the `remarkdown` branch.

## Requirements

* Ruby
* Bundler
* Node.js
* [libvips] and/or ImageMagick
* wget

```sh
gem install bundler
```

## Installing and building

```sh
make install
make
```

Note: All URLs listed in the `_images.txt` and `_videos.txt` files are
downloaded by `make` into `/images` and `/video`, respectively, with a hierarchy
of directories including the host name.

These local images can be served responsively using [jekyll_picture_tag]'s `{%
picture ... %}` tag.

### Development

```sh
make serve
```

Note:

* Authors are defined in `_data/authors.yml`
* Categories are described in `_data/archives.yml`.

### Deploying

```sh
make deploy DEPLOY_TARGET="root@cxadams.com:/srv/www/christopheradams.io"
```

## Screenshot

![Screenshot](/assets/img/screenshot.png?raw=true)

[Barber]: https://github.com/samesies/barber-jekyll
[Bootstrap]: https://getbootstrap.com/
[Jekyll]: http://jekyllrb.com/
[libvips]: https://www.libvips.org/install.html
[Remarkdown]: https://fvsch.com/remarkdown/
[remarkdown-branch]: /tree/remarkdown
[jekyll_picture_tag]: https://github.com/rbuchberger/jekyll_picture_tag
