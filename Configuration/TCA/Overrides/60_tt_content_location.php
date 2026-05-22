<?php

declare(strict_types=1);

use TYPO3\CMS\Core\Utility\ExtensionManagementUtility;

defined('TYPO3') or die();

ExtensionManagementUtility::addRecordType(
    [
        'label' => 'LLL:EXT:theme_upside_down/Resources/Private/Language/backend_fields.xlf:tt_content.CType.upside_location.label',
        'description' => 'LLL:EXT:theme_upside_down/Resources/Private/Language/backend_fields.xlf:tt_content.CType.upside_location.description',
        'value' => 'upside_location',
        'icon' => 'content-textmedia',
        'group' => 'upside_narrative',
    ],
    '
      header,
      tx_themeupsidedown_location_coords,
      bodytext,
      tx_themeupsidedown_location_threat,
      tx_themeupsidedown_location_featured,
      assets,
      --div--;core.form.tabs:access,
      hidden,starttime,endtime
    '
);
