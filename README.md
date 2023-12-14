# The Following Instructions Are Work in Progress


# Single GPU Passthrough Guide on Linux

## Introduction
This guide is designed to assist beginners in setting up a single GPU passthrough on Linux systems using libvirt and virt-manager, specifically focusing on systems with only one GPU.

## Prerequisites
- **System Compatibility**: Ensure your CPU supports IOMMU (Intel VT-d for Intel CPUs, AMD-Vi for AMD CPUs).
- **GPU Compatibility**: Verify if your GPU supports UEFI and is compatible with passthrough.
- **Laptop Compatibility**: You need to be able to disable the iGPU in the BIOS.

## Steps to Setup

### 1. Add GPU specific options
- **AMD GPU's**: Add `video=efifb:off` to the kernel commandline.
- **Nvidia GPU's**: Nvidia users are recommended to be on driver version 545 or later and add `nvidia-drm.modeset=1 nvidia-drm.fbdev=1` to the kernel commandline.

### 1. Enable IOMMU in BIOS and Kernel
- **BIOS Settings**: Enable AMD-Vi or Intel VT-d in your BIOS.
- **Kernel Parameters**: Add `intel_iommu=on` for Intel CPUs to your kernel parameters.
- **Verify IOMMU Activation**: After rebooting, use the command `dmesg | grep IOMMU` to confirm IOMMU is enabled.

### 2. Check IOMMU Groups
- **Script to List IOMMU Groups**: Use the provided script to view IOMMU groups and attached devices. Ensure your GPU is in a separate group or consider using an ACS override patch if necessary.

### 3. Install Required Tools
- **Tool Installation**:
    - For Ubuntu: `apt install qemu-kvm qemu-utils libvirt-daemon-system libvirt-clients bridge-utils virt-manager ovmf`
    - For Arch Linux: `pacman -S qemu libvirt edk2-ovmf virt-manager dnsmasq ebtables`
    - For Fedora: `dnf install @virtualization`
    - For Gentoo: `emerge -av qemu virt-manager libvirt ebtables dnsmasq`
- **Enable Services**: Use `systemctl enable --now libvirtd` to enable and start the Libvirt service.

### 4. Setup Guest OS
- **Create VM with Virt-Manager**: Customize your VM before installation, ensuring you set the Chipset to Q35 and Firmware to UEFI.

### 5. Attaching PCI Devices
- Remove unnecessary devices like Channel Spice, Display Spice, and Video QXL from your VM.
- Add your GPU's VGA and HDMI Audio as PCI Host devices.
- Add other PCI devices like the sound card and a USB controller

### 6. Libvirt Hooks
- **Create and Configure Libvirt Hooks**: Clone the repo and run `cd VFIO-SGPU/ sudo chmod +x install-hooks.sh` `sudo ./install-hooks.sh`

### 7. Keyboard/Mouse Passthrough Options
- **USB Controller Method**: Add the USB controller that your mouse and keyboard connect to as a PCI host device.
- **USB Host Device Method**: Add your keyboard and mouse as USB Host Devices. Note that this method uses emulated USB and doesn't work for all devices.
- **Evdev Passthrough**: Modify the libvirt configuration of your VM to include your keyboard and mouse in the `/dev/input/by-id/`.

## Additional Notes
- **Handling Disadvantages**: Be aware that VM's are often not allowed and blocked in popular online games. Consider dual booting to play those games.
- **Community Support**: For additional help, VM optimisation etc consider reaching out to places like r/vfio, the VFIO Discord server or the RisingPrismTV Discord server
