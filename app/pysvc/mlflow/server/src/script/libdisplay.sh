#!/bin/bash
#
# Library for displaying variable settings

# load env & lib
. /opt/script/libenv.sh

# Regular Colors
NC='\033[0m'
#RED='\033[38;5;1m'
#GREEN='\033[38;5;2m'
YELLOW='\033[38;5;3m'
BLUE='\033[38;5;4m'
#MAGENTA='\033[38;5;5m'
#CYAN='\033[38;5;6m'

# print ENV var setting with color
print_env_value() {
    printf "$1 = ${YELLOW}$2${NC}\n"
}

# print ENV var setting table
print_env_table() {
    printf "${BLUE}--------- CHECK ENV VAR ---------${NC}\n"
    print_env_value MLF_BACKEND_STORE_UIR $MLF_BACKEND_STORE_UIR
    print_env_value MLFLOW_ARTIACTS_DESTINATION $MLFLOW_ARTIACTS_DESTINATION
    print_env_value MLF_WORKERS $MLF_WORKERS
    print_env_value MLF_ARTIFACT_ROOT $MLF_ARTIFACT_ROOT
    if [[ $MLF_ARTIFACT_ROOT == "enable" ]]; then
        print_env_value MLF_DEFAULT_ARTIFACT_ROOT $MLF_DEFAULT_ARTIFACT_ROOT
    fi
    print_env_value MLF_PROMETHEUS $MLF_PROMETHEUS
    if [[ $MLF_PROMETHEUS == "enable" ]]; then
        print_env_value MLF_EXPORSE_PROMETHEUS $MLF_EXPORSE_PROMETHEUS
    fi
    print_env_value MLF_DEBUG $MLF_DEBUG
    printf "${BLUE}-------------- END --------------${NC}\n"
}
