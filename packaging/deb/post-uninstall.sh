#!/usr/bin/env bash

NAME=lora-gateway-RHF0M301

function remove_systemd {
	systemctl stop $NAME
	systemctl disable $NAME
	rm -f /lib/systemd/system/$NAME.service
}

remove_systemd
