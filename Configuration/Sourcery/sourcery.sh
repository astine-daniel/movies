#!/bin/sh

api_key_not_setted_error() {
    echo "error: Environment variable \${API_KEY} not setted. Set it into env-vars.cfg file or by the CI." >&2
    exit 1
}

# Check if env-vars.sh exists
if [ -f ../env-vars.sh ]; then . ../env-vars.sh; fi

# # Check if ${API_KEY} is setted
if [ -z "${API_KEY}" ]; then api_key_not_setted_error; fi

"${PODS_ROOT}"/Sourcery/bin/sourcery \
    --config "${SRCROOT}"/../Configuration/Sourcery/.sourcery.yml
