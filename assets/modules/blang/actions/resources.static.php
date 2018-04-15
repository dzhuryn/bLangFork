<?php
if(IN_MANAGER_MODE!="true") die("<b>INCLUDE_ORDERING_ERROR</b><br /><br />Please use the MODX Content Manager instead of accessing this file directly.");


function createResourceList($resourceTable,$action,$nameField = 'name') {
    global $modx, $_lang, $_style, $modx_textdir;

    $pluginsql = $resourceTable == 'site_plugins' ? $resourceTable.'.disabled, ' : '';

    $tvsql = '';
    $tvjoin = '';
    if($resourceTable == 'site_tmplvars') {
        $tvsql = 'site_tmplvars.caption, ';
        $tvjoin = sprintf('LEFT JOIN %s AS stt ON site_tmplvars.id=stt.tmplvarid GROUP BY site_tmplvars.id,reltpl', $modx->getFullTableName('site_tmplvar_templates'));
        $sttfield = 'IF(stt.templateid,1,0) AS reltpl,';
    }
    else $sttfield = '';

    //$orderby = $resourceTable == 'site_plugins' ? '6,2' : '5,1';


    switch($resourceTable) {
        case 'site_plugins':
            $orderby= '6,2'; break;
        case 'site_tmplvars':
            $orderby= '7,3'; break;
        case 'site_templates':
            $orderby= '6,1'; break;
        default:
            $orderby= '5,1';
    }

    $selectableTemplates = $resourceTable == 'site_templates' ? "{$resourceTable}.selectable, " : "";

    $rs = $modx->db->select(
        "{$sttfield} {$pluginsql} {$tvsql} {$resourceTable}.{$nameField} as name, {$resourceTable}.id, {$resourceTable}.description, {$resourceTable}.locked, {$selectableTemplates}IF(isnull(categories.category),'{$_lang['no_category']}',categories.category) as category, categories.id as catid",
        $modx->getFullTableName($resourceTable)." AS {$resourceTable}
            LEFT JOIN ".$modx->getFullTableName('categories')." AS categories ON {$resourceTable}.category = categories.id {$tvjoin}",
        "",
        $orderby
        );
    $limit = $modx->db->getRecordCount($rs);
    if($limit<1){
        return $_lang['no_results'];
    } else {
    $output = '<ul id="'.$resourceTable.'">';
    $preCat = '';
    $insideUl = 0;
    while ($row = $modx->db->getRow($rs)) {
        $row['category'] = stripslashes($row['category']); //pixelchutes
        if ($preCat !== $row['category']) {
            $output .= $insideUl? '</ul>': '';
            $output .= '<li><strong>'.$row['category']. ($row['catid']!=''? ' <small>('.$row['catid'].')</small>' : '') .'</strong><ul>';
            $insideUl = 1;
        }

        if ($resourceTable == 'site_templates') {
            $class = $row['selectable'] ? '' : ' class="disabledPlugin"';
            $lockElementType = 1;
        }
        if ($resourceTable == 'site_tmplvars') {
            $class = $row['reltpl'] ? '' : ' class="disabledPlugin"';
            $lockElementType = 2;
        }
        if ($resourceTable == 'site_htmlsnippets') {
            $lockElementType = 3;
        }
        if ($resourceTable == 'site_snippets') {
            $lockElementType = 4;
        }
        if ($resourceTable == 'site_plugins') {
            $class = $row['disabled'] ? ' class="disabledPlugin"' : '';
            $lockElementType = 5;
        }

        // Prepare displaying user-locks
        $lockedByUser = '';
        $rowLock = $modx->elementIsLocked($lockElementType, $row['id'], true);
        if($rowLock && $modx->hasPermission('display_locks')) {
            if($rowLock['internalKey'] == $modx->getLoginUserID()) {
                $title = $modx->parseText($_lang["lock_element_editing"], array('element_type'=>$_lang["lock_element_type_".$lockElementType],'lasthit_df'=>$rowLock['lasthit_df']));
                $lockedByUser = '<span title="'.$title.'" class="editResource" style="cursor:context-menu;"><img src="'.$_style['icons_preview_resource'].'" /></span>&nbsp;';
            } else {
                $title = $modx->parseText($_lang["lock_element_locked_by"], array('element_type'=>$_lang["lock_element_type_".$lockElementType], 'username'=>$rowLock['username'], 'lasthit_df'=>$rowLock['lasthit_df']));
                if($modx->hasPermission('remove_locks')) {
                    $lockedByUser = '<a href="#" onclick="unlockElement('.$lockElementType.', '.$row['id'].', this);return false;" title="'.$title.'" class="lockedResource"><img src="'.$_style['icons_secured'].'" /></a>';
                } else {
                    $lockedByUser = '<span title="'.$title.'" class="lockedResource" style="cursor:context-menu;"><img src="'.$_style['icons_secured'].'" /></span>';
                }
            }
        }

        $output .= '<li><span'.$class.'>'.$lockedByUser.'<a href="index.php?a=112&id='.$_GET['id'].'&action=param&elemId='.$row['id'].'">'.$row['name'].' <small>(' . $row['id'] . ')</small></a>'.($modx_textdir ? '&rlm;' : '').'</span>';

        if ($resourceTable == 'site_tmplvars') {
             $output .= !empty($row['description']) ? ' - '.$row['caption'].' &nbsp; <small>('.$row['description'].')</small>' : ' - '.$row['caption'];
        }else{
            $output .= !empty($row['description']) ? ' - '.$row['description'] : '' ;
        }

        $tplInfo  = array();
        if($row['locked']) $tplInfo[] = $_lang['locked'];
        if($row['id'] == $modx->config['default_template'] && $resourceTable == 'site_templates') $tplInfo[] = $_lang['defaulttemplate_title'];
        $output .= !empty($tplInfo) ? ' <em>('.join(', ', $tplInfo).')</em>' : '';

        $output .= '</li>';

        $preCat = $row['category'];
    }
    $output .= $insideUl? '</ul>': '';
    $output .= '</ul>';
}
    return $output;
}


