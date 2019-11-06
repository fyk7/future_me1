FROM ruby:2.6.5-alpine3.10

RUN apk update && \
    apk add --no-cache \
    curl-dev \
    gcc \
    g++ \
    imagemagick6-dev \
    libxml2-dev \
    libc-dev \
    mariadb-dev \
    make \
    tzdata \
    vim \
    nodejs \
    yarn

RUN mkdir /app
ENV APP_ROOT /app
WORKDIR $APP_ROOT

ADD ./Gemfile $APP_ROOT/Gemfile
ADD ./Gemfile.lock $APP_ROOT/Gemfile.lock

RUN bundle install --jobs=4
ADD . $APP_ROOT

EXPOSE  3000

ENV RAILS_ENV production

ARG RAILS_MASTER_KEY
ENV RAILS_MASTER_KEY $RAILS_MASTER_KEY

RUN RAILS_ENV=production bundle exec rake assets:precompile
RUN rm -f tmp/pids/server.pid
CMD ["bundle", "exec", "rails", "s", "puma", "-b", "0.0.0.0", "-p", "3000", "-e", "production"]

