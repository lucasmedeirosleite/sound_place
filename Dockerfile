FROM elixir:1.5.1

RUN apt-get update \
    && apt-get install -y apt-utils \
    && apt-get install -y curl \
    && apt-get install -y inotify-tools \
    && curl -sL https://deb.nodesource.com/setup_8.x | bash - \
    && apt-get install -y postgresql-client build-essential nodejs \
    && npm install -g brunch

ENV DEBIAN_FRONTEND=noninteractive
ENV MIX_ENV prod
ENV APP_HOME /app

ENV HISTFILE $APP_HOME/tmp/docker_histfile
ENV LANG C.UTF-8

RUN mkdir -p $APP_HOME/tmp

RUN mix local.hex --force
RUN mix local.rebar --force

RUN mix archive.install --force https://github.com/phoenixframework/archives/raw/master/phx_new.ez

WORKDIR $APP_HOME

RUN mix deps.get --only prod
RUN mix compile
RUN cd assets && npm install && brunch build --production && cd ..
RUN mix phx.digest
