{ pkgs, ... }:

{
  systemd.services.nextcloud-backup = {
    description = "Nextcloud backup";
    serviceConfig = {
      Type = "oneshot";
      User = "nextcloud";
      ExecStart = pkgs.writeShellScript "nextcloud-backup" ''
        set -e
        BACKUP_DIR="/mnt/D/homelab/backups/nextcloud"
        DATE=$(date +%Y-%m-%d_%H-%M)
        BACKUP_PATH="$BACKUP_DIR/$DATE"
        mkdir -p "$BACKUP_PATH"

        OCC=/run/current-system/sw/bin/nextcloud-occ
        NEXTCLOUD_ROOT="/mnt/D/homelab/nextcloud"

        # Always disable maintenance mode on exit, even if something below fails —
        # otherwise a failed backup leaves the site stuck showing the maintenance page.
        trap '$OCC maintenance:mode --off' EXIT

        echo "Enabling maintenance mode..."
        $OCC maintenance:mode --on

        echo "Backing up config..."
        cp -r "$NEXTCLOUD_ROOT/config" "$BACKUP_PATH/config"

        echo "Backing up data..."
        cp -r "$NEXTCLOUD_ROOT/data" "$BACKUP_PATH/data"

        if [ -d "$NEXTCLOUD_ROOT/store-apps" ]; then
          echo "Backing up store-apps..."
          cp -r "$NEXTCLOUD_ROOT/store-apps" "$BACKUP_PATH/store-apps"
        else
          echo "store-apps not present, skipping (apps managed declaratively via Nix)"
        fi

        echo "Backing up PostgreSQL database..."
        ${pkgs.postgresql}/bin/pg_dump nextcloud > "$BACKUP_PATH/nextcloud-db.sql"

        echo "Backup complete: $BACKUP_PATH"

        # Keep only last 7 backups
        ls -dt "$BACKUP_DIR"/*/ | tail -n +8 | xargs -r rm -rf
      '';
    };
  };

  systemd.timers.nextcloud-backup = {
    description = "Daily Nextcloud backup";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "daily";
      Persistent = true;
      RandomizedDelaySec = "5m";
    };
  };
}
