#!/bin/bash

QUIET_MODE=${QUIET_MODE:-"false"}
action=$1
apps_on=( pidgin thunderbird )
apps_off=( pidgin thunderbird-bin )

start_app(){
	if ! $QUIET_MODE ;then
		#start an app and keep them going if they haven't already started
		app=$1
		if ! ( ps -C $app | grep -o $app );then
			$app &
		fi
	fi
}

stop_app(){
	app=$1
	kill -9 $(pidof ${app})
}

main(){
	case $action in
		"start")
			for i in ${apps_on[*]};do
				start_app $i
			done
			;;
		"stop")
			for i in ${apps_off[*]};do
				stop_app $i
			done
			;;
	esac
}
main
