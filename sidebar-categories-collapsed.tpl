{if file_exists("templates/orderforms/$carttpl/overwrites/sidebar-categories-collapsed.tpl")}
    {include file="templates/orderforms/$carttpl/overwrites/sidebar-categories-collapsed.tpl"}
{else}

    <div class="categories-collapsed visible-xs visible-sm clearfix">

        <div class="pull-left form-inline">
            <div class="dropdown">
                <a href="#" data-toggle="dropdown" class="btn btn-default">
                    {if $groupname}
                        {$groupname}
                    {elseif $domain eq "register"}
                        {$LANG.navregisterdomain}
                    {elseif $transferdomainenabled}
                        {$LANG.transferinadomain}
                    {elseif $gid eq "addons"}
                        {$LANG.cartproductaddons}
                    {elseif $gid eq "renewals"}
                        {$LANG.domainrenewals}
                    {/if} 
                    <i class="ls ls-caret"></i>
                </a>
                <ul class="dropdown-menu ps">
                    {foreach $secondarySidebar as $panel}
                        {if $panel->getName() != "Choose Currency"}
                            <li class="dropdown-title h6">{$panel->getLabel()}</li>
                            {if $panel->hasChildren()}
                                {foreach $panel->getChildren() as $child}
                                    {if $child->getClass() != "active" && $child->getUri()}
                                    <li>
                                        <a menuItemName="{$child->getName()}" href="{$child->getUri()}" class="{if $child->getClass()} {$child->getClass()}{/if}{if $child->isCurrent()} active{/if}"{if $child->getAttribute('dataToggleTab')} data-toggle="tab"{/if}{if $child->getAttribute('target')} target="{$child->getAttribute('target')}"{/if} id="{$child->getId()}">
                                            {$child->getLabel()}
                                        </a>
                                    </li>
                                    {/if}
                                {/foreach}
                            {/if}
                        {/if}
                    {/foreach}
                </ul>
            </div>
        </div>
        {if !$loggedin && $currencies}
            <div class="pull-right form-inline">
                <form method="post" action="{$WEB_ROOT}/cart.php{if $action}?a={$action}{if $domain}&domain={$domain}{/if}{elseif $gid}?gid={$gid}{/if}">
                    <select name="currency" onchange="submit()" class="form-control">
                        <option value="">{$LANG.choosecurrency}</option>
                        {foreach from=$currencies item=listcurr}
                            <option value="{$listcurr.id}"{if $listcurr.id == $currency.id} selected{/if}>{$listcurr.code}</option>
                        {/foreach}
                    </select>
                </form>
            </div>
        {/if}
    </div>
{/if}
