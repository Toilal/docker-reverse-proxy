FROM httpd:2.4
LABEL maintainer="Rémi Alvergnat <remi.alvergnat@gfi.fr>"

{{#DOCKER_DEVBOX_CA_CERTIFICATES}}
COPY .ca-certificates/* /usr/local/share/ca-certificates/
RUN apt-get update && apt-get install -y ca-certificates && update-ca-certificates
{{/DOCKER_DEVBOX_CA_CERTIFICATES}}

RUN mkdir -p /usr/local/apache2/conf/custom \
&& mkdir -p /var/www/html \
&& sed -i '/LoadModule proxy_module/s/^#//g' /usr/local/apache2/conf/httpd.conf \
&& sed -i '/LoadModule proxy_fcgi_module/s/^#//g' /usr/local/apache2/conf/httpd.conf \
&& echo >> /usr/local/apache2/conf/httpd.conf && echo 'Include conf/custom/*.conf' >> /usr/local/apache2/conf/httpd.conf


RUN sed -i '/LoadModule rewrite_module/s/^#//g' /usr/local/apache2/conf/httpd.conf

RUN sed -i '/LoadModule proxy_module/s/^#//g' /usr/local/apache2/conf/httpd.conf \
&& sed -i '/LoadModule proxy_http_module/s/^#//g' /usr/local/apache2/conf/httpd.conf \
&& sed -i '/LoadModule ssl_module/s/^#//g' /usr/local/apache2/conf/httpd.conf \
&& sed -i '/LoadModule proxy_connect_module/s/^#//g' /usr/local/apache2/conf/httpd.conf