#!/bin/bash

set -e
set -u
set -o pipefail

print_public_key() {
    local key=$1

    if [[ -n "$key" ]]; then
        jq -c -n --arg public_key "$key" '{ "public_key": $public_key }'
    else
        echo '{"public_key":""}'
    fi
}

export PATH='/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin'

PUBLIC_KEY=${PUBLIC_KEY-}

if ! test -t 0; then
    eval "$(jq -r '@sh "PUBLIC_KEY=\(.public_key)"')"
fi

if [[ -f $PUBLIC_KEY ]]; then
    print_public_key "$(cat "${PUBLIC_KEY}")"
else
    print_public_key "${PUBLIC_KEY}"
fi
