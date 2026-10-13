# Browser Favourites (Docker)

Local landing page for bookmark groups: a left sidebar (Favorites first, then YAML-defined groups) and a card grid of links in the main area. Content is driven entirely by [`_data/links.yml`](_data/links.yml).

## Requirements

- Docker and Docker Compose
- Traefik v3 (or compatible) on the external Docker network `lb-common`

## Setup

1. Add the local hostname (requires sudo):

```bash
sudo make add_localhost
```

2. Start the site:

```bash
make start
```

3. Open:

```
https://browser.local.io
```

HTTP redirects to HTTPS. LiveReload is disabled when served over Traefik to avoid mixed content.

4. Stop:

```bash
make stop
```

5. Follow container logs:

```bash
make logs
```

## Configuration

Edit [`_data/links.yml`](_data/links.yml) to add groups and links (gitignored except the sample). To start from a sample with GitHub links and a multi-env card, copy [`_data/links.example.yml`](_data/links.example.yml) to `_data/links.yml`. Full field reference: [docs/CONFIGURATION.md](docs/CONFIGURATION.md).

Jekyll watch reloads changes automatically while the container is running (source is volume-mounted).

## Ruby without Docker

```bash
bundle install
bundle exec jekyll serve
```

Then open `http://localhost:4000`.

## Project layout

```
├── _data/links.example.yml  # Sample config (in git)
├── _data/links.yml          # Your links (gitignored; copy from sample)
├── _includes/               # Sidebar, cards, portal
├── _layouts/default.html
├── assets/css/              # Dashboard + link card styles
├── docker/                  # Dockerfile and compose
└── index.md                 # Main landing page
```
