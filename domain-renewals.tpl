{if isset($RSThemes['pages']['domain-renewals'])}
    {include file=$RSThemes['pages']['domain-renewals']['fullPath']}
{else}      
    {include file="orderforms/$carttpl/common.tpl"}

    <div class="main-sidebar sidebar-primary col-md-3 pull-md-left sidebar hidden-xs hidden-sm">
        {include file="orderforms/$carttpl/sidebar-categories.tpl"}
    </div>

    <div class="main-content col-md-9 pull-md-right">
        {include file="orderforms/$carttpl/sidebar-categories-collapsed.tpl"}
        {if $renewalsData}
        <div class="row row-eq-height">
            <div class="col-md-8 col-sm-12 flex-column">
                <div class="domain-renewals" id="domainRenewals">
                    {foreach $renewalsData as $renewalData}
                        <div class="panel panel-default panel-form domain-renewal {if $renewal_added}domain-renewal-added border-primary{/if}" data-domain="{$renewalData.domain}">
                            <div class="panel-body">
                                <div class="domain-renewal-content">
                                    <h3 class="domain-renewal-title">{$renewalData.domain}</h3>
                                    <div class="domain-renewal-status">
                                        {if !$renewalData.eligibleForRenewal}
                                            <span class="label label-info">
                                                {lang key='domainRenewal.unavailable'}
                                            </span>
                                        {elseif ($renewalData.pastGracePeriod && $renewalData.pastRedemptionGracePeriod)}
                                            <span class="label label-info">
                                                {lang key='domainrenewalspastgraceperiod'}
                                            </span>
                                        {elseif !$renewalData.beforeRenewLimit && $renewalData.daysUntilExpiry > 0}
                                            <span class="label label-{if $renewalData.daysUntilExpiry > 30}success{else}warning{/if}">
                                                {lang key='domainRenewal.expiringIn' days=$renewalData.daysUntilExpiry}
                                            </span>
                                        {elseif $renewalData.daysUntilExpiry === 0}
                                            <span class="label label-warning">
                                                {lang key='expiresToday'}
                                            </span>
                                        {elseif $renewalData.beforeRenewLimit}
                                            <span class="label label-info">
                                                {lang key='domainRenewal.maximumAdvanceRenewal' days=$renewalData.beforeRenewLimitDays}
                                            </span>
                                        {else}
                                            <span class="label label-danger">
                                                {lang key='domainRenewal.expiredDaysAgo' days=$renewalData.daysUntilExpiry*-1}
                                            </span>
                                        {/if}
                                    </div>
                                    <p class="w-100">{lang key='clientareadomainexpirydate'}: {$renewalData.expiryDate->format('j M Y')} ({$renewalData.expiryDate->diffForHumans()})</p>
                                </div>
                                
                                <div class="domain-renewal-form">
                                    {if ($renewalData.pastGracePeriod && $renewalData.pastRedemptionGracePeriod) || !count($renewalData.renewalOptions)}
                                    {else}
                                        <div class="domain-renewal-period">
                                            <select class="form-control select-renewal-pricing" id="renewalPricing{$renewalData.id}" data-domain-id="{$renewalData.id}">
                                                {foreach $renewalData.renewalOptions as $renewalOption}
                                                    <option value="{$renewalOption.period}">
                                                        {$renewalOption.period} {lang key='orderyears'} @ {$renewalOption.rawRenewalPrice}
                                                        {if $renewalOption.gracePeriodFee && $renewalOption.gracePeriodFee->toNumeric() != 0.00}
                                                            + {$renewalOption.gracePeriodFee} {lang key='domainRenewal.graceFee'}
                                                        {/if}
                                                        {if $renewalOption.redemptionGracePeriodFee && $renewalOption.redemptionGracePeriodFee->toNumeric() != 0.00}
                                                            + {$renewalOption.redemptionGracePeriodFee} {lang key='domainRenewal.redemptionFee'}
                                                        {/if}
                                                        {if $renewalData.inGracePeriod || $renewalData.inRedemptionGracePeriod}
                                                            *
                                                        {/if}
                                                    </option>
                                                {/foreach}
                                            </select>
                                        </div>
                                    {/if}
                                    {if !$renewalData.eligibleForRenewal || $renewalData.beforeRenewLimit || ($renewalData.pastGracePeriod && $renewalData.pastRedemptionGracePeriod)}
                                    {else}
                                        <div class="domain-renewal-actions">
                                            <button id="renewDomain{$renewalData.id}" class="btn {if $renewal_added}btn-primary{else}btn-info{/if} btn-add-renewal-to-cart" data-domain-id="{$renewalData.id}">
                                                <div class="loader loader-button">
                                                    {include file="$template/includes/loader.tpl" classes="spinner-sm"}  
                                                </div>
                                                <span class="to-add" {if $renewal_added}style="display: none"{/if}>{lang key='addtocart'}</span>
                                                <span class="added" {if $renewal_added}style="display: block"{/if}>{lang key='domaincheckeradded'}</span>
                                            </button>
                                        </div>
                                    {/if}
                                </div>    
                            </div>
                        </div> 
                    {/foreach}
                </div>
                <div class="message message-danger message-lg message-no-data no-renew hidden">
                    <div class="message-icon">
                        <i class="lm lm-close"></i>
                    </div>
                    <h2 class="message-text">{$LANG.norecordsfound}</h2>
                </div>
            
            </div>
            <div class="col-md-4">
                <div id="sticky-sidebar">
                    <div class="sticky-sidebar-inner">
                        <div class="order-summary" id="orderSummary">
                            <div class="loader" id="orderSummaryLoader">
                                {include file="$template/includes/loader.tpl" classes="spinner-sm spinner-light"}  
                            </div>
                            <h2>{lang key='ordersummary'}</h2>
                            <div class="summary-container" id="producttotal">

                            </div>
                            <div class="order-summary-actions">
                                <a href="{$WEB_ROOT}/cart.php?a=view" class="btn btn-info btn-checkout" id="checkout"><i class="ls ls-share"></i>{$LANG.checkout}</a>
                            </div>
                        </div>
                        {if $hasDomainsInGracePeriod}
                            <small class="text-light m-t-20" style="display: block;">* {lang key='domainRenewal.graceRenewalPeriodDescription'}</small>
                        {/if}
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
                    <a href="{$WEB_ROOT}/cart.php?a=checkout" class="btn btn-info btn-checkout" id="checkout"><i class="ls ls-share"></i>{$LANG.continue}</a>
                </div>
            </div>
        </div>
        {else}
            <div class="message message-no-data">
                <div class="message-image">
                    {include file="$template//assets/svg-icon/domain.tpl"}            
                </div>
                <h6 class="message-text">{lang key='domainRenewal.noDomains'}</h6>
            </div>        
        {/if}
        
    </div>            

    <form id="removeRenewalForm" method="post" action="{$WEB_ROOT}/cart.php">
        <input type="hidden" name="a" value="remove" />
        <input type="hidden" name="r" value="" id="inputRemoveItemType" />
        <input type="hidden" name="i" value="" id="inputRemoveItemRef" />
        <div class="modal fade modal-remove-item" id="modalRemoveItem" tabindex="-1" role="dialog">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="{lang key='orderForm.close'}">
                            <i class="lm lm-close"></i>
                        </button>
                        <h3 class="modal-title">
                            <span>{lang key='orderForm.removeItem'}</span>
                        </h3>
                    </div>
                    <div class="modal-body">
                        {lang key='cartremoveitemconfirm'}
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-primary">{lang key='yes'}</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">{lang key='no'}</button>
                    </div>
                </div>
            </div>
        </div>
    </form>

    <script>recalculateRenewalTotals();</script>
{/if}