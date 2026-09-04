{ ... }:

{
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 25;
    priority = 100;
  };

  # sudo mkdir -p /persist/swap
  #
  # sudo touch /persist/swap/swapfile
  #
  # sudo chattr +C /persist/swap/swapfile
  #
  # sudo chmod 600 /persist/swap/swapfile
  # sudo chmod 600 /persist/swap
  #
  # sudo fallocate -l 16G /persist/swap/swapfile
  # sudo mkswap /persist/swap/swapfile
  swapDevices = [
    {
      device = "/persist/swap/swapfile";
      size = 16 * 1024;
      priority = 10;
    }
  ];
}
