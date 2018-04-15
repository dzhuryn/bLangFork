name:prepare
description:prepare
======
<?php
/** @var DocLister $_DocLister */
/** @var DocumentParser $modx $id */

$id = $_DocLister->getCFGDef('id');
$lang = $modx->getConfig('_lang');

if(!empty($lang)){
    $data['url'] = $modx->getConfig('_root') . substr($modx->makeUrl($data['id']), 1);

    if (!empty($data['menutitle_' . $lang])) {
        $data['title'] = $data['menutitle_' . $lang];
    } else {
        $data['title'] = $data['pagetitle_' . $lang];
    }
    $data['pagetitle'] = $data['pagetitle_' . $lang];
    $data['longtitle'] = $data['longtitle_' . $lang];
    $data['menutitle'] = $data['menutitle_' . $lang];
    $data['introtext'] = $data['introtext_' . $lang];
    $data['content'] = $data['content_' . $lang];
}

switch ($id) {
    default:
        break;

}
return $data;
