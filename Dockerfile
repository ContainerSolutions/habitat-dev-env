FROM alpine:3.4

RUN apk --no-cache add sudo

ENV SCRIPT https://raw.githubusercontent.com/habitat-sh/habitat/master/components/hab/install.sh
RUN apk --no-cache add -t build-pkgs curl wget ca-certificates bash \
	&& curl "$SCRIPT" | bash \
	&& apk del build-pkgs

ENV HAB_ORIGIN cs
WORKDIR /mnt

ARG uid
RUN adduser -D -u ${uid} hab
RUN echo "#${uid} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER hab
RUN hab origin key generate cs && \
		hab origin key export cs --type public | sudo hab origin key import
