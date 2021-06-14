FROM golang:1.16.5-alpine

# First dummy image
ENV GOPATH="/go"
ENV APPPATH="$GOPATH/src/github.com/alice-lg"

RUN apk add --update --no-cache git make g++ musl-dev python2 npm nodejs && \
    apk add --update --no-cache -X http://dl-cdn.alpinelinux.org/alpine/edge/community yarn && \
    npm install --global gulp-cli && \
    mkdir -p $GOPATH/bin $GOPATH/pkg $APPPATH && \
    cd $APPPATH && \
    go get github.com/GeertJohan/go.rice && \
    go get github.com/GeertJohan/go.rice/rice && \
    git clone https://github.com/alice-lg/alice-lg.git && \
    cd alice-lg && \
    make

## Secound primary image
FROM alpine:3.12

LABEL org.opencontainers.image.created="Thu, 11 Mar 2021 23:06:13 +0000"
LABEL org.opencontainers.image.authors="Tim Oliver Rabl <info@timrabl.de>"
LABEL org.opencontainers.image.url="https://github.com/timrabl/alice-lg.git"
LABEL org.opencontainers.image.version="4.2.0"
LABEL org.opencontainers.image.title="alice-lg"
LABEL org.opencontainers.image.description="Your docker based lookingglass."

ENV GOPATH="/go"
ENV APPPATH="$GOPATH/src/github.com/alice-lg"

COPY --from=0 $APPPATH/alice-lg/bin/alice-lg-linux-amd64 /usr/local/bin/alice-lg-linux-amd64

CMD ["alice-lg-linux-amd64"]
