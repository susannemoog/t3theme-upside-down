<?php

declare(strict_types=1);

use TYPO3\CMS\Core\Utility\ExtensionManagementUtility;

defined('TYPO3') or die();

ExtensionManagementUtility::addRecordType(
    [
        'label' => 'LLL:EXT:theme_upside_down/Resources/Private/Language/backend_fields.xlf:tt_content.CType.upside_character.label',
        'description' => 'LLL:EXT:theme_upside_down/Resources/Private/Language/backend_fields.xlf:tt_content.CType.upside_character.description',
        'value' => 'upside_character',
        'icon' => 'content-text',
        'group' => 'upside_narrative',
    ],
    '
      header,
      subheader,
      tx_themeupsidedown_character_faction,
      bodytext,
      tx_themeupsidedown_character_status,
      --div--;core.form.tabs:access,
      hidden,starttime,endtime
    '
);
