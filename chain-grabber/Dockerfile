ARG RUBY_VERSION=3.0.3
FROM ruby:$RUBY_VERSION

RUN apt-get update && apt-get install -y  build-essential \
  git libpq-dev libcurl4 libjemalloc2 \
  libsecp256k1-dev libsodium-dev
ENV LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libjemalloc.so.2  
WORKDIR /usr/src/
RUN git clone https://github.com/nervosnetwork/ckb-explorer.git
RUN for i in $(ls -d ckb-explorer/.*);do test -f $i && mv -v $i ./; done;
RUN mv ckb-explorer/* .
ARG RAILS_ENV=development
ARG BUNDLER_VERSION=2.2.32
ENV RAILS_ENV=$RAILS_ENV
ENV RAILS_SERVE_STATIC_FILES true
ENV RAILS_LOG_TO_STDOUT true
ENV DB_HOST=postgres

RUN gem i -N bundler:${BUNDLER_VERSION} foreman
RUN bundle config --global frozen 1 && \
  bundle config set --local path 'vendor/bundle' && \
  bundle config deployment true
RUN bundle install -j4 --retry 3 && rm -rf vendor/cache

RUN echo "CKB_NODE_URL=http://node:8114" > .env.local
RUN echo "REDIS_URL=redis://redis:6379/1" >> .env.local
RUN touch config/settings.local.yml

# Install PostgreSQL client
RUN apt-get install postgresql-client -y

ADD ./docker-entrypoint.sh .

ENTRYPOINT ["/usr/src/docker-entrypoint.sh"]
