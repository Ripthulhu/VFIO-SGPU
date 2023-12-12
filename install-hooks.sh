#!/bin/bash

mkdir -p /etc/libvirt/hooks

cp hooks/vfio-startup /usr/local/bin/vfio-startup
cp hooks/vfio-teardown /usr/local/bin/vfio-teardown
cp hooks/qemu /etc/libvirt/hooks/qemu

chmod +x /usr/local/bin/vfio-startup
chmod +x /usr/local/bin/vfio-teardown
chmod +x /etc/libvirt/hooks/qemu
