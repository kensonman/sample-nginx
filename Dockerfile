FROM nginx:stable-alpine
LABEL maintainer="Kenson Man <kenson@kenson.idv.hk>"
LABEL version=v1.0.0

ENV WDIR=/usr/share/nginx/html

COPY src/ ${WDIR}/
COPY scripts/  /scripts/


RUN echo ">>   Installing dependancies..." \
 && mkdir -p /var/log/supervisor \
 && apk update \
 && apk upgrade \
 && apk add --update --no-cache bash nginx supervisor vim sed \
 && adduser -S theuser \
 && mkdir -p ${WDIR}/logs \
 && mkdir -p /usr/share/nginx/html/.well-know \
 && chown -R theuser:www-data ${WDIR} \
 && chmod +x /scripts/entrypoint \
 && ln -s /scripts/entrypoint /usr/bin/entrypoint \
 && echo ">>   Finishing..."

EXPOSE 80

ENTRYPOINT ["/scripts/entrypoint"]
CMD ["run"]
WORKDIR ${WDIR}
