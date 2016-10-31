FROM fabric8/fluentd:0.14.8

MAINTAINER Gilbert Roulot <gilbert.roulot@tech-angels.com>

ENTRYPOINT ["fluentd"]

RUN apk-install curl-dev wget

RUN gem install fluent-plugin-kubernetes_metadata_filter \
                fluent-plugin-forest \
                gelf

RUN mkdir -p /etc/fluent/plugin \
    && wget https://raw.githubusercontent.com/tech-angels/fluent-plugin-gelf/master/lib/fluent/plugin/out_gelf.rb -O /etc/fluent/plugin/out_gelf.rb

ENV GELF_HOST graylog.default.svc.cluster.local
ENV GELF_PORT 12900
ENV OVH_TOKEN DEFAULT

ADD fluent.conf /etc/fluent/fluent.conf
