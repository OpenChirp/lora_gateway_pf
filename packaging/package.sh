#!/usr/bin/env bash

# validate TARGET
case $TARGET in
	'deb') DEB_WANTED="deb"
		;;
	*)
		echo "Unknown target distribution $TARGET"
		exit 1
		;;
esac

NAME=lora-gateway-pf-RHF0M301
BIN_DIR=/opt/$NAME
SCRIPT_DIR=/opt/$NAME/scripts
CONFIG_DIR=/etc/$NAME
TMP_WORK_DIR=`mktemp -d`
ARCH="armhf"

POSTINSTALL_SCRIPT=$TARGET/post-install.sh
PREINSTALL_SCRIPT=$TARGET/pre-install.sh
POSTUNINSTALL_SCRIPT=$TARGET/post-uninstall.sh

LICENSE=MIT
VERSION=0.`git describe --always`
URL=https://github.com/OpenChirp/lora_gateway_pf_RHF0M301/
MAINTAINER=info@openchirp.io
VENDOR="OpenChirp.io"
DESCRIPTION=" LoRa Gateway Packet Forwarder RHF0M301 forwards the packets captured on the radio interface to a UDP port"
DIST_FILE_PATH="../dist/tar/${NAME}_${VERSION}.tar.gz"
DEB_FILE_PATH="../dist/deb"

COMMON_FPM_ARGS="\
	--log error \
	-C $TMP_WORK_DIR \
	--url $URL \
	--license $LICENSE \
	--maintainer $MAINTAINER \
	--after-install $POSTINSTALL_SCRIPT \
	--before-install $PREINSTALL_SCRIPT \
	--after-remove $POSTUNINSTALL_SCRIPT \
	--architecture $ARCH \
	--name $NAME \
	--version $VERSION"

if [ ! -f $DIST_FILE_PATH ]; then
	echo "Dist file $DIST_FILE_PATH does not exist"
	exit 1
fi

# make temp dirs
mkdir -p $TMP_WORK_DIR/$BIN_DIR
mkdir -p $TMP_WORK_DIR/$SCRIPT_DIR
mkdir -p $TMP_WORK_DIR/$CONFIG_DIR

# unpack pre-compiled binary
tar -zxf $DIST_FILE_PATH -C $TMP_WORK_DIR/$BIN_DIR

# copy scripts
cp $TARGET/gwrst.sh $TMP_WORK_DIR/$SCRIPT_DIR
cp $TARGET/update_gwid.sh $TMP_WORK_DIR/$SCRIPT_DIR
cp $TARGET/$NAME.service $TMP_WORK_DIR/$SCRIPT_DIR
cp -r $TARGET/conf/* $TMP_WORK_DIR/$CONFIG_DIR



if [ -n "$DEB_WANTED" ]; then
	fpm -s dir -t deb $COMMON_FPM_ARGS --vendor "$VENDOR" --description "$DESCRIPTION" .
	if [ $? -ne 0 ]; then
		echo "Failed to create Debian package -- aborting."
		exit 1
	fi
	mkdir -p ../dist/deb
	mv *.deb ../dist/deb
	echo "Debian package created successfully at dist/deb/"
fi

# remove temporary dirs
rm -rf $TMP_WORK_DIR
