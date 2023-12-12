# VFIO-SGPU
This script intents to be a simple and clean solution for single GPU passthrough users

Make sure you follow section 1 and 2 on the OVMF Arch wiki (distro agnostic) but don't add `iommu=pt` to the kernel commandline

AMDGPU users should add `video=efifb:off` to the kernel commandline

Run `install-hooks.sh` as root

Create a VM with the name `windows` and boot it 
