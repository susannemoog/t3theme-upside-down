<?php

declare(strict_types=1);

use TYPO3\CMS\Core\Utility\ExtensionManagementUtility;

defined('TYPO3') or die();

ExtensionManagementUtility::addRecordType(
    [
        'label' => 'LLL:EXT:theme_upside_down/Resources/Private/Language/backend_fields.xlf:tt_content.CType.upside_testimonial.label',
        'description' => 'LLL:EXT:theme_upside_down/Resources/Private/Language/backend_fields.xlf:tt_content.CType.upside_testimonial.description',
        'value' => 'upside_testimonial',
        'icon' => 'content-special-html',
        'group' => 'upside_narrative',
    ],
    '
      header,
      subheader,
      bodytext,
      tx_themeupsidedown_testimonial_citation,
      tx_themeupsidedown_testimonial_location,
      tx_themeupsidedown_testimonial_clearance,
      --div--;core.form.tabs:access,
      hidden,starttime,endtime
    '
);
