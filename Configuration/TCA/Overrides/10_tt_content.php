<?php

declare(strict_types=1);

use TYPO3\CMS\Core\Utility\ExtensionManagementUtility;

defined('TYPO3') or die();

ExtensionManagementUtility::addTCAcolumns('tt_content', [
    'tx_themeupsidedown_cta_link' => [
        'exclude' => true,
        'label' => 'LLL:EXT:theme_upside_down/Resources/Private/Language/backend_fields.xlf:tt_content.tx_themeupsidedown_cta_link',
        'config' => [
            'type' => 'link',
            'allowedTypes' => ['page', 'url', 'record'],
            'appearance' => [
                'allowedFileExtensions' => '',
            ],
        ],
    ],
    'tx_themeupsidedown_cta_label' => [
        'exclude' => true,
        'label' => 'LLL:EXT:theme_upside_down/Resources/Private/Language/backend_fields.xlf:tt_content.tx_themeupsidedown_cta_label',
        'config' => [
            'type' => 'input',
            'eval' => 'trim',
            'max' => 120,
        ],
    ],
]);

ExtensionManagementUtility::addFieldsToPalette(
    'tt_content',
    'headers',
    '--linebreak--,tx_themeupsidedown_cta_link,tx_themeupsidedown_cta_label',
    'after:subheader'
);

// Custom columns for narrative content elements
ExtensionManagementUtility::addTCAcolumns('tt_content', [
    // upside_character
    'tx_themeupsidedown_character_faction' => [
        'exclude' => true,
        'label' => 'LLL:EXT:theme_upside_down/Resources/Private/Language/backend_fields.xlf:tt_content.tx_themeupsidedown_character_faction',
        'config' => ['type' => 'input', 'eval' => 'trim', 'max' => 255],
    ],
    'tx_themeupsidedown_character_status' => [
        'exclude' => true,
        'label' => 'LLL:EXT:theme_upside_down/Resources/Private/Language/backend_fields.xlf:tt_content.tx_themeupsidedown_character_status',
        'config' => [
            'type' => 'select',
            'renderType' => 'selectSingle',
            'items' => [
                ['label' => 'LLL:EXT:theme_upside_down/Resources/Private/Language/backend_fields.xlf:tt_content.tx_themeupsidedown_character_status.unknown', 'value' => 'unknown'],
                ['label' => 'LLL:EXT:theme_upside_down/Resources/Private/Language/backend_fields.xlf:tt_content.tx_themeupsidedown_character_status.alive', 'value' => 'alive'],
                ['label' => 'LLL:EXT:theme_upside_down/Resources/Private/Language/backend_fields.xlf:tt_content.tx_themeupsidedown_character_status.missing', 'value' => 'missing'],
                ['label' => 'LLL:EXT:theme_upside_down/Resources/Private/Language/backend_fields.xlf:tt_content.tx_themeupsidedown_character_status.compromised', 'value' => 'compromised'],
            ],
            'default' => 'unknown',
        ],
    ],
    // upside_location
    'tx_themeupsidedown_location_coords' => [
        'exclude' => true,
        'label' => 'LLL:EXT:theme_upside_down/Resources/Private/Language/backend_fields.xlf:tt_content.tx_themeupsidedown_location_coords',
        'config' => ['type' => 'input', 'eval' => 'trim', 'max' => 255],
    ],
    'tx_themeupsidedown_location_threat' => [
        'exclude' => true,
        'label' => 'LLL:EXT:theme_upside_down/Resources/Private/Language/backend_fields.xlf:tt_content.tx_themeupsidedown_location_threat',
        'config' => [
            'type' => 'select',
            'renderType' => 'selectSingle',
            'items' => [
                ['label' => 'LLL:EXT:theme_upside_down/Resources/Private/Language/backend_fields.xlf:tt_content.tx_themeupsidedown_location_threat.nominal', 'value' => 'nominal'],
                ['label' => 'LLL:EXT:theme_upside_down/Resources/Private/Language/backend_fields.xlf:tt_content.tx_themeupsidedown_location_threat.elevated', 'value' => 'elevated'],
                ['label' => 'LLL:EXT:theme_upside_down/Resources/Private/Language/backend_fields.xlf:tt_content.tx_themeupsidedown_location_threat.critical', 'value' => 'critical'],
            ],
            'default' => 'nominal',
        ],
    ],
    'tx_themeupsidedown_location_featured' => [
        'exclude' => true,
        'label' => 'LLL:EXT:theme_upside_down/Resources/Private/Language/backend_fields.xlf:tt_content.tx_themeupsidedown_location_featured',
        'config' => [
            'type' => 'check',
            'renderType' => 'checkboxToggle',
        ],
    ],
    // upside_incident
    'tx_themeupsidedown_incident_id' => [
        'exclude' => true,
        'label' => 'LLL:EXT:theme_upside_down/Resources/Private/Language/backend_fields.xlf:tt_content.tx_themeupsidedown_incident_id',
        'config' => ['type' => 'input', 'eval' => 'trim', 'max' => 50],
    ],
    'tx_themeupsidedown_incident_date' => [
        'exclude' => true,
        'label' => 'LLL:EXT:theme_upside_down/Resources/Private/Language/backend_fields.xlf:tt_content.tx_themeupsidedown_incident_date',
        'config' => ['type' => 'input', 'eval' => 'trim', 'max' => 50],
    ],
    'tx_themeupsidedown_incident_classification' => [
        'exclude' => true,
        'label' => 'LLL:EXT:theme_upside_down/Resources/Private/Language/backend_fields.xlf:tt_content.tx_themeupsidedown_incident_classification',
        'config' => ['type' => 'input', 'eval' => 'trim', 'max' => 255],
    ],
    // upside_testimonial
    'tx_themeupsidedown_testimonial_citation' => [
        'exclude' => true,
        'label' => 'LLL:EXT:theme_upside_down/Resources/Private/Language/backend_fields.xlf:tt_content.tx_themeupsidedown_testimonial_citation',
        'config' => ['type' => 'input', 'eval' => 'trim', 'max' => 255],
    ],
    'tx_themeupsidedown_testimonial_location' => [
        'exclude' => true,
        'label' => 'LLL:EXT:theme_upside_down/Resources/Private/Language/backend_fields.xlf:tt_content.tx_themeupsidedown_testimonial_location',
        'config' => ['type' => 'input', 'eval' => 'trim', 'max' => 255],
    ],
    'tx_themeupsidedown_testimonial_clearance' => [
        'exclude' => true,
        'label' => 'LLL:EXT:theme_upside_down/Resources/Private/Language/backend_fields.xlf:tt_content.tx_themeupsidedown_testimonial_clearance',
        'config' => ['type' => 'input', 'eval' => 'trim', 'max' => 100],
    ],
]);

// Add Classified Document and Transmission frame class options to Story Beat elements
$GLOBALS['TCA']['tt_content']['types']['upside_storybeat']['columnsOverrides']['frame_class']['config']['items'][] = [
    'label' => 'LLL:EXT:theme_upside_down/Resources/Private/Language/backend_fields.xlf:tt_content.frame_class.classified',
    'value' => 'classified',
];

$GLOBALS['TCA']['tt_content']['types']['upside_storybeat']['columnsOverrides']['frame_class']['config']['items'][] = [
    'label' => 'LLL:EXT:theme_upside_down/Resources/Private/Language/backend_fields.xlf:tt_content.frame_class.transmission',
    'value' => 'transmission',
];
