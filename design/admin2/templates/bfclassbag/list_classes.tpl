{* loop over classes and render a print friendly output *}
{def $classes = fetch('class','list',hash(
		'sort_by', array( 'name', true() )
		))}

<link rel="stylesheet" type="text/css" href={"stylesheets/bfclassbag.css"|ezdesign()} />

<div class="list-classes">
	{* table of contents *}
	<h1>Classes Auto Documentation</h1>

	<table width="100%" class="list">
	<tr><th>Name</th><th>Identifier<th>Objects</th></tr>
	{foreach $classes as $class}
	<tr><td>{$class.name}</td><td>{$class.identifier}<td>{$class.object_count}</td></tr>
	<tr><td colspan="3">
	<ul>
		{foreach $class.data_map as $fieldname => $field}
		<li>
			<span class="field_name {if $field.is_required}required{/if} {if $field.is_searchable}searchable{/if}">{$field.name}</span>
			<span class="field_id">[{$fieldname}]</span>
			{if $field.description|count} : <span class="field_description">{$field.description}</span>{/if}
			<span class="field_type">{$field.data_type.information.name}</span>
			{if is_set( $field.content.default_selection_node )}
				{if $field.content.default_selection_node}
					{def $selectionNode = fetch( 'content', 'node', hash( 'node_id', $field.content.default_selection_node ))}
					<span class="field_selection_node">(Container: [{$selectionNode.node_id}] {$selectionNode.name})</span>
					{undef $selectionNode}
				{else}
					<span class="field_selection_node">(Container: none)</span>
				{/if}
			{/if}
		</li>
		{/foreach}
	</ul>
	</td></tr>
	{/foreach}
	</table>

	<h2>Identifier List</h2>
	<ul>
	{foreach $classes as $class}
	    <li>{$class.identifier}</li>
	{/foreach}
	</ul>

	<br/>
	<table class="list">
	<tr><th>Key</th></tr>
	<tr><td><span class="required">Required</span></td></tr>
	<tr><td><span class="searchable">Searchable</span></td></tr>
	</table>
</div>

