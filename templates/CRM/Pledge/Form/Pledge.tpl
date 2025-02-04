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
{* this template is used for adding/editing/deleting pledge *} 
{if $cdType}
  {include file="CRM/Custom/Form/CustomData.tpl"}
{elseif $showAdditionalInfo and $formType }
  {include file="CRM/Contribute/Form/AdditionalInfo/$formType.tpl"}
{else}
{if !$email and $action neq 8 and $context neq 'standalone'}
<div class="messages status">
  <div class="icon inform-icon"></div>
        <p>{ts}You will not be able to send an acknowledgment for this pledge because there is no email address recorded for this contact. If you want a acknowledgment to be sent when this pledge is recorded, click Cancel and then click Edit from the Summary tab to add an email address before recording the pledge.{/ts}</p>
</div>
{/if}
{if $action EQ 1}
    <h3>{ts}New Pledge{/ts}</h3>
{elseif $action EQ 2}
    <h3>{ts}Edit Pledge{/ts}</h3>
    {* Check if current Total Pledge Amount is different from original pledge amount. *}
    {math equation="x / y" x=$amount y=$installments format="%.2f" assign="currentInstallment"}
    {* Check if current Total Pledge Amount is different from original pledge amount. *}
    {if $currentInstallment NEQ $eachPaymentAmount}
    	{assign var=originalPledgeAmount value=`$installments*$eachPaymentAmount`}
    {/if}
{elseif $action EQ 8}
    <h3>{ts}Delete Pledge{/ts}</h3>
{/if}
<div class="crm-block crm-form-block crm-pledge-form-block">
 <div class="crm-submit-buttons">{include file="CRM/common/formButtons.tpl" location="top"}</div> 
   {if $action eq 8} 
    <div class="messages status">
        <div class="icon inform-icon"></div>&nbsp;       
        <span class="font-red bold">{ts}WARNING: Deleting this pledge will also delete any related pledge payments.{/ts} {ts}This action cannot be undone.{/ts}</span>
        <p>{ts}Consider cancelling the pledge instead if you want to maintain an audit trail and avoid losing payment data. To set the pledge status to Cancelled and cancel any not-yet-paid pledge payments, first click Cancel on this form. Then click the more &gt; link from the pledge listing, and select the Cancel action.{/ts}</p>
    </div>
   {else}
      <table class="form-layout-compressed">
        {if $context eq 'standalone'}
	    {if !$email and $outBound_option != 2}
	      {assign var='profileCreateCallback' value=1 }
	    {/if}
            {include file="CRM/Contact/Form/NewContact.tpl"}
        {else}
          <tr class="crm-pledge-form-block-displayName">
              <td class="font-size12pt right"><strong>{ts}Pledge by{/ts}</strong></td>
              <td class="font-size12pt"><strong>{$displayName}</strong></td>
          </tr>
        {/if}
	<tr class="crm-pledge-form-block-amount">
	    <td class="font-size12pt right">{$form.amount.label}</td>
	    <td><span class="font-size12pt">{$form.amount.html|crmMoney}</span> {if $originalPledgeAmount}<div class="messages status"><div class="icon inform-icon"></div>&nbsp;{ts 1=$originalPledgeAmount|crmMoney} Pledge total has changed due to payment adjustments. Original pledge amount was %1.{/ts}</div>{/if}</td>
	</tr>
        <tr class="crm-pledge-form-block-installments"><td class="label">{$form.installments.label}</td><td>{$form.installments.html} {ts}installments of{/ts} {if $action eq 1 or $isPending}{$form.eachPaymentAmount.html|crmMoney}{elseif $action eq 2 and !$isPending}{$eachPaymentAmount|crmMoney}{/if}&nbsp;{ts}every{/ts}&nbsp;{$form.frequency_interval.html}&nbsp;{$form.frequency_unit.html}</td></tr>
        <tr class="crm-pledge-form-block-frequency_day"><td class="label nowrap">{$form.frequency_day.label}</td><td>{$form.frequency_day.html} {ts}day of the period{/ts}<br />
            <span class="description">{ts}This applies to weekly, monthly and yearly payments.{/ts}</td></tr>
        {if $form.create_date}	
        <tr class="crm-pledge-form-block-create_date">
            <td class="label">{$form.create_date.label}</td>
            <td>{include file="CRM/common/jcalendar.tpl" elementName=create_date}<br />
        {/if}
        {if $create_date}
            <tr class="crm-pledge-form-block-create_date"><td class="label">{ts}Pledge Made{/ts}</td><td class="view-value">{$create_date|truncate:10:''|crmDate}
        {/if}<br />
            <span class="description">{ts}Date when pledge was made by the contributor.{/ts}</span></td></tr>
       
        {if $form.start_date}	
            <tr class="crm-pledge-form-block-start_date">
                <td class="label">{$form.start_date.label}</td>
                <td>{include file="CRM/common/jcalendar.tpl" elementName=start_date}<br />
        {/if}
        {if $start_date}
            <tr class="crm-pledge-form-block-start_date"><td class="label">{ts}Payments Start{/ts}</td><td class="view-value">{$start_date|truncate:10:''|crmDate}
        {/if}<br />
            <span class="description">{ts}Date of first pledge payment.{/ts}</span></td></tr>
       
        {if $email and $outBound_option != 2}
            {if $form.is_acknowledge }
                <tr class="crm-pledge-form-block-is_acknowledge"><td class="label">{$form.is_acknowledge.label}</td><td>{$form.is_acknowledge.html}<br />
                <span class="description">{ts 1=$email}Automatically email an acknowledgment of this pledge to %1?{/ts}</span></td></tr>
            {/if}
	    {elseif $context eq 'standalone' and $outBound_option != 2 }
                <tr id="acknowledgment-receipt" style="display:none;"><td class="label">{$form.is_acknowledge.label}</td><td>{$form.is_acknowledge.html} <span class="description">{ts}Automatically email an acknowledgment of this pledge to {/ts}<span id="email-address"></span>?</span></td></tr>
        {/if}
        <tr id="fromEmail" style="display:none;">
            <td class="label">{$form.from_email_address.label}</td>
            <td>{$form.from_email_address.html}</td>
        </tr>
        <tr id="acknowledgeDate"><td class="label" class="crm-pledge-form-block-acknowledge_date">{$form.acknowledge_date.label}</td>
            <td>{include file="CRM/common/jcalendar.tpl" elementName=acknowledge_date}<br />
            <span class="description">{ts}Date when an acknowledgment of the pledge was sent.{/ts}</span></td></tr>
            <tr class="crm-pledge-form-block-contribution_type_id"><td class="label">{$form.contribution_type_id.label}</td><td>{$form.contribution_type_id.html}<br />
            <span class="description">{ts}Sets the default contribution type for payments against this pledge.{/ts}</span></td></tr>

	    {* CRM-7362 --add campaign *}
	    {include file="CRM/Campaign/Form/addCampaignToComponent.tpl"
	    campaignTrClass="crm-pledge-form-block-campaign_id"}

	    <tr class="crm-pledge-form-block-contribution_page_id"><td class="label">{$form.contribution_page_id.label}</td><td>{$form.contribution_page_id.html}<br />
            <span class="description">{ts}Select an Online Contribution page that the user can access to make self-service pledge payments. (Only Online Contribution pages configured to include the Pledge option are listed.){/ts}</span></td></tr>
        
	    <tr class="crm-pledge-form-block-status"><td class="label">{ts}Pledge Status{/ts}</td><td class="view-value">{$status}<br />
            <span class="description">{ts}Pledges are "Pending" until the first payment is received. Once a payment is received, status is "In Progress" until all scheduled payments are completed. Overdue pledges are ones with payment(s) past due.{/ts}</span></td></tr>
		<tr><td colspan=2>{include file="CRM/Custom/Form/CustomData.tpl"}</td></tr>
       </table>
{literal}
<script type="text/javascript">
// bind first click of accordion header to load crm-accordion-body with snippet
// everything else taken care of by cj().crm-accordions()
cj(document).ready( function() {
    cj('.crm-ajax-accordion .crm-accordion-header').one('click', function() { 
    	loadPanes(cj(this).attr('id')); 
    });
    cj('.crm-ajax-accordion.crm-accordion-open .crm-accordion-header').each(function(index) { 
    	loadPanes(cj(this).attr('id')); 
    	});
});
// load panes function calls for snippet based on id of crm-accordion-header
function loadPanes( id ) {   
    var url = "{/literal}{crmURL p='civicrm/contact/view/pledge' q='snippet=4&formType=' h=0}{literal}" + id;
    {/literal}
        {if $contributionMode}
            url = url + "&mode={$contributionMode}";
        {/if}
    {literal}
   if ( ! cj('div.'+id).html() ) {
	    var loading = '<img src="{/literal}{$config->resourceBase}i/loading.gif{literal}" alt="{/literal}{ts}loading{/ts}{literal}" />&nbsp;{/literal}{ts}Loading{/ts}{literal}...';
	    cj('div.'+id).html(loading);
	    cj.ajax({
	        url    : url,
	        success: function(data) { cj('div.'+id).html(data); }
	        });
    	}
	}
