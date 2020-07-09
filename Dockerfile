FROM nginx:alpine as production

ENV CODO_VER="codo-beta-0.3.5"

RUN mkdir -p /var/www/codo && sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories
RUN rm -fr /etc/nginx/conf.d/default.conf

WORKDIR /var/www/

COPY docker/nginx_ops.conf  /etc/nginx/conf.d/codo_frontend.conf

#RUN wget https://github.com/opendevops-cn/codo/releases/download/${CODO_VER}/${CODO_VER}.tar.gz && tar zxf ${CODO_VER}.tar.gz && rm -fr ${CODO_VER}.tar.gz

ADD ./releases/${CODO_VER}.tar.gz .


EXPOSE 80
EXPOSE 443

STOPSIGNAL SIGTERM

CMD ["nginx", "-g", "daemon off;"]
