FROM nginx:1.13.9-alpine

LABEL io.openshift.s2i.scripts-url=image:///usr/lib/s2i

RUN mkdir /usr/lib/s2i && \
    chmod a+w /usr/share/nginx/html /var/cache/nginx /var/run && \
    sed -i -e 's/listen       80;/listen       8080;/' \
           -e 's/location \/ {/location ~ ^\/[^\/]* {/' \
           -e 's/\(.*\)#error_page\( *\)404/\1error_page\2404/' \
           -e '/^ *server.*localhost;$/a\    rewrite ^\/([^\\.]+[^\/])$ $1\/ permanent;' /etc/nginx/conf.d/default.conf

# COPY assemble run /usr/lib/s2i/

EXPOSE 8080

USER 1001