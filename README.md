# [christopheradams.io](https://christopheradams.io)

## About

A website of articles and photographs by Christopher Adams. Built with [Jekyll].

The current theme is inspired by [Barber], and implemented using [Bootstrap].

The previous theme used [Remarkdown]. See the `remarkdown` branch.

## Requirements

* Ruby
* Bundler
* [libvips] and/or ImageMagick
* Git LFS
* wget

## Installing and building

```sh
make install
make
```

### Development

```sh
make serve
```

Note:

* Authors are defined in `_data/authors.yml`
* Categories are described in `_data/archives.yml`.

### Deploying

```sh
make deploy DEPLOY_TARGET="user@example.org:/path/to/webroot"
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
