{def $object = $node.object}
{def $redirecturi = concat( "/bfclassbag/view/", $node.class_identifier )}

{def $creator = $object.owner.main_node}
{def $modifier = $object.versions[ $object.versions|count()|dec() ].creator.main_node}

<tr class="{$css_class}">
	<td><input type="checkbox" name="DeleteIDArray[]" value="{$node.node_id}"></td>
	<td class="id number" align="right">{$object.id}</td>
	<td class="id number" align="right">
	{foreach $object.assigned_nodes as $n}
		{if $object.assigned_nodes|count()|gt(1)}{if eq($n.node_id,$node.node_id)}<b>{/if}{/if}
		<a title={$n.url_alias|ezurl()} href={$n.url_alias|ezurl()}>{$n.node_id}</a>
		{if $object.assigned_nodes|count()|gt(1)}{if eq($n.node_id,$node.node_id)}</b>{/if}{/if}
	{/foreach}
	</td>
	<td>{node_view_gui content_node=$node view=line}</td>
	<td class="author">{node_view_gui content_node=$creator view=listitem}</td>
	<td class="ts">{$object.published|l10n(shortdatetime)}</td>
	<td class="author">{if ne( $object.published, $object.modified )}{if ne($creator.node_id,$modifier.node_id)}{node_view_gui content_node=$modifier view=listitem}{else}-{/if}{/if}</td>
	<td class="ts">{if ne( $object.published, $object.modified )}{$object.modified|l10n(shortdatetime)}{/if}</td>
	<td class="act">
		<form method="post" action="/content/action">
			<input type="hidden" name="TopLevelNode" value="{$node.object.main_node_id}" />
			<input type="hidden" name="ContentNodeID" value="{$node.node_id}" />
			<input type="hidden" name="ContentObjectID" value="{$node.contentobject_id}" />

			<input type="hidden" name="RedirectURI" value="/bfclassbag/view/{$node.class_identifier}" />
			<input type="hidden" name="DestinationURL" value="/bfclassbag/view/{$node.class_identifier}" />
			<input type="hidden" name="CancelURI" value="/bfclassbag/view/{$node.class_identifier}" />
			<input type="hidden" name="RedirectURIAfterRemove" value="/bfclassbag/view/{$node.class_identifier}" />
			<input type="hidden" name="RedirectURIAfterDiscard" value="{$redirecturi}" />
			<input type="hidden" name="RedirectURIAfterPublish" value="/bfclassbag/view/{$node.class_identifier}" />
			
			{* Edit button. *}
			{def $can_create_languages = $node.object.can_create_languages
				 $languages            = fetch( 'content', 'prioritized_languages' )}
			{if $node.can_edit}
				{if and(eq( $languages|count, 1 ), is_set( $languages[0] ) )}
						<input name="ContentObjectLanguageCode" value="{$languages[0].locale}" type="hidden" />
				{else}
						<select name="ContentObjectLanguageCode">
						{foreach $node.object.can_edit_languages as $language}
								   <option value="{$language.locale}"{if $language.locale|eq($node.object.current_language)} selected="selected"{/if}>{$language.name|wash}</option>
						{/foreach}
						{if gt( $can_create_languages|count, 0 )}
							<option value="">{'Another language'|i18n( 'design/admin/node/view/full')}</option>
						{/if}
						</select>
				{/if}
				<input src={"edit.gif"|ezimage} type="image" name="EditButton" value="{'Edit'|i18n( 'design/admin/node/view/full' )}" title="{'Edit the contents of this item.'|i18n( 'design/admin/node/view/full' )}" />
			{else}
				<select name="ContentObjectLanguageCode" disabled="disabled">
					<option value="">{'Not available'|i18n( 'design/admin/node/view/full')}</option>
				</select>
				<input src={"edit-disabled.gif"|ezimage} type="image" name="EditButton" value="{'Edit'|i18n( 'design/admin/node/view/full' )}" title="{'You do not have permission to edit this item.'|i18n( 'design/admin/node/view/full' )}" disabled="disabled" />
			{/if}
			{undef $can_create_languages}
			
			{* Remove button. *}
			{if $node.can_remove}
				<input src={"trash-icon-16x16.gif"|ezimage} type="image" name="ActionRemove" value="{'Remove'|i18n( 'design/admin/node/view/full' )}" title="{'Remove this item.'|i18n( 'design/admin/node/view/full' )}" />
			{else}
				<input src={"trash-icon-16x16.gif"|ezimage} type="image" name="ActionRemove" value="{'Remove'|i18n( 'design/admin/node/view/full' )}" title="{'You do not have permission to remove this item.'|i18n( 'design/admin/node/view/full' )}" disabled="disabled" />
			{/if}
			
		</form>
		
	</td>
</tr>
