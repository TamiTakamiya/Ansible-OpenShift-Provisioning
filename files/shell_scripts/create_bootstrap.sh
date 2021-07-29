#!bin/bash

##create
qemu-img create -f qcow2 -b /var/lib/libvirt/images/rhcos-qemu.s390x.qcow2 /var/lib/libvirt/images/bootstrap.qcow2 100G

##boot
virt-install --boot kernel=rhcos-kernel,initrd=rhcos-initramfs.img,kernel_args='rd.neednet=1 coreos.inst.install_dev=/dev/vda coreos.live.rootfs_url=http://9.60.87.139:8080/bin/rhcos-rootfs.img coreos.inst.ignition_url=http://9.60.87.139:8080/ignition/bootstrap.ign ip=9.60.87.133::9.60.86.1:255.255.254.0:::none nameserver=9.60.87.139' --connect qemu:///system --name bootstrap-0 --memory 16384 --vcpus 4 --disk /var/lib/libvirt/images/bootstrap.qcow2 --accelerate --import --network network=macvtap-net --qemu-commandline="-drive if=none,id=ignition,format=raw,file=/var/www/html/ignition/bootstrap.ign,readonly=on -device virtio-blk,serial=ignition,drive=ignition" --noautoconsole
