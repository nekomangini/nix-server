{ ... }:

{
  services.kanshi = {
    enable = true;
    systemdTarget = "niri.service";

    settings = [
      {
        profile = {
          name = "main";
          outputs = [
            {
              criteria = "Philips Consumer Electronics Company PHL 221V8 0x000001F2";
              transform = "270";
              position = "0,0";
            }
            {
              criteria = "PNP(AOP) 22CV1Q H3 1510054903W01";
              position = "1080,0";
            }
            {
              criteria = "Unknown Unknown Unknown";
              status = "disable";
            }
          ];
        };
      }
      {
        profile = {
          name = "triple";
          outputs = [
            {
              criteria = "LG Electronics LG TV 0x01010101";
              mode = "1360x768@60.015Hz";
              position = "-1360,0";
            }
            {
              criteria = "Philips Consumer Electronics Company PHL 221V8 0x000001F2";
              transform = "270";
              position = "0,0";
            }
            {
              criteria = "PNP(AOP) 22CV1Q H3 1510054903W01";
              position = "1080,0";
            }
            {
              criteria = "Unknown Unknown Unknown";
              status = "disable";
            }
          ];
        };
      }
    ];
  };
}
