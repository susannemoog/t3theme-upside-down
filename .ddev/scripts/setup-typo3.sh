#!/usr/bin/env bash

# Idempotent TYPO3 setup for DDEV post-start.
# Creates Build/ on first run; subsequent runs refresh composer and caches.

set -euo pipefail

source /var/www/html/.ddev/scripts/functions.sh

BUILD_DIR="${PROJECT_ROOT}/Build"
BUILD_COMPOSER="${BUILD_DIR}/composer.json"
SETTINGS_FILE="${BUILD_DIR}/config/system/settings.php"

echo ""
echo -e "${BOLD}Upside Down — Setup${NC}"
echo "═══════════════════════════════════════"
echo ""

# ── Step 1: Bootstrap Build/ ──────────────────────────────────────────────────

if [ ! -f "${BUILD_COMPOSER}" ]; then
    info "[1/4] Creating Build environment..."
    mkdir -p "${BUILD_DIR}"

    cat > "${BUILD_COMPOSER}" << 'COMPOSER_JSON'
{
  "type": "project",
  "repositories": [
    { "type": "path", "url": ".." }
  ],
  "require": {
    "php": "^8.3",
    "surfcamp/theme-upside-down": "@dev",
    "typo3/cms-core": "^14.3",
    "typo3/cms-fluid": "^14.3",
    "typo3/cms-fluid-styled-content": "^14.3",
    "typo3/cms-frontend": "^14.3",
    "typo3/cms-adminpanel": "^14.3",
    "typo3/cms-backend": "^14.3",
    "typo3/cms-belog": "^14.3",
    "typo3/cms-beuser": "^14.3",
    "typo3/cms-dashboard": "^14.3",
    "typo3/cms-extbase": "^14.3",
    "typo3/cms-extensionmanager": "^14.3",
    "typo3/cms-filelist": "^14.3",
    "typo3/cms-form": "^14.3",
    "typo3/cms-impexp": "^14.3",
    "typo3/cms-info": "^14.3",
    "typo3/cms-install": "^14.3",
    "typo3/cms-lowlevel": "^14.3",
    "typo3/cms-rte-ckeditor": "^14.3",
    "typo3/cms-setup": "^14.3",
    "typo3/cms-tstemplate": "^14.3",
    "typo3/cms-viewpage": "^14.3"
  },
  "config": {
    "sort-packages": true,
    "allow-plugins": {
      "typo3/class-alias-loader": true,
      "typo3/cms-composer-installers": true
    }
  },
  "extra": {
    "typo3/cms": {
      "web-dir": "public"
    }
  }
}
COMPOSER_JSON

    success "Build/composer.json created"
else
    info "[1/4] Build environment already present"
fi

# Generate Build/config/system/additional.php (DDEV dev overrides)
mkdir -p "${BUILD_DIR}/config/system"
cat > "${BUILD_DIR}/config/system/additional.php" << 'ADDITIONAL_PHP'
<?php
if (getenv('IS_DDEV_PROJECT') === 'true') {
    $GLOBALS['TYPO3_CONF_VARS'] = array_replace_recursive(
        $GLOBALS['TYPO3_CONF_VARS'],
        [
            'GFX' => [
                'processor'         => 'ImageMagick',
                'processor_path'    => '/usr/bin/',
                'processor_path_lzw'=> '/usr/bin/',
            ],
            'MAIL' => [
                'transport'              => 'smtp',
                'transport_smtp_encrypt' => false,
                'transport_smtp_server'  => 'localhost:1025',
            ],
            'SYS' => [
                'trustedHostsPattern' => '.*.*',
                'devIPmask'           => '*',
                'displayErrors'       => 1,
            ],
        ]
    );

    // Backend login branding — controlled via DDEV web_environment vars
    // (override in .ddev/config.local.yaml or .ddev/.env)
    $GLOBALS['TYPO3_CONF_VARS']['EXTENSIONS']['backend'] = array_replace(
        $GLOBALS['TYPO3_CONF_VARS']['EXTENSIONS']['backend'] ?? [],
        array_filter([
            'loginLogo'            => getenv('TYPO3_BE_LOGIN_LOGO') ?: '',
            'loginBackgroundImage' => getenv('TYPO3_BE_LOGIN_BG_IMAGE') ?: '',
            'loginHighlightColor'  => getenv('TYPO3_BE_LOGIN_HIGHLIGHT_COLOR') ?: '',
        ])
    );
}
ADDITIONAL_PHP

# ── Step 2: Composer install ──────────────────────────────────────────────────

info "[2/4] Running composer install..."
composer install --working-dir="${BUILD_DIR}" --no-interaction || {
    error "Composer install failed"
    exit 1
}
success "Dependencies installed"

# ── Step 3: TYPO3 setup (first run only) ─────────────────────────────────────

if [ ! -f "${SETTINGS_FILE}" ]; then
    info "[3/4] Initial TYPO3 setup..."
    cd "${BUILD_DIR}" && vendor/bin/typo3 setup --no-interaction --force --server-type=other
    success "TYPO3 configured"
else
    info "[3/4] TYPO3 already configured"
fi

# Install .htaccess if missing (required for slug-based routing under Apache)
HTACCESS="${BUILD_DIR}/public/.htaccess"
HTACCESS_TPL="${BUILD_DIR}/vendor/typo3/cms-install/Resources/Private/FolderStructureTemplateFiles/root-htaccess"
if [ ! -f "${HTACCESS}" ] && [ -f "${HTACCESS_TPL}" ]; then
    cp "${HTACCESS_TPL}" "${HTACCESS}"
    info "Installed Build/public/.htaccess"
fi

# Generate TYPO3 site configuration (always regenerate so base URL stays in sync with DDEV hostname)
SITE_CONFIG_DIR="${BUILD_DIR}/config/sites/main"
mkdir -p "${SITE_CONFIG_DIR}"
cat > "${SITE_CONFIG_DIR}/config.yaml" << 'SITE_YAML'
rootPageId: 1
base: /
dependencies:
  - surfcamp/theme-upside-down
languages:
  - title: English
    enabled: true
    languageId: 0
    base: /
    typo3Language: default
    locale: en_US.UTF-8
    iso-639-1: en
    navigationTitle: English
    hreflang: en-US
    direction: ltr
    flag: us
errorHandling: []
routes: []
SITE_YAML
info "Site configuration written (base: /)"

# ── Step 4: Extension setup + cache flush ────────────────────────────────────

info "[4/4] Extension setup + cache flush..."
cd "${BUILD_DIR}" && vendor/bin/typo3 extension:setup 2>/dev/null || warn "extension:setup had warnings"
cd "${BUILD_DIR}" && vendor/bin/typo3 cache:flush 2>/dev/null || warn "cache:flush had warnings"
success "Done"

echo ""
echo "═══════════════════════════════════════"
success "TYPO3 is ready  →  ${DDEV_PRIMARY_URL}/typo3/"
echo -e "  Login: ${BOLD}admin${NC} / ${BOLD}Password.1${NC}"
echo -e "  Demo content: ${BOLD}ddev seed${NC}"
echo ""
