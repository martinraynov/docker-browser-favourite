FROM ruby:3.2.0

WORKDIR /srv/jekyll

RUN apt-get update && \
    apt-get install -y build-essential git && \
    rm -rf /var/lib/apt/lists/*

COPY Gemfile* ./

RUN bundle install

COPY docker/docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

EXPOSE 4000 35729

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
