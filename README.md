# Home NAS Setup

Docker-based home media server setup including:
- Jellyfin (Media Server)
- qBittorrent (Download Client)
- Sonarr (TV Shows)
- Radarr (Movies)
- Readarr (Books)
- Audiobookshelf (Audiobooks)

## Setup Instructions

1. Clone this repository
2. Copy `.env.example` to `.env` and adjust values
3. Run `docker compose -f jellyfin/compose.yml up -d`

## Services

- Jellyfin: http://localhost:8096
- qBittorrent: http://localhost:8080
- Sonarr: http://localhost:8989
- Radarr: http://localhost:7878
- Readarr: http://localhost:8787
- Audiobookshelf: http://localhost:13378 