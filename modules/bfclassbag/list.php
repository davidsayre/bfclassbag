<?php

$http = eZHTTPTool::instance();
$Module = $Params['Module'];

include_once( "kernel/common/template.php" );

$tpl = templateInit();
$tpl->setVariable( "params", $Params );
$tpl->setVariable( "module", $Module );
$tpl->setVariable( "view_parameters", $Params['UserParameters'] );
$tpl->setVariable( "http", $http );

$Result = array( 'params' => $Params );
//$Result['left_menu'] = "design:menu/.tpl";
$Result['content'] = $tpl->fetch( "design:bfclassbag/list_classes.tpl" );
$Result['path'] = array(
	array( 'text' => "Class groups", 'url' => '/class/grouplist' ),
	array( 'text' => "Class Listing", 'url' => null )	
		);

?>