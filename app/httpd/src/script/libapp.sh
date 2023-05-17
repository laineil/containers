#!/bin/bash
#
# Library for setting up OpenLDAP

# load env & lib
. /opt/script/libenv.sh
. /opt/script/liblog.sh

### set up rootca ###
httpd_tls_rootca() {
    info "HTTPD TLS ROOTCA is being set."
    if [[ $HTTPD_TLS_ROOTCA == "disable" ]]; then
        warn "To enhance security, we recommend using TLS with a CA certificate."
    elif [[ $HTTPD_TLS_ROOTCA == "enable" ]]; then
        sed -i "s/#SSLCACertificateFile/SSLCACertificateFile/g" $SSL_CONF
    else
        error "HTTPD_TLS_ROOTCA setting is incorrect."
        exit 1
    fi
}

### setup apache httpd ###
httpd_setup() {
    info "** Starting Apache HTTPD setup **"
    httpd_tls_rootca
    info "** Apache HTTPD setup finished **"
}
