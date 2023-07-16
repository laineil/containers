#!/bin/bash
#
# Library for defining env variable

# system httpd
export HTTPD_PID_FILE=/run/httpd/httpd.pid
export HTTPD_CONF=/etc/httpd/conf/httpd.conf
export SSL_CONF=/etc/httpd/conf.d/ssl.conf

# dynamic var
export HTTPD_LOG_LEVEL="${HTTPD_LOG_LEVEL:-warn}"
export HTTPD_TLS_ROOTCA="${HTTPD_TLS_ROOTCA:-disable}"
