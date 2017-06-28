#!/bin/bash

set -e
set -u
set -o pipefail

export PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

eval "$(jq -r '@sh "PUBLIC_KEY=\(.public_key)"')"

if [[ -f $PUBLIC_KEY ]]; then
    jq -c -n --arg public_key "$(cat ${PUBLIC_KEY})" '{ "public_key": $public_key }'
else
    echo '{ "public_key": "" }'
fi
