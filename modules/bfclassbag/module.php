<?php

$Module = array(
	"name" => "Beaconfire Class Bag View"
);

$ViewList = array();

$ViewList[ "view" ] = array(
	"script" => "view.php",
	"params" => array('class_id'),
	'default_navigation_part' => 'ezsetupnavigationpart',
	'ui_context' => 'administration',
);

?>
