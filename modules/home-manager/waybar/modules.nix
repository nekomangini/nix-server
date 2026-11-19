{ ... }:

let
  shared = {
    "custom/launcher" = {
      format = " ";
      tooltip = false;
    };

    "niri/workspaces" = {
      all-outputs = false; # each bar shows only its own monitor's workspaces
    };

    tray = {
      spacing = 10;
      tooltip = false;
    };

    clock = {
      format = "{:%I:%M - %a, %b %d %Y}";
      tooltip = false;
    };

    temperature = {
      thermal-zone = 2;
      critical-threshold = 80;
      format = "temp {temperatureC}°C";
      format-critical = "temp {temperatureC}°C";
      interval = 2;
      states.critical = 80;
    };

    "custom/gpu-temp" = {
      exec = "nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits";
      format = "gpu {}°C";
      interval = 2;
      tooltip = false;
    };

    cpu = {
      format = "cpu {usage}%";
      interval = 2;
      states.critical = 90;
    };

    memory = {
      format = "mem {percentage}%";
      interval = 2;
      states.critical = 80;
    };

    network = {
      format-wifi = "wifi {bandwidthDownBits}";
      format-ethernet = "eth {bandwidthDownBits}";
      format-disconnected = "no network";
      interval = 5;
      tooltip = false;
    };

    pulseaudio = {
      scroll-step = 5;
      max-volume = 150;
      format = "vol {volume}%";
      format-bluetooth = "vol {volume}%";
      format-muted = "muted";
      on-click = "pwvucontrol";
      tooltip = false;
    };

    "custom/control" = {
      format = "⏻";
      on-click = "niri-powermenu";
      tooltip = false;
    };
  };
in

{
  programs.waybar.settings = {
    mainBar = shared;
    hdmiBar = shared;
  };
}
