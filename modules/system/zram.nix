{ ... }:
{
  zramSwap = {
    enable = true;
    priority = 100;
    memoryPercent = 200;
    swapDevices = 1;
    algorithm = "zstd";
  };
}
