#!/bin/bash
set -e

# For development check if the gems are installed
if ! bundle check >/dev/null; then
  bundle install
fi

# Remove a potentially pre-existing server.pid for Rails
rm -f /app/tmp/pids/server.pid

# Then exec the container's main process
# (what's set as CMD in the Dockerfile, passed in CLI, or defined in docker-compose).
exec "$@"
