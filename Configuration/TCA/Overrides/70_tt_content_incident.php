<?php

declare(strict_types=1);

use TYPO3\CMS\Core\Utility\ExtensionManagementUtility;

defined('TYPO3') or die();

ExtensionManagementUtility::addRecordType(
    [
        'label' => 'LLL:EXT:theme_upside_down/Resources/Private/Language/backend_fields.xlf:tt_content.CType.upside_incident.label',
        'description' => 'LLL:EXT:theme_upside_down/Resources/Private/Language/backend_fields.xlf:tt_content.CType.upside_incident.description',
        'value' => 'upside_incident',
        'icon' => 'content-bullets',
        'group' => 'upside_narrative',
    ],
    '
      header,
      tx_themeupsidedown_incident_id,
      tx_themeupsidedown_incident_date,
      tx_themeupsidedown_incident_classification,
      bodytext,
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
