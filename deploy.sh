#!/usr/bin/env bash

if podman secret exists immich_db_password; then
    echo "Secret 'immich_db_password' already exists."
else
    echo "Secret not found. Please enter the password for immich_db_password:"
    systemd-ask-password | podman secret create immich_db_password -
fi

export DB_DATA_LOCATION="$HOME/immich/db"
export UPLOAD_LOCATION="$HOME/immich/library"
export IMMICH_VERSION="v3"
export TZ=$(timedatectl show --property=Timezone --value)

mkdir -p "$DB_DATA_LOCATION"
mkdir -p "$UPLOAD_LOCATION"

USER_QUADLETS_DIR="$HOME/.config/containers/systemd/immich"
mkdir -p "$USER_QUADLETS_DIR"

for file in ./immich/*.container ./immich/*.pod; do
    # Handle case where no files match the wildcard
    [ -e "$file" ] || continue
    
    filename=$(basename "$file")
    
    envsubst '$DB_DATA_LOCATION:$UPLOAD_LOCATION:$IMMICH_VERSION:$TZ' < "$file" > "$USER_QUADLETS_DIR/$filename"
done

# Automatically reload systemd so it sees the new files immediately
echo "Reloading systemd user daemon..."
systemctl --user daemon-reload