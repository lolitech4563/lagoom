{if isset($RSThemes['pages']['configureproduct'])}
    {include file=$RSThemes['pages']['configureproduct']['fullPath']}
{else}      
    {include file="orderforms/$carttpl/common.tpl"}

    <script>
    var _localLang = {
        'addToCart': '{$LANG.orderForm.addToCart|escape}',
        'addedToCartRemove': '{$LANG.orderForm.addedToCartRemove|escape}'
    }
    </script>

    <form id="frmConfigureProduct">
        <input type="hidden" name="configure" value="true" />
        <input type="hidden" name="i" value="{$i}" />
        <div class="main-content">
            <div class="order-content">
                <div class="section">
                    <div class="section-header">
                        <p class="section-desc">{$LANG.orderForm.configureDesiredOptions}</p>
                    </div>
                    <div class="alert alert-danger hidden" role="alert" id="containerProductValidationErrors">
                        <div class="alert-body">
                            <p>{$LANG.orderForm.correctErrors}:</p>
                            <ul id="containerProductValidationErrorsList"></ul>
                        </div>
                    </div>
                    <div class="panel panel-default panel-form">
                        <div class="panel-body">
                            <div class="domain-information">
                                <div class="domain-information-title">                                      
                                    <h2>{$productinfo.group_name} - {$productinfo.name}</h2>
                                </div>
                            </div>
                            <div class="product-info">
                                {$productinfo.description}
                            </div>
                        </div>
                    </div>
                </div>
                {if $pricing.type eq "recurring"}
                    {assign var='recurringCount' value=0} 

                    {foreach item=cl from=$pricing.cycles name=foo}
                        {assign var='recurringCount' value=$recurringCount + 1} 
                    {/foreach}

                    {if $pricing.monthly}
                        {assign var='mincycle' value="monthly"}
                        {assign var='minimalprice' value=$pricing.rawpricing.monthly}
                    {elseif $pricing.quarterly}
                        {assign var='mincycle' value="quarterly"}
                        {math assign="minimalprice" equation="y/3" y=$pricing.rawpricing.quarterly}
                    {elseif $pricing.semiannually}
                        {assign var='mincycle' value="semiannually"}
                        {math assign="minimalprice" equation="y/6" y=$pricing.rawpricing.semiannually} 
                    {elseif $pricing.annually}
                        {assign var='mincycle' value="annually"}
                        {math assign="minimalprice" equation="y/12" y=$pricing.rawpricing.annually} 
                    {elseif $pricing.biennially}
                        {assign var='mincycle' value="biennially"}
                        {math assign="minimalprice" equation="y/24" y=$pricing.rawpricing.biennially} 
                    {elseif $pricing.triennially}    
                        {assign var='mincycle' value="triennially"}
                        {math assign="minimalprice" equation="y/36" y=$pricing.rawpricing.triennially} 
                    {/if}
                    {if $pricing.quarterly}
                        {math assign="check_discount_quarterly" equation="100-((y/(x*3))*100)" x=$minimalprice y=$pricing.rawpricing.quarterly format="%d"}
                    {else}
                        {assign var='check_discount_quarterly' value="0"}
                    {/if}

                    {if $pricing.semiannually}
                        {math assign="check_discount_semiannually" equation="100-((y/(x*6))*100)" x=$minimalprice y=$pricing.rawpricing.semiannually format="%d"}
                    {else}
                        {assign var='check_discount_semiannually' value="0"}
                    {/if}
                    {if $pricing.annually}
                        {math assign="check_discount_annually" equation="100-((y/(x*12))*100)" x=$minimalprice y=$pricing.rawpricing.annually format="%d"}
                    {else}
                        {assign var='check_discount_annually' value="0"}
                    {/if}
                    {if $pricing.biennially}
                        {math assign="check_discount_biennially" equation="100-((y/(x*24))*100)" x=$minimalprice y=$pricing.rawpricing.biennially format="%d"}
                    {else}
                        {assign var='check_discount_biennially' value="0"}    
                    {/if}
                    {if $pricing.triennially}
                        {math assign="check_discount_triennially" equation="100-((y/(x*36))*100)" x=$minimalprice y=$pricing.rawpricing.triennially format="%d"}
                    {else}
                        {assign var='check_discount_triennially' value="0"}      
                    {/if}
                    {if $check_discount_quarterly > 0 || $check_discount_semiannually > 0 || $check_discount_annually > 0 || $check_discount_biennially > 0 || $check_discount_triennially > 0}
                        {assign var="show_discount" value=true}
                    {/if}
                        
                    <div class="section {if $recurringCount == 1}hidden{/if}" id="sectionCycles">
                        <h3>{$LANG.cartchoosecycle}</h3>
                        <div class="row row-eq-height m-b-neg-24" data-inputs-container>
                            {if $pricing.monthly}
                                <div class="col-sm-4">
                                    <div class="panel panel-check {if $billingcycle eq "monthly"} checked{/if} m-b-24" data-virtual-input >
                                        <div class="check check-cycle">
                                            <label {if $configurableoptions}data-update-config data-config-i={$i} data-config-val="monthly"{else}data-change-billingcycle{/if}>
                                                <input class="icheck-control" type="radio" value="monthly" name="billingcycle" {if $billingcycle eq "monthly"} checked{/if}>
                                                <div class="check-content">
                                                    {if $pricing.monthly|strstr:$LANG.orderpaymentterm1month}
                                                        <h6 class="check-title">{$LANG.orderpaymenttermmonthly} <br> {$pricing.monthly|replace:$LANG.orderpaymentterm1month:""|replace:"-":""}</h6>
                                                    {else}
                                                        <h6 class="check-title">{$LANG.orderpaymenttermmonthly} <br> {$pricing.monthly|replace:$LANG.orderpaymenttermmonthly:""}</h6>
                                                    {/if}
                                                    {if !$DiscountCenterAddonIsActive && $show_discount}
                                                        <p class="check-subtitle">-</p>
                                                    {/if}
                                                </div>
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            {/if}
                            {if $pricing.quarterly}
                                <div class="col-sm-4">
                                    <div class="panel panel-check {if $billingcycle eq "quarterly"} checked{/if} m-b-24" data-virtual-input >
                                        <div class="check check-cycle">
                                            <label {if $configurableoptions}data-update-config data-config-i={$i} data-config-val="quarterly"{else}data-change-billingcycle{/if}>
                                                <input class="icheck-control" type="radio" value="quarterly" name="billingcycle" {if $billingcycle eq "quarterly"} checked{/if}>
                                                <div class="check-content">
                                                    {if $pricing.quarterly|strstr:$LANG.orderpaymentterm3month}
                                                        <h6 class="check-title">{$LANG.orderpaymenttermquarterly} <br> {$pricing.quarterly|replace:$LANG.orderpaymentterm3month:""|replace:"-":""}</h6>
                                                    {else}
                                                         <h6 class="check-title">{$LANG.orderpaymenttermquarterly} <br> {$pricing.quarterly|replace:$LANG.orderpaymenttermquarterly:""}</h6>
                                                    {/if}
                                                   
                                                    {if !$DiscountCenterAddonIsActive}                                                       
                                                        {if $mincycle eq "quarterly" && $show_discount}
                                                            <p class="check-subtitle"> 
                                                                -
                                                            </p>
                                                        {else}                                                            
                                                            {math assign="price_save" equation="100-((y/(x*3))*100)" x=$minimalprice y=$pricing.rawpricing.quarterly format="%d"}
                                                            {if $price_save > 0}
                                                                <p class="check-subtitle"> 
                                                                    <span class="save">{$rslang->trans('order.price_save')} {$price_save}%</span>
                                                                </p>
                                                            {elseif $show_discount}
                                                                <p class="check-subtitle"> 
                                                                    -
                                                                </p>
                                                            {/if} 
                                                        {/if}    
                                                    {/if}
                                                </div>
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            {/if}
                            {if $pricing.semiannually}
                                <div class="col-sm-4">
                                    <div class="panel panel-check {if $billingcycle eq "semiannually"} checked{/if} m-b-24" data-virtual-input >
                                        <div class="check check-cycle">
                                            <label {if $configurableoptions}data-update-config data-config-i={$i} data-config-val="semiannually"{else}data-change-billingcycle{/if}>
                                                <input class="icheck-control" type="radio" name="billingcycle" value="semiannually"{if $billingcycle eq "semiannually"} checked{/if}>
                                                <div class="check-content">
                                                    {if $pricing.semiannually|strstr:$LANG.orderpaymentterm6month}
                                                        <h6 class="check-title">{$LANG.orderpaymenttermsemiannually} <br> {$pricing.semiannually|replace:$LANG.orderpaymentterm6month:""|replace:"-":""}</h6>
                                                    {else}
                                                        <h6 class="check-title">{$LANG.orderpaymenttermsemiannually} <br> {$pricing.semiannually|replace:$LANG.orderpaymenttermsemiannually:""}</h6>
                                                    {/if}
                                                    {if !$DiscountCenterAddonIsActive}                                                                                                             
                                                        {if $mincycle eq "semiannually" && $show_discount}
                                                            <p class="check-subtitle"> 
                                                                -
                                                            </p>
                                                        {else}
                                                            {math assign="price_save" equation="100-((y/(x*6))*100)" x=$minimalprice y=$pricing.rawpricing.semiannually format="%d"}
                                                            {if $price_save > 0}
                                                                <p class="check-subtitle"> 
                                                                    <span class="save">{$rslang->trans('order.price_save')} {$price_save}%</span>
                                                                </p>
                                                            {elseif $show_discount}
                                                                <p class="check-subtitle"> 
                                                                    -
                                                                </p>
                                                            {/if}
                                                        {/if}    
                                                        
                                                    {/if}
                                                </div>
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            {/if}
                            {if $pricing.annually}
                                <div class="col-sm-4">
                                    <div class="panel panel-check {if $billingcycle eq "annually"} checked{/if} m-b-24" data-virtual-input >
                                        <div class="check check-cycle">
                                            <label {if $configurableoptions}data-update-config data-config-i={$i} data-config-val="annually"{else}data-change-billingcycle{/if}>
                                                <input class="icheck-control" type="radio" name="billingcycle" value="annually"{if $billingcycle eq "annually"} checked{/if}>
                                                <div class="check-content">
                                                    {if $pricing.annually|strstr:$LANG.orderpaymentterm12month}
                                                        <h6 class="check-title">{$LANG.orderpaymenttermannually} <br> {$pricing.annually|replace:$LANG.orderpaymentterm12month:""|replace:"-":""}</h6>
                                                    {else}
                                                        <h6 class="check-title">{$LANG.orderpaymenttermannually} <br> {$pricing.annually|replace:$LANG.orderpaymenttermannually:""}</h6>
                                                    {/if}
                                                    
                                                    {if !$DiscountCenterAddonIsActive}                                                                                                         
                                                        {if $mincycle eq "annually" && $show_discount}
                                                            <p class="check-subtitle">    
                                                                -
                                                            </p>
                                                        {else}
                                                            {math assign="price_save" equation="100-((y/(x*12))*100)" x=$minimalprice y=$pricing.rawpricing.annually format="%d"}
                                                            {if $price_save > 0}
                                                                <p class="check-subtitle">    
                                                                    <span class="save">{$rslang->trans('order.price_save')} {$price_save}%</span>
                                                                </p>
                                                            {elseif $show_discount}
                                                                <p class="check-subtitle">    
                                                                    -
                                                                </p>
                                                            {/if}
                                                        {/if}     
                                                    {/if}
                                                </div>
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            {/if}
                            {if $pricing.biennially}
                                <div class="col-sm-4">
                                    <div class="panel panel-check {if $billingcycle eq "biennially"} checked{/if} m-b-24" data-virtual-input >
                                        <div class="check check-cycle">
                                            <label {if $configurableoptions}data-update-config data-config-i={$i} data-config-val="biennially"{else}data-change-billingcycle{/if}>
                                                <input class="icheck-control" type="radio" name="billingcycle" value="biennially"{if $billingcycle eq "biennially"} checked{/if}>
                                                <div class="check-content">
                                                    {if $pricing.biennially|strstr:$LANG.orderpaymentterm24month}
                                                        <h6 class="check-title">{$LANG.orderpaymenttermbiennially} <br> {$pricing.biennially|replace:$LANG.orderpaymentterm24month:""|replace:"-":""}</h6>
                                                    {else}
                                                        <h6 class="check-title">{$LANG.orderpaymenttermbiennially} <br> {$pricing.biennially|replace:$LANG.orderpaymenttermbiennially:""}</h6>
                                                    {/if}
                                                    
                                                    {if !$DiscountCenterAddonIsActive}                                                
                                                        {if $mincycle eq "biennially" && $show_discount}
                                                            <p class="check-subtitle">   
                                                                -
                                                            </p>
                                                        {else}
                                                            {math assign="price_save" equation="100-((y/(x*24))*100)" x=$minimalprice y=$pricing.rawpricing.biennially format="%d"}
                                                            {if $price_save > 0}
                                                                <p class="check-subtitle">   
                                                                    <span class="save">{$rslang->trans('order.price_save')} {$price_save}%</span>
                                                                </p>
                                                            {elseif $show_discount}
                                                                <p class="check-subtitle">   
                                                                    -
                                                                </p>
                                                            {/if}
                                                        {/if}      
                                                    {/if}
                                                </div>
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            {/if}
                            {if $pricing.triennially}
                                <div class="col-sm-4">
                                    <div class="panel panel-check {if $billingcycle eq "triennially"} checked{/if} m-b-24" data-virtual-input >
                                        <div class="check check-cycle">
                                            <label {if $configurableoptions}data-update-config data-config-i={$i} data-config-val="triennially"{else}data-change-billingcycle{/if}>
                                                <input class="icheck-control" type="radio" name="billingcycle" value="triennially"{if $billingcycle eq "triennially"} checked{/if}>
                                                <div class="check-content">
                                                    {if $pricing.triennially|strstr:$LANG.orderpaymentterm36month}
                                                        <h6 class="check-title">{$LANG.orderpaymenttermtriennially} <br> {$pricing.triennially|replace:$LANG.orderpaymentterm36month:""|replace:"-":""}</h6>
                                                    {else}
                                                        <h6 class="check-title">{$LANG.orderpaymenttermtriennially} <br>{$pricing.triennially|replace:$LANG.orderpaymenttermtriennially:""}</h6>
                                                    {/if}
                                                    
                                                    {if !$DiscountCenterAddonIsActive}                                                                                                               
                                                        {if $mincycle eq "triennially" && $show_discount}
                                                            <p class="check-subtitle">
                                                                -
                                                            </p>
                                                        {else}
                                                            {math assign="price_save" equation="100-((y/(x*36))*100)" x=$minimalprice y=$pricing.rawpricing.triennially format="%d"}                                                            
                                                            {if $price_save > 0}
                                                                <p class="check-subtitle">
                                                                    <span class="save">{$rslang->trans('order.price_save')} {$price_save}%</span>
                                                                </p>
                                                            {elseif $show_discount}
                                                                <p class="check-subtitle">
                                                                    -
                                                                </p>
                                                            {/if}
                                                        {/if}                                                          
                                                    {/if}
                                                </div>
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            {/if}
                        </div>
                    </div>
                {/if}

                {if count($metrics) > 0}
                    <div class="section">
                        <div class="section-header">
                            <h3 class="section-title">{$LANG.metrics.title}</h3>
                            <p class="section-desc">{$LANG.orderForm.configureDesiredOptions}</p>
                        </div>
                        <ul class="list-group list-group-bordered">
                            {foreach $metrics as $metric}
                                <li class="list-group-item d-flex align-center space-between">
                                    {$metric.displayName}
                                    -
                                    {if count($metric.pricing) > 1}
                                        {$LANG.metrics.startingFrom} {$metric.lowestPrice} / {if $metric.unitName}{$metric.unitName}{else}{$LANG.metrics.unit}{/if}
                                        <button type="button" class="btn btn-default btn-xs" data-toggle="modal" data-target="#modalMetricPricing-{$metric.systemName}">
                                            {$LANG.metrics.viewPricing}
                                        </button>
                                    {elseif count($metric.pricing) == 1}
                                        {$metric.lowestPrice} / {if $metric.unitName}{$metric.unitName}{else}{$LANG.metrics.unit}{/if}
                                        {if $metric.includedQuantity > 0} ({$metric.includedQuantity} {$LANG.metrics.includedNotCounted}){/if}
                                    {/if}
                                    {include file="$template/usagebillingpricing.tpl"}
                                </li>
                            {/foreach}
                        </ul>
                    </div>    
                {/if}

                {if $configurableoptions}
                    <div class="section message message-no-data hidden" id="productConfigurableOptionsLoader">
						<div class="loader">
                             {include file="$template/includes/loader.tpl"}
                        </div>
					</div>
                    <div class="section product-configurable-options" id="productConfigurableOptions">
                        {foreach $configurableoptions as $num => $configoption}
                            {if $configoption.optiontype eq 1}
                                <div class="section">
                                    <h3>{$configoption.optionname}</h3>
                                    <div class="panel panel-default panel-form">
                                        <div class="panel-body">
                                            <select name="configoption[{$configoption.id}]" id="inputConfigOption{$configoption.id}" class="form-control">
                                                {foreach key=num2 item=options from=$configoption.options}
                                                    <option value="{$options.id}"{if $configoption.selectedvalue eq $options.id} selected="selected"{/if}>
                                                        {$options.name}
                                                    </option>
                                                {/foreach}
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            {elseif $configoption.optiontype eq 2}
                                <div class="section">
                                    <h3>{$configoption.optionname}</h3>
                                    <div class="row row-eq-height m-b-neg-24" data-inputs-container>
                                        {foreach key=num2 item=options from=$configoption.options}
                                            <div class="col-sm-4">
                                                <div class="panel panel-check {if $configoption.selectedvalue eq $options.id}checked{/if}" data-virtual-input>
                                                    <div class="check">
                                                        <label>
                                                            <input type="radio" class="icheck-control" name="configoption[{$configoption.id}]" value="{$options.id}"{if $configoption.selectedvalue eq $options.id} checked="checked"{/if} />
                                                            <div class="check-content">
                                                                <h6 class="check-title">
                                                                    {if $options.nameonly}
                                                                        {$options.nameonly}
                                                                    {else}
                                                                        {$rslang->trans('generals.enable')}
                                                                    {/if}
                                                                </h6>
                                                                <p class="check-subtitle">
                                                                    {if $options.fullprice == '0.00' && $options.setup != '0.00'}
                                                                    {else}
                                                                        {$currency.prefix}{$options.fullprice}{$currency.suffix}{if $options.setup != '0.00'} + {/if}
                                                                    {/if}
                                                                    {if $options.setup != '0.00'}
                                                                        {$currency.prefix}{$options.setup}{$currency.suffix} {$LANG.ordersetupfee}
                                                                    {/if}
                                                                </p>
                                                            </div>
                                                        </label>
                                                    </div>
                                                </div>      
                                            </div>                               
                                        {/foreach}
                                    </div>
                                </div>
                            {elseif $configoption.optiontype eq 3}
                                <div class="section">
                                    <h3>{$configoption.optionname}</h3>
                                    <div class="row row-eq-height m-b-neg-24" data-inputs-container>
                                        {foreach key=num2 item=options from=$configoption.options}
                                            <div class="col-sm-4">
                                                <div class="panel panel-check {if $configoption.selectedqty} checked{/if}" data-virtual-input>
                                                    <div class="check">
                                                        <label>
                                                            <input class="icheck-control" type="checkbox" name="configoption[{$configoption.id}]" id="inputConfigOption{$configoption.id}" value="1"{if $configoption.selectedqty} checked{/if} />
                                                            <div class="check-content">
                                                                <h6 class="check-title">
                                                                    {if $configoption.options.0.nameonly}
                                                                        {$configoption.options.0.nameonly}
                                                                    {else}
                                                                        {$rslang->trans('generals.enable')}
                                                                    {/if}
                                                                </h6>
                                                                <p class="check-subtitle">
                                                                {if $configoption.options.0.recurring != "0.00"}                                                                 
                                                                        {$currency.prefix}{$configoption.options.0.recurring|string_format:"%.2f"}{$currency.suffix}
                                                                {else}
                                                                    -     
                                                                {/if}
                                                                </p>
                                                            </div>
                                                        </label>
                                                    </div>
                                                </div>      
                                            </div>                               
                                        {/foreach}
                                    </div>
                                </div>                               
                            {elseif $configoption.optiontype eq 4}
                                <div class="section">
                                    <h3>{$configoption.optionname}</h3>
                                    {if $configoption.qtymaximum}
                                        <div class="panel panel-default panel-form panel-range-slider">
                                            <div class="panel-body">
                                                <div>
                                                    {if !$rangesliderincluded}
                                                        <script type="text/javascript" src="{$BASE_PATH_JS}/ion.rangeSlider.min.js"></script>
                                                        <link href="{$BASE_PATH_CSS}/ion.rangeSlider.css" rel="stylesheet">
                                                        <link href="{$BASE_PATH_CSS}/ion.rangeSlider.skinModern.css" rel="stylesheet">
                                                        {assign var='rangesliderincluded' value=true}
                                                    {/if}
                                                    <input type="text" name="configoption[{$configoption.id}]" value="{if $configoption.selectedqty}{$configoption.selectedqty}{else}{$configoption.qtyminimum}{/if}" id="inputConfigOption{$configoption.id}" class="form-control" />
                                                    <script>
                                                        var sliderTimeoutId = null;
                                                        var sliderRangeDifference = {$configoption.qtymaximum} - {$configoption.qtyminimum};
                                                        // The largest size that looks nice on most screens.
                                                        var sliderStepThreshold = 25;
                                                        // Check if there are too many to display individually.
                                                        var setLargerMarkers = sliderRangeDifference > sliderStepThreshold;

                                                        jQuery("#inputConfigOption{$configoption.id}").ionRangeSlider({
                                                            min: {$configoption.qtyminimum},
                                                            max: {$configoption.qtymaximum},
                                                            grid: true,
                                                            grid_snap: setLargerMarkers ? false : true,
                                                            onChange: function() {
                                                                if (sliderTimeoutId) {
                                                                    clearTimeout(sliderTimeoutId);
                                                                }

                                                                sliderTimeoutId = setTimeout(function() {
                                                                    sliderTimeoutId = null;
                                                                    recalctotals();
                                                                }, 250);
                                                            }
                                                        });
                                                    </script>
                                                </div>
                                            </div>    
                                        </div>    
                                    {else}
                                        <div class="panel panel-default panel-form">
                                            <div class="panel-body">
                                                <div class="input-group">
                                                    <input type="number" name="configoption[{$configoption.id}]" value="{if $configoption.selectedqty}{$configoption.selectedqty}{else}{$configoption.qtyminimum}{/if}" id="inputConfigOption{$configoption.id}" min="{$configoption.qtyminimum}" onchange="recalctotals()" onkeyup="recalctotals()" class="form-control form-control-qty" />
                                                    <span class="input-group-addon">
                                                        x {$configoption.options.0.name}
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                    {/if}
                                </div>    
                            {/if}
                        {/foreach}
                    </div>
                {/if}
                {if $RSThemes['addonSettings']['hide_password_fields'] != "displayed"}
                    {assign var="ns_groups" value=","|explode:$RSThemes['addonSettings']['hide_password_fields']}
                    {if $productinfo.gid|in_array:$ns_groups}
                        {assign var="hideServerFields" value=true}
                    {/if}
                {/if}    
                {if $RSThemes['addonSettings']['hide_nameserver_fields'] != "displayed"}
                    {assign var="ns_groups" value=","|explode:$RSThemes['addonSettings']['hide_nameserver_fields']}
                    {if $productinfo['gid']|in_array:$ns_groups}
                        {assign var="hideNSFields" value=true}
                    {/if}
                {/if}

                {if $productinfo.type eq "server"}
                    <div class="section {if $hideNSFields && $hideServerFields}hidden{/if}">
                        <h3>{$LANG.cartconfigserver}</h3>
                        <div class="panel panel-default panel-form">
                            <div class="panel-body">
                                {if $hideServerFields}    
                                    <div class="row hidden">
                                        <div class="col-sm-6">
                                            <div class="form-group">
                                                <label for="inputHostname">{$LANG.serverhostname}</label>
                                                <input type="text" name="hostname" class="form-control" id="inputHostname" value="{$server.hostname}" placeholder="servername.yourdomain.com">
                                            </div>
                                        </div>
                                        {literal}
                                            <script>
                                                function makeid(length) {
                                                    var result = '';
                                                    var characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
                                                    var charactersLength = characters.length;
                                                    for (var i = 0; i < length; i++) {
                                                        result += characters.charAt(Math.floor(Math.random() * charactersLength));
                                                    }
                                                    return result;
                                                }
                                                $(document).ready(function() {
                                                    $('#inputHostname').val('{/literal}{$companyname|lower|replace:" ":""}{literal}-' + makeid(20) + '.com')
                                                });
                                            </script>
                                        {/literal}
                                        <div class="col-sm-6">
                                            <div class="form-group">
                                                <label for="inputRootpw">{$LANG.serverrootpw}</label>
                                                <input type="password" name="rootpw" class="form-control" id="inputRootpw" value="N/A">
                                            </div>
                                        </div>
                                    </div>
                                {else}
                                    <div class="row">
                                        <div class="col-sm-6">
                                            <div class="form-group">
                                                <label for="inputHostname">{$LANG.serverhostname}</label>
                                                <input type="text" name="hostname" class="form-control" id="inputHostname" value="{$server.hostname}" placeholder="servername.yourdomain.com">
                                            </div>
                                        </div>
                                        <div class="col-sm-6">
                                            <div class="form-group">
                                                <label for="inputRootpw">{$LANG.serverrootpw}</label>
                                                <input type="password" name="rootpw" class="form-control" id="inputRootpw" value="{$server.rootpw}">
                                            </div>
                                        </div>
                                    </div>
                                {/if}
                               
                                {if $hideNSFields}
                                    <div class="row hidden">
                                        <div class="col-sm-6">
                                            <div class="form-group">
                                                <label for="inputNs1prefix">{$LANG.serverns1prefix}</label>
                                                <input type="text" name="ns1prefix" class="form-control" id="inputNs1prefix" value="ns1" placeholder="ns1">
                                            </div>
                                        </div>
                                        <div class="col-sm-6">
                                            <div class="form-group">
                                                <label for="inputNs2prefix">{$LANG.serverns2prefix}</label>
                                                <input type="text" name="ns2prefix" class="form-control" id="inputNs2prefix" value="ns2" placeholder="ns2">
                                            </div>
                                        </div>
                                    </div>
                                {else}
                                     <div class="row ">
                                        <div class="col-sm-6">
                                            <div class="form-group">
                                                <label for="inputNs1prefix">{$LANG.serverns1prefix}</label>
                                                <input type="text" name="ns1prefix" class="form-control" id="inputNs1prefix" value="{$server.ns1prefix}" placeholder="ns1">
                                            </div>
                                        </div>
                                        <div class="col-sm-6">
                                            <div class="form-group">
                                                <label for="inputNs2prefix">{$LANG.serverns2prefix}</label>
                                                <input type="text" name="ns2prefix" class="form-control" id="inputNs2prefix" value="{$server.ns2prefix}" placeholder="ns2">
                                            </div>
                                        </div>
                                    </div>
                                {/if}
                            </div>
                        </div>
                    </div>
                {/if}
                {if $customfields}
                    <div class="section">
                        <h3>{$LANG.orderadditionalrequiredinfo}</h3>
                            <div class="panel panel-default panel-form">
                            <div class="panel-body">
                                <div class="row"> 
                                    {foreach $customfields as $customfield}
                                        <div class="col-sm-6">
                                            <div class="form-group"> 
                                                {if $customfield.type eq 'tickbox'}            
                                                    <label class="checkbox" for="customfield{$customfield.id}">
                                                        {$customfield.input|replace:'type="checkbox"':'type="checkbox" class="icheck-control"'}
                                                        {$customfield.name} <span class="required"> {$customfield.required}</span>
                                                    </label>
                                                    {if $customfield.description}<span class="help-block"> {$customfield.description}</span>{/if}
                                                {else}
                                                    <label class="control-label" for="customfield{$customfield.id}">{$customfield.name} <span class="required">{$customfield.required}</span></label>
                                                    {if $customfield.type == "link"}
                                                    <div class="input-group">
                                                        {$customfield.input|replace:"<a":"<a class='input-group-addon'"|replace:"www":"<i class='ls ls-chain'></i>"}
                                                    </div>
                                                    {else}
                                                        {$customfield.input} 
                                                    {/if}
                                                    {if $customfield.description}<span class="help-block">{$customfield.description}</span>{/if}
                                                {/if}
                                            </div>
                                        </div>
                                    {/foreach}  
                                </div>
                            </div>
                        </div>                                 
                    </div>
                {/if}
                    
                {if count($addonsPromoOutput) > 0}
                    {foreach $addonsPromoOutput as $output}
                        {if $output != ""}{assign var="hasVisiblePromoAddons" value=true}{/if}
                    {/foreach} 
                    {if $hasVisiblePromoAddons}
                        <div class="section">
                            <h3>{$LANG.cartavailableaddons}</h3>
                            {foreach $addonsPromoOutput as $output}
                                {$output|replace:"type='radio'":"class='icheck-control'"|replace:"bg-white":""}
                            {/foreach}
                        </div>    
                    {/if}
                {/if}

                {if $addons}
                    <div class="section">
                        <h3>{$rslang->trans('order.additional_services')}</h3>
                        <div class="row row-eq-height m-b-neg-24" data-inputs-container>
                            {foreach $addons as $addon}
                                <div class="col-sm-{if count($addons) > 1}6{else}12{/if}">
                                    <div class="panel panel-check m-b-24 {if $addon.status}checked{/if}" data-virtual-input>
                                        <div class="check">
                                            <label>
                                                <input class="icheck-control" type="checkbox" name="addons[{$addon.id}]"{if $addon.status} checked{/if} />
                                                <div class="check-content">
                                                    <h6 class="check-title">{$addon.name}</h6>
                                                    <p class="check-subtitle">{$addon.pricing}</p>
                                                    <p class="check-desc">{$addon.description}</p>
                                                </div>
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            {/foreach}
                        </div>
                    </div>                   
                {/if}
            </div>

            <div class="order-sidebar">
                <div id="sticky-sidebar">
                    <div class="sticky-sidebar-inner">
                        <div id="orderSummary">
                            <div class="order-summary">
                                <div class="loader" id="orderSummaryLoader">
                                    {include file="$template/includes/loader.tpl" classes="spinner-sm spinner-light"}  
                                </div>
                                <h2>{$LANG.ordersummary}</h2>
                                <div class="summary-container" id="producttotal">
                                
                                </div>
                                <div class="order-summary-actions">
                                    <button type="submit" id="btnCompleteProductConfig" class="btn btn-info btn-checkout">
                                        <span><i class="ls ls-share"></i>{$LANG.continue}</span>
                                        <div class="loader loader-button hidden" >
                                            {include file="$template/includes/loader.tpl" classes="spinner-sm"}  
                                        </div>
                                    </button>
                                </div>
                            </div>
                            <div class="alert alert-info alert-sm alert-panel">
                                <div class="alert-icon ls ls-info-circle"></div>
                                <div class="alert-body">
                                    {$LANG.orderForm.haveQuestionsContact} <a href="contact.php" target="_blank" class="alert-link">{$LANG.orderForm.haveQuestionsClickHere}</a>
                                </div>
                            </div>
                        </div>
                    </div>    
                </div>
            </div>
        </div>
        <div class="order-summary order-summary-mob" id="orderSummaryMob">
            <div class="loader" id="orderSummaryLoaderMob" style="display: none;">
                {include file="$template/includes/loader.tpl" classes="spinner-sm spinner-light"}  
            </div>
            <h2>{$LANG.ordersummary}</h2>
            <div class="summary-container">
                <div class="summary-container" id="producttotalmob">
                            
                </div>
                <div class="order-summary-actions">
                    <button type="submit" id="btnCompleteProductConfigMob" class="btn btn-info btn-checkout">                        
                        <span><i class="ls ls-share"></i>{$LANG.continue}</span>
                        <div class="loader loader-button hidden" >
                            {include file="$template/includes/loader.tpl" classes="spinner-sm"}  
                        </div>
                    </button>    
                </div>
            </div>
        </div>
    </form>

    <script>recalctotals();</script>
{/if}