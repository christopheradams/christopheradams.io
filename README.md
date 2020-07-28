# [christopheradams.io](https://christopheradams.io)

## About

A website of articles and photographs by Christopher Adams. Built with [Jekyll].

The current theme is inspired by [Barber], and implemented using [Bootstrap].

The previous theme used [Remarkdown]. See the `remarkdown` branch.

## Requirements

* Ruby
* Node.js
* IPFS
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

```
ipfs get --output assets/media QmR81MgMQVyHysobRAfKRZ1QQhTRpJEctxSzqX7SHP3Xv6
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
