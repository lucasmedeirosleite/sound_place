FROM elixir:1.5.1

RUN apt-get update \
    && apt-get install -y apt-utils \
    && apt-get install -y curl \
    && apt-get install -y inotify-tools \
    && curl -sL https://deb.nodesource.com/setup_8.x | bash - \
    && apt-get install -y postgresql-client build-essential nodejs \
    && npm install -g brunch

ENV DEBIAN_FRONTEND=noninteractive

ENV APP_HOME /app
RUN mkdir -p $APP_HOME/tmp

ENV HISTFILE $APP_HOME/tmp/docker_histfile
ENV LANG C.UTF-8

RUN mix local.hex --force
RUN mix local.rebar --force

RUN mix archive.install --force https://github.com/phoenixframework/archives/raw/master/phx_new.ez

WORKDIR $APP_HOME

CMD scripts/start.sh
