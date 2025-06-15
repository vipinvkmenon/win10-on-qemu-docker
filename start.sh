#!/bin/bash
set -e

# Start QEMU VM with VNC output on :1 (5901)
qemu-system-x86_64 \
  -m 4096 \
  -drive file=win10pe.qcow2,format=qcow2 \
  -boot c \
  -net nic -net user \
  -vga std \
  -usb -device usb-tablet \
  -rtc base=localtime \
  -smp 2 \
  -vnc :1 \
  -daemonize

# Start noVNC to expose VNC via WebSocket on port 6080
/novnc/utils/novnc_proxy --vnc localhost:5901 --listen 6080
