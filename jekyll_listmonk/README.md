# jekyll_listmonk

Create listmonk campaigns from Jekyll posts.

This is designed to run **inside a target Jekyll site's Bundler environment** so the
site's plugins (for example `jekyll_picture_tag`) are available.

## Install (in a target Jekyll repo)

Add to the site's `Gemfile`:

```ruby
group :development do
  gem "jekyll_listmonk", path: "../jekyll_listmonk"
end
```

Then:

```sh
bundle install
```

## Usage

Preview rendered HTML:

```sh
bundle exec jekyll-listmonk preview 2025-12-19-white-fungus-issue-18-dino
```

Create a campaign:

```sh
LISTMONK_URL="https://list.example.com" \
LISTMONK_USER="api_user" \
LISTMONK_TOKEN="api_token" \
LISTMONK_LIST_IDS="1" \
bundle exec jekyll-listmonk campaign 2025-12-19-white-fungus-issue-18-dino
```

### Environment variables

Required:

- `LISTMONK_URL`
- `LISTMONK_USER`
- `LISTMONK_TOKEN`
- `LISTMONK_LIST_IDS` (comma-separated)

Optional:

- `LISTMONK_AUTH_MODE=header` (send `Authorization: token user:token` instead of Basic auth)
- `LISTMONK_TEMPLATE_ID`
- `LISTMONK_SUBJECT` (defaults to post title)
- `LISTMONK_CAMPAIGN_NAME` (defaults to post title)
- `LISTMONK_CAMPAIGN_TYPE` (defaults to `regular`)
- `LISTMONK_FROM_EMAIL`, `LISTMONK_FROM_NAME`
- `LISTMONK_TAGS` (comma-separated)
- `DRY_RUN=1` (prints HTML and does not call the API)

## Image behavior

- If a post's front matter has an `image` field, a `{% picture ... %}` tag is injected as
  the first line of content.
- In-body `{% picture ... %}` tags are rewritten to use the `newsletter` preset and have
  `--img class="..."` removed.
- Any resulting `srcset`/`sizes` attributes are stripped from `<img>` tags in the output.

This expects the target site to define a `newsletter` preset in `_data/picture.yml`.

