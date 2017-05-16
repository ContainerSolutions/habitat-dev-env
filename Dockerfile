FROM alpine:3.4

ARG uid

RUN apk --no-cache add sudo bash tar xz make \
	&& echo "hab ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
	&& adduser -D -u ${uid} hab

ARG script=https://api.bintray.com/content/habitat/stable/linux/x86_64/hab-%24latest-x86_64-linux.tar.gz?bt_package=hab-x86_64-linux
RUN apk --no-cache add -t build-pkgs wget ca-certificates tar \
	&& wget -qO - "$script" | tar zxf - \
	&& mv hab-*/hab /usr/local/bin && chmod a+x /usr/local/bin/hab && rm -rf hab-* \
	&& apk del build-pkgs

USER hab
ENV HAB_ORIGIN cs
RUN hab origin key generate cs && \
		hab origin key export cs --type public | sudo hab origin key import
VOLUME /hab
VOLUME /home/hab/.hab
