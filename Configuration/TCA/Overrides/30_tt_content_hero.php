<?php

declare(strict_types=1);

use TYPO3\CMS\Core\Utility\ExtensionManagementUtility;

defined('TYPO3') or die();

ExtensionManagementUtility::addRecordType(
    [
        'label' => 'LLL:EXT:theme_upside_down/Resources/Private/Language/backend_fields.xlf:tt_content.CType.upside_hero.label',
        'description' => 'LLL:EXT:theme_upside_down/Resources/Private/Language/backend_fields.xlf:tt_content.CType.upside_hero.description',
        'value' => 'upside_hero',
        'icon' => 'content-header',
        'group' => 'upside_narrative',
    ],
    '
      header,
      subheader,
      bodytext,
      --div--;core.form.tabs:access,
      hidden,starttime,endtime
    '
);
