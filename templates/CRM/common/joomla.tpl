{*
 +--------------------------------------------------------------------+
 | CiviCRM version 3.4                                                |
 +--------------------------------------------------------------------+
 | Copyright CiviCRM LLC (c) 2004-2011                                |
 +--------------------------------------------------------------------+
 | This file is a part of CiviCRM.                                    |
 |                                                                    |
 | CiviCRM is free software; you can copy, modify, and distribute it  |
 | under the terms of the GNU Affero General Public License           |
 | Version 3, 19 November 2007 and the CiviCRM Licensing Exception.   |
 |                                                                    |
 | CiviCRM is distributed in the hope that it will be useful, but     |
 | WITHOUT ANY WARRANTY; without even the implied warranty of         |
 | MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.               |
 | See the GNU Affero General Public License for more details.        |
 |                                                                    |
 | You should have received a copy of the GNU Affero General Public   |
 | License and the CiviCRM Licensing Exception along                  |
 | with this program; if not, contact CiviCRM LLC                     |
 | at info[AT]civicrm[DOT]org. If you have questions about the        |
 | GNU Affero General Public License or the licensing of CiviCRM,     |
 | see the CiviCRM license FAQ at http://civicrm.org/licensing        |
 +--------------------------------------------------------------------+
*}
{if $config->debug}
{include file="CRM/common/debug.tpl"}
{/if}

<div id="crm-container" lang="{$config->lcMessages|truncate:2:"":true}" xml:lang="{$config->lcMessages|truncate:2:"":true}">
    
{* Only include joomla.css in administrator (backend). Page layout style ids and classes conflict with typical front-end css and break the page layout. *}
{include file="CRM/common/action.tpl"}
{if $buildNavigation }
    {include file="CRM/common/Navigation.tpl" }
{/if}

<table border="0" cellpadding="0" cellspacing="0" id="crm-content">
  <tr>
{if $sidebarLeft}
    <td id="sidebar-left" valign="top">
        <div id="civi-sidebar-logo" style="margin: 0 0 .25em .25em"><img src="{$config->resourceBase}i/logo_words_small.png" title="{ts}CiviCRM{/ts}"/></div><div class="spacer"></div>
       {$sidebarLeft}
    </td>
{/if}
    <td valign="top">
    {if $breadcrumb}
    <div class="breadcrumb">
      {foreach from=$breadcrumb item=crumb key=key}
        {if $key != 0}
           &raquo;
        {/if}
        <a href="{$crumb.url}">{$crumb.title}</a>
      {/foreach}
    </div>
    {/if}

{if $browserPrint}
{* Javascript window.print link. Used for public pages where we can't do printer-friendly view. *}
<div id="printer-friendly"><a href="javascript:window.print()" title="{ts}Print this page.{/ts}"><div class="ui-icon ui-icon-print"></div></a></div>
{else}
{* Printer friendly link/icon. *}
<div id="printer-friendly"><a href="{$printerFriendly}" title="{ts}Printer-friendly view of this page.{/ts}"><div class="ui-icon ui-icon-print"></div></a></div>
{/if}

{if $pageTitle}
	<div class="crm-title">
		<h1 class="title">{if $isDeleted}<del>{/if}{$pageTitle}{if $isDeleted}</del>{/if}</h1>
	</div>    
{/if}

{*{include file="CRM/common/langSwitch.tpl"}*}

    <div class="clear"></div>

    {if $localTasks}
        {include file="CRM/common/localNav.tpl"}
    {/if}

    {include file="CRM/common/status.tpl"}

    <!-- .tpl file invoked: {$tplFile}. Call via form.tpl if we have a form in the page. -->
    {if $isForm}
        {include file="CRM/Form/$formTpl.tpl"}
    {else}
        {include file=$tplFile}
    {/if}

    {if ! $urlIsPublic}
    {include file="CRM/common/footer.tpl"}
    {/if}

    </td>

  </tr>
</table>

{literal}
<script type="text/javascript">
cj(function() {
   cj().crmtooltip(); 
});
</script>
{/literal}
{* We need to set jquery $ object back to $*}
<script type="text/javascript">jQuery.noConflict(true);</script>
</div> {* end crm-container div *}
