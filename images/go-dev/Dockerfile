# docker build . -t $DOCKER_USERNAME/go-dev
# docker push $DOCKER_USERNAME/go-dev

FROM golang:1.14-alpine

# @see https://stackoverflow.com/questions/40944479
# @see https://wiki.alpinelinux.org/wiki/Docker#Installation
RUN apk add bash docker

# we use this all the time, so try to get a nice looking bash
COPY bashrc /root/.bashrc
RUN chmod u+x /root/.bashrc

# mount project
VOLUME /go-dev
WORKDIR /go-dev
