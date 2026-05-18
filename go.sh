#!/bin/bash
 openocd \
  -f interface/cmsis-dap.cfg \
  -c "cmsis_dap_backend hid" \
  -c "transport select swd" \
  -f target/lpc84x.cfg \
  -c "adapter speed 1000" \
  -c "program debug/led_blinky.elf verify reset exit"
