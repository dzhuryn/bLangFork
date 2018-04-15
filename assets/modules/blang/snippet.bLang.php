<?php

$type = isset($type)?$type:'switch';


switch ($type){
    case 'alterTitle':
        $id = isset($id)?$id:$modx->documentIdentifier;
        $lang = isset($lang)?$lang:$modx->getConfig('_lang');
        $pageTitle = $modx->runSnippet('DocInfo',['field'=>'pagetitle_'.$lang,'docid'=>$id]);
        $longTitle = $modx->runSnippet('DocInfo',['field'=>'longtitle_'.$lang,'docid'=>$id]);

        echo empty($longTitle)?$pageTitle:$longTitle;

        break;
    case 'menutitle':
        $id = isset($id)?$id:$modx->documentIdentifier;
        $lang = isset($lang)?$lang:$modx->getConfig('_lang');
        $pageTitle = $modx->runSnippet('DocInfo',['field'=>'pagetitle_'.$lang,'docid'=>$id]);
        $menutitle = $modx->runSnippet('DocInfo',['field'=>'menutitle_'.$lang,'docid'=>$id]);

        echo empty($menutitle)?$pageTitle:$menutitle;

        break;
    case 'switch':
        $Mlang = LANG::GetInstance();
        $lang=(string)$Mlang->lang;
        if($pl) return '[+'.$pl.'_'.$lang.'+]';
        if ($name) return '[*'.$name.'_'.$lang.'*]';
        if ($s) return $modx->getConfig($s.'_'.$lang);
        echo $$lang;
        break;

    case 'list':


        include_once(MODX_BASE_PATH . 'assets/snippets/DocLister/lib/DLTemplate.class.php');
        $tpl = DLTemplate::getInstance($modx);
        //�������
        $outerTpl = isset($outerTpl)?$outerTpl:'@CODE:<div>[+active+][+list+]</div>';
        $activeTpl = isset($activeTpl)?$activeTpl:'@CODE:<a class="active" href="[+url+]">[+title+]</a>';
        $listTpl = isset($listTpl)?$listTpl:'@CODE:<ul>[+wrapper+]</ul>';
        $listRow = isset($listRow)?$listRow:'@CODE:<li><a href="[+url+]">[+title+]</a></li>';
        $listActiveRow = isset($listActiveRow)?$listActiveRow:'@CODE:<li><a class="active" href="[+url+]">[+title+]</a></li>';

        $languages = explode(',',$GLOBALS['bLangSetting']['langs']);
        $Mlang = LANG::GetInstance();
        $activeLang=(string)$Mlang->lang;

        $activeTitle = !empty($modx->getConfig('__'.$activeLang.'_title'))?$modx->getConfig('__'.$activeLang.'_title'):$activeLang;
        $activeUrl = $modx->getConfig('_'.$activeLang.'_url');
        
        $active = $tpl->parseChunk($activeTpl,[
            'title'=>$activeTitle,
            'url'=>$activeUrl,
        ]);
        
        $listItems = '';
        foreach ($languages as $lang) {
            $url = $modx->getConfig('_'.$lang.'_url');
            $title = !empty($modx->getConfig('__'.$lang.'_title'))?$modx->getConfig('__'.$lang.'_title'):$lang;
            
            $template = $lang == $activeLang?$listActiveRow:$listRow;
            $listItems .= $tpl->parseChunk($template,[
               'title'=>$title,     
               'url'=>$url,     
            ]);
        }
        $list = $tpl->parseChunk($listTpl,[
            'wrapper'=>$listItems,
        ]);

        $outer = $tpl->parseChunk($outerTpl,[
            'active'=>$active,
            'list'=>$list,
        ]);
        echo $outer;


        break;
}
