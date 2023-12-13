# VFIO-SGPU
This script intents to be a simple and clean solution for single GPU passthrough users.

The following instructions are incomplete and not finished yet.

Make sure you follow section 1 and 2 on the OVMF Arch wiki (distro agnostic) but don't add `iommu=pt` to the kernel commandline.
You can find the wiki at https://wiki.archlinux.org/title/PCI_passthrough_via_OVMF#Prerequisites

AMDGPU users should add `video=efifb:off` to the kernel commandline.
Nvidia users should be on driver version 545 or later and add `nvidia-drm.modeset=1 nvidia-drm.fbdev=1`.

Clone the repo and run
`cd VFIO-SGPU/`
`sudo chmod +x install-hooks.sh`
`sudo ./install-hooks.sh`

Create a VM with the name `windows`, add the GPU as a PCI device and boot the VM.
