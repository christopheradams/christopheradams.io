.PHONY: install install-bootstrap install-bundle install-media serve build deploy clean

BOOTSTRAP_VERSION = 5.3.3
BOOTSTRAP_DIR = vendor/bootstrap

DEPLOY_TARGET ?= root@cxadams.com:/srv/www/christopheradams.io

all: build

install: install-bootstrap install-bundle

install-bundle:
	bundle install

install-bootstrap:
	@if [ -d "$(BOOTSTRAP_DIR)" ]; then \
		echo "Bootstrap already installed. Skipping."; \
	else \
		mkdir -p $(BOOTSTRAP_DIR); \
		wget -O bootstrap.tar.gz https://github.com/twbs/bootstrap/archive/v$(BOOTSTRAP_VERSION).tar.gz; \
		tar -xzf bootstrap.tar.gz; \
		cp -r bootstrap-$(BOOTSTRAP_VERSION)/* $(BOOTSTRAP_DIR)/; \
		rm -rf bootstrap.tar.gz bootstrap-$(BOOTSTRAP_VERSION); \
	fi

serve:
	bundle exec jekyll serve --livereload --drafts

build:
	JEKYLL_ENV=production bundle exec jekyll build

deploy: build
	rsync -avz --delete _site/ $(DEPLOY_TARGET)

clean:
	bundle exec jekyll clean
