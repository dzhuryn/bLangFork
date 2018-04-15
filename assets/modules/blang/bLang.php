<?php
/**
 * Created by PhpStorm.
 * User: admin
 * Date: 21.01.2018
 * Time: 17:34
 */

class bLang
{
    public  $languages = [];

    public function __construct()
    {
        $this->languages = explode(',',$GLOBALS['bLangSetting']['langs']);

    }

    public function renderMM(){


        global $modx;
        $tempalte = '';
        if(!empty($_REQUEST['newtemplate'])){
            $tempalte = $_REQUEST['newtemplate'];
        }
        if($tempalte == '' && !empty($_GET['id'])){
            $docId = (int) $_GET['id'];
            $tempalte = $modx->runSnippet('DocInfo',['field'=>'template','docid'=>$docId]);
        }

        if($tempalte == ''){
            $tempalte = $modx->getConfig('default_template');
        }

        $tempalte = (int) $tempalte;

        //получаэм тв с учетом шаблона текущего

        $BT = $modx->getFullTableName('blang_tmplvars');
        $BTT = $modx->getFullTableName('blang_tmplvar_templates');

        $sql = "select BT.* from $BT as BT, $BTT as BTT where BT.id = BTT.tmplvarid and BTT.templateid = ".$tempalte." order by rank asc";

        $tvs = $modx->db->makeArray($modx->db->query($sql));


        $tabs = [];
        foreach ($tvs as $tv) {
            if(empty($tv['tab'])){
                continue;
            }
            $tabResp = explode('==',$tv['tab']);
            $tab = $tabResp[0];

            $tabName = empty($tabResp[1])?$tabResp[0]:$tabResp[1];

            if($tab == '[lang]'){
                foreach ($this->languages as $lang) {
                    $tabs[$lang] = $lang;
                }
            }
            else{
                $tabs[$tab] = $tabName;
            }

        }

        foreach ($tabs as $tab => $tabName) {
            mm_createTab($tabName, $tab.'_tab', '', '');
        }
        foreach ($tvs as $tv) {
            if(empty($tv['tab'])){
                continue;
            }


            $tabResp = explode('==',$tv['tab']);
            $tab = $tabResp[0];


            $fieldName = $tv['name'];
            if($tab == '[lang]'){
                foreach ($this->languages as $lang) {
                    mm_moveFieldsToTab($fieldName.'_'.$lang,$lang.'_tab');
                }
            }
            else{
                foreach ($this->languages as $lang) {


                    mm_moveFieldsToTab($fieldName.'_'.$lang,$tab.'_tab');
                }

            }

        }


    }

}