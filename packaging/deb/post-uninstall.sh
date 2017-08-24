#!/usr/bin/env bash

NAME=lora-gateway-pf-RHF0M301
BIN_DIR=/opt/$NAME
CONFIG_DIR=/etc/$NAME

function remove_systemd {
	systemctl stop $NAME
	systemctl disable $NAME
	rm -f /lib/systemd/system/$NAME.service
}

remove_systemd

# Remove install folders
rm -rf BIN_DIR
rm -rf CONFIG_DIR