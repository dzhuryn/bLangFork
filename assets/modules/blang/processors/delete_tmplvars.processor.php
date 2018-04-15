<?php
if(IN_MANAGER_MODE!="true") die("<b>INCLUDE_ORDERING_ERROR</b><br /><br />Please use the MODX Content Manager instead of accessing this file directly.");
if(!$modx->hasPermission('delete_template')) {
	$modx->webAlertAndQuit($_lang["error_no_privileges"]);
}

$id = isset($_GET['elemId'])? intval($_GET['elemId']) : 0;
if($id==0) {
	$modx->webAlertAndQuit($_lang["error_no_id"]);
}

$forced = isset($_GET['force'])? $_GET['force'] : 0;




// delete variable
$modx->db->delete($modx->getFullTableName('blang_tmplvars'), "id='{$id}'");

// delete variable's template access
$modx->db->delete($modx->getFullTableName('blang_tmplvar_templates'), "tmplvarid='{$id}'");

// delete variable's access permissions
$modx->db->delete($modx->getFullTableName('blang_tmplvar_access'), "tmplvarid='{$id}'");


// finished emptying cache - redirect
$header="Location: ".$GLOBALS['moduleUrl'];
header($header);
?>