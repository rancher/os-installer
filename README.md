#os-installer: Installs RancherOS
-----

##Purpose:

This repository provides scripts for the container used to install RancherOS.

The container can be used directly, but there is a wrapper in RancherOS, `/usr/sbin/rancheros-install`, that handles calling things in the right order. If you just want to disect it, start with the rancheros-install script and look in here to see what is being called.

##Basics

When booting from the ISO file RancherOS runs completely from memory. In order to run more containers, and save state between reboots, you need to persist and run from disk. 

When booting, RancherOS looks for a device labeled "RANCHER_STATE". If it finds a volume with that labeled the OS will mount the device and use it to store state. 

The scripts in this container will create a device labeled RANCHER_STATE and make it bootable. The two supported methods, are generic and amazon-ebs. The approach can be translated to suit different needs.

The generic install type follows these steps:

1. ) partition device with a single partition the size of the disk.
2. ) format ext4 and label partition as RANCHER_STATE
3. ) Install grub2 on device
4. ) Place kernel/initrd and grub.cfg inside /boot on the device.
5. ) Seeds the cloud-init data so that a ssh key or other RancherOS configuration can be set.

The amazon-ebs approach follows these steps:

1. ) format the device (Ext4) and label RANCHER_STATE
2. ) Add PV-GRUB configuration (menu.lst)
3. ) Add Kernel and Initrd
4. ) Sets Rancher to look for EC2 cloud-init data.



## Usage

**Warning:** Using this container directly can be like running with scissors...

```
 # Partition disk without prompting of any sort:
 docker run --privileged -it --entrypoint=/scripts/set-disk-partitions rancher/os:<version> <device>


 # install 
 docker run --privileged -it -v /home:/home -v /opt:/opt \
        rancher/os:<version> -d <device> -t <install_type> -c <cloud-config file> \
        -i /custom/dist/dir \
        -f </src/path1:/dst/path1,/src/path2:/dst/path2,/src/path3:/dst/path3>
```

The installation process requires a cloud config file. It needs to be placed in either /home/rancher/ or /opt/. The installer make use of the user-volumes to facilitate files being available between system containers. `-i` and `-f` options are, well, optional. 

By providing `-i` (or `DIST` env var) you specify the path to your custom `vmlinuz` and `initrd`. 
  
`-f` allows you to copy arbitrary files to the target root filesystem.

## Contact
For bugs, questions, comments, corrections, suggestions, etc., open an issue in
 [rancherio/os](//github.com/rancherio/os/issues) with a title starting with `[os-installer] `.

Or just [click here](//github.com/rancherio/os/issues/new?title=%5Bos-installer%5D%20) to create a new issue.

## License
Copyright (c) 2014-2015 [Rancher Labs, Inc.](http://rancher.com)

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

[http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.








