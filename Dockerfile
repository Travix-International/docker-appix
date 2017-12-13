FROM alpine:3.6

ARG APPIX_AUTH

ENV USER="appix"

RUN apk --no-cache add curl jq busybox-suid \
  && adduser -h /home/appix -s /bin/sh -D -S appix

USER appix

RUN touch $HOME/.profile \
  && curl -sSL https://raw.githubusercontent.com/Travix-International/appix/master/appixinstall.sh | sh \
  && echo "export PATH=$PATH:$HOME/.appix" >> $HOME/.profile \
  && echo $APPIX_AUTH | base64 -d > $HOME/.appix/auth.json

COPY ./scripts/deploy.sh /home/appix

USER root

RUN chown appix /home/appix/deploy.sh

USER appix

RUN chmod +x $HOME/deploy.sh

ENTRYPOINT [ "/bin/sh", "-l" ]