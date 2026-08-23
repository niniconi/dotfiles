# recon - reconnaissance/audit (osint-utils + web-exp-utils + audit-utils)
# duplicates kept across groups (firefox/subfinder) for independent group toggling

{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # OSINT
    sn0int
    subfinder
    xdg-utils
    firefox
    # web app audit
    nuclei
    sqlmap
    gobuster
    bettercap
    # system audit
    lynis
    ssh-audit
    cppcheck
    flawfinder
    sysdig
    bcc
  ];
}
