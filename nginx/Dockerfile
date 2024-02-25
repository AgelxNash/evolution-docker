FROM nginx:1.21.3-alpine

ARG UID
ARG GID
ARG NODE_NAME

ENV UID=${UID}
ENV GID=${GID}
ENV USER=evolution
ENV GROUP=evolution
ENV NODE_NAME=${NODE_NAME}
ENV ESC='$'

# MacOS staff group's gid is 20, so is the dialout group in alpine linux. We're not using it, let's just remove it.
RUN delgroup dialout

RUN addgroup -g ${GID} --system evolution
RUN adduser -G evolution --system -D -s /bin/sh -u ${UID} evolution
RUN sed -i "s/user nginx/user evolution/g" /etc/nginx/nginx.conf

COPY nginx.conf /etc/nginx/nginx.conf
COPY default.conf /etc/nginx/conf.d/default.conf.template
RUN envsubst < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf

RUN mkdir -p /var/cache/nginx && chown -R ${USER}:${GROUP} /var/cache/nginx && \
    mkdir -p /var/log/nginx  && chown -R ${USER}:${GROUP} /var/log/nginx && \
    mkdir -p /var/lib/nginx  && chown -R ${USER}:${GROUP} /var/lib/nginx && \
    mkdir -p /var/www/html && chown -R evolution:evolution /var/www/html && \
    touch /run/nginx.pid && chown -R ${USER}:${GROUP} /run/nginx.pid && \
    mkdir -p /etc/nginx/templates /etc/nginx/ssl/certs && \
    chown -R ${USER}:${GROUP} /etc/nginx && \
    chmod -R 777 /etc/nginx/conf.d

USER evolution
WORKDIR /var/www/html

CMD ["nginx", "-g", "daemon off;"]