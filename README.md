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

## Newsletter automation (Listmonk)

This repo includes a `Rakefile` that can render a Jekyll post (including Liquid tags)
into an email-friendly HTML fragment and create a Listmonk campaign from it.

### Preview

```sh
bundle exec rake newsletter:preview[instructions-beyond-code]
```

### Create a campaign

Set your Listmonk config via environment variables:

- **`LISTMONK_URL`**: Base URL, e.g. `https://list.example.com`
- **`LISTMONK_LIST_IDS`**: Comma-separated list IDs, e.g. `1,2`
- **`LISTMONK_USER` / `LISTMONK_TOKEN`**: Listmonk API user + token (sent as Basic auth `user:token`)
  - Set **`LISTMONK_AUTH_MODE=header`** to send `Authorization: token user:token` instead.

Legacy/backcompat (if you used it previously):

- **`LISTMONK_PASSWORD`**: Basic auth password (only used if `LISTMONK_TOKEN` is not set)

Optional:

- **`LISTMONK_SUBJECT`**: Email subject (defaults to the post title)
- **`LISTMONK_CAMPAIGN_NAME`**: Campaign name (defaults to `"Newsletter: <title>"`)
- **`LISTMONK_CAMPAIGN_TYPE`**: Defaults to `regular`
- **`LISTMONK_FROM_EMAIL` / `LISTMONK_FROM_NAME`**
- **`LISTMONK_TAGS`**: Comma-separated tags
- **`DRY_RUN=1`**: Print HTML and skip API calls

Example:

```sh
LISTMONK_URL="https://list.example.com" \
LISTMONK_USER="admin" \
LISTMONK_TOKEN="token" \
LISTMONK_LIST_IDS="1" \
bundle exec rake newsletter:campaign[2024-03-07-instructions-beyond-code]
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
