#!/bin/bash
#
# Library for setting up OpenLDAP

# load env & lib
. /opt/script/libenv.sh
. /opt/script/liblog.sh

### Update ldif ###
ldap_add_ldif() {
    ldapadd -Q -Y EXTERNAL -H ldapi:// -f $1 >/dev/null 2>&1
}

### Modify ldif ###
ldap_modify_ldif() {
    ldapmodify -Q -Y EXTERNAL -H ldapi:// -f $1 >/dev/null 2>&1
}

### initialize ldap ###
ldap_init() {
    info "Initialize OpenLDAP server..."
    if [[ $LDAP_BASE_DN == "dc=example,dc=org" ]]; then
        :
    else
        sed -i "s/dc=example,dc=org/$LDAP_BASE_DN/g" $LDAP_LDIF_TMP/slapd.ldif
    fi
    slapadd -n 0 -F $LDAP_CONF_DIR -l $LDAP_LDIF_TMP/slapd.ldif >/dev/null 2>&1
}

### start ldap ###
ldap_start() {
    info "Starting OpenLDAP server in background..."
    $LDAP_SLAPD -h "$LDAP_URLS" -F $LDAP_CONF_DIR
}

### stop ldap ###
ldap_stop() {
    info "Stopping OpenLDAP server..."
    kill -9 `cat $LDAP_PID_FILE`
    sleep $SLEEP_TIME
}

### frontend admin password ###
ldap_fe_admin_pwd() {
    info "Frontend admin password is being set..."
    if [[ $LDAP_FE_ADMIN_PWD == "default" ]]; then
        :
    else
        local PWD=`slappasswd -h {SSHA} -s $LDAP_FE_ADMIN_PWD`
        echo "olcRootPW: $PWD" >> $LDAP_LDIF_TMP/admin_pwd/update_pwd_frontend_admin.ldif
        ldap_modify_ldif $LDAP_LDIF_TMP/admin_pwd/update_pwd_frontend_admin.ldif
    fi
}

### backend admin password ###
ldap_be_admin_pwd() {
    info "Backend admin password is being set..."
    if [[ $LDAP_BE_ADMIN_PWD == "default" ]]; then
        :
    else
        local PWD=`slappasswd -h {SSHA} -s $LDAP_BE_ADMIN_PWD`
        echo "olcRootPW: $PWD" >> $LDAP_LDIF_TMP/admin_pwd/update_pwd_backend_admin.ldif
        ldap_modify_ldif $LDAP_LDIF_TMP/admin_pwd/update_pwd_backend_admin.ldif
    fi
}

### TLS ###
ldap_tls() {
    info "TLS is being set..."
    if [[ $LDAP_TLS == "disable" ]]; then
        warn "To enhance security, we recommend the use of TLS encryption."
    elif [[ $LDAP_TLS == "enable_without_ca" ]]; then
        warn "To enhance security, we recommend using TLS with a CA certificate."
        ldap_add_ldif $LDAP_LDIF_TMP/tls/tls_without_ca.ldif
    elif [[ $LDAP_TLS == "enable" ]]; then
        ldap_add_ldif $LDAP_LDIF_TMP/tls/tls_with_ca.ldif
    else
        error "LDAP_TLS setting is incorrect."
        exit 1
    fi
}

### module ###
ldap_module() {
    info "module is being set..."
    ldap_add_ldif $LDAP_LDIF_TMP/module.ldif
}

### overlay ###
ldap_overlay() {
    info "overlay is being set..."
    ldap_add_ldif $LDAP_LDIF_TMP/overlay/memberof.ldif
    ldap_add_ldif $LDAP_LDIF_TMP/overlay/refint.ldif
}

### index ###
ldap_index() {
    info "index is being set..."
    ldap_add_ldif $LDAP_LDIF_TMP/index.ldif
} 

### anonymous binding ###
ldap_anon_bind() {
    info "Anonymous binding is being set..."
    if [[ $LDAP_ANON_BIND == "enable" ]]; then
        warn "To enhance security, we recommend disabling anonymous binding."
        :
    elif [[ $LDAP_ANON_BIND == "disable" ]]; then
        ldap_modify_ldif $LDAP_LDIF_TMP/access_rule/disable_bind_anon.ldif
    else
        error "LDAP_ANON_BIND setting is incorrect."
        exit 1
    fi
}