/*

<script type="text/javascript" src="media/script/tabpane.js"></script>
<script type="text/javascript" src="media/script/jquery.quicksearch.js"></script>
<script>
    function initQuicksearch(inputId, listId) {
        jQuery('#'+inputId).quicksearch('#'+listId+' ul li', {
            selector: 'a',
            'show': function () { jQuery(this).removeClass('hide'); },
            'hide': function () { jQuery(this).addClass('hide'); },
            'bind':'keyup',
            'onAfter': function() {
                jQuery('#'+listId).find('> li > ul').each( function() {
                    var parentLI = jQuery(this).closest('li');
                    var totalLI  = jQuery(this).children('li').length;
                    var hiddenLI = jQuery(this).children('li.hide').length;
                    if (hiddenLI == totalLI) { parentLI.addClass('hide'); }
                    else { parentLI.removeClass('hide'); }
                });
            }
        });
    }

    function unlockElement(type, id, domEl) {
    <?php
        // Prepare lang-strings
        $unlockTranslations = array('msg'=>$_lang["unlock_element_id_warning"],
                                    'type1'=>$_lang["lock_element_type_1"], 'type2'=>$_lang["lock_element_type_2"], 'type3'=>$_lang["lock_element_type_3"], 'type4'=>$_lang["lock_element_type_4"],
                                    'type5'=>$_lang["lock_element_type_5"], 'type6'=>$_lang["lock_element_type_6"], 'type7'=>$_lang["lock_element_type_7"], 'type8'=>$_lang["lock_element_type_8"]);
        foreach ($unlockTranslations as $key=>$value) $unlockTranslations[$key] = iconv($modx->config["modx_charset"], "utf-8", $value);
        ?>
        var trans = <?php echo json_encode($unlockTranslations); ?>;
        var msg = trans.msg.replace('[+id+]',id).replace('[+element_type+]',trans['type'+type]);
        if(confirm(msg)==true) {
            jQuery.get( 'index.php?a=67&type='+type+'&id='+id, function( data ) {
                if(data == 1) {
                    jQuery(domEl).fadeOut();
                }
                else alert( data );
            });
        }
    }
</script>

<h1 class="pagetitle">
  <span class="pagetitle-icon">
    <i class="fa fa-th"></i>
  </span>
  <span class="pagetitle-text">
    <?php echo $_lang['element_management']; ?>
  </span>
</h1>

<div class="sectionBody">
<div class="tab-pane" id="resourcesPane">

    <script type="text/javascript">
        tpResources = new WebFXTabPane( document.getElementById( "resourcesPane" ), true);
    </script>



<!-- Template variables -->
<?php   if($modx->hasPermission('new_template') || $modx->hasPermission('edit_template')) { ?>
    <div class="tab-page" id="tabVariables">
        <h2 class="tab"><i class="fa fa-list-alt"></i> <?php echo $_lang["tmplvars"] ?></h2>
        <script type="text/javascript">tpResources.addTabPage( document.getElementById( "tabVariables" ) );</script>
        <!--//
            Modified By Raymond for Template Variables
            Added by Apodigm 09-06-2004- DocVars - web@apodigm.com
        -->
        <div id="tv-info" style="display:none">
            <p class="element-edit-message"><?php echo $_lang['tmplvars_management_msg']; ?></p>
        </div>

        <ul class="actionButtons">
            <li>
              <form class="filterElements-form">
                <input class="form-control" type="text" placeholder="<?php echo $_lang['element_filter_msg']; ?>" id="site_tmplvars_search">
              </form>
            </li>
            <li><a href="index.php?a=300"><?php echo $_lang['new_tmplvars']; ?></a></li>
            <li><a href="index.php?a=305"><?php echo $_lang['template_tv_edit']; ?></a></li>
            <li><a href="#" id="tv-help"><?php echo $_lang['help']; ?></a></li>
        </ul>

        <?php // echo createResourceList('site_tmplvars',301); ?>

        <script>
          initQuicksearch('site_tmplvars_search', 'site_tmplvars');
          jQuery( "#tv-help" ).click(function() {
             jQuery( '#tv-info').toggle();
          });
        </script>
    </div>
<?php } ?>



</div>
</div>


*/

