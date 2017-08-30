# Lora Gateway Packet Forwarder and Configuration files

## Tested Hardware
 * RHF0M301 LoRa Gateway Concentrator Module [[link1](http://www.risinghf.com/product/rhf0m301/?lang=en)] [[link2](https://www.seeedstudio.com/LoRa%2FLoRaWAN-Gateway-915MHz-for-Raspberry-Pi-3-p-2821.html)]
 * RAK831 LoRa Gateway Concentrator Module [[link1](http://www.rakwireless.com/en/WisKeyOSH/RAK831)]

## Building from Source
```
# Clone Repo and submodules
git clone git@github.com:OpenChirp/lora_gateway_pf.git
cd lora_gateway_pf
git submodule update --recursive --init

# Compile
make build

# build the .tar.gz file
make package

# build the .deb file (includes zone specific confguration files and startup script)
make package-deb VERSION=x.x.x
```

Install package
```
cd dist/deb/
sudo dpkg -i lora-gateway-pf-*_armhf.deb
```


## Current Software Versions
* [lora_gateway](https://github.com/Lora-net/lora_gateway): v5.0.1
* [packet_forwarder](https://github.com/Lora-net/packet_forwarder): v4.0.1 - 2017-03-16
