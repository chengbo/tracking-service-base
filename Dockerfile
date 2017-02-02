FROM python:3.6-alpine
MAINTAINER Bo Cheng <chengbo1983@gmail.com>

EXPOSE 80
EXPOSE 514 514/udp

RUN apk update && apk upgrade && \
      apk add --no-cache build-base linux-headers libxml2-dev libxslt-dev rsyslog supervisor \
      && rm -rf /var/cache/apk/*

RUN pip3 install uwsgi
RUN pip3 install requests
RUN pip3 install lxml
RUN pip3 install suds-jurko
RUN pip3 install Flask

RUN mkdir /src

WORKDIR /src

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

ENTRYPOINT ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
