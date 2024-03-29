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
    printf "${1} = ${YELLOW}${2}${NC}\n"
}

# print ENV var setting table
print_env_table() {
    printf "${BLUE}--------- CHECK ENV VAR ---------${NC}\n"
    print_env_value MLF_WORKERS ${MLF_WORKERS}
    print_env_value MLF_TIMEOUT ${MLF_TIMEOUT}
    print_env_value MLF_EX_MODEL ${MLF_EX_MODEL}
    print_env_value MLF_MODEL_URI ${MLF_MODEL_URI}
    printf "${BLUE}-------------- END --------------${NC}\n"
}
