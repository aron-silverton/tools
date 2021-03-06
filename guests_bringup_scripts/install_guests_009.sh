echo 0000:01:00.4 > /sys/bus/pci/drivers/uhci_hcd/unbind
echo 0000:01:00.2 > /sys/bus/pci/drivers/hpilo/unbind

for vm in `virsh list --all | grep VM-009 | awk '{print p$2}'`; do virsh undefine $vm;done
for vm in `virsh list --all | grep VM-009 | awk '{print p$2}'`; do virsh destroy $vm;done

systemctl restart libvirtd
rm -rf /images/dev-h-vrt-00*

mkdir /images/dev-h-vrt-009-009/
mkdir /images/dev-h-vrt-009-010/
mkdir /images/dev-h-vrt-009-011/
mkdir /images/dev-h-vrt-009-012/
mkdir /images/dev-h-vrt-009-013/
mkdir /images/dev-h-vrt-009-014/

qemu-img create -f qcow2 -o size=35G /images/dev-h-vrt-009-009/dev-h-vrt-009-009.img
qemu-img create -f qcow2 -o size=35G /images/dev-h-vrt-009-010/dev-h-vrt-009-010.img
qemu-img create -f qcow2 -o size=35G /images/dev-h-vrt-009-011/dev-h-vrt-009-011.img
qemu-img create -f qcow2 -o size=35G /images/dev-h-vrt-009-012/dev-h-vrt-009-012.img
qemu-img create -f qcow2 -o size=35G /images/dev-h-vrt-009-013/dev-h-vrt-009-013.img
qemu-img create -f qcow2 -o size=35G /images/dev-h-vrt-009-014/dev-h-vrt-009-014.img

/auto/GLIT/SCRIPTS/AUTOINSTALL/Multihost/os_installer_new.py linux -a -o Fedora_24_x86_64_virt_guest -t dev-h-vrt-009-009
/auto/GLIT/SCRIPTS/AUTOINSTALL/Multihost/os_installer_new.py linux -a -o RH_7.6_x86_64_virt_guest -t dev-h-vrt-009-010
/auto/GLIT/SCRIPTS/AUTOINSTALL/Multihost/os_installer_new.py linux -a -o RH_7.6_x86_64_virt_guest -t dev-h-vrt-009-011
/auto/GLIT/SCRIPTS/AUTOINSTALL/Multihost/os_installer_new.py linux -a -o RH_7.6_x86_64_virt_guest -t dev-h-vrt-009-012
/auto/GLIT/SCRIPTS/AUTOINSTALL/Multihost/os_installer_new.py linux -a -o RH_7.6_x86_64_virt_guest -t dev-h-vrt-009-013
/auto/GLIT/SCRIPTS/AUTOINSTALL/Multihost/os_installer_new.py linux -a -o RH_7.6_x86_64_virt_guest -t dev-h-vrt-009-014

/usr/bin/virt-install --quiet --name VM-009-009-Fed24-Upstream --vcpus 8 --ram 8192 --disk path=/images/dev-h-vrt-009-009/dev-h-vrt-009-009.img,size=35,format=qcow2 --network bridge:br0,mac=00:50:56:19:c6:09,model=virtio --accelerate --vnc --pxe --force &

/usr/bin/virt-install --quiet --name VM-009-010-RH7.6-CX3Pro --vcpus 8 --ram 8192 --disk path=/images/dev-h-vrt-009-010/dev-h-vrt-009-010.img,size=35,format=qcow2 --network bridge:br0,mac=00:50:56:19:c6:0a,model=virtio --accelerate --vnc --pxe --force --hostdev pci_0000_07_00_0 &

/usr/bin/virt-install --quiet --name VM-009-011-RH7.6-IB --vcpus 8 --ram 8192 --disk path=/images/dev-h-vrt-009-011/dev-h-vrt-009-011.img,size=35,format=qcow2 --network bridge:br0,mac=00:50:56:19:c6:0b,model=virtio --accelerate --vnc --pxe --force --hostdev pci_0000_0a_00_0 &

/usr/bin/virt-install --quiet --name VM-009-012-RH7.6-CX4 --vcpus 8 --ram 8192 --disk path=/images/dev-h-vrt-009-012/dev-h-vrt-009-012.img,size=35,format=qcow2 --network bridge:br0,mac=00:50:56:19:c6:0c,model=virtio --accelerate --vnc --pxe --force  --hostdev pci_0000_24_00_0 --hostdev pci_0000_24_00_1 &

/usr/bin/virt-install --quiet --name VM-009-013-RH7.6-CX4LX --vcpus 8 --ram 8192 --disk path=/images/dev-h-vrt-009-013/dev-h-vrt-009-013.img,size=35,format=qcow2 --network bridge:br0,mac=00:50:56:19:c6:0d,model=virtio --accelerate --vnc --pxe --force --hostdev pci_0000_04_00_0 --hostdev pci_0000_04_00_1 &

/usr/bin/virt-install --quiet --name VM-009-014-RH7.6-CX5 --vcpus 8 --ram 8192 --disk path=/images/dev-h-vrt-009-014/dev-h-vrt-009-014.img,size=35,format=qcow2 --network bridge:br0,mac=00:50:56:19:c6:0e,model=virtio --accelerate --vnc --pxe --force --hostdev pci_0000_21_00_0 --hostdev pci_0000_21_00_1 &

