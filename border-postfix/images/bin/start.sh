#!/usr/bin/env bash
#
#

function fatal() {
    echo "Error: $1"
    exit 1
}

/scripts/bootstrap.sh || fatal "Unable to bootstrap"

echo "Exec Postfix"
exec postfix start-fg
