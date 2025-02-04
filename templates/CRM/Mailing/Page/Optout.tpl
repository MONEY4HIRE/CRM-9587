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
{if $confirm}
<div class="messages status">
      <div class="icon inform-icon"></div>&nbsp;
      <label>{$display_name} ({$email})</label> {ts}has been successfully opted out.{/ts}
</div>
{else}
<div>
<form action="{$confirmURL}" method="post">
{ts 1=$display_name 2=$email}Are you sure you want to optout: %1 (%2){/ts}
<br/>
<center>
<input type="submit" name="_qf_optout_next" value="{ts}Optout{/ts}" class="form-submit" />
&nbsp;&nbsp;&nbsp;
<input type="submit" name="_qf_optout_cancel" value="{ts}Cancel{/ts}" class="form-submit" />
</center>
</form>
</div>
{/if}