# Based on Blockstream's esplora project

FROM debian:stretch-slim

ARG NODE_ENV=production
ENV NODE_ENV $NODE_ENV

# TODO: weed out unnecessary deps
RUN apt-get -yq update \
    && apt-get -yq install \
        curl

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -

RUN apt-get -yq install nodejs

RUN npm i npm@latest -g

RUN mkdir -p /srv/faucet

WORKDIR /srv/faucet

COPY package.json package-lock.json* /srv/faucet/

# required to run some scripts as root (needed for docker)
RUN npm ci

# cleanup
# RUN apt-get --auto-remove remove -y --purge manpages git \
#  && apt-get clean \
#  && apt-get autoclean \
#  && rm -rf /usr/share/doc* /usr/share/man /usr/share/postgresql/*/man /var/lib/apt/lists/* /var/cache/* /tmp/* /root/.cache /*.deb /root/.cargo

EXPOSE 8123