<?php

declare(strict_types=1);

defined('TYPO3') or die();

// Load the backend-preview stylesheet into every backend page.
// f:asset.css does NOT work in content preview templates because those are rendered
// as late HTML fragments after PageRenderer::render() has already assembled <head>.
// $GLOBALS['TYPO3_CONF_VARS']['BE']['stylesheets'] is the only mechanism that
// injects a CSS file into the backend <head> reliably from an extension.
$GLOBALS['TYPO3_CONF_VARS']['BE']['stylesheets']['theme_upside_down_preview']
    = 'EXT:theme_upside_down/Resources/Public/Css/backend-preview.css';
