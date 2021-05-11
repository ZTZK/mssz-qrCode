FROM alpine
MAINTAINER mssz
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories
RUN apk add --no-cache tini openrc busybox-initscripts
COPY * /usr/local/bin/
RUN echo "1 * * * * rm -f /usr/local/bin/static/*">>/var/spool/cron/crontabs/root
RUN echo "* * * * * run-parts /etc/periodic/15min">>/var/spool/cron/crontabs/root
RUN cp /var/spool/cron/crontabs/root /etc/periodic/15min
RUN rc-update add crond
RUN chmod +x /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/web_app
ENTRYPOINT ./usr/local/bin/run.sh
