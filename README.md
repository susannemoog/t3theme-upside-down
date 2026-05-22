# Upside Down — TYPO3 Theme

A custom TYPO3 14 theme extension with a Stranger Things-inspired visual language. The repository ships the full DDEV development environment alongside the extension — clone, start, seed, done.

## Quick Start

```bash
git clone <this-repo> upside-down
cd upside-down
ddev start
ddev seed
```

On first `ddev start`, the post-start hook installs TYPO3 14 from Packagist into a gitignored `Build/` directory, generates the site configuration, and sets up the database schema. `ddev seed` imports demo content and copies media assets.

- **Frontend:** https://upside-down.ddev.site
- **Backend:** https://upside-down.ddev.site/typo3/
- **Login:** `admin` / `Password.1`

## Commands

```bash
ddev start          # install TYPO3, generate site config, extension:setup, cache:flush
ddev seed           # import demo content + copy media to fileadmin (safe, guards against overwrite)
ddev seed --force   # overwrite existing content
ddev test           # run 37 Playwright E2E tests
```

## Running Tests

Tests run in a dedicated Playwright container (Chromium pre-installed):

```bash
ddev test                        # run all 37 tests
ddev test --grep "Hero"          # run a subset
```

The Playwright container (`mcr.microsoft.com/playwright`) is started automatically alongside the web and db containers on `ddev start`.

## Pages

The demo content seeds six pages:

| URL | Title |
|-----|-------|
| `/` | Landing page — hero, dispatch, characters, locations, incidents, testimonials |
| `/hawkins-field-guide` | Hawkins Field Guide — storybeat layout |
| `/survival-kit` | Survival Kit |
| `/strange-questions` | Strange Questions |
| `/imprint` | Imprint (hidden from nav) |
| `/privacy` | Privacy (hidden from nav) |

## How It Works

### Directory Layout

```
upside-down/
├── .ddev/
│   ├── commands/host/test          # ddev test — runs Playwright in dedicated container
│   ├── commands/web/seed           # ddev seed — imports demo content
│   ├── docker-compose.playwright.yaml
│   ├── config.yaml
│   └── scripts/
│       ├── functions.sh
│       └── setup-typo3.sh          # idempotent post-start hook
├── Configuration/
│   ├── Sets/upside-down/           # TYPO3 14 Site Set (TypoScript, TSconfig, settings)
│   ├── BackendLayouts/
│   └── TCA/Overrides/              # 7 custom CTypes
├── Resources/
│   ├── Private/
│   │   ├── Templates/              # Fluid templates for pages and content elements
│   │   ├── Language/               # Backend field labels
│   │   └── Sql/                    # Demo content seed SQL
│   └── Public/
│       ├── Css/                    # Component stylesheets
│       ├── JavaScript/
│       └── Media/                  # SVG assets
├── Tests/playwright/specs/         # E2E test specs
├── composer.json                   # type: typo3-cms-extension
├── ext_emconf.php
├── ext_localconf.php
├── ext_tables.sql
└── Build/                          # gitignored — created by setup-typo3.sh
    ├── composer.json               # type: project, path repo → ..
    ├── public/                     # TYPO3 web root (docroot)
    ├── vendor/
    ├── var/
    └── config/                     # settings.php, additional.php, site config
```

### Post-Start Hook

`setup-typo3.sh` runs on every `ddev start` and is fully idempotent:

1. Creates `Build/composer.json` (first run only) — `type: project`, path repository pointing to the extension root at `..`
2. Generates `Build/config/system/additional.php` — DDEV overrides for ImageMagick, SMTP, and `displayErrors`
3. Runs `composer install --working-dir=Build/`
4. Runs `typo3 setup` (first run only, guarded by `settings.php` presence)
5. Copies `.htaccess` from the TYPO3 install template (required for slug-based routing under Apache)
6. Generates `Build/config/sites/main/config.yaml` — site configuration with `base: /` and the `surfcamp/theme-upside-down` Site Set dependency
7. Runs `extension:setup` and `cache:flush`

### TYPO3 Site Set

TypoScript and TSconfig are delivered via a [TYPO3 14 Site Set](https://docs.typo3.org/m/typo3/reference-coreapi/main/en-us/ApiOverview/SiteHandling/SiteSets.html) — no `sys_template` database record is required. The site configuration references it via:

```yaml
dependencies:
  - surfcamp/theme-upside-down
```

### Custom CTypes

Seven custom content element types extend `tt_content`:

| CType | Description |
|-------|-------------|
| `upside_hero` | Landing hero with eyebrow text, headline, and scroll anchor |
| `upside_featured` | Dispatch card with badge, title, and CTA |
| `upside_character` | Character card with status badge (unknown / missing / compromised / alive) |
| `upside_location` | Location card with featured flag and threat level |
| `upside_incident` | Accordion item with classification label |
| `upside_testimonial` | Testimonial slider item |
| `upside_storybeat` | Storybeat block for the field guide layout |

## Requirements

- [DDEV](https://ddev.readthedocs.io/en/stable/) v1.24+
- Docker (Docker Desktop, Rancher Desktop, or Colima)
- Git

## License

GPL-2.0-or-later — see [LICENSE](LICENSE).
