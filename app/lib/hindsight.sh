#!/bin/sh
# vim: ft=sh ts=4 sw=4 sts=4 noet
set -euf

# shellcheck disable=SC1090
. "$DAB/lib/output.sh"

echo_red() {
	echo_color "$COLOR_RED" "$@" 1>&2
}

captain_hindsight() {
	# shellcheck disable=SC2181
	[ $? -ne 0 ] || return 0 # Exit status code was 0
	[ -n "$*" ] || return 0  # Exit if the cmdline was empty
	cmdline="dab $*"

	echo
	echo_red "I'm sorry, it looks like the command '$cmdline' failed."

	case "$cmdline" in
	'dab apps'*)
		echo_red "If the app is misbehaving perhaps try 'dab apps update <APP_NAME>' and start it up again"
		echo_red "If you are unsure what the app is doing try 'dab apps logs <APP_NAME>'"
		echo_red "If the app has some bad data perhaps try 'dab apps destroy <APP_NAME>' and start it up again"
		;;
	'dab pki issue'* | 'dab pki renew'*)
		echo_red "If the pki is misbehaving perhaps try 'dab pki ready'"
		echo_red "If the pki has some bad data perhaps try 'dab pki destroy'"
		;;
	'dab pki ready'* | 'dab pki up'*)
		echo_red "If the pki is not starting at all, perhaps investigate with 'dab apps logs vault'"
		echo_red "If the pki is starting up properly perhaps try 'dab apps restart vault'"
		echo_red "If the pki has some bad data perhaps try 'dab pki destroy'"
		;;
	'dab config'*)
		echo_red "If the config key needs to be wiped, then give no value to 'dab config set'"
		;;
	esac

	echo_red 'If you believe this to due to a problem with Dab please file a bug report at https://github.com/Nekroze/dab/issues/new?template=bug_report.md'
}