{ pkgs, config, ... }:

let
  background = ../../wallpaper/evangelion_010.jpg;
  package = pkgs.homepage-dashboard.overrideAttrs (oldAttrs: {
    postInstall = ''
      mkdir -p $out/share/homepage/public/images
      ln -s ${background} $out/share/homepage/public/images/background.png
    '';
  });
  pc-server = "192.168.1.200";
  laptop-server = "192.168.1.9";
in
{
  services.homepage-dashboard = {
    enable = true;
    openFirewall = true;
    listenPort = 3333;
    allowedHosts = "${pc-server}:3333,localhost:3333,dashboard.home";
    package = package;

    environmentFiles = [
      config.age.secrets."homepage.env".path
    ];

    settings = {
      title = "Home Lab";
      theme = "dark";
      color = "blue";
      headerStyle = "clean";
      background = {
        image = "/images/background.png";
        blur = "md";
        saturate = 50;
        brightness = 50;
        opacity = 40;
      };
      cardBlur = "sm";
    };

    widgets = [
      {
        resources = {
          cpu = true;
          memory = true;
          disk = [
            "/"
            "/mnt/D"
          ];
        };
      }
      {
        datetime = {
          text_size = "xl";
          format = {
            dateStyle = "short";
            timeStyle = "short";
            hour12 = true;
          };
        };
      }
    ];

    services = [
      {
        "Media" = [
          {
            "Jellyfin" = {
              description = "Media Server";
              href = "http://jellyfin.home";
              icon = "jellyfin.png";
              widget = {
                type = "jellyfin";
                url = "http://${pc-server}:8096";
                key = "{{HOMEPAGE_VAR_JELLYFIN_API_KEY}}";
                version = 2;
                enableBlocks = true;
                enableNowPlaying = true;
              };
            };
          }
          {
            "Navidrome" = {
              description = "Music Server";
              href = "http://navidrome.home";
              icon = "navidrome.png";
              widget = {
                type = "navidrome";
                url = "http://${pc-server}:4533";
                user = "{{HOMEPAGE_VAR_NAVIDROME_USER}}";
                token = "{{HOMEPAGE_VAR_NAVIDROME_TOKEN}}";
                salt = "{{HOMEPAGE_VAR_NAVIDROME_SALT}}";

              };
            };
          }
          {
            "Kavita" = {
              description = "Manga Reader";
              href = "http://kavita.home";
              icon = "kavita.png";
              widget = {
                type = "kavita";
                url = "http://${pc-server}:3020";
                key = "{{HOMEPAGE_VAR_KAVITA_API_KEY}}";
              };
            };
          }
          {
            "Immich" = {
              description = "Photo Backup";
              href = "http://immich.home";
              icon = "immich.png";
              widget = {
                type = "immich";
                url = "http://${pc-server}:2283";
                key = "{{HOMEPAGE_VAR_IMMICH_API_KEY}}";
                version = 2;
              };
            };
          }

          {
            "Cloud" = [
              {
                "Nextcloud" = {
                  href = "http://nextcloud.home";
                  description = "File sync and share";
                  icon = "nextcloud.png";
                  widget = {
                    type = "nextcloud";
                    url = "http://nextcloud.home";
                    username = "{{HOMEPAGE_VAR_NEXTCLOUD_USER}}";
                    password = "{{HOMEPAGE_VAR_NEXTCLOUD_PASS}}";
                  };
                };
              }
              {
                "FileBrowser" = {
                  href = "http://filebrowser.home";
                  description = "web-base file manager";
                  icon = "filebrowser.png";
                };
              }
            ];
          }
        ];
      }
      {
        "Productivity" = [
          {
            "Linkding" = {
              description = "Bookmark Manager";
              href = "http://linkding.home";
              icon = "linkding.png";
            };
          }
          {
            "Radicale (Void)" = {
              description = "CalDAV Server";
              href = "http://${laptop-server}:5232";
              icon = "radicale.png";
            };
          }
          {
            "Radicale (NixOS)" = {
              description = "CalDAV Server";
              href = "http://radicale.home";
              icon = "radicale.png";
            };
          }
          {
            "Wiki.js" = {
              description = "Documentation";
              href = "http://wikijs.home";
              icon = "wikijs.png";
            };
          }
          {
            "Jotty" = {
              description = "Task Manager";
              href = "http://jotty.home";
              icon = "jotty.png";
            };
          }
        ];
      }
      {
        "Tools" = [
          {
            "Uptime Kuma" = {
              description = "Uptime Monitor";
              href = "http://uptime.home";
              icon = "uptime-kuma.png";
              widget = {
                type = "uptimekuma";
                url = "http://${pc-server}:3001";
                slug = "homelab";
              };
            };
          }
          {
            "Forgejo" = {
              description = "Git Server";
              href = "http://forgejo.home";
              icon = "forgejo.png";
            };
          }
          {
            "Syncthing" = {
              description = "Local sync tool";
              href = "http://syncthing.home";
              icon = "syncthing.png";
              widget = {
                type = "customapi";
                url = "http://${pc-server}:8384/rest/svc/report";
                headers = {
                  "X-API-Key" = "{{HOMEPAGE_VAR_SYNCTHING_API_KEY}}";
                };
                mappings = [
                  {
                    field = "numFolders";
                    label = "Folders";
                    format = "number";
                  }
                  {
                    field = "numDevices";
                    label = "Devices";
                    format = "number";
                  }
                  {
                    field = "totFiles";
                    label = "Files";
                    format = "number";
                  }
                ];
              };
            };
          }
          {
            "MeTube" = {
              description = "YouTube downloader";
              href = "http://metube.home";
              icon = "youtube.png";
            };
          }
          {
            "Adguard Home" = {
              description = "DNS Blocker";
              href = "http://adguard.home";
              icon = "adguard-home.png";
            };
          }
          {
            "Netdata" = {
              description = "System Monitor";
              href = "http://netdata.home";
              icon = "netdata.png";
              widget = {
                type = "netdata";
                url = "http://${pc-server}:19999";
                metric = "system.ram";
              };
            };
          }
        ];
      }
    ];

    bookmarks = [
      {
        "Dev" = [
          {
            "GitHub" = [
              {
                href = "https://github.com/nekomangini";
                icon = "github.png";
              }
            ];
          }
          {
            "NixOS Wiki" = [
              {
                href = "https://wiki.nixos.org";
                icon = "nixos.png";
              }
            ];
          }
          {
            "Nix Pills" = [
              {
                href = "https://nixos.org/guides/nix-pills/";
                icon = "nixos.png";
              }
            ];
          }
          {
            "NixOS & Flakes Book" = [
              {
                href = "https://nixos-and-flakes.thiscute.world/introduction/";
                icon = "nixos.png";
              }
            ];
          }
        ];
      }
    ];
  };
}
