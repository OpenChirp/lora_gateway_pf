#!/usr/bin/env bash

NAME=lora-gateway-pf
BIN_DIR=/opt/$NAME
SCRIPT_DIR=/opt/$NAME/scripts
CONFIG_DIR=/etc/$NAME
DAEMON_USER=root
DAEMON_GROUP=root

function install_systemd {
	cp -f $SCRIPT_DIR/$NAME.service /lib/systemd/system/$NAME.service
	systemctl daemon-reload
	systemctl enable $NAME
}

# ensure scripts are executable
chmod +x $SCRIPT_DIR/*

echo -e "\n\n\n"
echo "--------------------------------------------------------------------------------------------"
echo "A sample configuration file has been copied to: /etc/$NAME/global_conf.json"
echo " Other region settings can be found at /etc/$NAME/aux"
echo "After setting the correct values, run the following command to start LoRa Packet Forwarder:"
echo ""
echo "$ sudo systemctl start $NAME"
echo "--------------------------------------------------------------------------------------------"
echo -e "\n\n\n"

install_systemd
