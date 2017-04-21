FROM alpine:3.4

RUN apk --no-cache add curl wget ca-certificates bash git vim
RUN adduser -D hab
WORKDIR /root

ENV SCRIPT https://raw.githubusercontent.com/habitat-sh/habitat/master/components/hab/install.sh
ENV TUTO https://github.com/habitat-sh/habitat-example-plans
RUN curl "$SCRIPT" | bash
RUN git clone "$TUTO"

WORKDIR /root/habitat-example-plans/mytutorialapp
COPY plan.sh ./habitat/plan.sh
