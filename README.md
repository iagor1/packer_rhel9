# packer rhel9 qemu
packer using qemu builder to create golden images locally.

## What is this repository?

This repository is for who may want or need create rhel9 golden images with qemu. And when i was searching for repos like this, there were just a few, and
some of them, the boot command dindt work very well causing kernel panic.

## About the code

The code is very simple, the purpose of this repo is to warn about some mistakes you can get.

1 - You need qemu args to build the image, for some reason just the flag cpu is required.

2 - If boot command is wrong, probaly it will cause kernel panic.

3 - If your ssh_username and ssh_passwd are incorrect, packer will not create the output (image) so make sure they are corret in the kickstart file

## Required:

- Kvm 
- virt-install
- rhel 9 iso and checksum
- packer

## Setup

this is just if you need 

`apt-get install qemu-kvm qemu virt-manager virt-viewer libvirt-bin bridge-utils`

`sudo lsmod | grep kvm`

`sudo kvm-ok`


## Run

`
packer validate .
`

`
PACKER_LOG=1 packer build rhel9.pkr.hcl
`
or

`
packer build rhel9.pkr.hcl
`

Run image with virt-install

`
virt-install --name rhel9custom --memory 2048 --vcpus 2 --disk rhel9-kvm.qcow2,bus=sata --import --os-variant rhl9 --network default
`

convert img

`sudo qemu-img convert -f qcow2 rhel9-kvm.qcow2 rhel9custom.vdi`

## LINKS

links helpfull

https://www.lisenet.com/2022/rocky-linux-9-kernel-panic-on-packer-launched-qemu-kvm/

https://discuss.hashicorp.com/t/packer-qemu-kvm-redhat-9-kernel-panic/39886/5

https://gist.github.com/bkmetzler/d17fc843d35e2b5881a1a482efd88ac9

https://access.redhat.com/labs/kickstartconfig/#basic-configuration

https://docs.openstack.org/image-guide/convert-images.html