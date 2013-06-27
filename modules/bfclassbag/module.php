<?php

$Module = array(
	"name" => "Beaconfire Class View"
);

$ViewList = array();

$ViewList[ "list" ] = array( 
	"functions" => array( 'list' ),
	"script" => "list.php",
);

$ViewList[ "view" ] = array(
	"script" => "view.php",
	"params" => array('class_id'),
	'default_navigation_part' => 'ezsetupnavigationpart',
	'ui_context' => 'administration',
);


$FunctionList= array();
$FunctionList['list'] = array();
$FunctionList['view'] = array();


?>
