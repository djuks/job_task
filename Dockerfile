FROM ruby:2.7.2

# install dependencies
RUN apt-get update -qq && apt-get install -y \
  nodejs

WORKDIR /app

# Add a script to be executed every time the container starts.
COPY docker-entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]
