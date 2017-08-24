# Lora Gateway RHF0M301 Packet Forwarder and Configuration files

## Building from Source
```
# Clone Repo and submodules
git clone git@github.com:OpenChirp/lora_gateway_RHF0M301.git
cd lora_gateway_RHF0M301
git submodule update --recursive --init

# Compile
make build

# build the .tar.gz file
make package

# build the .deb file (includes zone specific confguration files and startup script)
make package-deb
```

## Current Software Versions
* [lora_gateway](https://github.com/Lora-net/lora_gateway): v5.0.1
* [packet_forwarder](https://github.com/Lora-net/packet_forwarder): v4.0.1 - 2017-03-16
