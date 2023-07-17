#!/bin/bash
#
# Library for setting up OpenLDAP

# load env & lib
. /opt/script/libenv.sh
. /opt/script/liblog.sh

### set up httpd tls rootca ###
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

### check ldap tls reqcert ###
ldap_tls_reqcert() {
    info "Check if the LDAP_TLS_REQCERT setting is correct."
    if [[ $LDAP_TLS_REQCERT == "never" || $LDAP_TLS_REQCERT == "allow" ]]; then
        warn "To enhance security, we recommend setting try/never to LDAP_TLS_REQCERT."
    elif [[ $LDAP_TLS_REQCERT == "try" || $LDAP_TLS_REQCERT == "demand" ]]; then
        :
    else
        error "LDAP_TLS_REQCERT setting is incorrect."
        exit 1
    fi
}

### set up /etc/openldap/ldap.conf ###
ldap_conf() {
    info "LDAP configuration for TLS is being set."
    if [[ $LDAP_CONN_MODE == "ldap" ]]; then
        info "LDAP_TLS_REQCERT is ignored since ldaps is not enabled."
    elif [[ $LDAP_CONN_MODE == "ldaps" ]]; then
        ldap_tls_reqcert
        echo "TLS_CACERT      $LDAP_CA" >> $LDAP_CONF
        echo "TLS_REQCERT     $LDAP_TLS_REQCERT" >> $LDAP_CONF
    else
        error "LDAP_CONN_MODE setting is incorrect."
        exit 1
    fi
}

### phpLDAPadmin set up ldap host ###
phpldap_ldap_server() {
    info "phpLDAPadmin ldap server info is being set."
    if (( $LDAP_CONN_PORT < 1 || $LDAP_CONN_PORT > 65535 )); then
        error "LDAP_CONN_PORT setting is incorrect."
        exit 1
    fi
    sed -i "s|// \(\$servers->setValue('server','host','127.0.0.1');\)|\1|g" $PHP_CONF
    sed -i "s|// \(\$servers->setValue('server','port',389);\)|\1|g" $PHP_CONF
    sed -i "s|'host','127.0.0.1'|'host',\'$LDAP_CONN_MODE://$LDAP_SERVER_HOST\'|g" $PHP_CONF
    sed -i "s/'port',389/'port',$LDAP_CONN_PORT/g" $PHP_CONF
}

### phpLDAPadmin set up ldap server name ###
phpldap_server_name() {
    info "phpLDAPadmin ldap server name is being set."
    if [[ $LDAP_SERVER_NAME == "default" ]]; then
        :
    else
        sed -i "s/Local LDAP Server/$LDAP_SERVER_NAME/g" $PHP_CONF
    fi
}

### phpLDAPadmin set up login attr ###
phpldap_login_attr() {
    info "phpLDAPadmin login attr is being set."
    if [[ $PHPLDAP_LOGIN_ATTR == "dn" ]]; then
        sed -i "s/'attr','uid'/'attr','dn'/g" $PHP_CONF
    elif [[ $PHPLDAP_LOGIN_ATTR == "uid" ]]; then
        :
    else
        error "PHPLDAP_LOGIN_ATTR setting is incorrect."
        exit 1
    fi
}

### phpLDAPadmin set up auth_type ###
phpldap_auth_type() {
    info "phpLDAPadmin authentication information type is being set."
    sed -i "s|// \(\$servers->setValue('login','auth_type','session');\)|\1|g" $PHP_CONF
    valid_options=("cookie" "session" "http" "config" "sasl" "sasl_external")
    if [[ ! " ${valid_options[@]} " =~ " $PHPLDAP_AUTH_TYPE " ]]; then
        error "PHPLDAP_AUTH_TYPE setting is incorrect."
        #exit 1
    fi
    sed -i "s/'auth_type','session'/'auth_type',\'$PHPLDAP_AUTH_TYPE\'/g" $PHP_CONF
}

### phpLDAPadmin set up anonymous binding ###
phpldap_anon_bind() {
    info "phpLDAPadmin anonymous binding is being set."
    if [[ $PHPLDAP_ANON_BIND == "enable" ]]; then
        :
    elif [[ $PHPLDAP_ANON_BIND == "disable" ]]; then
        sed -i "s|// \(\$servers->setValue('login','anon_bind',true);\)|\1|g" $PHP_CONF
        sed -i "s/'anon_bind',true/'anon_bind',false/g" $PHP_CONF
    else
        error "PHPLDAP_ANON_BIND setting is incorrect."
        echo $PHPLDAP_ANON_BIND
        #exit 1
    fi
}

### phpLDAPadmin set up session timeout ###
phpldap_session_timeout() {
    info "phpLDAPadmin session timeout is being set."
    if [[ $PHPLDAP_SESSION_TIMEOUT == "disable" ]]; then
        :
    elif [[ "$PHPLDAP_SESSION_TIMEOUT" =~ ^[1-9][0-9]*$ ]]; then
        sed -i "s|#  \(\$servers->setValue('login','timeout',30);\)|\1|g" $PHP_CONF
        sed -i "s/'timeout',30/'timeout',$PHPLDAP_SESSION_TIMEOUT/g" $PHP_CONF
    else
        error "PHPLDAP_SESSION_TIMEOUT setting is incorrect."
        exit 1
    fi
}

### phpLDAPadmin hide the warnings for invalid objectClasses/attributes  ###
phpldap_hide_warn() {
    info "Whether phpLDAPadmin hides the warnings."
    if [[ $PHPLDAP_HIDE_WARN == "enable" ]]; then 
        sed -i "s|// \(\$config->custom->appearance\['hide_template_warning'\] = false;\)|\1|g" $PHP_CONF
        sed -i "s/\['hide_template_warning'\] = false;/['hide_template_warning'\] = true;/g" $PHP_CONF
    elif [[ $PHPLDAP_HIDE_WARN == "disable" ]]; then
        :
    else
        error "PHPLDAP_HIDE_WARN setting is incorrect."
        exit 1
    fi
}

### phpLDAPadmin sample login DN  ###
phpldap_sample_dn() {
    info "phpLDAPadmin sample login dn being set."
    if [[ $PHPLDAP_SAMPLE_DN == "disable" ]]; then
        :
    else
        sed -i "s|#  \(\$servers->setValue('login','bind_id','cn=Manager,dc=example,dc=com');\)|\1|g" $PHP_CONF
        sed -i "s/cn=Manager,dc=example,dc=com/$PHPLDAP_SAMPLE_DN/g" $PHP_CONF
    fi
}

### set up apache httpd ###
httpd_setup() {
    info "** Starting Apache HTTPD setup **"
    httpd_tls_rootca
    info "** Apache HTTPD setup finished **"
}

### set up phpldapadmin ###
phpldapadmin_setup() {
    info "** Starting phpLDAPadmin setup **"
    ldap_conf
    phpldap_ldap_server
    phpldap_server_name
    phpldap_login_attr
    phpldap_auth_type
    phpldap_anon_bind
    phpldap_session_timeout
    phpldap_hide_warn
    phpldap_sample_dn
    info "** phpLDAPadmin setup finished **"
}
