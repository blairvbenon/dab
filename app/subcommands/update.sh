#!/bin/sh
# Description: Update dab
# vim: ft=sh ts=4 sw=4 sts=4 noet
set -euf

# shellcheck disable=SC1091
. ./lib/output.sh
# shellcheck disable=SC1091
. ./lib/update.sh

export self_update_period=10
maybe_selfupdate_dab
