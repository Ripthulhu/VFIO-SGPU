# VFIO-SGPU
This script intents to be a simple and clean solution for single GPU passthrough users

Make sure you follow section 1 and 2 on the OVMF Arch wiki (distro agnostic) but don't add `iommu=pt` to the kernel commandline.
You can find the wiki at https://wiki.archlinux.org/title/PCI_passthrough_via_OVMF#Prerequisites

AMDGPU users should add `video=efifb:off` to the kernel commandline

Clone the repo and run 
`cd VFIO-SGPU/`
`sudo chmod +x install_hooks.sh`
`sudo ./install_hooks.sh`

Create a VM with the name `windows` and boot it 
