# Link portal configuration

All content is defined in [`_data/links.yml`](../_data/links.yml). Jekyll exposes this file as `site.data.links`.

A starter file with **GitHub** bookmarks and a **multi-environment** link is in [`_data/links.example.yml`](../_data/links.example.yml) (tracked in git). Copy it to `_data/links.yml` for your local bookmarks (gitignored):

```bash
cp _data/links.example.yml _data/links.yml
```

## Top-level structure

| Key | Required | Description |
|-----|----------|-------------|
| `site` | No | Branding shown in the sidebar |
| `all_group` | No | Label and description for the virtual **All** sidebar entry (always first; id is `all`) |
| `environments` | No | Env badge order and labels when using per-env URLs |
| `groups` | Yes | Sidebar sections (do not use `id: all`; that view is built-in) |
| `links` | Yes | Bookmark cards assigned to a group |

## `site`

| Field | Description |
|-------|-------------|
| `title` | Main title next to the logo (falls back to `_config.yml` `title`) |
| `subtitle` | Short tagline under the title in the sidebar |
| `version` | Optional; sidebar footer version if `component_version` is not set in [`_config.yml`](../_config.yml) |

## `all_group`

Optional. Controls the built-in **All** group (first in the sidebar, shows every link). You do not add links with `group: all`.

| Field | Description |
|-------|-------------|
| `label` | Sidebar label (default `All`) |
| `description` | Shown under the page title when All is selected |

**Component version (sidebar footer):** set `component_version` in [`_config.yml`](../_config.yml) (e.g. `"1.0.0"`). Bump it when you release an update to this portal.

## `environments`

Optional. Used when a link defines `urls` (one URL per environment).

| Field | Required | Description |
|-------|----------|-------------|
| `id` | Yes | Key used under `links[].urls` (also CSS class on the badge) |
| `label` | No | Badge text (defaults to capitalized `id`) |

If omitted, the template falls back to `local`, `latest`, `stage`, `load`, `prod` **only for keys present** on each link’s `urls` map.

When `environments` is set, **every** listed environment gets a badge on links that use `urls`: non-empty values are clickable; empty or missing values show as disabled (grey).

## `groups`

Each entry:

| Field | Required | Description |
|-------|----------|-------------|
| `id` | Yes | Stable id used in URLs (`#favorites`, `#observability`) |
| `label` | Yes | Sidebar label |
| `description` | No | Shown under the page title when the group is selected |

**Rules:**

- Every `link.group` must match a group `id`.
- Do not use `id: all` in `groups`; the All view is automatic and always listed first.

## `links`

Each entry:

| Field | Required | Default | Description |
|-------|----------|---------|-------------|
| `id` | Yes | — | Stable identifier |
| `group` | Yes | — | Group `id` this link belongs to |
| `title` | Yes | — | Card title |
| `url` | Conditional | — | Single destination URL (use **or** `urls`) |
| `urls` | Conditional | — | Map of environment id → URL (use **or** `url`) |
| `description` | No | — | Optional subtitle on the card |
| `tags` | No | `[]` | Optional labels (included in search) |
| `open_in_new_tab` | No | `false` | Set to `true` to open in a new tab (title link and env badges) |

**URL modes:**

1. **Single URL** — set `url` only, or `urls` with exactly one non-empty value. A **full-width environment-style button** is shown (same layout as the Local row on multi-env cards). Plain `url` uses the Local label; a single `urls` entry uses that environment’s label and colors.
2. **Multiple environments** — set `urls` with two or more non-empty values. The card is not clickable as a whole; use the **environment badges** to open each URL.

## Search

The search bar filters cards in the **currently selected sidebar group** by title, description, tags, id, and all configured URLs (client-side).

## Example

```yaml
environments:
  - id: local
    label: Local
  - id: latest
    label: Latest
  - id: stage
    label: Stage
  - id: prod
    label: Prod

links:
  - id: grafana
    group: favorites
    title: Grafana
    description: Metrics and dashboards
    tags: [metrics]
    urls:
      local: https://grafana.local.io
      latest: https://latest.grafana.example.com
      stage: https://stage.grafana.example.com
      prod: ""

  - id: traefik
    group: favorites
    title: Traefik
    url: http://traefik.local.io
```

## Local preview

After editing `_data/links.yml`, save the file. With Docker (`make start`), Jekyll watch reloads the site automatically.
