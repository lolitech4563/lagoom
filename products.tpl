{if isset($RSThemes['pages']['products'])}
    {include file=$RSThemes['pages']['products']['fullPath']}
{else}
    {include file="orderforms/$carttpl/common.tpl"}

    <div class="col-md-3 pull-md-left main-sidebar sidebar hidden-xs hidden-sm">
        {include file="orderforms/$carttpl/sidebar-categories.tpl"}
    </div>
    <div class="main-content col-md-9 pull-md-right">
        {include file="orderforms/$carttpl/sidebar-categories-collapsed.tpl"}
        {if $errormessage}
            <div class="alert alert-danger">
                {$errormessage}
            </div>
        {elseif !$productGroup}
            <div class="alert alert-info">
                {lang key='orderForm.selectCategory'}
            </div>
        {/if}
        <div class="products" id="products">
            <div class="row row-eq-height row-eq-height-sm">
                {foreach $products as $key => $product}
                    <div class="col-lg-4 col-sm-6 {if $RSThemes['addonSettings']['auto_recalculate_package_width'] eq 1}flex-grow{/if}">
                        <div class="package {if $product.isFeatured}package-featured{/if}" id="product{$product@iteration}">
                            {if $product.isFeatured}
                                <span class="label-corner label-primary">{$rslang->trans('order.featured')}</span>
                            {/if}
                            <h3 class="package-name">{$product.name}</h3>
                            <div class="package-price">
                                {if $product.bid}
                                    <div class="package-starting-from">{$LANG.bundledeal}</div>
                                    {if $product.displayprice}
                                        <span class="price {if $RSThemes['addonSettings']['package_price_wrap'] eq 'break-all'}word-break-all{/if}">{$product.displayprice}</span>
                                    {/if}
                                {else}
                                    {if $product.pricing.hasconfigoptions}
                                        <div class="package-starting-from ">{$LANG.startingfrom}</div>
                                    {/if}
                                    {if $DiscountCenterAddonIsActive}
                                        <div class="price {if $RSThemes['addonSettings']['package_price_wrap'] eq 'break-all'}word-break-all{/if}">{$product.pricing.minprice.price}{if $product.pricing.type !=="free" && $product.pricing.type !=="onetime"}<span class="price-cycle">/{if $product.pricing.minprice.cycle eq "monthly"}{$LANG.pricingCycleShort.monthly}{elseif $product.pricing.minprice.cycle eq "quarterly"}{$LANG.pricingCycleShort.quarterly}{elseif $product.pricing.minprice.cycle eq "semiannually"}{$LANG.pricingCycleShort.semiannually}{elseif $product.pricing.minprice.cycle eq "annually"}{$LANG.pricingCycleShort.annually}{elseif $product.pricing.minprice.cycle eq "biennially"}{$LANG.pricingCycleShort.biennially}{elseif $product.pricing.minprice.cycle eq "triennially"}{$LANG.pricingCycleShort.triennially}{/if}</span>{/if}</div>
                                    {else}
                                        <div class="price {if $RSThemes['addonSettings']['package_price_wrap'] eq 'break-all'}word-break-all{/if}">{if $currency.prefix}<span class="price-prefix">{$currency.prefix}</span>{/if}{$product.pricing.minprice.price|replace:$currency.suffix:""|replace:$currency.prefix:""}{if $currency.suffix}{$currency.suffix}{/if}{if $product.pricing.type !=="free" && $product.pricing.type !=="onetime"}<span class="price-cycle">/{if $product.pricing.minprice.cycle eq "monthly"}{$LANG.pricingCycleShort.monthly}{elseif $product.pricing.minprice.cycle eq "quarterly"}{$LANG.pricingCycleShort.quarterly}{elseif $product.pricing.minprice.cycle eq "semiannually"}{$LANG.pricingCycleShort.semiannually}{elseif $product.pricing.minprice.cycle eq "annually"}{$LANG.pricingCycleShort.annually}{elseif $product.pricing.minprice.cycle eq "biennially"}{$LANG.pricingCycleShort.biennially}{elseif $product.pricing.minprice.cycle eq "triennially"}{$LANG.pricingCycleShort.triennially}{/if}</span>{/if}</div>
                                    {/if}
                                    {if $product.pricing.minprice.setupFee}
                                        <small class="package-setup-fee">{$product.pricing.minprice.setupFee->toPrefixed()} {$LANG.ordersetupfee}</small>
                                    {/if}
                                {/if}
                            </div>
                            {if $product.features}
                            <ul class="package-features">
                                {foreach $product.features as $feature => $value}
                                    <li id="product{$product@iteration}-feature{$value@iteration}">
                                        {$feature} {$value}
                                    </li>
                                {/foreach}
                            </ul>
                            {/if}
                            {if $product.featuresdesc}
                                <div class="package-content">
                                    <p>{$product.featuresdesc}</p>
                                </div>
                            {/if}
                            <div class="package-footer">
                                <a href="{$WEB_ROOT}/cart.php?a=add&{if $product.bid}bid={$product.bid}{else}pid={$product.pid}{/if}" class="btn btn-lg btn-primary" id="product{$product@iteration}-order-button">
                                    {$LANG.ordernowbutton}
                                </a>
                                {if $product.stockControlEnabled}
                                    <div class="package-qty">
                                        {$product.qty} {$LANG.orderavailable}
                                    </div>
                                {/if}
                            </div>
                        </div>
                    </div>
                {/foreach}
            </div>
        </div>
        {if count($productGroup.features) > 0}
            <div class="section m-t-24">
                <h3>{$LANG.orderForm.includedWithPlans}</h3>
                <div class="panel panel-form">
                    <div class="panel-body">
                        <ul class="list-features list-info">
                            {foreach $productGroup.features as $features}
                                <li class="m-b-10 align-center"><i class="lm lm-check m-r-8 text-primary "></i><span class="h6 m-b-0">{$features.feature}<span></li>
                            {/foreach}
                        </ul>
                    </div>
                </div>
            </div>
        {/if}
    </div>
{/if}
