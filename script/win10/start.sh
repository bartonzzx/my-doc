#sudo qemu-system-x86_64 -accel kvm -cpu host -m 8G -smp 8,cores=4,threads=2 -vnc 0.0.0.0:2 -device virtio-net,netdev=net1 -device virtio-blk-pci,drive=win10 -device virtio-scsi-pci,drive=virtio-win -netdev bridge,id=net1,br=br0 -blockdev driver=qcow2,node-name=win10,file.driver=file,file.filename=win10.qcow2 --boot once=d -cdrom win10.iso -blockdev driver=file,filename=virtio-win.iso,node-name=virtio-wi
sudo qemu-system-x86_64 \
	-accel kvm \
	-cpu host \
	-m 8G \
	-smp 8,cores=4,threads=2 \
	-vnc 0.0.0.0:2 \
	-device qemu-xhci \
	-device usb-tablet \
	-device virtio-net,netdev=net1 \
	-netdev bridge,id=net1,br=br0 \
	-device virtio-scsi-pci,id=scsi0 \
	-blockdev driver=qcow2,node-name=win10,file.driver=file,file.filename=win10.qcow2 \
	-device scsi-hd,drive=win10 \
	-blockdev driver=raw,node-name=cd0,file.driver=file,file.filename=win10.iso \
	-device ide-cd,drive=cd0,bootindex=0 \
	-blockdev driver=raw,node-name=cd1,file.driver=file,file.filename=virtio-win.iso \
	-device ide-cd,drive=cd1 \
	-boot menu=on
