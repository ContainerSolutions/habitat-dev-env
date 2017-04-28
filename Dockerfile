FROM alpine:3.4

ARG uid

RUN apk --no-cache add sudo bash tar xz make \
	&& echo "hab ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
	&& adduser -D -u ${uid} hab

ARG script=https://raw.githubusercontent.com/habitat-sh/habitat/master/components/hab/install.sh
RUN apk --no-cache add -t build-pkgs curl wget ca-certificates \
	&& curl "$script" | bash \
	&& apk del build-pkgs

USER hab
ENV HAB_ORIGIN cs
RUN hab origin key generate cs && \
		hab origin key export cs --type public | sudo hab origin key import
VOLUME /hab
COPY rebuild /usr/bin/
