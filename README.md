# Single GPU Passthrough Guide on Linux

## Introduction
This guide assists beginners in setting up GPU passthrough on Linux systems using libvirt and virt-manager, focusing on systems with a single GPU. We highly recommend joining the VFIO Discord (links at the bottom) and reviewing the #wiki-and-psa section for valuable information. This includes steps to acquire a ROM for Nvidia cards and optimize the VM for maximum performance. The Arch OVMF Wiki page is another excellent resource.

## Prerequisites
- **System Compatibility**: Your CPU must support IOMMU (Intel VT-d for Intel CPUs, AMD-Vi for AMD CPUs).
- **GPU Compatibility**: Ensure your GPU supports UEFI and is compatible with passthrough. Nvidia cards require a ROM file, and AMD Navi 14 or older GPUs need the `vendor-reset` module (link provided below).
- **Laptop Compatibility**: Ability to disable the iGPU in the BIOS is essential.
- **Distro Compatibility**: This script works only on distributions that use systemd.

## Setup Steps

### 1. Add GPU Specific Options
- **AMD GPUs**: Include `video=efifb:off` in your kernel parameters.
- **Nvidia GPUs**: It's recommended to use driver version 545 or later and add `nvidia-drm.modeset=1 nvidia-drm.fbdev=1` to the kernel parameters.

### 2. Enable IOMMU in BIOS and Kernel
- **BIOS Settings**: Activate AMD-Vi or Intel VT-d in your BIOS.
- **Kernel Parameters**: Add `intel_iommu=on` for Intel CPUs.
- **Verify IOMMU Activation**: Use `dmesg | grep IOMMU` after rebooting to ensure IOMMU is enabled.

### 3. Check IOMMU Groups
- **IOMMU Groups Script**: Utilize the provided `iommu-groups.sh` script to view IOMMU groups and connected devices. Your GPU should be in a separate group, or you might need an ACS override patch. If the script returns nothing, IOMMU isn't functioning.

### 4. Install Required Packages
- **Packages Installation**:
    - Ubuntu: `apt install qemu-kvm qemu-utils libvirt-daemon-system libvirt-clients bridge-utils virt-manager ovmf`
    - Arch Linux: `pacman -S qemu libvirt edk2-ovmf virt-manager dnsmasq ebtables`
    - Fedora: `dnf install @virtualization`
    - Gentoo: `emerge -av qemu virt-manager libvirt ebtables dnsmasq`
- **Enable Services**: Run `systemctl enable --now libvirtd` to enable and start the Libvirt service.

### 5. Set Up Guest OS
- **VM Creation with Virt-Manager**: Customize your VM before installation, setting the Chipset to Q35 and Firmware to UEFI.

### 6. Attaching PCI Devices
- Remove devices like Channel Spice, Display Spice, and Video QXL.
- Add your GPU's VGA and HDMI Audio as PCI Host devices.
- Add other PCI devices like the sound card and a USB controller.

### 7. Libvirt Hooks
- **Libvirt Hooks Configuration**: Clone the repo and execute `cd VFIO-SGPU/`, `sudo chmod +x install-hooks.sh`, and `sudo ./install-hooks.sh`.

### 8. Keyboard/Mouse Passthrough Options
- **USB Controller Method**: Add the USB controller for your mouse and keyboard as a PCI host device.
- **USB Host Device Method**: Add your keyboard and mouse as USB Host Devices. Note: This method uses emulated USB and may not work with all devices.
- **Evdev Passthrough**: Modify your VM's libvirt configuration to include your keyboard and mouse in `/dev/input/by-id/`.

## Additional Notes
- **Handling Disadvantages**: Be aware that VMs are often restricted or blocked in popular online games. Consider dual-booting for those games.
- **Community Support**: For additional help, VM optimization, etc., consider reaching out to communities like r/vfio, the VFIO Discord server, or the RisingPrismTV Discord server.

## Links and Resources
- **VFIO Discord Server**: https://discord.gg/mteRzQkRW7
- **RisingPrismTV Discord Server**: https://discord.gg/uU6MtsuaYE
- **Arch OVMF Wiki**: https://wiki.archlinux.org/title/PCI_passthrough_via_OVMF
- **Vendor-Reset**: https://github.com/gnif/vendor-reset
