#!/bin/bash
set -e

# Remove a potentially pre-existing .pid for Rails and Postgres
rm -f /codewit/tmp/pids/server.pid
rm -f /usr/local/var/postgres/postmaster.pid

# Rebuild dependencies from scratch
bundle update --all || bundle install

# Set up database
bundle exec rails db:create
bundle exec rails db:migrate

# Set up yarn versioning
bundle exec rails webpacker:install

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
