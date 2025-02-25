.PHONY: install install-bootstrap install-bundle install-media serve build deploy clean

BOOTSTRAP_VERSION = 5.3.3
BOOTSTRAP_DIR = vendor/bootstrap

IMAGES_FILE := _images.txt
IMAGES_DIR := images

VIDEOS_FILE := _videos.txt
VIDEOS_DIR := _videos

VIDEO_FILES := $(shell find _videos -type f -name "*.mp4")
GENERATED_VIDEOS := $(patsubst _videos/%.mp4,videos/%.mp4,$(VIDEO_FILES))

DEPLOY_TARGET ?= root@cxadams.com:/srv/www/christopheradams.io

all: build

install: install-bootstrap install-bundle install-media

install-bundle:
	bundle install

install-bootstrap:
	mkdir -p $(BOOTSTRAP_DIR)
	curl -L https://github.com/twbs/bootstrap/archive/v$(BOOTSTRAP_VERSION).tar.gz -o bootstrap.tar.gz
	tar -xzf bootstrap.tar.gz
	cp -r bootstrap-$(BOOTSTRAP_VERSION)/* $(BOOTSTRAP_DIR)/
	rm -rf bootstrap.tar.gz bootstrap-$(BOOTSTRAP_VERSION)

install-media:
	wget --directory-prefix=$(IMAGES_DIR) --force-directories --no-clobber --input-file=$(IMAGES_FILE)
	wget --directory-prefix=$(VIDEOS_DIR) --force-directories --no-clobber --input-file=$(VIDEOS_FILE)

media: $(GENERATED_VIDEOS)

videos/%.mp4: _videos/%.mp4
	mkdir -p $$(dirname $@)
	ffmpeg -i $< -c:v libx264 -profile:v main -vf format=yuv420p -c:a aac -crf 28 -movflags +faststart $@

serve: media
	bundle exec jekyll serve --livereload --drafts

build: media
	JEKYLL_ENV=production bundle exec jekyll build

deploy: build
	rsync -avz --delete _site/ $(DEPLOY_TARGET)

clean:
	bundle exec jekyll clean
	rm -rf $(IMAGES_DIR) $(VIDEOS_DIR)
