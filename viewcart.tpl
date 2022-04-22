{if isset($RSThemes['pages']['viewcart'])}
    {include file=$RSThemes['pages']['viewcart']['fullPath']}
{else}
    {include file="orderforms/$carttpl/common.tpl"}
    
    <script>
        // Define state tab index value
        var statesTab = 10;
        var stateNotRequired = true;
    </script>
    
    <script type="text/javascript" src="{$BASE_PATH_JS}/StatesDropdown.js"></script>
    <div class="main-content">
        <div class="order-content">
            {if $cartitems == 0}
                <div class="message message-no-data">
                    <div class="message-image">
                        {include file="$template//assets/svg-icon/basket.tpl"}
                    </div>
                    <h6 class="message-text">{$LANG.cartempty}</h6>
                    <div class="message-action">
                        <a class="btn btn-primary" href="{$WEB_ROOT}/cart.php">
                            {$rslang->trans('order.start_shopping')}
                        </a>
                    </div>
                </div>
        
                {if $promoSliderExtension}
                    {include file="$template/core/extensions/PromoBanners/promo-slide.tpl" setting="cart-view" class="m-t-3x"}
                {/if}
            {else}
                {if $promoerrormessage}
                    <div class="alert alert-danger" role="alert">
                        <div class="alert-body">
                            {$promoerrormessage}
                        </div>
                    </div>
                {elseif $errormessage}
                    <div class="alert alert-danger" role="alert">
                        <div class="alert-body">
                            <p>{$LANG.orderForm.correctErrors}:</p>
                            <ul>
                                {$errormessage}
                            </ul>
                        </div>
                    </div>
                {elseif $promotioncode && $rawdiscount eq "0.00"}
                    <div class="alert alert-info" role="alert">
                        <div class="alert-body">
                            {$LANG.promoappliedbutnodiscount}
                        </div>
                    </div>
                {elseif $promoaddedsuccess}
                    <div class="alert alert-success" role="alert">
                        <div class="alert-body">
                            {$LANG.orderForm.promotionAccepted}
                        </div>
                    </div>
                {/if}
                {if $bundlewarnings}
                    <div class="alert alert-warning" role="alert">
                        <div class="alert-body">
                            <strong>{$LANG.bundlereqsnotmet}</strong><br />
                            <ul>
                                {foreach from=$bundlewarnings item=warning}
                                    <li>{$warning}</li>
                                {/foreach}
                            </ul>
                        </div>
                    </div>
                {/if}
                <div class="section">
                    <form method="post" action="{$smarty.server.PHP_SELF}?a=view">
                        <div class="panel panel-default panel-cart m-b-0 mob-border-0">
                            <div class="panel-heading cart-heading">
                                <div class="row row-sm">
                                    <div class="{if $showqtyoptions}col-sm-6{else}col-sm-8{/if}">
                                        {$LANG.orderForm.productOptions}
                                    </div>
                                    {if $showqtyoptions}
                                        <div class="col-sm-2">
                                            {$LANG.orderForm.qty}
                                        </div>
                                    {/if}
                                    <div class="col-sm-3">
                                        {$LANG.orderForm.priceCycle}
                                    </div>
                                    <div class="col-sm-2"></div>
                                </div>
                            </div>
                            {foreach $products as $num => $product}
                                <div class="panel-body cart-item">
                                    <div class="row row-sm" data-input-number>
                                        <div class="{if $showqtyoptions}col-sm-6{else}col-sm-8{/if} prod-name" data-content="{$LANG.orderproduct}">
                                            <div class="cart-item-title">
                                                <h2>{$product.productinfo.groupname} - {$product.productinfo.name}</h2>
                                                {if $product.domain}
                                                    <span class="text-domain">{$product.domain}</span>
                                                {/if}
                                            </div>
                                        </div>
                                        {if $showqtyoptions}
                                            <div class="col-sm-2 prod-qty" data-content="{$LANG.quantity}">
                                                {if $product.allowqty}
                                                    <div class="input-number">
                                                        <input type="number" data-input-number-input name="qty[{$num}]" min=1 value="{$product.qty}" min="0" />
                                                        <div class="input-number-actions">
                                                            <div class="plus" data-input-number-inc></div>
                                                            <div class="minus" data-input-number-dec></div>
                                                        </div>
                                                    </div>
                                                {else}
                                                    -
                                                {/if}
                                            </div>
                                        {/if}
                                        <div class="col-sm-3 prod-price {if !$showqtyoptions}no-qty{/if}" data-content="{$LANG.orderprice}">
                                            <span class="cart-item-price" data-input-number-price>{$product.pricing.totalTodayExcludingTaxSetup}{if $product.billingcycle !="free"}/{/if}{if $product.billingcycle =="onetime"}{$LANG.orderpaymenttermonetime}{elseif $product.billingcycle eq "monthly"}{$rslang->trans('order.period.short.monthly')}{elseif $product.billingcycle eq "quarterly"}{$rslang->trans('order.period.short.quarterly')}{elseif $product.billingcycle eq "semiannually"}{$rslang->trans('order.period.short.semiannually')}{elseif $product.billingcycle eq "annually"}{$rslang->trans('order.period.short.annually')}{elseif $product.billingcycle eq "biennially"}{$rslang->trans('order.period.short.biennially')}{elseif $product.billingcycle eq "triennially"}{$rslang->trans('order.period.short.triennially')}{/if}
                                                {if $product.pricing.productonlysetup}
                                                    + {$product.pricing.productonlysetup->toPrefixed()} {$LANG.ordersetupfee}
                                                {/if}
                                                {if $product.proratadate}<br /><span class="renewal">({$LANG.orderprorata} {$product.proratadate})</span>{/if}
                                            </span>
                                            <button class="btn btn-info hidden" data-input-number-update data-toggle="tooltip" data-html="true" data-original-title="{$LANG.carttaxupdateselectionsupdate}" title="">
                                                <i class="ls ls-info-circle"></i>{$LANG.carttaxupdateselectionsupdate}
                                            </button>
                                        </div>
                                        <div class="col-sm-1 prod-actions">
                                            <div class="cart-item-actions d-flex">
                                                <a href="{$smarty.server.PHP_SELF}?a=confproduct&i={$num}" data-toggle="tooltip" data-html="true" data-original-title="{$LANG.orderForm.edit}" title="" class="btn btn-icon btn-sm">
                                                    <i class="ls ls-edit"></i>
                                                </a>
                                                <button type="button" class="btn btn-icon btn-sm" data-toggle="tooltip" data-html="true" data-original-title=" {$LANG.orderForm.remove}" onclick="removeItem('p', '{$num}')">
                                                    <i class="ls ls-trash"></i>
                                                </button>
                                            </div>
                                        </div>
                                        {if $product.configoptions || $product.addons}
                                            <div class="clearfix"></div>
                                            <div class="row row-sm prod-desc">
                                                <div class="content">
                                                    <ul class="additional-information">
                                                        {foreach key=confnum item=configoption from=$product.configoptions}
                                                            <li>
                                                                <div class="content">
                                                                    <span class="item-name">{$configoption.name}:</span>
                                                                    <span class="item-value"> {if $configoption.type eq 1 || $configoption.type eq 2}{$configoption.option}{elseif $configoption.type eq 3}{if $configoption.qty}{$configoption.option}{else}{$LANG.no}{/if}{elseif $configoption.type eq 4}{$configoption.qty} x {$configoption.option}{/if}</span>
                                                                </div>
                                                                <div class="content">
                                                                    <span class="item-price">{if $configoption.recurring->toNumeric() && $configoption.recurring->toNumeric() != 0}{$configoption.recurring}{else}-{/if}</span>
                                                                </div>
                                                            </li>
                                                        {/foreach}
                                                        {foreach key=addonnum item=addon from=$product.addons}
                                                            <li {if $showAddonQtyOptions && $addon.allowqty===2}data-input-number-secondary{/if}>
                                                                <div class="content {if $showAddonQtyOptions && $addon.allowqty === 2}has-qty{/if}">
                                                                    {if $showAddonQtyOptions}<span>{/if}
                                                                        <span class="item-name">{$LANG.orderaddon}:</span>
                                                                        <span class="item-value">{$addon.name}</span>
                                                                        {if $showAddonQtyOptions}</span>{/if}
                                                                    {if $showAddonQtyOptions}
                                                                        <div class="item-qty">
                                                                            {if $addon.allowqty === 2}
                                                                                <div class="input-number input-number-sm">
                                                                                    <input type="number" data-input-number-secondary-input name="paddonqty[{$num}][{$addonnum}]" value="{$addon.qty}" min="0" />
                                                                                    <div class="input-number-actions">
                                                                                        <div class="plus" data-input-number-secondary-inc></div>
                                                                                        <div class="minus" data-input-number-secondary-dec></div>
                                                                                    </div>
                                                                                </div>
                                                                            {/if}
                                                                        </div>
                                                                    {/if}
                                                                </div>
                                                                <div class="content">
                                                                    <span class="item-price" {if $showAddonQtyOptions && $addon.allowqty===2}data-input-number-secondary-price{/if}>
                                                                        {if $addon.billingcycle != "free"}
                                                                            {$addon.totaltoday}/{if $addon.billingcycle =="free"}{$LANG.orderpaymenttermfree}{elseif $addon.billingcycle =="onetime"}{$LANG.orderpaymenttermonetime}{elseif $addon.billingcycle eq "monthly"}{$rslang->trans('order.period.short.monthly')}{elseif $addon.billingcycle eq "quarterly"}{$rslang->trans('order.period.short.quarterly')}{elseif $addon.billingcycle eq "semiannually"}{$rslang->trans('order.period.short.semiannually')}{elseif $addon.billingcycle eq "annually"}{$rslang->trans('order.period.short.annually')}{elseif $addon.billingcycle eq "biennially"}{$rslang->trans('order.period.short.biennially')}{elseif $addon.billingcycle eq "triennially"}{$rslang->trans('order.period.short.triennially')}{/if}
                                                                        {/if}
                                                                    </span>
                                                                    <button class="btn btn-info hidden" {if $showAddonQtyOptions && $addon.allowqty===2}data-input-number-secondary-update{/if} data-toggle="tooltip" data-html="true" data-original-title="{$LANG.carttaxupdateselectionsupdate}" title="">
                                                                        <i class="ls ls-info-circle"></i>{$LANG.carttaxupdateselectionsupdate}
                                                                    </button>
                                                                </div>
                                                            </li>
                                                        {/foreach}
                                                        <ul>
                                                </div>
                                            </div>
                                        {/if}
                                    </div>
                                </div>
                            {/foreach}
                            {foreach $domains as $num => $domain}
                                <div class="panel-body cart-item">
                                    <div class="row row-sm">
                                        <div class="{if $showqtyoptions}col-sm-6{else}col-sm-8{/if} prod-name" data-content="{$LANG.orderdomain}">
                                            <div class="cart-item-title">
                                                <h2>{if $domain.type eq "register"}{$LANG.orderdomainregistration}{else}{$LANG.orderdomaintransfer}{/if}</h2>
                                                {if $domain.domain}
                                                    <span class="text-domain">{$domain.domain}</span>
                                                {/if}
                                            </div>
                                        </div>
                                        {if $showqtyoptions}
                                            <div class="col-sm-2 prod-qty" data-content="{$LANG.quantity}">
                                                <div class="cart-item-qty-placeholder">-</div>
                                            </div>
                                        {/if}
                                        <div class="col-sm-3 prod-price {if !$showqtyoptions}no-qty{/if}" data-content="{$LANG.orderprice}">
                                            <span class="cart-item-price">
                                                {if count($domain.pricing) == 1 || $domain.type == 'transfer'}
                                                    <span>{$domain.price}{$domain.shortYearsLanguage}</span>
                                                    <span class="renewal cycle" name="{$domain.domain}Pricing">
                                                        {if isset($domain.renewprice)}{lang key='domainrenewalprice'} <span class="renewal-price cycle">{$domain.renewprice}{$domain.shortRenewalYearsLanguage}{/if}</span>
                                                    </span>
                                                {else}
                                                    <div class="dropdown">
                                                        <button class="btn btn-default dropdown-toggle" type="button" id="{$domain.domain}Pricing" name="{$domain.domain}Pricing" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
                                                            {$domain.price}{$domain.shortYearsLanguage}
                                                            <span class="caret"></span>
                                                        </button>
                                                        <ul class="dropdown-menu" aria-labelledby="{$domain.domain}Pricing">
                                                            {foreach $domain.pricing as $years => $price}
                                                                <li>
                                                                    <a href="#" onclick="selectDomainPeriodInCart('{$domain.domain}', '{$price.register}', {$years}, '{if $years == 1}{lang key='orderForm.year'}{else}{lang key='orderForm.years'}{/if}');return false;">
                                                                        {$years} {if $years == 1}{lang key='orderForm.year'}{else}{lang key='orderForm.years'}{/if} @ {$price.register}
                                                                    </a>
                                                                </li>
                                                            {/foreach}
                                                        </ul>
                                                    </div>
                                                    <span class="renewal cycle">
                                                        {lang key='domainrenewalprice'} <span class="renewal-price cycle">{if isset($domain.renewprice)}{$domain.renewprice}{$domain.shortRenewalYearsLanguage}{/if}</span>
                                                    </span>
                                                {/if}
                                            </span>
                                        </div>
                                        <div class="col-sm-1 prod-actions">
                                            <div class="cart-item-actions d-flex">
                                                <a href="{$smarty.server.PHP_SELF}?a=confdomains" data-toggle="tooltip" data-html="true" data-original-title="{$LANG.orderForm.edit}" title="" class="btn btn-icon btn-sm">
                                                    <i class="ls ls-edit"></i>
                                                </a>
                                                <button type="button" class="btn btn-icon btn-sm" data-toggle="tooltip" data-html="true" data-original-title=" {$LANG.orderForm.remove}" onclick="removeItem('d', '{$num}')">
                                                    <i class="ls ls-trash"></i>
                                                </button>
                                            </div>
                                        </div>
                                        {if $domain.dnsmanagement || $domain.emailforwarding || $domain.idprotection}
                                            <div class="clearfix"></div>
                                            <div class="row row-sm prod-desc">
                                                <div class="content">
                                                    <ul class="additional-information">
                                                        {if $domain.dnsmanagement}
                                                            <li>
                                                                <div class="content">
                                                                    <span class="item-value">{$LANG.domaindnsmanagement}</span>
                                                                </div>
                                                            </li>
                                                        {/if}
                                                        {if $domain.emailforwarding}
                                                            <li>
                                                                <div class="content">
                                                                    <span class="item-value">{$LANG.domainemailforwarding}</span>
                                                                </div>
                                                            </li>
                                                        {/if}
                                                        {if $domain.idprotection}
                                                            <li>
                                                                <div class="content">
                                                                    <span class="item-value">{$LANG.domainidprotection}</span>
                                                                </div>
                                                            </li>
                                                        {/if}
                                                    </ul>
                                                </div>
                                            </div>
                                        {/if}
                                    </div>
                                </div>
                            {/foreach}
                            {foreach $renewals as $num => $domain}
                                <div class="panel-body cart-item">
                                    <div class="row row-sm">
                                        <div class="{if $showqtyoptions}col-sm-5 col-lg-6{else}col-sm-7 col-lg-8{/if} prod-name" data-content="{$LANG.orderdomain}">
                                            <div class="cart-item-title">
                                                <h2>{$LANG.domainrenewal}</h2>
                                                <span class="text-domain">{$domain.domain}</span>
                                            </div>
                                        </div>
                                        {if $showqtyoptions}
                                            <div class="col-sm-2 prod-qty" data-content="{$LANG.quantity}">
                                                <div class="cart-item-qty-placeholder">-</div>
                                            </div>
                                        {/if}
                                        <div class="col-sm-3 prod-price {if !$showqtyoptions}no-qty{/if}" data-content="{$LANG.orderprice}">
                                            <div class="cart-item-price">
                                                {$domain.price}/{$domain.regperiod}{$rslang->trans('order.period.short.annually')}
                                            </div>
                                        </div>
                                        <div class="col-sm-1 prod-actions">
                                            <div class="cart-item-actions d-flex">
                                                <button type="button" class="btn btn-icon btn-sm" data-toggle="tooltip" data-html="true" data-original-title=" {$LANG.orderForm.remove}" onclick="removeItem('r', '{$num}')">
                                                    <i class="ls ls-trash"></i>
                                                </button>
                                            </div>
                                        </div>
                                        {if $domain.dnsmanagement || $domain.emailforwarding || $domain.idprotection}
                                            <div class="clearfix"></div>
                                            <div class="row row-sm prod-desc clear-both">
                                                <div class="content">
                                                    <ul class="additional-information">
                                                        {if $domain.dnsmanagement}
                                                            <li>
                                                                <div class="content">
                                                                    <span class="item-value">{$LANG.domaindnsmanagement}</span>
                                                                </div>
                                                            </li>
                                                        {/if}
                                                        {if $domain.emailforwarding}
                                                            <li>
                                                                <div class="content">
                                                                    <span class="item-value">{$LANG.domainemailforwarding}</span>
                                                                </div>
                                                            </li>
                                                        {/if}
                                                        {if $domain.idprotection}
                                                            <li>
                                                                <div class="content">
                                                                    <span class="item-value">{$LANG.domainidprotection}</span>
                                                                </div>
                                                            </li>
                                                        {/if}
                                                    </ul>
                                                </div>
                                            </div>
                                        {/if}
                                    </div>
                                </div>
                            {/foreach}
                            {foreach $addons as $num => $addon}
                                <div class="panel-body cart-item">
                                    <div class="row row-sm" data-input-number>
                                        <div class="{if $showAddonQtyOptions}col-sm-6{else}col-sm-8{/if} prod-name" data-content="{$LANG.orderaddon}">
                                            <span class="cart-item-title">
                                                <h2>{$addon.name} - {$addon.productname}</h2>
                                                {if $addon.domainname}
                                                    <span class="text-domain">
                                                        {$addon.domainname}
                                                    </span>
                                                {/if}
                                            </span>
                                            {if $addon.setup}
                                                <span class="item-setup">
                                                    + {$addon.setup} {$LANG.ordersetupfee}
                                                </span>
                                            {/if}
                                        </div>
                                        {if $showAddonQtyOptions}
                                            <div class="col-sm-2 prod-qty" data-content="{$LANG.quantity}">
                                                {if $addon.allowqty === 2}
                                                    <div class="input-number">
                                                        <input type="number" data-input-number-input name="addonqty[{$num}]" value="{$addon.qty}" min="0" />
                                                        <div class="input-number-actions">
                                                            <div class="plus" data-input-number-inc></div>
                                                            <div class="minus" data-input-number-dec></div>
                                                        </div>
                                                    </div>
                                                {else}
                                                    -
                                                {/if}
                                            </div>
                                        {/if}
                                        <div class="col-sm-3 prod-price">
                                            <span class="cart-item-price" data-input-number-price>
                                                <span>{$addon.pricingtext}</span>
                                                {if $addon.billingcycle != 'Free'}
                                                    <span class="cycle">/{if $addon.billingcycle =="free"}{$LANG.orderpaymenttermfree}{elseif $addon.billingcycle =="onetime"}{$LANG.orderpaymenttermonetime}{elseif $addon.billingcycle eq "monthly"}{$rslang->trans('order.period.short.monthly')}{elseif $addon.billingcycle eq "quarterly"}{$rslang->trans('order.period.short.quarterly')}{elseif $addon.billingcycle eq "semiannually"}{$rslang->trans('order.period.short.semiannually')}{elseif $addon.billingcycle eq "annually"}{$rslang->trans('order.period.short.annually')}{elseif $addon.billingcycle eq "biennially"}{$rslang->trans('order.period.short.biennially')}{elseif $addon.billingcycle eq "triennially"}{$rslang->trans('order.period.short.triennially')}{/if}</span>
                                                {/if}
                                            </span>
                                            <button class="btn btn-info hidden" data-input-number-update data-toggle="tooltip" data-html="true" data-original-title="{$LANG.carttaxupdateselectionsupdate}" title="">
                                                <i class="ls ls-info-circle"></i>{$LANG.carttaxupdateselectionsupdate}
                                            </button>
                                        </div>
                                        <div class="col-sm-1 prod-actions">
                                            <div class="cart-item-actions d-flex">
                                                <button type="button" class="btn btn-icon btn-sm" data-toggle="tooltip" data-html="true" data-original-title=" {$LANG.orderForm.remove}" onclick="removeItem('a', '{$num}')">
                                                    <i class="ls ls-trash"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            {/foreach}
                            {foreach $upgrades as $num => $upgrade}
                                <div class="panel-body cart-item" data-input-number>
                                    <div class="row row-sm">
                                        <div class="prod-name {if $showUpgradeQtyOptions}col-sm-6{else}col-sm-8{/if}" data-content="{$LANG.upgrade}">
                                            <span class="cart-item-title">
                                                {$LANG.upgrade}
                                            </span>
                                            <span class="item-group">
                                                {if $upgrade->type == 'service'}
                                                    {$upgrade->originalProduct->productGroup->name}<br>{$upgrade->originalProduct->name} => {$upgrade->newProduct->name}
                                                {elseif $upgrade->type == 'addon'}
                                                    {$upgrade->originalAddon->name} => {$upgrade->newAddon->name}
                                                {/if}
                                            </span>
                                            <span class="item-domain">
                                                {if $upgrade->type == 'service'}
                                                    {$upgrade->service->domain}
                                                {/if}
                                            </span>
                                        </div>
                                        {if $showUpgradeQtyOptions}
                                            <div class="col-sm-2 prod-qty" data-content="{$LANG.quantity}">
                                                {if $upgrade->allowMultipleQuantities}
                                                    <div class="input-number">
                                                        <input type="number" data-input-number-input name="upgradeqty[{$num}]" value="{$upgrade->qty}" min="{$upgrade->minimumQuantity}" />
                                                        <div class="input-number-actions">
                                                            <div class="plus" data-input-number-inc></div>
                                                            <div class="minus" data-input-number-dec></div>
                                                        </div>
                                                    </div>
                                                {else}
                                                    -
                                                {/if}
                                            </div>
                                        {/if}
                                        <div class="col-sm-3 item-price">
                                            <span class="cart-item-price" data-input-number-price>
                                                <span>{$upgrade->newRecurringAmount}</span>
                                                <span class="cycle">{$upgrade->localisedNewCycle}</span>
                                            </span>
                                            <button class="btn btn-info hidden" data-input-number-update data-toggle="tooltip" data-html="true" data-original-title="{$LANG.carttaxupdateselectionsupdate}" title="">
                                                <i class="ls ls-info-circle"></i>{$LANG.carttaxupdateselectionsupdate}
                                            </button>
                                        </div>
                                        <div class="col-sm-1 prod-actions">
                                            <div class="cart-item-actions d-flex">
                                                <button type="button" class="btn btn-icon btn-sm" data-toggle="tooltip" data-html="true" data-original-title=" {$LANG.orderForm.remove}" onclick="removeItem('u', '{$num}')">
                                                    <i class="ls ls-trash"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                    {if $upgrade->totalDaysInCycle > 0}
                                        <div class="row row-upgrade-credit">
                                            <div class="col-sm-7">
                                                <span class="item-group">
                                                    {$LANG.upgradeCredit}
                                                </span>
                                                <div class="upgrade-calc-msg">
                                                    {lang key="upgradeCreditDescription" daysRemaining=$upgrade->daysRemaining totalDays=$upgrade->totalDaysInCycle}
                                                </div>
                                            </div>
                                            <div class="col-sm-4 item-price">
                                                <span>-{$upgrade->creditAmount}</span>
                                            </div>
                                        </div>
                                    {/if}
                                </div>
                            {/foreach}
                            <div class="panel-footer d-flex space-between">
                                <div class="content {if $taxenabled && !$loggedin}{else}d-flex space-between w-100 flex-nowrap{/if}">
                                    <a href="cart.php" class="btn btn-default btn-sm"><i class="ls ls-reply"></i>{$LANG.orderForm.continueShopping}</a>
                                    {if $taxenabled && !$loggedin}
                                        <a data-toggle="modal" data-target="#estimate-taxes" class="btn btn-default btn-sm" href="#"><i class="ls ls-bank-note"></i>{$LANG.orderForm.estimateTaxes}</a>
                                    {else}
                                        <button type="button" class="btn btn-default btn-sm" id="btnEmptyCart"><i class="ls ls-trash"></i>{$LANG.emptycart}</button>
                                    {/if}
                                </div>
        
                                <div class="content">
                                    {if $taxenabled && !$loggedin}
                                        <button type="button" class="btn btn-default btn-sm" id="btnEmptyCart"><i class="ls ls-trash"></i>{$LANG.emptycart}</button>
                                    {/if}
                                </div>
        
                            </div>
                        </div>
                    </form>
                </div>
                {if !$loggedin && $currencies}
                    <div class="section">
                        <div class="section-header">
                            <h3>{$LANG.choosecurrency}</h3>
                        </div>
                        <div class="section-body">
                            <div class="panel panel-default panel-form m-b-0">
                                <div class="panel-body">
                                    <form method="post" action="cart.php?a=view">
                                        <select name="currency" onchange="submit()" class="form-control">
                                            {foreach from=$currencies item=listcurr}
                                                <option value="{$listcurr.id}" {if $listcurr.id==$currency.id} selected{/if}>{$listcurr.code}</option>
                                            {/foreach}
                                        </select>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                {/if}
                <div class="section">
                    <div class="section-header">
                        <h3>{$LANG.cartpromo}</h3>
                    </div>
                    <div class="section-body">
                        {if $promoBannerStatus}
                            {include file="$template/core/extensions/PromoBanners/promo-slide.tpl" setting="cart-view" class="m-t-3x"}
                        {/if}
                        {if $promotioncode}
                            <div class="panel panel-default panel-form border-primary {if $hookOutput}m-b-0{else}m-b-40{/if}">
                                <div class="panel-heading">
                                    <div class="promo-code-description">
                                        <i class="ls ls-addon"></i>
                                        <span>{$promotiondescription}</span>
                                    </div>
                                </div>
                                <div class="panel-footer d-flex space-between">
                                    <div class="content">
                                        <span class="code">{$promotioncode} </span>
                                    </div>
                                    <div class="content">
                                        <a href="{$smarty.server.PHP_SELF}?a=removepromo" class="btn btn-default btn-sm"><i class="ls ls-trash"></i> {$LANG.orderForm.removePromotionCode}</a>
                                    </div>
                                </div>
                            </div>
                        {else}
                            <div class="panel panel-default panel-form {if $hookOutput}m-b-0{else}m-b-40{/if}">
                                <div class="panel-body">
                                    <form method="post" action="cart.php?a=checkout">
                                        <div class="form-group promo-code">
                                            <input type="text" name="promocode" id="inputPromotionCode" class="form-control" placeholder="{$LANG.orderPromoCodePlaceholder}" required="required">
                                            <button type="submit" name="validatepromo" class="btn btn-primary" value="{$LANG.orderpromovalidatebutton}"> {$LANG.orderpromovalidatebutton}</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        {/if}
                    </div>
                </div>
                {if $hookOutput}
                    <div class="section m-b-40">
                        {foreach $hookOutput as $output}
                            {$output|replace:'style="margin:20px 0;"':''|replace:'<div class="sub-heading"><span>':'<div class="section-header"><span class="h3 d-flex">'|replace:'<div class="sub-heading"><span class="primary-bg-color">':'<div class="section-header"><span class="h3 d-flex">'}
                                        {/foreach}
                                </div>
                            {/if}
                            <script>
                                window.langPasswordStrength = "{$LANG.pwstrength}";
                                window.langPasswordWeak = "{$LANG.pwstrengthweak}";
                                window.langPasswordModerate = "{$LANG.pwstrengthmoderate}";
                                window.langPasswordStrong = "{$LANG.pwstrengthstrong}";
                                window.langPasswordTooShort = "{$rslang->trans('login.at_least_pass')}";
                            </script>
                            <form method="post" action="{$smarty.server.PHP_SELF}?a=checkout" name="orderfrm" id="frmCheckout">
                                <input type="hidden" name="submit" value="true" />
                                <div class="section">
                                    <div class="section-header">
                                        <h3>{$LANG.billingdetails}</h3>
                                    </div>
                                    <div class="section-body">
                                        {if $custtype neq "new" && $loggedin}
                                            <input type="hidden" name="custtype" id="inputCustType" value="{$custtype}" />
                                            <div class="panel-group panel-group-condensed m-b-0" id="containerExistingAccountSelect" data-inputs-container>
                                                {foreach $accounts as $account}
                                                    <div class="panel panel-default {if $selectedAccountId == $account->id}checked{/if} {if $account->isClosed || $account->noPermission || $inExpressCheckout} disabled{/if}" data-virtual-input>
                                                        <div class="panel-heading check">
                                                            <label>
                                                                <input id="account{$account->id}" class="icheck-control account-select{if $account->isClosed || $account->noPermission || $inExpressCheckout} disabled{/if}" type="radio" name="account_id" value="{$account->id}" {if $account->isClosed || $account->noPermission || $inExpressCheckout} disabled="disabled"{/if}{if $selectedAccountId == $account->id} checked="checked"{/if}>
                                                                <div class="check-content d-flex align-center">
                                                                    <span>{if $account->company}{$account->company}{else}{$account->fullName}{/if}</span>
                                                                    {if $account->isClosed || $account->noPermission}
                                                                        <div class="m-l-a label label-default">
                                                                            {if $account->isClosed}
                                                                                {lang key='closed'}
                                                                            {else}
                                                                                {lang key='noPermission'}
                                                                            {/if}
                                                                        </div>
                                                                    {elseif $account->currencyCode}
                                                                        <div class="m-l-a label label-info">
                                                                            {$account->currencyCode}
                                                                        </div>
                                                                    {/if}
                                                                </div>
                                                            </label>
                                                        </div>
                                                        <div class="panel-collapse collapse {if $selectedAccountId == $account->id}in{/if}" data-input-collapse role="tabpanel">
                                                            <div class="panel-body">
                                                                <address>
                                                                    <span class="address-item">{$account->email} </span> <br />
                                                                    <span class="address-item">{$account->address1}{if $account->address2}, {$account->address2}{/if}</span><br />
                                                                    <span class="address-item">{if $account->city}{$account->city},{/if}{if $account->postcode} {$account->postcode}{/if}</span> <br />
                                                                    <span class="address-item">{if $account->state}{$account->state}{/if}</span> <br />
                                                                    <span class="address-item">{$account->countryName}</span> <br />
                                                                    <span class="address-item">{if $account->phonenumber}{$account->phonenumber}{/if}</span>
                                                                </address>
                                                            </div>
                                                        </div>
                                                    </div>
                                                {/foreach}
                                                <div class="panel panel-default {if !$selectedAccountId || !is_numeric($selectedAccountId)} checked{/if} {if $inExpressCheckout}disabled{/if}" data-virtual-input>
                                                    <div class="panel-heading check">
                                                        <label>
                                                            <input class="icheck-control account-select" type="radio" name="account_id" value="new" {if !$selectedAccountId || !is_numeric($selectedAccountId)} checked="checked" {/if}{if $inExpressCheckout} disabled="disabled" class="disabled" {/if}>
                                                            <div class="check-content">
                                                                <span>{lang key='orderForm.createAccount'}</span>
                                                            </div>
                                                        </label>
                                                    </div>
                                                    <div class="panel-collapse collapse {if $custtype neq "existing"}in{/if}" data-input-collapse role="tabpanel">
                                                        <div class="panel-body">
                                                            {include file="orderforms/$carttpl/includes/register-user-fields.tpl"}
                                                        </div>
            
                                                    </div>
                                                </div>
                                            </div>
                                        {else}
                                            <div class="panel-group panel-group-condensed m-b-0" data-inputs-container>
                                                <div class="panel panel-default  {if $custtype eq "existing"}checked{/if}" data-virtual-input>
                                                    <div class="panel-heading check">
                                                        <label>
                                                            <input type="radio" class="icheck-control" name="custtype" {if $custtype eq "existing" }checked{/if} value="existing" />
                                                            <div class="check-content">
                                                                <span>{$LANG.orderForm.existingCustomerLogin}</span>
                                                            </div>
                                                        </label>
                                                    </div>
                                                    <div class="panel-collapse collapse {if $custtype eq "existing"}in{/if}" data-input-collapse role="tabpanel">
                                                        <div class="panel-body">
                                                            <div class="alert alert-danger w-hidden" id="existingLoginMessage"></div>
                                                            <div class="inline-form flex-column-sm">
                                                                 <div class="inline-form-element w-100">
                                                                    <label for="inputFirstName_exsist" class="control-label">{$LANG.orderForm.emailAddress}</label>
                                                                    <input type="text" name="loginemail" id="inputLoginEmail" class="form-control" value="{$loginemail}">
                                                                </div>
                                                                <div class="inline-form-element w-100">
                                                                    <label for="password_exsist" class="control-label">{$LANG.clientareapassword}</label>
                                                                    <input type="password" name="loginpassword" id="inputLoginPassword" class="form-control">
                                                                </div>
                                                                <div class="inline-form-element m-r-0">
                                                                    <label class="control-label hidden-xs">&nbsp;</label>
                                                                    <button type="button" id="btnExistingLogin" data-btn-loader class="btn btn-block btn-primary btn-md">
                                                                        <span>
                                                                            {lang key='login'}
                                                                        </span>
                                                                        <div class="loader loader-button">
                                                                            {include file="$template/includes/loader.tpl" classes="spinner-sm"}
                                                                        </div>
                                                                    </button>
                                                                </div>
                                                            </div>
                                                            {include file="orderforms/$carttpl/linkedaccounts.tpl" linkContext="checkout-existing"}
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="panel panel-default  {if $custtype neq "existing"}checked{/if}" data-virtual-input>
                                                    <div class="panel-heading check">
                                                        <label>
                                                            <input type="radio" class="icheck-control" name="custtype" {if $custtype neq "existing" }checked{/if} value="new" />
                                                            <div class="check-content">
                                                                <span>{$LANG.orderForm.createAccount}</span>
                                                            </div>
                                                        </label>
                                                    </div>
                                                    <div class="panel-collapse collapse {if $custtype neq "existing"}in{/if}" data-input-collapse role="tabpanel">
                                                        <div class="panel-body social-wide">
                                                            {include file="orderforms/$carttpl/includes/register-user-fields.tpl"}
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        {/if}
                                    </div>
                                </div>
                                {if $domainsinorder}
                                    <div class="section">
                                        <div class="section-header">
                                            <h3>{$LANG.domainregistrantinfo}</h3>
                                        </div>
                                        <div class="section-body">
                                            <div class="panel panel-default panel-form m-b-0">
                                                <div class="panel-body">
                                                    <div class="section">
                                                        <p>{$LANG.orderForm.domainAlternativeContact}</p>
                                                        <select name="contact" id="inputDomainContact" class="form-control {if $contact eq "addingnew"}m-b-40{/if}">
                                                            <option value="">{$LANG.usedefaultcontact}</option>
                                                            {foreach $domaincontacts as $domcontact}
                                                                <option value="{$domcontact.id}" {if $contact==$domcontact.id} selected{/if}>
                                                                    {$domcontact.name}
                                                                </option>
                                                            {/foreach}
                                                            <option value="addingnew" {if $contact=="addingnew" } selected{/if}>
                                                                {$LANG.clientareanavaddcontact}...
                                                            </option>
                                                        </select>
                                                    </div>
                                                    <div class="section {if $contact neq "addingnew"} hidden{/if}" id="domainRegistrantInputFields">
                                                        <h6>{$LANG.orderForm.personalInformation}</h6>
                                                        <div class="row">
                                                            <div class="col-sm-6">
                                                                <div class="form-group">
                                                                    <label for="inputDCFirstName" class="control-label">
                                                                        {$LANG.orderForm.firstName}
                                                                    </label>
                                                                    <input type="text" name="domaincontactfirstname" maxlength="50" id="inputDCFirstName" class="form-control" value="{$domaincontact.firstname}">
                                                                </div>
                                                            </div>
                                                            <div class="col-sm-6">
                                                                <div class="form-group">
                                                                    <label for="inputDCLastName" class="control-label">
                                                                        {$LANG.orderForm.lastName}
                                                                    </label>
                                                                    <input type="text" name="domaincontactlastname" maxlength="50" id="inputDCLastName" class="form-control" value="{$domaincontact.lastname}">
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-sm-6">
                                                                <div class="form-group">
                                                                    <label for="inputDCEmail" class="control-label">
                                                                        {$LANG.orderForm.emailAddress}
                                                                    </label>
                                                                    <input type="email" name="domaincontactemail" id="inputDCEmail" class="form-control" value="{$domaincontact.email}">
                                                                </div>
                                                            </div>
                                                            <div class="col-sm-6">
                                                                <div class="form-group">
                                                                    <label for="inputDCPhone" class="control-label">
                                                                        {$LANG.orderForm.phoneNumber}
                                                                    </label>
                                                                    <input type="tel" name="domaincontactphonenumber" id="inputDCPhone" class="form-control" value="{$domaincontact.phonenumber}">
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <h6 class="m-t-16">{$LANG.orderForm.billingAddress}</h6>
                                                        <div class="row">
                                                            <div class="col-sm-6">
                                                                <div class="form-group">
                                                                    <label for="inputDCCompanyName" class="control-label">
                                                                        {$LANG.orderForm.companyName} ({$LANG.orderForm.optional})
                                                                    </label>
                                                                    <input type="text" name="domaincontactcompanyname" id="inputDCCompanyName" class="form-control" value="{$domaincontact.companyname}">
                                                                </div>
                                                            </div>
                                                            <div class="col-sm-6">
                                                                <div class="form-group">
                                                                    <label for="inputDCTaxId">
                                                                        {$taxLabel} ({$LANG.orderForm.optional})
                                                                    </label>
                                                                    <input type="text" name="domaincontacttax_id" id="inputDCTaxId" class="form-control" value="{$domaincontact.tax_id}">
                                                                </div>
                                                            </div>
                                                            <div class="col-sm-6">
                                                                <div class="form-group">
                                                                    <label for="inputDCAddress1" class="control-label">
                                                                        {$LANG.orderForm.streetAddress}
                                                                    </label>
                                                                    <input type="text" name="domaincontactaddress1" id="inputDCAddress1" class="form-control" value="{$domaincontact.address1}">
                                                                </div>
                                                            </div>
            
                                                            <div class="col-sm-6">
                                                                <div class="form-group">
                                                                    <label for="inputDCAddress2" class="control-label">
                                                                        {$LANG.orderForm.streetAddress2}
                                                                    </label>
                                                                    <input type="text" name="domaincontactaddress2" id="inputDCAddress2" class="form-control" value="{$domaincontact.address2}">
                                                                </div>
                                                            </div>
                                                            <div class="col-sm-6">
                                                                <div class="form-group">
                                                                    <label for="inputDCCity" class="control-label">
                                                                        {$LANG.orderForm.city}
                                                                    </label>
                                                                    <input type="text" name="domaincontactcity" id="inputDCCity" class="form-control" value="{$domaincontact.city}">
                                                                </div>
                                                            </div>
            
                                                            <div class="col-sm-6">
                                                                <div class="row">
                                                                    <div class="col-sm-6">
                                                                        <div class="form-group">
                                                                            <label for="inputDCState" class="control-label">
                                                                                {$LANG.orderForm.state}
                                                                            </label>
                                                                            <input type="text" name="domaincontactstate" id="inputDCState" class="form-control" value="{$domaincontact.state}">
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-sm-6">
                                                                        <div class="form-group">
                                                                            <label for="inputDCPostcode" class="control-label">
                                                                                {$LANG.orderForm.postcode}
                                                                            </label>
                                                                            <input type="text" name="domaincontactpostcode" id="inputDCPostcode" class="form-control" value="{$domaincontact.postcode}">
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-sm-6">
                                                                <div class="form-group">
                                                                    <label for="inputDCPostcode" class="control-label">{$LANG.orderForm.country}</label>
                                                                    <select name="domaincontactcountry" id="inputDCCountry" class="form-control">
                                                                        {foreach $countries as $countrycode => $countrylabel}
                                                                            <option value="{$countrycode}" {if (!$domaincontact.country && $countrycode==$defaultcountry) || $countrycode eq $domaincontact.country} selected{/if}>
                                                                                {$countrylabel}
                                                                            </option>
                                                                        {/foreach}
                                                                    </select>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                {/if}
                                <div class="section" id="paymentGatewaysDetails">
                                    <h3>{$LANG.orderpaymentmethod}</h3>
                                    <div class="panel panel-default {if !$canUseCreditOnCheckout} hidden{/if}">
                                        <div class="panel-body">
                                            <p class="credit-balance-title">{$LANG.availcreditbal}:</p>
                                            <div class="panel panel-info">
                                                <div class="panel-body bg-info">
                                                    <div class="credit-balance">{$creditBalance}</div>
                                                </div>
                                            </div>
                                            <div id="applyCreditContainer" class="apply-credit-container radio-content" data-apply-credit="{$applyCredit}">
                                                <div class="form-group">
                                                    <div class="radio">
                                                        <label>
                                                            <input class="icheck-control" id="useCreditOnCheckout" type="radio" name="applycredit" value="1" {if $applyCredit} checked{/if}>
                                                            <span id="spanFullCredit" {if !($creditBalance->toNumeric() >= $total->toNumeric())} class="hidden"{/if}>
                                                                {lang key='cart.applyCreditAmountNoFurtherPayment' amount=$total}
                                                            </span>
                                                            <span id="spanUseCredit" {if $creditBalance->toNumeric() >= $total->toNumeric()} class="hidden"{/if}>
                                                                {lang key='cart.applyCreditAmount' amount=$creditBalance}
                                                            </span>
                                                        </label>
                                                    </div>
                                                </div>
                                                <div class="form-group m-b-0">
                                                    <div class="radio">
                                                        <label>
                                                            <input id="skipCreditOnCheckout" class="icheck-control" type="radio" name="applycredit" value="0" {if !$applyCredit} checked{/if}>
                                                            <span>{lang key='cart.applyCreditSkip' amount=$creditBalance}</span>
                                                        </label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
        
                                    {if !$inExpressCheckout}
                                        <div id="paymentGatewaysContainer">
                                            <div class="section">
                                                <div class="panel-group panel-group-condensed m-b-0" data-inputs-container>
                                                    {foreach $gateways as $gateway}
                                                        <div class="panel panel-default {if $selectedgateway eq $gateway.sysname}checked{/if} {$gateway.sysname|lower|replace:" ":"-"}" data-virtual-input>
                                                            <div class="panel-heading check">
                                                                <label>
                                                                    <input type="radio" name="paymentmethod" value="{$gateway.sysname}" data-payment-type="{$gateway.payment_type}" data-show-local="{$gateway.show_local_cards}" data-remote-inputs="{$gateway.uses_remote_inputs}" class="icheck-control payment-methods{if $gateway.type eq "CC"} is-credit-card{/if}" {if $selectedgateway eq $gateway.sysname} checked{/if} />
                                                                    <div class="check-content">
                                                                        <span>{$gateway.name}</span>
                                                                    </div>
                                                                    {assign var=gatewayIcon value=$gateway.sysname|lower|replace:" ":"-"}
                                                                    <span class="check-icon" data-gateway-icon-name="{$gatewayIcon}">
                                                                        {if file_exists("templates/$template/core/styles/{$RSThemes.styles.name}/assets/img/gateways/{$gatewayIcon}.png")}
                                                                            <img src="templates/{$template}/core/styles/{$RSThemes.styles.name}/assets/img/gateways/{$gatewayIcon}.png" alt="" />
                                                                        {elseif file_exists("templates/$template/core/styles/{$RSThemes.styles.name}/assets/img/gateways/{$gatewayIcon}.svg")}
                                                                            <img src="templates/{$template}/core/styles/{$RSThemes.styles.name}/assets/img/gateways/{$gatewayIcon}.svg" alt="" />
                                                                        {elseif file_exists("templates/$template/assets/svg-icon/gateway-$gatewayIcon.tpl")}
                                                                            {include file="$template//assets/svg-icon/gateway-$gatewayIcon.tpl"}
                                                                        {/if}
                                                                    </span>
                                                                </label>
                                                            </div>
                                                        </div>
                                                    {/foreach}
                                                </div>
                                                <div class="alert alert-danger text-center gateway-errors w-hidden m-t-40"></div>
                                            </div>
            
                                            <div class="section {if $selectedgatewaytype neq "CC"}hidden{/if}" id="creditCardInputFields">
                                                <h3>{$LANG.orderForm.paymentDetails}</h3>
                                                <div class="panel panel-form panel-default" data-input-collapse role="tabpanel">
                                                    <div class="cc-input-container">
                                                        {if $client && $client->payMethods->count() !== 0}
                                                            <ul class="nav nav-tabs">
                                                                <li class="active">
                                                                    <a href="#existingCardsContainer" data-radio-tab aria-expanded="true">
                                                                        {$LANG.creditcarduseexisting}
                                                                    </a>
                                                                </li>
                                                                <li>
                                                                    <a href="#newCardInfoTab" data-radio-tab data-radio-target="#new" aria-expanded="true">
                                                                        {$LANG.creditcardenternewcard}
                                                                    </a>
                                                                </li>
                                                            </ul>
                                                        {else}
                                                            <label class="hidden">
                                                                <input type="radio" name="ccinfo" class="icheck-control" value="new" id="new" {if !$client || $client->payMethods->count() === 0} checked="checked"{/if} />
                                                            </label>
                                                        {/if}
                                                        <div class="panel-body">
                                                            {if $client && $client->payMethods->count() !== 0}
                                                                <div class="tab-content">
                                                                    <div id="existingCardsContainer" class="tab-pane existing-cc-grid active">
                                                                        {include file="orderforms/{$carttpl}/includes/existing-paymethods.tpl"}
                                                                        <div class="row cvv-input" id="existingCardInfo">
                                                                            <div class="col-sm-4">
                                                                                <div class="form-group">
                                                                                    <label for="inputCardCvvExisting" class="control-label">{$LANG.creditcardcvvnumbershort}</label>
                                                                                    <div class="form-tooltip">
                                                                                        <input type="tel" name="cccvv" id="inputCardCVV2" class="form-control" autocomplete="cc-cvc">
                                                                                        <i class="ls ls-info-circle tooltip-icon" data-cc-popover-show></i>
                                                                                        <div data-cc-popover class="popover top">
                                                                                            <div class="arrow"></div>
                                                                                            <div class="popover-content">
                                                                                                <img src='{$BASE_PATH_IMG}/ccv.gif' width='180' />
                                                                                            </div>
                                                                                        </div>
                                                                                    </div>
                                                                                    <span class="field-error-msg help-block">{lang key="paymentMethodsManage.cvcNumberNotValid"}</span>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div id="newCardInfoTab" class="tab-pane {if $client->payMethods->count() === 0}active{/if}">
                                                                        <span class="hidden">
                                                                            <input type="radio" name="ccinfo" class="icheck-control"  value="new" id="new" {if !$client || $client->payMethods->count() === 0} checked="checked"{/if} />
                                                                        </span>
                                                                    {/if}
                                                                    <div id="newCardInfo">
                                                                        <div class="row">
                                                                            <div class="col-sm-6 new-card-container" id="cardNumberContainer">
                                                                                <div class="form-group fieldgroup-creditcard">
                                                                                    <label class="control-label">{$LANG.creditcardcardnumber}</label>
                                                                                    <input type="tel" name="ccnumber" id="inputCardNumber" class="form-control field cc-number-field" placeholder="{$LANG.orderForm.cardNumber}" autocomplete="cc-number" data-message-unsupported="{lang key='paymentMethodsManage.unsupportedCardType'}" data-message-invalid="{lang key='paymentMethodsManage.cardNumberNotValid'}" data-supported-cards="{$supportedCardTypes}">
                                                                                </div>
                                                                            </div>
                                                                            <div id="inputDescriptionContainer" class="col-md-6">
                                                                                <div class="form-group">
                                                                                    <label for="inputDescription" class="control-label">
                                                                                        {$LANG.paymentMethods.descriptionInput} {$LANG.paymentMethodsManage.optional}
                                                                                    </label>
                                                                                    <input type="text" class="form-control" id="inputDescription" name="ccdescription" autocomplete="off" value="" />
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        {if $showccissuestart}
                                                                            <div class="row">
                                                                                <div class="col-sm-6 new-card-container">
                                                                                    <div class="form-group">
                                                                                        <label for="inputCardStart" class="control-label">
                                                                                            {$LANG.creditcardcardstart}
                                                                                        </label>
                                                                                        <input type="tel" name="ccstartdate" id="inputCardStart" class="form-control" placeholder="MM / YY ({$LANG.creditcardcardstart})" autocomplete="cc-exp">
                                                                                    </div>
                                                                                </div>
                                                                                <div class="col-sm-6 new-card-container">
                                                                                    <div class="form-group">
                                                                                        <label for="inputCardIssue" class="control-label">
                                                                                            {$LANG.creditcardcardissuenum}
                                                                                        </label>
                                                                                        <input type="tel" name="ccissuenum" id="inputCardIssue" class="form-control" placeholder="{$LANG.creditcardcardissuenum}">
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        {/if}
                                                                        <div class="row">
                                                                            <div class="col-sm-6">
                                                                                <div class="form-group">
                                                                                    <label for="inputCardExpiry" class="control-label">
                                                                                        {$LANG.creditcardcardexpires}
                                                                                    </label>
                                                                                    <input type="tel" name="ccexpirydate" id="inputCardExpiry" class="form-control" placeholder="MM / YY{if $showccissuestart} ({$LANG.creditcardcardexpires}){/if}" autocomplete="cc-exp">
                                                                                </div>
                                                                            </div>
                                                                            <div class="col-sm-4" id="cvv-field-container">
                                                                                <div class="form-group">
                                                                                    <label for="inputCardCVV" class="control-label">
                                                                                        {$LANG.creditcardcvvnumbershort}
                                                                                    </label>
                                                                                    <div class="form-tooltip">
                                                                                        <input type="tel" name="cccvv" id="inputCardCVV" class="form-control" autocomplete="cc-cvc">
                                                                                        <i class="ls ls-info-circle tooltip-icon" data-cc-popover-show></i>
                                                                                        <div data-cc-popover class="popover top">
                                                                                            <div class="arrow"></div>
                                                                                            <div class="popover-content">
                                                                                                <img src='{$BASE_PATH_IMG}/ccv.gif' width='180' />
                                                                                            </div>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div id="#newCardSaveSettings">
                                                                            {if $allowClientsToRemoveCards}
                                                                                <div class="new-card-container" id="inputNoStoreContainer">
                                                                                    <input type="hidden" name="nostore" value="1">
                                                                                    <div class="checkbox">
                                                                                        <input class="icheck-control" type="checkbox" checked="checked" name="nostore" id="inputNoStore" value="0">
                                                                                        {$LANG.creditCardStore}
                                                                                    </div>
                                                                                </div>
                                                                            {/if}
                                                                        </div>
                                                                    </div>
                                                                    {if $client && $client->payMethods->count() !== 0}
                                                                    </div>
                                                                </div>
                                                            {/if}
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    {else}
                                        {if $expressCheckoutOutput}
                                            {$expressCheckoutOutput}
                                        {else}
                                            <p align="center">
                                                {lang key='paymentPreApproved' gateway=$expressCheckoutGateway}
                                            </p>
                                        {/if}
                                    {/if}
                                </div>
                                {if $showMarketingEmailOptIn}
                                    <div class="section">
                                        <h3>{lang key='emailMarketing.joinOurMailingList'}</h3>
                                        <p>{$marketingEmailOptInMessage}</p>
                                        <div class="panel panel-switch m-w-288{if $marketingEmailOptIn} checked{/if}">
                                            <div class="panel-body">
                                                <span class="switch-label">{$rslang->trans('generals.receive_emails')}</span>
                                                <label class="switch switch--lg switch--text">
                                                    <input class="switch__checkbox" type="checkbox" name="marketingoptin" value="1" {if $marketingEmailOptIn} checked{/if}>
                                                    <span class="switch__container"><span class="switch__handle"></span></span>
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                {/if}
                                {if $shownotesfield}
                                    <div class="section">
                                        <h3>{$LANG.orderForm.additionalNotes}</h3>
                                        <textarea name="notes" class="form-control" rows="4" placeholder="{$LANG.ordernotesdescription}">{$orderNotes}</textarea>
                                    </div>
                                {/if}
                                {if $captcha}
                                    {include file="$template/includes/captcha.tpl"}
                                {/if}
                                {if $accepttos}
                                    <div class="section">
                                        <div class="checkbox">
                                            <label>
                                                <input class="icheck-control" type="checkbox" name="accepttos" id="accepttos" />
                                                <span>{$LANG.ordertosagreement} <a href="{$tosurl}" target="_blank">{$LANG.ordertos}</a></span>
                                            </label>
                                        </div>
                                    </div>
                                {/if}
                                {if $servedOverSsl}
                                    <div class="section">
                                        <div class="alert alert-warning checkout-security-msg">
                                            <div class="alert-body">
                                                <i class="ls ls-lock"></i>
                                                {$LANG.ordersecure} (<strong>{$ipaddress}</strong>) {$LANG.ordersecure2}
                                            </div>
                                        </div>
                                    </div>
            
                                {/if}
                                <button type="submit" id="submit-checkout" class="hidden btn btn-primary btn-lg {if $captcha}{$captcha->getButtonClass($captchaForm)}{/if}">
                                    {$LANG.completeorder}
                                </button>
                            </form>
                            <script type="text/javascript" src="{$BASE_PATH_JS}/jquery.payment.js"></script>
                            {literal}
                                <script type="text/javascript">
                                    if ($('.gateway-errors').length > 0) {
                                        function mutate(mutations) {
                                            mutations.forEach(function (mutation) {
                                                
                                                if ($(mutation.target).hasClass('hidden')) {
                                                    //$('#submit-checkout').trigger('click');
                                                } else {
                                                    $('#checkout .loader').addClass('hidden');
                                                    $('#checkout span').removeClass('invisible hidden');
                                                    $('#checkout2 .loader').addClass('hidden');
                                                    $('#checkout2 span').removeClass('invisible hidden');
                                                }
                                            });
                                        }

                                        var MutationObserver = window.MutationObserver || window.WebKitMutationObserver || window.MozMutationObserver;
                                        var target = document.querySelector('.gateway-errors');
                                        var observer = new MutationObserver(mutate);
                                        var config = {characterData: false, attributes: false, childList: true, subtree: true};
                                        observer.observe(target, config);
                                    }                 
                                </script>
                            {/literal}
                        {/if}
                </div>
                <div class="order-sidebar" id="">
                    <div id="sticky-sidebar">
                        <div class="sticky-sidebar-inner">
                            <div class="order-summary" id="orderSummary">
                                <div class="loader" id="orderSummaryLoader" style="display: none;">
                                    {include file="$template/includes/loader.tpl" classes="spinner-sm spinner-light"}
                                </div>
                                <h2>{$LANG.ordersummary}</h2>
                                <div class="summary-container">
                                    <div class="content">
                                        <ul class="order-summary-list">
                                            <li class="list-item" data-subtotal>
                                                <span class="item-name">{$LANG.ordersubtotal}</span>
                                                <span class="item-value">{$subtotal}</span>
                                            </li>
                                        </ul>
                                        {if $promotioncode || $taxrate || $taxrate2}
                                            <ul class="order-summary-list faded">
                                                {if $taxrate}
                                                    <li class="list-item">
                                                        <span class="item-name">{$taxname} @ {$taxrate}%</span>
                                                        <span class="item-value" id="taxTotal1">{$taxtotal}</span>
                                                    </li>
                                                {/if}
                                                {if $taxrate2}
                                                    <li class="list-item">
                                                        <span class="item-name">{$taxname2} @ {$taxrate2}%</span>
                                                        <span class="item-value" id="taxTotal2">{$taxtotal2}</span>
                                                    </li>
                                                {/if}
                                                {if $promotioncode}
                                                    <li class="list-item light">
                                                        <span class="item-name">{$promotiondescription}</span>
                                                        <span class="item-value">{$discount}</span>
                                                    </li>
                                                {/if}
                                            </ul>
                                        {/if}
                                        <ul class="order-summary-list" id="recurring">
                                            <li class="list-item faded">{$LANG.orderForm.totals}</li>
                                            <li class="list-item" id="recurringMonthly" {if !$totalrecurringmonthly}style="display:none;" {/if}>
                                                <span class="item-name">{$LANG.orderpaymenttermmonthly}</span>
                                                <span class="item-value">{$totalrecurringmonthly}</span>
                                            </li>
                                            <li class="list-item" id="recurringQuarterly" {if !$totalrecurringquarterly}style="display:none;" {/if}>
                                            <li class="list-item" id="recurringQuarterly" {if !$totalrecurringquarterly}style="display:none;" {/if}>
                                                <span class="item-name">{$LANG.orderpaymenttermquarterly}</span>
                                                <span class="item-value">{$totalrecurringquarterly}</span>
                                            </li>
                                            <li class="list-item" id="recurringSemiAnnually" {if !$totalrecurringsemiannually}style="display:none;" {/if}>
                                                <span class="item-name">{$LANG.orderpaymenttermsemiannually}</span>
                                                <span class="item-value">{$totalrecurringsemiannually}</span>
                                            </li>
                                            <li class="list-item" id="recurringAnnually" {if !$totalrecurringannually}style="display:none;" {/if}>
                                                <span class="item-name">{$LANG.orderpaymenttermannually}</span>
                                                <span class="item-value">{$totalrecurringannually}</span>
                                            </li>
                                            <li class="list-item" id="recurringBiennially" {if !$totalrecurringbiennially}style="display:none;" {/if}>
                                                <span class="item-name">{$LANG.orderpaymenttermbiennially}</span>
                                                <span class="item-value">{$totalrecurringbiennially}</span>
                                            </li>
                                            <li class="list-item" id="recurringTriennially" {if !$totalrecurringtriennially}style="display:none;" {/if}>
                                                <span class="item-name">{$LANG.orderpaymenttermtriennially}</span>
                                                <span class="item-value">{$totalrecurringtriennially}</span>
                                            </li>
                                        </ul>
                                    </div>
                                    <div class="total-due-today" data-total>
                                        <div class="content">
                                            <span id="totalDueToday" class="amt">{$total}</span>
                                            <span class="total-due-today-text">{$LANG.ordertotalduetoday}</span>
                                        </div>
                                        <div class="basket-icon">
                                            <i class="ls ls-basket"></i>
                                        </div>
                                    </div>
                                    <div class="order-summary-actions">
                                        <button type="button" class="btn btn btn-info btn-checkout{if $cartitems == 0} disabled{/if}" {if $cartitems==0} disabled{/if} data-btn-loader id="checkout">
                                            <span>
                                                <i class="ls ls-share"></i>{$LANG.orderForm.checkout}
                                            </span>
                                            <div class="loader loader-button hidden">
                                                {include file="$template/includes/loader.tpl" classes="spinner-sm"}
                                            </div>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
    
            <div class="order-summary order-summary-mob" id="orderSummary">
                <div class="loader" id="orderSummaryLoaderMob" style="display: none;">
                    {include file="$template/includes/loader.tpl" classes="spinner-sm spinner-light"}
                </div>
                <h2>{$LANG.ordersummary}</h2>
                <div class="summary-container">
                    <div class="content">
                        <ul class="order-summary-list">
                            <li class="list-item">
                                <span class="item-name">{$LANG.ordersubtotal}</span>
                                <span class="item-value" id="subtotal">{$subtotal}</span>
                            </li>
                        </ul>
                        {if $promotioncode || $taxrate || $taxrate2}
                            <ul class="order-summary-list faded">
                                {if $taxrate}
                                    <li class="list-item">
                                        <span class="item-name">{$taxname} @ {$taxrate}%</span>
                                        <span class="item-value" id="taxTotal1Mob">{$taxtotal}</span>
                                    </li>
                                {/if}
                                {if $taxrate2}
                                    <li class="list-item">
                                        <span class="item-name">{$taxname2} @ {$taxrate2}%</span>
                                        <span class="item-value" id="taxTotal2Mob">{$taxtotal2}</span>
                                    </li>
                                {/if}
                                {if $promotioncode}
                                    <li class="list-item light">
                                        <span class="item-name">{$promotiondescription}</span>
                                        <span class="item-value">{$discount}</span>
                                    </li>
                                {/if}
                            </ul>
                        {/if}
                        <ul class="order-summary-list" id="recurringMob">
                            <li class="list-item faded">{$LANG.orderForm.totals}</li>
                            <li class="list-item" id="recurringMobMonthly" {if !$totalrecurringmonthly}style="display:none;" {/if}>
                                <span class="item-name">{$LANG.orderpaymenttermmonthly}</span>
                                <span class="item-value">{$totalrecurringmonthly}</span>
                            </li>
                            <li class="list-item" id="recurringMobQuarterly" {if !$totalrecurringquarterly}style="display:none;" {/if}>
                                <span class="item-name">{$LANG.orderpaymenttermquarterly}</span>
                                <span class="item-value">{$totalrecurringquarterly}</span>
                            </li>
                            <li class="list-item" id="recurringMobSemiAnnually" {if !$totalrecurringsemiannually}style="display:none;" {/if}>
                                <span class="item-name">{$LANG.orderpaymenttermsemiannually}</span>
                                <span class="item-value">{$totalrecurringsemiannually}</span>
                            </li>
                            <li class="list-item" id="recurringMobAnnually" {if !$totalrecurringannually}style="display:none;" {/if}>
                                <span class="item-name">{$LANG.orderpaymenttermannually}</span>
                                <span class="item-value">{$totalrecurringannually}</span>
                            </li>
                            <li class="list-item" id="recurringMobBiennially" {if !$totalrecurringbiennially}style="display:none;" {/if}>
                                <span class="item-name">{$LANG.orderpaymenttermbiennially}</span>
                                <span class="item-value">{$totalrecurringbiennially}</span>
                            </li>
                            <li class="list-item" id="recurringMobTriennially" {if !$totalrecurringtriennially}style="display:none;" {/if}>
                                <span class="item-name">{$LANG.orderpaymenttermtriennially}</span>
                                <span class="item-value">{$totalrecurringtriennially}</span>
                            </li>
                        </ul>
                    </div>
                    <div class="total-due-today">
                        <div class="content">
                            <span id="totalDueTodayMob" class="amt">{$total}</span>
                            <span class="total-due-today-text">{$LANG.ordertotalduetoday}</span>
                        </div>
                        <button type="button" class="btn btn-icon btn-primary btn-rounded btn-sm">
                            <i class="fa fa-chevron-up"></i>
                        </button>
                    </div>
                    <div class="order-summary-actions">
                        <button type="button" class="btn btn btn-info btn-checkout{if $cartitems == 0} disabled{/if}" {if $cartitems==0} disabled{/if} data-btn-loader id="checkout2">
                            <span>
                                <i class="ls ls-share"></i>{$LANG.orderForm.checkout}
                            </span>
                            <div class="loader loader-button hidden">
                                {include file="$template/includes/loader.tpl" classes="spinner-sm"}
                            </div>
                        </button>
                    </div>
                </div>
            </div>
    
            <form method="post" action="cart.php">
                <input type="hidden" name="a" value="remove" />
                <input type="hidden" name="r" value="" id="inputRemoveItemType" />
                <input type="hidden" name="i" value="" id="inputRemoveItemRef" />
                <div class="modal fade modal-remove-item" id="modalRemoveItem" tabindex="-1" role="dialog">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="{$LANG.orderForm.close}">
                                    <span aria-hidden="true"><i class="lm lm-close"></i></span>
                                </button>
                                <h3 class="modal-title">
                                    <span>{$LANG.orderForm.removeItem}</span>
                                </h3>
                            </div>
                            <div class="modal-body">
                                {$LANG.cartremoveitemconfirm}
                            </div>
                            <div class="modal-footer">
                                <button type="submit" class="btn btn-primary">{$LANG.yes}</button>
                                <button type="button" class="btn btn-default" data-dismiss="modal">{$LANG.no}</button>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
    
            <form method="post" action="cart.php">
                <input type="hidden" name="a" value="empty" />
                <div class="modal fade modal-remove-item" id="modalEmptyCart" tabindex="-1" role="dialog">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="{$LANG.orderForm.close}">
                                    <span aria-hidden="true"><i class="lm lm-close"></i></span>
                                </button>
                                <h3 class="modal-title">
                                    <span>{$LANG.emptycart}</span>
                                </h3>
                            </div>
                            <div class="modal-body">
                                {$LANG.cartemptyconfirm}
                            </div>
                            <div class="modal-footer">
                                <button type="submit" class="btn btn-primary">{$LANG.yes}</button>
                                <button type="button" class="btn btn-default" data-dismiss="modal">{$LANG.no}</button>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
            {if $taxenabled && !$loggedin}
                <form method="post" action="cart.php?a=setstateandcountry">
                    <div class="modal modal-lg fade" id="estimate-taxes">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true"><i class="lm lm-close"></i></span>
                                    </button>
                                    <h3 class="modal-title">{$LANG.orderForm.estimateTaxes}</h3>
                                </div>
                                <div class="modal-body">
                                    <div class="row">
                                        <div class="col-sm-6">
                                            <div class="form-group">
                                                <label for="inputState2" class="control-label">{$LANG.orderForm.state}</label>
                                                <input type="text" name="state" id="inputState2" value="{$clientsdetails.state}" class="form-control" {if $loggedin} disabled="disabled" {/if} />
                                            </div>
                                        </div>
                                        <div class="col-sm-6">
                                            <div class="form-group">
                                                <label for="inputCountry2" class="control-label">{$LANG.orderForm.country}</label>
                                                <select name="country" id="inputCountry2" class="form-control">
                                                    {foreach $countries as $countrycode => $countrylabel}
                                                        <option value="{$countrycode}" {if (!$country && $countrycode==$defaultcountry) || $countrycode eq $country} selected{/if}>
                                                            {$countrylabel}
                                                        </option>
                                                    {/foreach}
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="submit" class="btn btn-primary">{$LANG.orderForm.updateTotals}</button>
                                    <button type="button" class="btn btn-default" data-dismiss="modal">{$LANG.orderForm.cancel}</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            {/if}
        {/if}