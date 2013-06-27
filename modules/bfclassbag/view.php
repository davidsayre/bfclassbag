<?php
	require_once( 'kernel/common/template.php' );
	//require_once( 'kernel/classes/ezcontentobjecttreenode.php' );
	$Module = $Params['Module'];
	$http = eZHTTPTool::instance();
	$tpl = eZTemplate::factory();
	$classId = $Module->NamedParameters['class_id'];
	$tpl->setVariable( "module", $Module );
	$tpl->setVariable( "page_title", "View Bag" );
	$tpl->setVariable( "class_id", $classId );
	$tpl->setVariable( "view_parameters", $Module->UserParameters );
	$Result = array();
	$Result['content'] = $tpl->fetch( "design:bfclassbag/list_objects.tpl" );
	$Result['path'] = array(
		array( 'text' => "Class groups", 'url' => '/class/grouplist' ),
		array( 'text' => "Class objects: $classId", 'url' => false )
	);
?>
