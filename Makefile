.PHONY: clean
VERSION := 0.$(shell git describe --always)
NAME := "lora-gateway-pf-RHF0M301"

clean:
	rm -rf build

build:
	@echo "Compiling source"
	@cd lora_gateway; make clean; make
	@cd packet_forwarder; make clean; make

	@echo "make build Dirs"
	@mkdir -p build
	@mkdir -p build/tests
	@mkdir -p build/utils

	@echo "copy binary"
	@cp packet_forwarder/lora_pkt_fwd/lora_pkt_fwd build

	@echo "copy tests and utils"
	@cp lora_gateway/libloragw/test_loragw_cal build/tests
	@cp lora_gateway/libloragw/test_loragw_gps build/tests
	@cp lora_gateway/libloragw/test_loragw_hal build/tests
	@cp lora_gateway/libloragw/test_loragw_reg build/tests
	@cp lora_gateway/libloragw/test_loragw_spi build/tests

	@cp lora_gateway/util_lbt_test/util_lbt_test build/utils
	@cp lora_gateway/util_pkt_logger/util_pkt_logger build/utils
	@cp lora_gateway/util_spectral_scan/util_spectral_scan build/utils
	@cp lora_gateway/util_spi_stress/util_spi_stress build/utils
	@cp lora_gateway/util_tx_continuous/util_tx_continuous build/utils
	@cp lora_gateway/util_tx_test/util_tx_test build/utils

	@cp packet_forwarder/util_ack/util_ack build/utils
	@cp packet_forwarder/util_sink/util_sink build/utils
	@cp packet_forwarder/util_tx_test/util_tx_test build/utils

package: build
	@echo "Creating package"
	@mkdir -p dist/tar/$(VERSION)
	@cp -r build/* dist/tar/$(VERSION)
	@cd dist/tar/$(VERSION) && tar -pczf ../$(NAME)_$(VERSION).tar.gz .
	@rm -rf dist/tar/$(VERSION)

package-deb: package
	@echo "Creating DEB installer"
	@chmod +x packaging/package.sh
	@cd packaging && TARGET=deb ./package.sh
