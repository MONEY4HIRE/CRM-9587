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
{if $context eq 'user'}
<div class="view-content">
{if $pledge_rows}
{strip}
<table class="selector">
  <tr class="columnheader">
  {foreach from=$pledge_columnHeaders item=header}
    <th>{$header.name}</th>
  {/foreach}
  </tr>
  {counter start=0 skip=1 print=false}
  {foreach from=$pledge_rows item=row}
  <tr id='rowid{$row.pledge_id}' class="{cycle values="odd-row,even-row"} {if $row.pledge_status_name eq 'Overdue' } disabled{/if} crm-pledge crm-pledge_{$row.pledge_id} ">
    <td class="crm-pledge-pledge_amount">{$row.pledge_amount|crmMoney}</td>
    <td class="crm-pledge-pledge_total_paid">{$row.pledge_total_paid|crmMoney}</td>
    <td class="crm-pledge-pledge_amount">{$row.pledge_amount-$row.pledge_total_paid|crmMoney}</td>
    <td class="crm-pledge-pledge_contribution_type">{$row.pledge_contribution_type}</td>
    <td class="crm-pledge-pledge_create_date">{$row.pledge_create_date|truncate:10:''|crmDate}</td>
    <td class="crm-pledge-pledge_next_pay_date">{$row.pledge_next_pay_date|truncate:10:''|crmDate}</td>
    <td class="crm-pledge-pledge_next_pay_amount">{$row.pledge_next_pay_amount|crmMoney}</td>
    <td class="crm-pledge-pledge_status crm-pledge-pledge_status_{$row.pledge_status}">{$row.pledge_status}</td>
    <td>{if $row.pledge_contribution_page_id and ($row.pledge_status_name neq 'Completed') and ( $row.contact_id eq $loggedUserID ) }<a href="{crmURL p='civicrm/contribute/transact' q="reset=1&id=`$row.pledge_contribution_page_id`&pledgeId=`$row.pledge_id`"}">{ts}Make Payment{/ts}</a><br/>{/if}
	<div id="{$row.pledge_id}_show">
	    <a href="#" onclick="show('paymentDetails{$row.pledge_id}', 'table-row'); buildPaymentDetails('{$row.pledge_id}','{$row.contact_id}'); hide('{$row.pledge_id}_show');show('{$row.pledge_id}_hide','table-row');return false;"><img src="{$config->resourceBase}i/TreePlus.gif" class="action-icon" alt="{ts}open section{/ts}"/>{ts}Payments{/ts}</a>
	</div>
    </td>
   </tr>
   <tr id="{$row.pledge_id}_hide">
     <td colspan="11">
         <a href="#" onclick="show('{$row.pledge_id}_show', 'table-row');hide('{$row.pledge_id}_hide');return false;"><img src="{$config->resourceBase}i/TreeMinus.gif" class="action-icon" alt="{ts}open section{/ts}"/>{ts}Payments{/ts}</a>
       <br/>
       <div id="paymentDetails{$row.pledge_id}"></div>
     </td>
  </tr>
 <script type="text/javascript">
     hide('{$row.pledge_id}_hide');
 </script>
  {/foreach}
</table>
{/strip}
{else}
<div class="messages status">
         <div class="icon inform-icon"></div>
             {ts}There are no Pledges for your record.{/ts}
         </div>
{/if}
{*pledge row if*}

{*Display honor block*}
{if $pledgeHonor && $pledgeHonorRows}	
{strip}
<div id="help">
    <p>{ts}Pledges made in your honor.{/ts}</p>
</div>
  <table class="selector">
    <tr class="columnheader">
        <th>{ts}Pledger{/ts}</th> 
        <th>{ts}Amount{/ts}</th>
	<th>{ts}Contribution Type{/ts}</th>
        <th>{ts}Create date{/ts}</th>
        <th>{ts}Acknowledgment Sent{/ts}</th>
	 <th>{ts}Acknowledgment Date{/ts}</th>
        <th>{ts}Status{/ts}</th>
        <th></th>   
    </tr>
	{foreach from=$pledgeHonorRows item=row}
	   <tr id='rowid{$row.honorId}' class="{cycle values="odd-row,even-row"}">
	   <td class="crm-pledge-display_name"><a href="{crmURL p="civicrm/contact/view" q="reset=1&cid=`$row.honorId`"}" id="view_contact">{$row.display_name}</a></td>
	   <td class="crm-pledge-amount">{$row.amount|crmMoney}</td>
           <td class="crm-pledge-type">{$row.type}</td>
           <td class="crm-pledge-create_date">{$row.create_date|truncate:10:''|crmDate}</td>
           <td align="center">{if $row.acknowledge_date}{ts}Yes{/ts}{else}{ts}No{/ts}{/if}</td>
           <td class="crm-pledge-acknowledge_date">{$row.acknowledge_date|truncate:10:''|crmDate}</td>
           <td class="crm-pledge-status">{$row.status}</td>
	  </tr>
        {/foreach}
</table>
{/strip}
{/if} 
</div>
{* main if close*}
{/if}

{* Build pledge payment details*}
{literal}
<script type="text/javascript">

function buildPaymentDetails( pledgeId, contactId )
{
    var dataUrl = {/literal}"{crmURL p='civicrm/pledge/payment' h=0 q="action=browse&context=`$context`&snippet=4&pledgeId="}"{literal} + pledgeId + '&cid=' + contactId;

     cj.ajax({
               url     : dataUrl,
               dataType: "html",
               timeout : 5000, //Time in milliseconds
               success : function( data ){
                              cj( '#paymentDetails' + pledgeId ).html( data );
                         },
               error   : function( XMLHttpRequest, textStatus, errorThrown ) {
                                 console.error( 'Error: '+ textStatus );
                        }
         });	
}
</script>
{/literal}