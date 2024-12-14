IMAGES_FILE := _images.txt
IMAGES_DIR := images

VIDEOS_FILE := _videos.txt
VIDEOS_DIR := _videos

VIDEO_FILES := $(shell find _videos -type f -name "*.mp4")
GENERATED_VIDEOS := $(patsubst _videos/%.mp4,videos/%.mp4,$(VIDEO_FILES))

all: $(GENERATED_VIDEOS)

install:
	wget --directory-prefix=$(IMAGES_DIR) --force-directories --no-clobber --input-file=$(IMAGES_FILE)
	wget --directory-prefix=$(VIDEOS_DIR) --force-directories --no-clobber --input-file=$(VIDEOS_FILE)

videos/%.mp4: _videos/%.mp4
	mkdir -p $$(dirname $@)
	ffmpeg -i $< -c:v libx264 -profile:v main -vf format=yuv420p -c:a aac -crf 28 -movflags +faststart $@

clean:
	rm -rf $(IMAGES_DIR) $(VIDEOS_DIR)

.PHONY: all install clean