### BASE DN ###
ldap_base_dn() {
    info "BASE DN is being set..."
    if [[ $LDAP_BASE_DN == "dc=example,dc=org" ]]; then
        :
    else
        sed -i "s/dc=example,dc=org/$LDAP_BASE_DN/g" $LDAP_LDIF_TMP/base_dn.ldif
        sed -i "s/dc=example,dc=org/$LDAP_BASE_DN/g" $LDAP_LDIF_TMP/example/*/*
        sed -i "s/dc=example,dc=org/$LDAP_BASE_DN/g" $LDAP_LDIF_TMP/access_rule/*
        sed -i "s/dc=example,dc=org/$LDAP_BASE_DN/g" $LDAP_LDIF_TMP/ppolicy/*
    fi
    ldap_add_ldif $LDAP_LDIF_TMP/base_dn.ldif
}

### example tree ###
ldap_ex_ldif() {
    for ldif in `ls $LDAP_LDIF_TMP/example/$1/`
    do
        ldap_add_ldif $LDAP_LDIF_TMP/example/$1/$ldif
    done
}

ldap_ex_tree() {
    info "Example tree is being set..."
    if [[ $LDAP_EX_TREE == "enable" ]]; then
        ldap_ex_ldif ou
        ldap_ex_ldif users
        ldap_ex_ldif groups
        ldap_ex_ldif departments
    elif [[ $LDAP_EX_TREE == "disable" ]]; then
        info "LDAP_EX_TREE is currently disabled. If you need to test LDAP quickly, we recommend enabling it."
    else
        error "LDAP_EX_TREE setting is incorrect."
        exit 1
    fi
}

### access rule ###
ldap_acs_rule() {
    if [[ $LDAP_EX_TREE == "enable" ]]; then
        info "Access rule is being set..."
        if [[ $LDAP_ACS_RULE == "flexible" ]]; then
            ldap_modify_ldif $LDAP_LDIF_TMP/access_rule/update_mdb_flexible.ldif
            warn "To enhance security, we recommend using strict access rule."
        elif [[ $LDAP_ACS_RULE == "strict" ]]; then
            ldap_modify_ldif $LDAP_LDIF_TMP/access_rule/update_mdb_strict.ldif
        else
            error "LDAP_ACS_RULE setting is incorrect."
            exit 1
        fi
    else
        info "LDAP_ACS_RULE is ignored since LDAP_EX_TREE is not enabled."
    fi
}

### password policy ###
ldap_pwd_policy() {
    if [[ $LDAP_EX_TREE == "enable" ]]; then
        info "Password policy is setting..."
        if [[ $LDAP_PWD_POLICY == "disable" ]]; then
            warn "To enhance security, we recommend enabling password policy."
        elif [[ $LDAP_PWD_POLICY == "enable" ]]; then
            ldap_add_ldif $LDAP_LDIF_TMP/ppolicy/pwpolicies.ldif
            ldap_add_ldif $LDAP_LDIF_TMP/ppolicy/ppolicy.ldif
            ldap_add_ldif $LDAP_LDIF_TMP/ppolicy/defualt_users_ppolicy_strict.ldif
            ldap_add_ldif $LDAP_LDIF_TMP/ppolicy/svc_users_ppolicy.ldif
            ldap_add_ldif $LDAP_LDIF_TMP/ppolicy/update_ppolicy_svc01.ldif
            ldap_add_ldif $LDAP_LDIF_TMP/ppolicy/update_ppolicy_svc02.ldif
        else
            error "LDAP_PWD_POLICY setting is incorrect."
            exit 1
        fi
    else
        info "LDAP_PWD_POLICY is ignored since LDAP_EX_TREE is not enabled."
    fi
}

### set up ldap ###
ldap_setup() {
    info "** Starting OpenLDAP setup **"
    ldap_init
    ldap_start
    ldap_fe_admin_pwd
    ldap_be_admin_pwd
    ldap_tls
    ldap_module
    ldap_overlay
    ldap_index
    ldap_anon_bind
    ldap_base_dn
    ldap_ex_tree
    ldap_acs_rule
    ldap_pwd_policy
    ldap_stop
    info "** OpenLDAP setup finished **"
    # clean up ldap ldif tmp
    rm -rf $LDAP_LDIF_TMP
}
