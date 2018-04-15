<?php



if (empty($GLOBALS['bLangSetting'])) {
    $resp = $modx->db->makeArray($modx->db->query("select * from " . $modx->getFullTableName('blang_settings')));
    foreach ($resp as $field) {
        $GLOBALS['bLangSetting'][$field['name']] = $field['value'];
    }
}
//старие настройки плагина
$fields = $GLOBALS['bLangSetting']['fields'];
$translate = $GLOBALS['bLangSetting']['translate'];
$languages = $GLOBALS['bLangSetting']['langs'];
$root = $GLOBALS['bLangSetting']['root'];
$yandexKey = $GLOBALS['bLangSetting']['yandexKey'];

//если все поля переводить
if($fields == 1){
    $fields = [];
    $resp = $modx->db->makeArray($modx->db->query("select name from ".$modx->getFullTableName('blang_tmplvars')));
    if(is_array($resp)){
        foreach ($resp as $el) {
            $fields[] = $el['name'];
        }
    }
    $fields = implode(',',$fields);
}
//добавляэм mtv .
if (in_array($modx->event->name, ['OnWebPageInit', 'OnManagerPageInit'])) {

    if (!function_exists('mtvLang')) {
        function mtvLang($settings, $templates = ['templates'])
        {

            global $modx;
            $langs = explode(',', $GLOBALS['bLangSetting']['langs']);

            $changesFields = [];

            if (!empty($settings['changesFields'])) {
                $changesFields = $settings['changesFields'];
            }
            $pageLang = $modx->getConfig('_lang');
            //делаем поля mtv мультимовными
            $fields = $settings['fields'];
            $langFields = [];
            foreach ($changesFields as $fieldName) {
                $temp = $fields[$fieldName];
                foreach ($langs as $lang) {
                    $tempLang = $temp;
                    $tempLang['caption'] = $tempLang['caption'] . ' (' . $lang . ')';
                    $langFields[$fieldName][$fieldName . '_' . $lang] = $tempLang;
                }
            }
            $newFields = [];
            foreach ($fields as $fieldName => $field) {
                if (in_array($fieldName, $changesFields) && !empty($langFields[$fieldName])) {
                    foreach ($langFields[$fieldName] as $langFieldName => $langField) {
                        $newFields[$langFieldName] = $langField;
                    }
                } else {
                    $newFields[$fieldName] = $field;
                }
            }
            if (!empty($newFields)) {
                $settings['fields'] = $newFields;
            }
            //шаблоны
            //замена полей
            if (is_array($templates)) {
                foreach ($templates as $templateKey) {
                    $rowTpl = $settings[$templateKey]['rowTpl'];
                    foreach ($changesFields as $fieldName) {
                        $rowTpl = str_replace('[+' . $fieldName . '+]', '[+' . $fieldName . '_' . $pageLang . '+]', $rowTpl);
                    }
                    $settings[$templateKey]['rowTpl'] = $rowTpl;
                }
            }
            return $settings;
        }
    }
    if($modx->event->name == 'OnManagerPageInit'){
        return;
    }
}

if (!function_exists('prepareLang')) {
    function prepareLang($lang)
    {
        switch ($lang) {
            case 'ua':
                $lang = 'uk';
                break;
        }
        return $lang;
    }
}

$e =& $modx->event;
$modx->config['agent'] = $_SERVER['HTTP_USER_AGENT'];

$fields = isset($fields) ? $fields : '';
$translate = isset($translate) ? $translate : 0;
$languages = isset($languages) ? explode(',', $languages) : '';
$root = isset($root) ? $root : 'ru';
$yandexKey = isset($yandexKey) ? $yandexKey : '';


if ($e->name == 'OnDocFormSave' && $translate == 1) {

    require_once MODX_BASE_PATH . 'assets/modules/blang/translate/src/Translation.php';
    require_once MODX_BASE_PATH . 'assets/modules/blang/translate/src/Translator.php';
    require_once MODX_BASE_PATH . 'assets/modules/blang/translate/src/Exception.php';
    require_once MODX_BASE_PATH . 'assets/lib/MODxAPI/modResource.php';


    $data = [];
    $fields = explode(',', $fields);

    $doc = new modResource($modx);
    $doc->edit((int)$id);

    foreach ($languages as $lang) {
        foreach ($fields as $field) {
            $data[$field.'_' . $lang] = $doc->get($field.'_' . $lang);
        }
    }
    $data['pagetitle'] = $doc->get('pagetitle');

    if (empty($data['pagetitle_' . $root]) && !empty($data['pagetitle'])) {
        $data['pagetitle_' . $root] = $data['pagetitle'];
    }

    $translator = new Yandex\Translate\Translator($yandexKey);

    if (is_array($languages)) {
        foreach ($languages as $lang) {
            if ($lang == $root) {
                continue;
            }
            foreach ($fields as $field) {
                if (empty($data[$field . '_' . $root]) || !empty($data[$field . '_' . $lang])) {
                    continue;
                }

                $translation = $translator->translate($data[$field . '_' . $root], prepareLang($root) . '-' . prepareLang($lang));
                $data[$field . '_' . $lang] = (string)$translation;



            }
        }
    }

    $data['content_ru'] = str_replace('<р>','<p>',$data['content_ru']);
    $data['content_ua'] = str_replace('<р>','<p>',$data['content_ua']);



    foreach ($data as $key => $value) {
        $doc->set($key, $value);
    }
    return $doc->save(false, false);
}
if ($e->name == 'OnLoadWebDocument' ) {
    $l = explode('-', $_SERVER['HTTP_ACCEPT_LANGUAGE']);


    if (empty($_COOKIE['deflang'])) {
        if (strtolower($l[0]) != 'ru' && strtolower($l[0]) != 'ua') {
            $_GET['lang'] = 'en';
        } else {
            $_GET['lang'] = 'ru';
        }
        setcookie('deflang', $_GET['lang'], time() + 10000000, '/');
        $modx->sendRedirect('http://' . $_SERVER['HTTP_HOST'] . '/' . ($_GET['lang'] == 'en' ? 'en/' . $_GET['q'] : $_GET['q']));

    }
}

$languageUrls = [];
foreach ($languages as $language) {
    if ($language == $root) {
        $languageUrls[$language] = '';
    } else {
        $languageUrls[$language] = $language . '/';
    }
}
require_once MODX_BASE_PATH . 'assets/modules/blang/lang.class.inc.php';
$Lang = LANG::GetInstance($root, $languages, $languageUrls);
$lang = (string)$Lang->lang;

$access = $modx->getTemplateVar('access_' . $lang, '*', $modx->documentIdentifier);
if ($access['value'] == '0') $this->sendForward($modx->config['site_url'] . $modx->config['_root'], 'HTTP/1.0 404 Not Found');


/*
* for bAuth
*/
$_SESSION['_root'] = $modx->config['_root'];
