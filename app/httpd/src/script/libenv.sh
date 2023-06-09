#!/bin/bash
#
# Library for defining env variable

# system httpd
HTTPD_PID_FILE=/run/httpd/httpd.pid
HTTPD_CONF=/etc/httpd/conf/httpd.conf
SSL_CONF=/etc/httpd/conf.d/ssl.conf

# dynamic var
HTTPD_LOG_LEVEL="${HTTPD_LOG_LEVEL:-warn}"
HTTPD_TLS_ROOTCA="${HTTPD_TLS_ROOTCA:-disable}"
