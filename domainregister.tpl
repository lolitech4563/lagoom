{if isset($RSThemes['pages']['domainregister'])}
    {include file=$RSThemes['pages']['domainregister']['fullPath']}
{else}

    {include file="orderforms/$carttpl/common.tpl"}

    <div class="col-md-3 pull-md-left sidebar hidden-xs hidden-sm">
        {include file="orderforms/$carttpl/sidebar-categories.tpl"}
    </div>

    <div class="main-content pull-md-right col-md-9">
        <p class="desc">{$LANG.orderForm.findNewDomain}</p>
        {include file="orderforms/$carttpl/sidebar-categories-collapsed.tpl"}
        <div class="panel panel-choose-domain">
            <div class="panel-body panel-domain-search pattern-bg-domain">
                <form method="post" action="cart.php" id="frmDomainChecker">
                    <input type="hidden" name="a" value="checkDomain">
                    <div class="inline-form">
                        <div class="search-group w-100 inline-form-element">
                            <input type="text" name="domain" class="form-control input-lg" placeholder="{$LANG.findyourdomain}" value="{$lookupTerm}" id="inputDomain" data-toggle="tooltip" data-placement="left" data-trigger="manual" title="{lang key='orderForm.domainOrKeyword'}" />
                        </div>
                        <span class="inline-form-element">
                            <button type="submit" id="btnCheckAvailability" class="btn btn-block btn-lg btn-primary domain-check-availability {if $captcha}{$captcha->getButtonClass($captchaForm)}{/if}">{$LANG.search}</button>
                        </span>
                    </div>
                    {if $captcha->isEnabled() && $captcha->isEnabledForForm($captchaForm) && !$captcha->recaptcha->isInvisible()}
                        <div class="domainchecker-homepage-captcha">
                            <div class="captcha-container captcha captcha-centered text-center m-a form-group" id="captchaContainer">
                                {if $captcha == "recaptcha"}
                                     <div class="recaptcha-container"></div>
                                 {elseif $captcha != "recaptcha"}
                                    <div class="captchatext text-light">{lang key="cartSimpleCaptcha"}</div>
                                    <div class="input-group">                                 
                                        <div class="input-group-addon">
                                            <img id="inputCaptchaImage" src="{$systemurl}includes/verifyimage.php" align="middle" />                                          
                                        </div>    
                                       <input id="inputCaptcha" type="text" name="code" maxlength="6" class="form-control" data-toggle="tooltip" data-placement="right" data-trigger="manual" title="{lang key='orderForm.required'}" />
                                    </div>
                                {/if}
                            </div>
                        </div>
                    {/if}
                </form>
            </div>
        </div>
        
        <div id="primaryLookupSearching" class="domain-lookup-loader message message-lg message-no-data {if (!$lookupTerm || $captchaError || $invalid)}hidden{/if}">
            <div class="loader">
                {include file="$template/includes/loader.tpl"}  
            </div>
        </div>
        <div id="DomainSearchResults" class="hidden">
            <div id="searchDomainInfo" class="domain-checker-result-headline">
                <div id="primaryLookupResult" class="hidden">
                    <div id="idnLanguageSelector" class="message message-no-data hidden idn-language-selector idn-language">
                        <p class="text-center">           
                            {lang key='cart.idnLanguageDescription'}
                        </p>
                        <div class="form-group w-100 m-b-0">
                            <div class="row">
                                <div class="col-md-6 col-md-offset-3">
                                    <select name="idnlanguage" class="form-control">
                                        <option value="">{lang key='cart.idnLanguage'}</option>
                                        {foreach $idnLanguages as $idnLanguageKey => $idnLanguage}
                                            <option value="{$idnLanguageKey}">{lang key='idnLanguage.'|cat:$idnLanguageKey}</option>
                                        {/foreach}
                                    </select>
                                </div>
                            </div>
                            <span class="field-error-msg help-block text-center text-danger">
                                {lang key='cart.selectIdnLanguageForRegister'}
                            </span>
                        </div>
                    </div>
                    <div class="domain-available message message-success message-lg message-no-data ">
                        <div class="message-icon">
                            <i class="lm lm-check"></i>
                        </div>
                        <h2 class="message-text">
                            {$LANG.domainavailable1} <strong></strong> {$LANG.domainavailable2}
                        </h2>
                        <div class="domain-price">
                            <h4 class="price"></h4>
                            <button class="btn btn-info btn-add-to-cart" data-whois="0" data-domain="">
                                <span class="to-add">{$LANG.addtocart}</span>
                                <span class="added"><i class="ls ls-check m-r-8"></i>{lang key='checkout'}</span>
                                <span class="unavailable">{$LANG.domaincheckertaken}</span>
                            </button>
                        </div>
                    </div>
                    <div class="domain-unavailable message message-danger message-lg message-no-data ">
                        <div class="message-icon">
                            <i class="lm lm-close"></i>
                        </div>
                        <h2 class="message-text">{lang key='orderForm.domainIsUnavailable'}</h2>
                    </div>
                    <div class="domain-error domain-checker-unavailable message message-danger message-lg message-no-data">
                        <div class="message-icon">
                            <i class="lm lm-close"></i>
                        </div>
                        <h2 class="message-text"></h2>
                    </div>
                    <div class="domain-invalid message message-danger message-lg message-no-data ">
                        <div class="message-icon">
                            <i class="lm lm-close"></i>
                        </div>
                        <h2 class="message-text">{lang key='orderForm.domainInvalid'}</h2>
                        <h6 class="text-center text-light">
                            {lang key='orderForm.domainLetterOrNumber'}<span class="domain-length-restrictions">{lang key='orderForm.domainLengthRequirements'}</span>
                            <br />
                            {lang key='orderForm.domainInvalidCheckEntry'}
                        </h6>
                    </div> 
                </div>
            </div>
            {if $spotlightTlds}
                <div id="spotlightTlds" class="spotlight-tlds clearfix">
                    <div class="spotlight-tlds-container">
                        {foreach $spotlightTlds as $key => $data}
                            <div class="spotlight-tld-container spotlight-tld-container-{$spotlightTlds|count}">
                                <div id="spotlight{$data.tldNoDots}" class="spotlight-tld">
                                    <div class="spotlight-loader">
                                        {include file="$template/includes/loader.tpl"}  
                                    </div>
                                    <div class="spotlight-body domain-lookup-result">
                                        <div class="spotlight-top">
                                            <div class="spotlight-price ">
                                                <span class="available">{$data.register}</span>
                                                <span class="unavailable hidden">-</span>
                                            </div>
                                            {if $data.group == "hot"}
                                                {assign var="grouplabel" value="danger"}
                                            {elseif $data.group == "new"}
                                                {assign var="grouplabel" value="success"}
                                            {elseif $data.group == "sale"}
                                                {assign var="grouplabel" value="purple"}
                                            {/if}
                                            <div class="spotlight-content">
                                                {if $data.group}
                                                    <span class="label-corner label-{$grouplabel}">{$data.groupDisplayName}</span>
                                                {/if}
                                                <span class="extension">{$data.tld}</span>
                                            </div>
                                            <div class="spotlight-footer ">
                                                <button type="button" class="btn unavailable btn-unavailable btn-block btn-sm hidden" disabled="disabled">
                                                    {lang key='domainunavailable'}
                                                </button>
                                                <button type="button" class="btn invalid btn-unavailable btn-block btn-sm hidden" disabled="disabled">
                                                    {lang key='domainunavailable'}
                                                </button>
                                                <button type="button" class="btn btn-info btn-block btn-sm hidden btn-add-to-cart" data-whois="0" data-domain="">
                                                    <span class="to-add">{lang key='orderForm.add'}</span>
                                                    <span class="added">{lang key='checkout'}</span>
                                                    <span class="unavailable">{$LANG.domaincheckertaken}</span>
                                                </button>
                                            </div>
                                        </div>
                                    </div>  
                                </div>
                            </div>
                        {/foreach}
                    </div>
                </div>
            {/if}
            <div class="suggested-domains m-t-32{if !$showSuggestionsContainer || ($lookupTerm && !$captchaError && !$invalid) || (!$captcha->isEnabled() && $lookupTerm && !$invalid)} hidden{/if}">
                <h4>
                    {lang key='orderForm.suggestedDomains'}
                </h4>
                <ul id="domainSuggestions" class="domain-lookup-result list-group hidden">
                    <li class="domain-suggestion list-group-item hidden">
                        <div class="content">
                            <span class="domain"></span><span class="extension"></span>
                            <span class="promo hidden">
                                <span class="sales-group-hot label label-danger hidden">{lang key='domainCheckerSalesGroup.hot'}</span>
                                <span class="sales-group-new label label-success hidden">{lang key='domainCheckerSalesGroup.new'}</span>
                                <span class="sales-group-sale label label-purple hidden">{lang key='domainCheckerSalesGroup.sale'}</span>
                            </span>
                        </div>
                        
                        <div class="actions">
                            <span class="price"></span>
                            <button type="button" class="btn btn-info btn-sm btn-add-to-cart" data-whois="1" data-domain="">
                                <span class="to-add">{$LANG.addtocart}</span>
                                <span class="added">{lang key='checkout'}</span>
                                <span class="unavailable">{$LANG.domaincheckertaken}</span>
                            </button>
                            <button type="button" class="btn btn-primary domain-contact-support hidden">
                                {lang key='domainChecker.contactSupport'}
                            </button>
                        </div>
                    </li>
                </ul>
                <div class="panel-footer more-suggestions hidden text-center">
                    <a id="moreSuggestions" href="#" onclick="loadMoreSuggestions();return false;">{lang key='domainsmoresuggestions'}</a>
                    <span id="noMoreSuggestions" class="no-more small hidden">{lang key='domaincheckernomoresuggestions'}</span>
                </div>
                <div class="text-center text-muted domain-suggestions-warning">
                    <p>{lang key='domainssuggestionswarnings'}</p>
                </div>
            </div>
        </div>

        <div class="domain-pricing">
            {if $featuredTlds}
                <div class="featured-tlds-container">
                    <div class="row">
                        {foreach $featuredTlds as $num => $tldinfo}
                            <div class="col-sm-6">
                                <div class="featured-tld">
                                    <div class="img-container">
                                        <img src="{$BASE_PATH_IMG}/tld_logos/{$tldinfo.tldNoDots}.png">
                                    </div>
                                    <div class="price {$tldinfo.tldNoDots}">
                                        {if is_object($tldinfo.register)}
                                            {$tldinfo.register}{if $tldinfo.period > 1}{lang key="orderForm.shortPerYears" years={$tldinfo.period}}{else}{lang key="orderForm.shortPerYear" years=''}{/if}
                                        {else}
                                            {lang key="domainregnotavailable"}
                                        {/if}
                                    </div>
                                </div>
                            </div>
                        {/foreach}
                    </div>
                </div>
            {/if}

            <h5 class="text-light">{lang key='pricing.browseExtByCategory'}</h5>
            <div class="tld-filters">
                <div class="value"></div> 
                {assign var=firstCat value=$categoriesWithCounts|@key}  
                <select multiple class="form-control custom-multiselect">
                    {foreach $categoriesWithCounts as $category => $count key=key}
                        <option value="{$category}" {if $category == $firstCat}selected{/if}>{lang key="domainTldCategory.$category" defaultValue=$category} ({$count})</option>                   
                    {/foreach}
                </select>
            </div>
            <div class="tld-pricing">
                <div class="row tld-pricing-header">
                    <div class="col-sm-4 no-bg">{lang key='orderdomain'}</div>
                    <div class="col-sm-8">
                        <div class="row">
                            <div class="col-xs-4">{lang key='pricing.register'}</div>
                            <div class="col-xs-4">{lang key='pricing.transfer'}</div>
                            <div class="col-xs-4">{lang key='pricing.renewal'}</div>
                        </div>
                    </div>
                </div>
                {foreach $pricing['pricing'] as $tld => $price}
                    <div class="row tld-row" data-category="{foreach $price.categories as $category}|{$category}|{/foreach}">
                        <div class="col-sm-4 two-row-center">
                            <strong>.{$tld}</strong>
                            {if $price.group}
                                {if $price.group == "hot"}
                                    {assign var="grouplabel" value="danger"}
                                {elseif $price.group == "new"}
                                    {assign var="grouplabel" value="success"}
                                {elseif $price.group == "sale"}
                                    {assign var="grouplabel" value="purple"}
                                {/if}
                                <span class="label label-{$grouplabel}">{$price.group}!</span>
                            {/if}
                        </div>
                        <div class="col-sm-8">
                            <div class="row">
                                <div class="col-xs-4">
                                    <span class="tld-label">{lang key='pricing.register'}</span>
                                    {if isset($price.register) && current($price.register) > 0}
                                        {current($price.register)}<br>
                                        <small>{key($price.register)} {if key($price.register) > 1}{lang key="orderForm.years"}{else}{lang key="orderForm.year"}{/if}</small>
                                    {elseif isset($price.register) && current($price.register) == 0}
                                        <small>{lang key='orderfree'}</small>
                                    {else}
                                        <small>{lang key='na'}</small>
                                    {/if}
                                </div>
                                <div class="col-xs-4">
                                    <span class="tld-label">{lang key='pricing.transfer'}</span>
                                    {if isset($price.transfer) && current($price.transfer) > 0}
                                        {current($price.transfer)}<br>
                                        <small>{key($price.transfer)} {if key($price.register) > 1}{lang key="orderForm.years"}{else}{lang key="orderForm.year"}{/if}</small>
                                    {elseif isset($price.transfer) && current($price.transfer) == 0}
                                        <small>{lang key='orderfree'}</small>
                                    {else}
                                        <small>{lang key='na'}</small>
                                    {/if}
                                </div>
                                <div class="col-xs-4">
                                    <span class="tld-label">{lang key='pricing.renewal'}</span>
                                    {if isset($price.renew) && current($price.renew) > 0}
                                        {current($price.renew)}<br>
                                        <small>{key($price.renew)} {if key($price.register) > 1}{lang key="orderForm.years"}{else}{lang key="orderForm.year"}{/if}</small>
                                    {elseif isset($price.renew) && current($price.renew) == 0}
                                        <small>{lang key='orderfree'}</small>
                                    {else}
                                        <small>{lang key='na'}</small>
                                    {/if}
                                </div>
                            </div>
                        </div>
                    </div>
                {/foreach}
                <div class="message message-danger message-lg message-no-data no-tlds" style="display: none;">
                    <div class="message-icon">
                        <i class="lm lm-close"></i>
                    </div>
                    <h2 class="message-text">{lang key='pricing.selectExtCategory'}</h2>
                </div>    
            </div>
        </div>
        <div class="row row-eq-height row-eq-height-sm">
            <div class="col-sm-{if $domainTransferEnabled}6{else}12{/if}">
                <div class="domain-promo-box">
                    <div class="promo-box-body">
                        <div class="promo-box-content">
                            <div class="promo-box-icon">
                                {include file="$template//assets/svg-icon/web-hosting.tpl"} 
                            </div>
                            <div class="promo-box-header">
                                <h3>{lang key='orderForm.addHosting'}</h3>
                                <p class="description">{lang key='orderForm.chooseFromRange'}</p>
                            </div>
                        </div>
                        <div class="promo-box-content promo-box-content-between">
                            <p class="promo-description">{lang key='orderForm.packagesForBudget'}</p>
                            <a href="{$WEB_ROOT}/cart.php" class="btn btn-primary">
                                {lang key='orderForm.exploreNow'}
                            </a>
                        </div>
                    </div>    
                </div>
            </div>
            {if $domainTransferEnabled}
                <div class="col-sm-6">
                    <div class="domain-promo-box">
                        <div class="promo-box-body">
                            <div class="promo-box-content">
                                <div class="promo-box-icon">
                                    {include file="$template//assets/svg-icon/transfer-domain.tpl"} 
                                </div>
                                <div class="promo-box-header">
                                    <h3>{lang key='orderForm.transferToUs'}</h3>
                                    <p class="description text-primary">{lang key='orderForm.transferExtend'}*</p>
                                </div>
                            </div>
                            <div class="promo-box-content promo-box-content-between">
                                <p class="promo-description">* {lang key='orderForm.extendExclusions'}</p>
                                <a href="{$WEB_ROOT}/cart.php?a=add&domain=transfer" class="btn btn-primary">{lang key='orderForm.transferDomain'}</a>
                            </div>
                        </div>
                    </div>
                </div>    
            {/if}
        </div>
   
        <div class="bottom-action-sticky container">
            <div class="container">
                <div class="d-flex space-between">
                    <div class="content d-flex align-center justify-center">
                        <div class="badge" id="cartItemCount">0</div>
                        <span class="m-l-8">{$rslang->trans('domains.domains_selected')}</span>
                    </div>
                    <div class="content flex-basis-auto">
                        <a href="cart.php?a=confdomains" id="btnDomainContinue" class="btn btn-primary" data-btn-loader>
                            <span>
                                <i class="ls ls-share"></i>
                                <span class="btn-text">{$LANG.continue}</span>
                            </span>
                            <div class="loader loader-button hidden" >
                                {include file="$template/includes/loader.tpl" classes="spinner-sm spinner-light"}  
                            </div>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>   

    <script>
        jQuery(document).ready(function() {
            jQuery('.tld-filters a:first-child').click();
            {if ($lookupTerm && !$captchaError && !$invalid) || (!$captcha->isEnabled() && $lookupTerm && !$invalid)}
                {literal}
                    setTimeout(function(){
                        jQuery('#btnCheckAvailability').trigger('click');
                    }, 500);
                {/literal}
                
            {/if}
            {if $invalid}
                jQuery('#primaryLookupSearching').toggle();
                jQuery('#primaryLookupResult').children().toggle();
                jQuery('#primaryLookupResult').toggle();
                jQuery('#DomainSearchResults').toggle();
                jQuery('.domain-invalid').toggle();
            {/if}
        });
    </script>
    {* default <script>
        jQuery(document).ready(function() {
            jQuery('.tld-filters a:first-child').click();
        {if $lookupTerm && !$captchaError && !$invalid}
            jQuery('#btnCheckAvailability').click();
        {/if}
        {if $invalid}
            jQuery('#primaryLookupSearching').toggle();
            jQuery('#primaryLookupResult').children().toggle();
            jQuery('#primaryLookupResult').toggle();
            jQuery('#DomainSearchResults').toggle();
            jQuery('.domain-invalid').toggle();
        {/if}
        });
    </script> *}
{/if}