#!/usr/bin/env bash

# configure proxy
function proxy_on(){
   # assumes $PROXY_SERVER, $PROXY_PORT
   # are existing environment variables

   export ALL_PROXY="socks5://$PROXY_SERVER:$PROXY_PORT"
   export SOCKS_PROXY=$ALL_PROXY
   export NO_PROXY="localhost,127.0.0.0/8"

   gsettings set org.gnome.system.proxy mode 'manual'
   gsettings set org.gnome.system.proxy ignore-hosts "['localhost', '127.0.0.0/8']"
   gsettings set org.gnome.system.proxy.socks host $PROXY_SERVER
   gsettings set org.gnome.system.proxy.socks port $PROXY_PORT

   env | grep -i _proxy | sort
   echo -e "\nProxy-related environment variables set."

   gsettings list-recursively org.gnome.system.proxy
   echo -e "\nProxy-related DConf settings set."

   # clear
}

# Disable proxy settings
function proxy_off(){
   variables=( \
      "ALL_PROXY" "SOCKS_PROXY" "NO_PROXY" \
   )

   for i in "${variables[@]}"
   do
      unset $i
   done
   
   gsettings set org.gnome.system.proxy mode 'none'
   gsettings set org.gnome.system.proxy ignore-hosts "['localhost', '127.0.0.1']"
   gsettings set org.gnome.system.proxy.socks host ''
   gsettings set org.gnome.system.proxy.socks port 0


   env | grep -i _proxy | sort
   echo -e "\nProxy-related environment variables removed."
   
   gsettings list-recursively org.gnome.system.proxy
   echo -e "\nProxy-related DConf settings removed."
}

# Enable proxy settings immediately
proxy_on