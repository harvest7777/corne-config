#!/usr/bin/env bash
# Build ZMK firmware locally in Docker. Output: ./firmware/*.uf2
set -euo pipefail
cd "$(dirname "$0")"

docker run --rm -v "$PWD":/config -v zmk-ws:/ws -w /ws zmkfirmware/zmk-build-arm:3.5 bash -c '
  set -e
  if [ ! -d .west ]; then
    mkdir -p config && cp /config/config/west.yml config/
    west init -l config && west update && west zephyr-export
  fi
  west build -s zmk/app -d build/left -b nice_nano_v2 -S studio-rpc-usb-uart -- -DSHIELD=corne_left -DZMK_CONFIG=/config/config
  west build -s zmk/app -d build/right -b nice_nano_v2 -- -DSHIELD=corne_right -DZMK_CONFIG=/config/config
  mkdir -p /config/firmware
  cp build/left/zephyr/zmk.uf2 /config/firmware/corne_left.uf2
  cp build/right/zephyr/zmk.uf2 /config/firmware/corne_right.uf2
'
