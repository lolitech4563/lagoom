{if isset($RSThemes['pages']['addons'])}
    {include file=$RSThemes['pages']['addons']['fullPath']}
{else} 
    {include file="orderforms/$carttpl/common.tpl"}
        
    <div class="col-md-3 pull-md-left sidebar hidden-xs hidden-sm">
        {include file="orderforms/$carttpl/sidebar-categories.tpl"}
    </div>

    <div class="main-content col-md-9 pull-md-right">
        {include file="orderforms/$carttpl/sidebar-categories-collapsed.tpl"}
        {if count($addons) == 0}
            <div class="message message-no-data" id="noAddons">
                <div class="message-image">
                    {include file="$template//assets/svg-icon/addon.tpl"}            
                </div>
                <h6 class="message-text">{$LANG.cartproductaddonsnone}</h6>
            </div>     
        {/if}
        <div class="products">
            <div class="row row-eq-height">
                {foreach $addons as $num => $addon}
                    <div class="col-md-6">
                        <form method="post" action="{$smarty.server.PHP_SELF}?a=add" class="package package-horizontal">
                            <input type="hidden" name="aid" value="{$addon.id}" />
                            <h3 class="package-name">{$addon.name}</h3>
                            <div class="package-content">    
                                <p>{$addon.description}</p>
                            </div>
                            <div class="package-select">
                                <select name="productid" id="inputProductId{$num}" class="form-control">
                                    {foreach $addon.productids as $product}
                                        <option value="{$product.id}">
                                            {$product.product}{if $product.domain} - {$product.domain}{/if}
                                        </option>
                                    {/foreach}
                                </select>
                            </div>
                            <div class="package-footer">
                                <div class="package-price">
                                    {if $addon.free}
                                        <div class="price">{$LANG.orderfree}</div>
                                    {else}
                                        <div class="price"><span class="price-prefix">{$currency.prefix}</span>{$addon.recurringamount|replace:$currency.suffix:""|replace:$currency.prefix:""}{$currency.suffix}<span class="price-cycle">/{if $addon.billingcycle == "Monthly"}{$LANG.pricingCycleShort.monthly}{elseif $addon.billingcycle == "Quarterly"}{$LANG.pricingCycleShort.quarterly}{elseif $addon.billingcycle == "Semiannually"}{$LANG.pricingCycleShort.semiannually}{elseif $addon.billingcycle == "Annually"}{$LANG.pricingCycleShort.annually}{elseif $addon.billingcycle == "Biennially"}{$LANG.pricingCycleShort.biennially}{elseif $addon.billingcycle == "Triennially"}{$LANG.pricingCycleShort.triennially}{else}{$addon.billingcycle}{/if}</span></div>
                                        {if $addon.setupfee}<div class="package-setup-fee">+ {$addon.setupfee} {$LANG.ordersetupfee}</div>{/if}
                                    {/if}
                                </div>
                                <div class="package-actions">
                                    <button type="submit" class="btn btn-lg btn-primary" href="#">{$LANG.ordernowbutton}</button>
                                </div>
                            </div>
                        </form>
                    </div>
                    {if $num % 2 != 0}
                        </div>
                        <div class="row row-eq-height">
                    {/if}
                    {/foreach}
                </div>
            </div>
        </div>
    </div>
{/if}