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
{if $smarty.get.smartyDebug}
{debug}
{/if}

{if $smarty.get.sessionReset}
{$session->reset($smarty.get.sessionReset)}
{/if}

{if $smarty.get.sessionDebug}
{$session->debug($smarty.get.sessionDebug)}
{/if}

{if $smarty.get.directoryCleanup} 
{$config->cleanup($smarty.get.directoryCleanup)}
{/if}

{if $smarty.get.cacheCleanup} 
{$config->clearDBCache()}
{/if}

{if $smarty.get.configReset} 
{$config->reset()}
{/if}
