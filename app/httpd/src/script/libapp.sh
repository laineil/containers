#!/bin/bash
#
# Library for setting up OpenLDAP

# load env & lib
. /opt/script/libenv.sh
. /opt/script/liblog.sh

### set up rootca ###
httpd_rootca() {
    info "TLS ROOTCA is being set."
    if [[ $ROOTCA == "disable" ]]; then
        warn "To enhance security, we recommend using TLS with a CA certificate."
    elif [[ $ROOTCA == "enable" ]]; then
        sed -i "s/#SSLCACertificateFile/SSLCACertificateFile/g" $SSL_CONF
    else
        error "ROOTCA setting is incorrect."
        exit 1
    fi
}

### setup apache httpd ###
httpd_setup() {
    info "** Starting Apache HTTPD setup **"
    httpd_rootca
    info "** Apache HTTPD setup finished **"
}
