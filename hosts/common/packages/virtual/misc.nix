# misc - miscellaneous virtualization tools

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    bubblewrap
    # software TPM emulator for VMs (QEMU/libvirt tpm-tis backend)
    swtpm
  ];
}
