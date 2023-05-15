#!/bin/bash
#
# Library for logging functions

# Regular Colors
NC='\033[0m'
RED='\033[38;5;1m'
GREEN='\033[38;5;2m'
YELLOW='\033[38;5;3m'
#BLUE='\033[38;5;4m'
MAGENTA='\033[38;5;5m'
#CYAN='\033[38;5;6m'

# Log message
log() {
    printf "${MAGENTA}$(date +"%Y-%m-%d %H:%M:%S") ${NC}${*}\n"
}

# Log an 'info' message
info() {
    log "${GREEN}INFO${NC} ==> ${*}"
}

# Log an 'warn' message
warn() {
    log "${YELLOW}WARN${NC} ==> ${*}"
}

# Log an 'error' message
error() {
    log "${RED}ERROR${NC} ==> ${*}"
}
