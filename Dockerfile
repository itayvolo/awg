from ptobo/php-mssql:latest
COPY ./html/ /var/www/html
COPY ./httpd.conf /etc/httpd/conf/httpd.conf
