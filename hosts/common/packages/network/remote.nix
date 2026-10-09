# remote - remote connection/streaming clients

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # remote desktop (Remmina multi-protocol client + xfreerdp3)
    remmina
    freerdp
    # desktop streaming (sunshine server + moonlight client)
    sunshine
    moonlight-qt
  ];
}
