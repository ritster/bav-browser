#!/usr/bin/env bash
# Remove Data + JBrowse Files When Done

# Set default value for APACHE_ROOT if it's not already set (will only work for MacOS Silicon)
: "${APACHE_ROOT:='/opt/homebrew/var/www'}"

rm -rf ${APACHE_ROOT}/jbrowse2

find data ! -name 'README.md' -type f -exec rm -f {} +
