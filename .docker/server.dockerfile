# Adapted from: https://docs.docker.com/compose/rails/
FROM ruby:2.7.0

# import build time args (needed for build) (more args below)
ARG HOST_UID
ARG HOST_GID
ARG NODE_MODULES_PATH

# prepare nodejs install
RUN curl -sSL https://deb.nodesource.com/setup_12.x | bash -

# prepare yarn install
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# NOTE: RUN and CMD are always run as root
# NOTE: yarn needs write permissions in several files/folders

# create folders, owned by root
RUN mkdir /server && mkdir /.cache

# create files and folders, owned by host user
RUN mkdir /.cache/yarn && chown ${HOST_UID}:${HOST_GID} /.cache/yarn
RUN touch /.yarnrc && chown ${HOST_UID}:${HOST_GID} /.yarnrc
RUN mkdir /.bundle && chown ${HOST_UID}:${HOST_GID} /.bundle

# install packages
RUN apt-get update -qq && apt-get install -y \
  postgresql-client \
  nodejs \
  yarn

WORKDIR /server

COPY ./server/Gemfile /server/Gemfile
COPY ./server/Gemfile.lock /server/Gemfile.lock
RUN bundle install

# NOTE: yarn should not install into /server/node_modules, because all files
#       inside /server will be obscured by a Docker bind mount
COPY ./server/package.json /server/package.json
COPY ./server/yarn.lock /server/yarn.lock
RUN yarn install --production=false --modules-folder=$NODE_MODULES_PATH
RUN chown -R ${HOST_UID}:${HOST_GID} $NODE_MODULES_PATH
ENV NODE_PATH=$NODE_MODULES_PATH
ENV WEBPACKER_NODE_MODULES_BIN_PATH=${NODE_MODULES_PATH}/.bin

# prevent irb from crashing on close
RUN touch /.irb_history && chown ${HOST_UID}:${HOST_GID} /.irb_history

COPY ./server /server

# import build time args (proxy to env) (placed lower to improve build caching)
ARG RAILS_PORT
ARG LIVERELOAD_PORT
ARG USE_LIVERELOAD
ARG WEBPACKER_PORT
ARG USE_WEBPACKER
ARG RAILS_LOG_TO_STDOUT
ARG POSTGRES_USER
ARG POSTGRES_PASSWORD
ARG RUBYOPT

# runtime env vars
ENV HOST_UID=$HOST_UID
ENV HOST_GID=$HOST_GID
ENV RAILS_PORT=$RAILS_PORT
ENV LIVERELOAD_PORT=$LIVERELOAD_PORT
ENV USE_LIVERELOAD=$USE_LIVERELOAD
ENV WEBPACKER_PORT=$WEBPACKER_PORT
ENV USE_WEBPACKER=$USE_WEBPACKER
ENV RAILS_LOG_TO_STDOUT=$RAILS_LOG_TO_STDOUT
ENV POSTGRES_USER=$POSTGRES_USER
ENV POSTGRES_PASSWORD=$POSTGRES_PASSWORD
ENV RUBYOPT=$RUBYOPT

# Add a script to be executed every time the container starts
COPY ./.docker/start_server_container.sh /usr/bin/
RUN chmod +x /usr/bin/start_server_container.sh
ENTRYPOINT ["start_server_container.sh"]
EXPOSE $RAILS_PORT
EXPOSE $LIVERELOAD_PORT
EXPOSE $WEBPACKER_PORT

# Start the main process
# NOTE: this command is overridden in docker-compose.yml
CMD ["foreman", "start"]
