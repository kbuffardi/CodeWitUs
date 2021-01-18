#!/bin/bash
set -e

# Remove a potentially pre-existing .pid for Rails and Postgres
rm -f /codewit/tmp/pids/server.pid
rm -f /usr/local/var/postgres/postmaster.pid

# Set up database
rails db:create
rails db:migrate

# Set up yarn versioning
rails webpacker:install

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
