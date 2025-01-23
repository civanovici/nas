#!/bin/bash

# Base directory
BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Create service directories
declare -a SERVICES=(
    "jellyfin"
    "qbittorrent"
    "radarr"
    "sonarr"
    "readarr"
    "audiobookshelf"
)

# Create media directories
declare -a MEDIA_DIRS=(
    "jellyfin/media/movies"
    "jellyfin/media/tv"
    "jellyfin/media/books"
    "jellyfin/media/audiobooks"
)

# Create common directories
mkdir -p "$BASE_DIR/downloads"
mkdir -p "$BASE_DIR/downloads/incomplete"

# Create service specific directories
for SERVICE in "${SERVICES[@]}"; do
    mkdir -p "$BASE_DIR/$SERVICE/config"
    if [ "$SERVICE" = "jellyfin" ]; then
        mkdir -p "$BASE_DIR/$SERVICE/cache"
    fi
done

# Create media directories
for DIR in "${MEDIA_DIRS[@]}"; do
    mkdir -p "$BASE_DIR/$DIR"
done

# Create metadata directory for audiobookshelf
mkdir -p "$BASE_DIR/audiobookshelf/metadata"

# Set permissions
# Get PUID and PGID from .env file, default to 1000 if not found
PUID=$(grep PUID .env 2>/dev/null | cut -d '=' -f2 || echo 1000)
PGID=$(grep PGID .env 2>/dev/null | cut -d '=' -f2 || echo 1000)

echo "Setting permissions for PUID=$PUID and PGID=$PGID"

# Set ownership and permissions for all directories
find "$BASE_DIR" -type d -exec chown $PUID:$PGID {} \;
find "$BASE_DIR" -type d -exec chmod 755 {} \;

echo "Directory structure created and permissions set!"
echo "
Created directories:
- Service configs (jellyfin, qbittorrent, etc.)
- Downloads directory
- Media directories (movies, tv, books, audiobooks)
- Cache and metadata directories

Next steps:
1. Copy .env.example to .env and adjust values
2. Run 'docker compose -f jellyfin/compose.yml up -d'
" 