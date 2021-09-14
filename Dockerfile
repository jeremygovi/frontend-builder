FROM node:12-alpine as node_builder
ENV PHRASE_VERSION 2.1.6

# Install some base packages
RUN apk --no-cache --update --virtual build-dependencies add git make g++ \
    && rm -rf /var/cache/apk/*

ADD https://github.com/phrase/phrase-cli/releases/download/${PHRASE_VERSION}/phrase_linux_amd64 /usr/local/bin/phrase
RUN chmod +x /usr/local/bin/phrase

# isntall aws cli
RUN apk add --no-cache \
        python3 \
        py3-pip \
    && pip3 install --upgrade pip \
    && pip3 install \
        awscli==1.14.5 s3cmd==2.0.1 \
    && rm -rf /var/cache/apk/*
