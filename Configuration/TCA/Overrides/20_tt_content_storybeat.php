<?php

declare(strict_types=1);

use TYPO3\CMS\Core\Utility\ExtensionManagementUtility;

defined('TYPO3') or die();

ExtensionManagementUtility::addRecordType(
    [
        'label' => 'LLL:EXT:theme_upside_down/Resources/Private/Language/backend_fields.xlf:tt_content.CType.upside_storybeat.label',
        'description' => 'LLL:EXT:theme_upside_down/Resources/Private/Language/backend_fields.xlf:tt_content.CType.upside_storybeat.description',
        'value' => 'upside_storybeat',
        'icon' => 'content-text',
        'group' => 'upside_narrative',
    ],
    '
      --palette--;;headers,
      bodytext,
      --div--;core.form.tabs:appearance,
      --palette--;;frames,
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
