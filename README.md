# [christopheradams.io](https://christopheradams.io)

## About

A website of articles and photographs by Christopher Adams. Built with [Jekyll].

The current theme is inspired by [Barber], and implemented using [Bootstrap].

The previous theme used [Remarkdown]. See the `remarkdown` branch.

## Requirements

* Ruby
* Node.js
* rclone
* ImageMagick and [RMagick](https://github.com/rmagick/rmagick)

```sh
gem install bundler
```

## Instructions

```sh
bundle install
npm install
```

### Photos

Configure rclone with a a B2 Cloud Storage application key

```
rclone copyto --http-url https://files.cxadams.com/cxadams-website/ :http: assets/media
```

### Development

```sh
npm run watch
```

### Production

```sh
npm run build
npm run deploy root@cxadams.com:/srv/www/christopheradams.io
```

## Screenshot

![Screenshot](/assets/img/screenshot.png?raw=true)

[Barber]: http://barber.samesies.io/
[Bootstrap]: https://getbootstrap.com/
[Jekyll]: http://jekyllrb.com/
[Remarkdown]: https://fvsch.com/remarkdown/
[remarkdown-branch]: /tree/remarkdown
