#!/usr/bin/env bash
# Initial JBrowse Setup

# Set default value for APACHE_ROOT if it's not already set (will only work for MacOS Silicon)
: "${APACHE_ROOT:='/opt/homebrew/var/www'}"

# Initialize JBrowse file system
jbrowse create $APACHE_ROOT/jbrowse2
sudo chown -R $(whoami) $APACHE_ROOT/jbrowse2

## Minor JBrowse customization(s)

# Color Scheme
export INITIAL_CONFIG=\
'{
  "configuration": {
    "theme": {
      "palette": {
        "primary": { "main": "#344e41" },
        "secondary": { "main": "#3a5a40" },
        "tertiary": { "main": "#588157" },
        "quaternary": { "main": "#14213d" }
      }
    }
  }
}'
echo $INITIAL_CONFIG > $APACHE_ROOT/jbrowse2/config.json

# Plugins
# (OLD ERROR): can't seem to install plugins in this way - "Error: Failed to load https://unpkg.com/jbrowse-plugin-msaview/dist/jbrowse-plugin-msaview.umd.production.min.js"
#   error occurred because the unpkg repository was down
jq '. + {
  "plugins": [
    {
      "name": "MsaView",
      "url": "https://unpkg.com/jbrowse-plugin-msaview/dist/jbrowse-plugin-msaview.umd.production.min.js"
    },
    {
      "name": "Protein3d",
      "url": "https://unpkg.com/jbrowse-plugin-protein3d/dist/jbrowse-plugin-protein3d.umd.production.min.js"
    }
  ]
}' $APACHE_ROOT/jbrowse2/config.json > tmp.json && mv tmp.json $APACHE_ROOT/jbrowse2/config.json
