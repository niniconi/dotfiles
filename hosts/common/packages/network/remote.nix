# remote - remote connection/streaming clients

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # desktop streaming (sunshine server + moonlight client)
    sunshine
    moonlight-qt
  ];
}
