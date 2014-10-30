{def $page_limit = ezini( 'ViewSettings', 'PageLimit', 'bfclassbag.ini' )}
{def $class = fetch( 'content', 'class', hash( 'class_id', $class_id ))}
{def $children_count = fetch( 'content', 'tree_count', hash(
	'parent_node_id', 1,
	'main_node_only', true(),
	'class_filter_type', 'include',
	'class_filter_array', array($class_id),
	'sort_by', array( 'modified', true() )
))}
{def $content = fetch( 'content', 'tree', hash(
	'parent_node_id', 1,
	'main_node_only', true(),
	'class_filter_type', 'include',
	'class_filter_array', array($class_id),
	'sort_by', array( 'modified', false() ),
	'offset', $view_parameters.offset,
	'limit', $page_limit
))}
{def $bCanRemove = false()}
{if ezini( 'ViewSettings', 'MultiRemove', 'bfclassbag.ini' )|eq('enabled')} {set $bCanRemove = true()} {/if}

{def $bShowCreator = false()}
{if ezini( 'ViewSettings', 'ShowCreator', 'bfclassbag.ini' )|eq('enabled')} {set $bShowCreator = true()} {/if}

<link rel="stylesheet" type="text/css" href={"stylesheets/bfclassbag.css"|ezdesign()} />

{if $bCanRemove}
{literal}
<script>
	$(document).ready( function() {
		$( '#bulk-remove-form' ).submit( function() {
			$('#remove-boxes').empty();
			$('[name="DeleteIDArray\[\]"]:checked').clone().appendTo( '#remove-boxes' );
		} );
	} );
	
	function bf_toggleCheckboxes( name ) {
		var unchecked = $('[name="DeleteIDArray[]"]:not(:checked)');
		var checked = $('[name="DeleteIDArray[]"]:checked');
		checked.attr( 'checked', null );
		unchecked.attr( 'checked', 'checked' );
	}
</script>
{/literal}
{/if}

<div class="context-block list-objects">
<div class="box-header">
<h1 class="context-title"><a href="/class/grouplist"><img src="/design/admin2/images/up-16x16-grey.png" width="16" height="16" alt="Back to class groups." title="Back to class groups."></a>&nbsp;Objects of type &lt;{$class.name}&gt; ({$children_count})</h1>
</div>

<div class="box-bc"><div class="box-content">

    <table class="list" cellspacing="0" summary="List of recently modified classes">
		<tbody>
			<tr>
				{if $bCanRemove} <th class="tight"><img src={'toggle-button-16x16.gif'|ezimage} width="16" height="16" alt="{'Invert selection.'|i18n( 'design/admin/class/classlist' )}" title="{'Invert selection.'|i18n( 'design/admin/class/classlist' )}" onclick="bf_toggleCheckboxes( 'DeleteIDArray[]' ); return false;" /></th> {/if}
				<th>Name</th>
				<th class="tight" title="Object ID">OID</th>
				<th class="tight" title="Node IDs">NID</th>				
				{if $bShowCreator}
					<th>Creator</th>
					<th>Created</th>
				{/if}
				<th class="modifier" title="Modifier">Modifier</th>
				<th class="modified" title="Last Modified">Modified</th>
				<th class="tight">&nbsp;</th>
			</tr>
			
			{foreach $content as $node sequence array('bglight','bgdark') as $cssClass}
				{node_view_gui content_node=$node view=bag_line css_class=$cssClass can_remove=$bCanRemove show_creator=$bShowCreator}
			{/foreach}
			
		</tbody>
	</table>
	
	{def $sRedirectUri = concat( "/bfclassbag/view/", $class_id )}

	{if $bCanRemove}
	<div class="block">
	<form id="bulk-remove-form" method="post" action="/content/action">
		<div id="remove-boxes">
		</div>		
		<input type="hidden" name="RedirectURI" value="{$sRedirectUri}" />
		<input type="hidden" name="DestinationURL" value="{$sRedirectUri}" />
		<input type="hidden" name="CancelURI" value="{$sRedirectUri}" />
		<input type="hidden" name="RedirectURIAfterRemove" value="{$sRedirectUri}" />
		<input type="hidden" name="RedirectURIAfterDiscard" value="{$sRedirectUri}" />
		<input type="hidden" name="RedirectURIAfterPublish" value="{$sRedirectUri}" />		
		<input type="submit" name="RemoveButton" class="button" value="Remove Selected" />
	</form>
	</div>
	{/if}
	
	{include name=navigator
         uri='design:navigator/google.tpl'
         page_uri=$sRedirectUri
         item_count=$children_count
         view_parameters=$view_parameters
         item_limit=$page_limit}

</div></div><!-- box-content box-bc -->
</div><!-- content-block -->
