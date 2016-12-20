FROM ruby:2.3.1

MAINTAINER Louis-Gabriel ZAITI <zaiti.louisgabriel.dev@gmail.com>

ARG smashing-home=/var/smashing

RUN apt-get update && \
    apt-get -y install nodejs && \
    apt-get -y clean

RUN gem install bundler smashing

RUN mkdir $smashing-home && \
    smashing new smashing && \
    cd $smashing-home && \
    bundle && \
    ln -s $smashing-home/dashboards /dashboards && \
    ln -s $smashing-home/jobs /jobs && \
    ln -s $smashing-home/assets /assets && \
    ln -s $smashing-home/lib /lib-smashing && \
    ln -s $smashing-home/public /public && \
    ln -s $smashing-home/widgets /widgets && \
    mkdir /smashing/config && \
    mv /smashing/config.ru /smashing/config/config.ru && \
    ln -s $smashing-home/config/config.ru /smashing/config.ru && \
    ln -s $smashing-home/config /config

COPY run.sh /

VOLUME ["/dashboards", "/jobs", "/lib-smashing", "/config", "/public", "/widgets", "/assets"]

ENV PORT 3030
EXPOSE $PORT
WORKDIR /smashing

CMD ["/run.sh"]

