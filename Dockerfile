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

RUN rm -rf /usr/local/bundle/cache/* \
    /usr/local/share/.cache/* \
    /var/cache/* \
    /tmp/* \
    /usr/lib/mysqld* \
    /usr/bin/mysql*

RUN mkdir /app
ENV APP_ROOT /app
WORKDIR $APP_ROOT

ADD ./Gemfile $APP_ROOT/Gemfile
ADD ./Gemfile.lock $APP_ROOT/Gemfile.lock

RUN bundle install
ADD . $APP_ROOT

EXPOSE  3000
