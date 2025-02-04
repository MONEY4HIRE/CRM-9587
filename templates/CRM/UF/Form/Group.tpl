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
{* add/update/view CiviCRM Profile *} 
  <div class=" crm-block crm-form-block crm-uf_group-form-block">  
 <div class="crm-submit-buttons">{include file="CRM/common/formButtons.tpl" location="top"}</div>
{if $action eq 2 or $action eq 4 } {* Update or View*}
    <div class="action-link">
	<a href="{crmURL p='civicrm/admin/uf/group/field' q="action=browse&reset=1&gid=$gid"}" class="button"><span>{ts}View or Edit Fields for this Profile{/ts}</a></span>
	<div class="clear"></div>
    </div>
{/if}      
 
    {if $action eq 8 or $action eq 64}
    {if $action eq 8}
     <h2> {ts}Delete CiviCRM Profile{/ts}</h2>
    {/if}
            <div class="messages status">
                   <div class="icon inform-icon"></div>
                   {$message}
            </div>   
	       
    {else}
       
        <table class="form-layout">
            <tr class="crm-uf_group-form-block-title">
                <td class="label">{$form.title.label} {if $action == 2}{include file='CRM/Core/I18n/Dialog.tpl' table='civicrm_uf_group' field='title' id=$gid}{/if}</td>
                <td class="html-adjust">{$form.title.html}</td>
            </tr>
            <tr class="crm-uf_group-form-block-uf_group_type">
                <td class="label">{$form.uf_group_type.label} {help id='id-used_for' file="CRM/UF/Form/Group.hlp"}</td>
                <td class="html-adjust">{$form.uf_group_type.html}&nbsp;{$otherModuleString}</td>
            </tr>
            <tr class="crm-uf_group-form-block-weight" >
                <td class="label">{$form.weight.label}{if $config->userFramework EQ 'Drupal'} {help id='id-profile_weight' file="CRM/UF/Form/Group.hlp"}{/if}</td>
                <td class="html-adjust">{$form.weight.html}</td>
            </tr>
            <tr class="crm-uf_group-form-block-help_pre" >
                <td class="label">{$form.help_pre.label} {help id='id-help_pre' file="CRM/UF/Form/Group.hlp"}</td>
                <td class="html-adjust">{$form.help_pre.html}</td>
            </tr>
            <tr class="crm-uf_group-form-block-help_post" >
                <td class="label">{$form.help_post.label} {help id='id-help_post' file="CRM/UF/Form/Group.hlp"}</td>
                <td class="html-adjust">{$form.help_post.html}</td>
            </tr>
            <tr class="crm-uf_group-form-block-is_active" >
                <td class="label"></td><td class="html-adjust">{$form.is_active.html} {$form.is_active.label}</td>
            </tr>
        </table>
        {* adding advance setting tab *}
        {include file='CRM/UF/Form/AdvanceSetting.tpl'}        
    {/if}

    <div class="crm-submit-buttons">{include file="CRM/common/formButtons.tpl" location="bottom"}</div>
</div>
</div>
{include file="CRM/common/showHide.tpl"}

{* include jscript to warn if unsaved form field changes *}
{include file="CRM/common/formNavigate.tpl"}

