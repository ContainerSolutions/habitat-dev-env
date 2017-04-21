FROM alpine:3.4

RUN apk --no-cache add curl wget ca-certificates bash git vim sudo

ENV SCRIPT https://raw.githubusercontent.com/habitat-sh/habitat/master/components/hab/install.sh
ENV TUTO https://github.com/habitat-sh/habitat-example-plans

RUN curl "$SCRIPT" | bash

RUN hab origin key generate cs && \
		hab origin key export cs --type public | hab origin key import
ENV HAB_ORIGIN cs

RUN adduser -D hab
RUN echo "#1000 ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
WORKDIR /mnt
