<?php

declare(strict_types=1);

use TYPO3\CMS\Core\Utility\ExtensionManagementUtility;

defined('TYPO3') or die();

ExtensionManagementUtility::addRecordType(
    [
        'label' => 'LLL:EXT:theme_upside_down/Resources/Private/Language/backend_fields.xlf:tt_content.CType.upside_featured.label',
        'description' => 'LLL:EXT:theme_upside_down/Resources/Private/Language/backend_fields.xlf:tt_content.CType.upside_featured.description',
        'value' => 'upside_featured',
        'icon' => 'content-textpic',
        'group' => 'upside_narrative',
    ],
    '
      header,
      subheader,
      bodytext,
      tx_themeupsidedown_cta_label,
      tx_themeupsidedown_cta_link,
      assets,
      --div--;core.form.tabs:access,
      hidden,starttime,endtime
    ',
    [
        'columnsOverrides' => [
            'bodytext' => [
                'config' => [
                    'enableRichtext' => true,
                ],
            ],
        ],
    ]
);