</script>
{/literal}


<div class="accordion ui-accordion ui-widget ui-helper-reset">
{foreach from=$allPanes key=paneName item=paneValue}
<div class="crm-accordion-wrapper crm-ajax-accordion crm-{$paneValue.id}-accordion {if $paneValue.open eq 'true'}crm-accordion-open{else}crm-accordion-closed{/if}">
<div class="crm-accordion-header" id="{$paneValue.id}">
  <div class="icon crm-accordion-pointer"></div> 

        {$paneName}
  </div><!-- /.crm-accordion-header -->
 <div class="crm-accordion-body">
       <div class="{$paneValue.id}"></div>
 </div><!-- /.crm-accordion-body -->
</div><!-- /.crm-accordion-wrapper -->

{/foreach}
</div>
{/if} {* not delete mode if*}   

<br />
<div class="crm-submit-buttons">{include file="CRM/common/formButtons.tpl" location="bottom"}</div>
</div>
{literal}   
<script type="text/javascript">
cj(function() {
   cj().crmaccordions(); 
});
</script>
{/literal}
{literal}
     <script type="text/javascript">

     function verify( ) {
       var element = document.getElementsByName("is_acknowledge");
        if ( element[0].checked ) {
            var emailAddress = '{/literal}{$email}{literal}';
	    if ( !emailAddress ) {
	    var emailAddress = cj('#email-address').html(); 
	    }
	    var message = '{/literal}{ts 1="'+emailAddress+'"}Click OK to save this Pledge record AND send an acknowledgment to %1 now{/ts}{literal}.';
            if (!confirm( message) ) {
                return false;
            }
        }
     }
     
     function calculatedPaymentAmount( ) {
       var thousandMarker = '{/literal}{$config->monetaryThousandSeparator}{literal}';
       var seperator      = '{/literal}{$config->monetaryDecimalPoint}{literal}';
       var amount = document.getElementById("amount").value;
       // replace all thousandMarker and change the seperator to a dot
       amount = amount.replace(thousandMarker,'').replace(seperator,'.');
       var installments = document.getElementById("installments").value;
       if ( installments != '' && installments != NaN) {
            amount =  amount/installments;
            var installmentAmount = formatMoney( amount, 2, seperator, thousandMarker );
            document.getElementById("eachPaymentAmount").value = installmentAmount;
       }   
     }
     
     function formatMoney (amount, c, d, t){
       var n = amount, 
       c = isNaN(c = Math.abs(c)) ? 2 : c, 
       d = d == undefined ? "," : d, 
       t = t == undefined ? "." : t, s = n < 0 ? "-" : "", 
       i = parseInt(n = Math.abs(+n || 0).toFixed(c)) + "", 
       j = (j = i.length) > 3 ? j % 3 : 0;
	   return s + (j ? i.substr(0, j) + t : "") + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + t) + (c ? d + Math.abs(n - i).toFixed(c).slice(2) : "");
     };

    {/literal}
    {if $context eq 'standalone' and $outBound_option != 2 }
    {literal}
    cj( function( ) {
        cj("#contact_1").blur( function( ) {
            checkEmail( );
        });
        checkEmail( );
	showHideByValue( 'is_acknowledge', '', 'acknowledgeDate', 'table-row', 'radio', true); 
	showHideByValue( 'is_acknowledge', '', 'fromEmail', 'table-row', 'radio', false );
    });
    function checkEmail( ) {
        var contactID = cj("input[name='contact_select_id[1]']").val();
        if ( contactID ) {
            var postUrl = "{/literal}{crmURL p='civicrm/ajax/checkemail' h=0}{literal}";
            cj.post( postUrl, {contact_id: contactID},
                function ( response ) {
                    if ( response ) {
                        cj("#acknowledgment-receipt").show( );
                        cj("#email-address").html( response );
                    } else {
                        cj("#acknowledgment-receipt").hide( );
                    }
                }
            );
        } else {
	  cj("#acknowledgment-receipt").hide( );
	}
    }
    
    function profileCreateCallback( blockNo ) {
        checkEmail( );
    }
    {/literal}
    {/if}
</script>

{if $email and $outBound_option != 2}
{include file="CRM/common/showHideByFieldValue.tpl" 
    trigger_field_id    ="is_acknowledge"
    trigger_value       =""
    target_element_id   ="acknowledgeDate" 
    target_element_type ="table-row"
    field_type          ="radio"
    invert              = 1
}
{include file="CRM/common/showHideByFieldValue.tpl" 
    trigger_field_id    ="is_acknowledge"
    trigger_value       =""
    target_element_id   ="fromEmail" 
    target_element_type ="table-row"
    field_type          ="radio"
    invert              = 0	
}
{/if}

   {* include jscript to warn if unsaved form field changes *}
   {include file="CRM/common/formNavigate.tpl"}

{/if}
{* closing of main custom data if *}
