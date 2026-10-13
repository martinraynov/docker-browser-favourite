#!/bin/bash
set -e

cd /srv/jekyll

echo "Cleaning build artifacts..."
rm -rf _site .jekyll-cache .sass-cache .jekyll-metadata

if [ -d "_site" ]; then
    echo "WARNING: _site still exists after cleanup!"
    rm -rf _site/*
fi

echo "Building Jekyll site to verify configuration..."
bundle exec jekyll build --trace --verbose || {
    echo "ERROR: Jekyll build failed. Check the error messages above."
    exit 1
}

if [ ! -d "_site" ] || [ -z "$(ls -A _site)" ]; then
    echo "ERROR: _site directory is empty or doesn't exist!"
    exit 1
fi

if [ ! -f "_site/index.html" ]; then
    echo "WARNING: index.html not found in _site directory!"
    ls -la _site/
else
    echo "Build successful. Found index.html in _site directory."
fi

echo "Starting Jekyll server..."
LIVERELOAD_ARGS=""
if [ "${JEKYLL_DISABLE_LIVERELOAD}" != "1" ] && [ "${JEKYLL_DISABLE_LIVERELOAD}" != "true" ]; then
  LIVERELOAD_ARGS="--livereload"
fi
exec bundle exec jekyll serve --host 0.0.0.0 --port 4000 --source /srv/jekyll --destination /srv/jekyll/_site --force_polling --watch $LIVERELOAD_ARGS --trace
