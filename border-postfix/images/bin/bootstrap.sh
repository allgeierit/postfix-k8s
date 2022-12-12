#!/usr/bin/env bash
#
#

function fatal() {
    echo "Error: $1"
    exit 1
}

echo "Starting bootstrap."
# Copy config from mounted config map to postfix directory.
echo "Copy config files to /etc/postfix."
cp /config/* /etc/postfix
postmap /etc/postfix/transport
postmap /etc/postfix/access
postmap /etc/postfix/o365_domains

# When there is a clean mount under /data, copy postfix
# directory structure.
if [ ! -d /data/spool/postfix ]; then
   echo "Copy postfix directories to /data."
   mkdir -p /data/lib/postfix
   mkdir -p /data/mail
   mkdir -p /data/spool/postfix
   mkdir -p /data/log

   cp -pr /var/spool/postfix /data/spool
else
    echo "Postfix directories already copied."
fi

echo "Calling postfix set permissions."
postfix set-permissions
echo "Bootstrap done."
