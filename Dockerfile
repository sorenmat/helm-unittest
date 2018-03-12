FROM alpine

ENV HELM_LATEST_VERSION="v2.8.2"

RUN apk add --update ca-certificates
RUN apk add --update -t deps wget
RUN apk add --update git
RUN apk add --update bash curl
RUN wget http://storage.googleapis.com/kubernetes-helm/helm-${HELM_LATEST_VERSION}-linux-amd64.tar.gz \
 && tar -xvf helm-${HELM_LATEST_VERSION}-linux-amd64.tar.gz \
 && mv linux-amd64/helm /usr/local/bin \
 && apk del --purge deps \
 && rm /var/cache/apk/* \
 && rm -f /helm-${HELM_LATEST_VERSION}-linux-amd64.tar.gz

RUN mkdir -p ~/.helm/plugins
RUN helm plugin install https://github.com/lrills/helm-unittest

ENTRYPOINT ["helm"]
CMD ["help"]