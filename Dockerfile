FROM golang:1.10.2-stretch
MAINTAINER ymijorski@gmail.com

# install build-tools
RUN apt-get update -y && apt-get -y install git build-essential

# build
RUN mkdir /app && cd /app && git clone https://github.com/ymijorski/goburstpool . && make build

WORKDIR /app

# cleanup build artifacts
RUN apt-get --purge remove -y git build-essential
RUN apt-get autoremove -y && apt-get clean autoclean
RUN rm -rf /var/lib/{apt,dpkg,cache,log} /tmp/* /var/tmp/*

EXPOSE 8124
EXPOSE 8080
EXPOSE 7777

ENTRYPOINT ./goburstpool