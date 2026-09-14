# nix-server

[![NixOS](https://img.shields.io/badge/NixOS-26.05-5277C3?style=flat-square&logo=nixos&logoColor=white)](https://nixos.org)
[![Home Manager](https://img.shields.io/badge/Home%20Manager-flake-blue?style=flat-square)](https://github.com/nix-community/home-manager)
[![agenix](https://img.shields.io/badge/secrets-agenix-informational?style=flat-square)](https://github.com/ryantm/agenix)

My personal NixOS configuration — desktop, laptop, and a self-hosted home lab, all managed as a single flake with Home Manager as a NixOS module and secrets encrypted with agenix.

## Hosts

| Hostname      | Role       | Notes                                                                                                                                                                                 |
| ------------- | ---------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `sylphiette`  | 🖥️ Desktop | i3-7100, 16GB RAM, GTX 1050 Ti · static IP `192.168.1.200` · runs the home lab stack                                                                                                  |
| `neko-laptop` | 💻 Laptop  | **Not active** — only 2GB RAM, not enough headroom to run NixOS. Currently running [Void Linux](https://voidlinux.org) instead; config kept in-repo for whenever the hardware changes |

## Structure

```
.
├── flake.nix                            # entrypoint: nixosConfigurations for sylphiette / neko-laptop
├── hosts/
│   ├── desktop/                         # configuration.nix, hardware-configuration.nix, users
│   └── laptop/
├── modules/
│   ├── nixos/                           # system-level modules
│   │   ├── core/                        # boot, locale, networking, nix settings, secrets
│   │   ├── desktop/                     # xserver, Plasma
│   │   ├── development/                 # Android, Docker, nix-ld
│   │   ├── hardware/                    # audio, bluetooth, NVIDIA, ydotool
│   │   ├── maintenance/                 # auto-upgrade
│   │   ├── programs/ & services/        # fish, ssh, printing, KDE Connect, touchpad, adb
│   │   ├── users/
│   │   └── window-managers/             # Hyprland, i3, Niri, Qtile
│   └── home-manager/                    # user-level modules
│       ├── profiles/                    # desktop.nix / laptop.nix entrypoints
│       ├── hyprland/ i3/ niri/ qtile/   # per-compositor config
│       ├── helix/                       # editor + LSPs
│       ├── kitty/ waybar/ dunst/ rofi.nix / fuzzel.nix
│       ├── shell/fish/                  # aliases, functions, keybinds
│       ├── ruby/                        # Rails dev environment
│       └── ...                          # git, tmux, emacs, neovim, vim, kdeconnect, android, packages
├── homelab/                             # one module per self-hosted service (see below)
├── packages/                            # Raku CLI tooling, packaged as Nix derivations
├── secrets/                             # agenix-encrypted secrets + secrets.nix
├── wallpaper/                           # wallpaper set used by the desktop
└── assets/                              # README screenshots
```

## Desktop environment

Multi-compositor setup, switched per-session depending on what I'm feeling:

- **i3** — single monitor (wip)
- **Niri** — dual monitor (main)
- **Qtile** — triple monitor (wip)
- **Hyprland** — currently broken; planning to migrate from Hyprlang to Lua config

Shared across all of them: Waybar/panel, Fuzzel/Rofi launchers, Dunst notifications, Kitty (with a custom theme), Fish shell, Helix as the primary editor with a Doom Emacs daemon on standby, and tmux session management driven by [Raku](https://raku.org) scripts.

Notable fixes documented in-repo:

- Three-monitor layout, including a 32" TV as a third display
- Wayland/Emacs compatibility via `emacs-pgtk` under Niri
- KDE Connect split module: firewall rule lives in the NixOS module, the service itself in Home Manager
- Vue LSP in Helix — hybrid mode bundling `@vue/typescript-plugin` from the Nix store path
- Flutter on NixOS (SDK path resolution for Android Studio) + Brave pinned as `CHROME_EXECUTABLE`

## Home lab (`homelab/`)

Everything runs on the desktop host, fronted by **Caddy** as a reverse proxy on `*.home` domains, deployed as NixOS modules (Docker-only apps run via `virtualisation.oci-containers` on Podman), with all secrets managed through **agenix**.

Backups are automated with systemd timers — Nextcloud has daily backups with 7-day retention.

| Service                                                           | Purpose                                              |
| ----------------------------------------------------------------- | ---------------------------------------------------- |
| [Jellyfin](https://jellyfin.org)                                  | Media server (hardware transcoding via NVENC)        |
| [Immich](https://immich.app)                                      | Photo/video backup (GPU-accelerated ML)              |
| [Nextcloud](https://nextcloud.com)                                | File sync and share (self-hosted)                    |
| [FileBrowser](https://filebrowser.org)                            | Web-based file manager                               |
| [Navidrome](https://www.navidrome.org)                            | Music streaming                                      |
| [Kavita](https://www.kavitareader.com)                            | Manga/book/comic library                             |
| [Forgejo](https://forgejo.org)                                    | Git hosting — migration target from GitHub           |
| [Vaultwarden](https://github.com/dani-garcia/vaultwarden)         | Password manager — planned, not yet deployed         |
| [AdGuard Home](https://adguard.com/en/adguard-home/overview.html) | Network-wide DNS ad-blocking                         |
| [Syncthing](https://syncthing.net)                                | File sync across devices                             |
| [Radicale](https://radicale.org)                                  | CalDAV/CardDAV server                                |
| [Linkding](https://github.com/sissbruecker/linkding)              | Bookmark manager                                     |
| [Wiki.js](https://js.wiki)                                        | Personal wiki                                        |
| [Jotty](https://jotty.page)                                       | Notes                                                |
| [MeTube](https://github.com/alexta69/metube)                      | yt-dlp download frontend                             |
| [Uptime Kuma](https://github.com/louislam/uptime-kuma)            | Uptime monitoring, with Discord notifications/alerts |
| [Netdata](https://www.netdata.cloud)                              | Real-time metrics, alerts to Discord                 |
| [Homepage](https://gethomepage.dev)                               | Dashboard for the whole stack                        |

Each service lives in its own `homelab/<service>/default.nix` for easy enable/disable and review.

## Scripting (`packages/`)

Raku-based CLI tools packaged as Nix derivations and wired into the shell:

- `tmux/` — session manager, plus a dedicated Ruby on Rails dev-environment launcher
- `powermenu/` — Wayland and X11 power menus
- `websearch/` — Wayland and X11 quick-search launchers
- `sync/` — sync helpers (notes, blog, [nekopaper](https://nekopaper.netlify.app))
- `logs/`, `helix/`, `emacs/` — dev-log and editor session helpers

## Usage

```bash
# rebuild the desktop
sudo nixos-rebuild switch --flake .#sylphiette

# rebuild the laptop
sudo nixos-rebuild switch --flake .#neko-laptop
```

Secrets are managed with agenix — see `secrets/secrets.nix` for the recipient list before rekeying.

## TODO

- [ ] Migrate Hyprland configuration from Hyprlang to Lua
- [x] Enable GPU acceleration for machine learning in Immich
- [x] Clean up and reorganize packages
- [x] Migrate remaining GitHub repositories to Forgejo
- [ ] Deploy Vaultwarden
- [ ] Cleanup Raku scripts

## Screenshots

![Desktop screenshot](assets/Screenshot%20from%202026-07-17%2010-38-32.png)

---

Also check out [nekopaper](https://nekopaper.netlify.app) for the companion wallpaper gallery app.
