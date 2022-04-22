{if isset($RSThemes['pages']['configureproductdomain'])}
    {include file=$RSThemes['pages']['configureproductdomain']['fullPath']}
{else}  	
    {include file="orderforms/$carttpl/common.tpl"}

    <div class="main-content">
        <div class="order-content">
            <form id="frmProductDomain">
                <input type="hidden" id="frmProductDomainPid" value="{$pid}" />
                <div class="panel panel-default panel-choose-domain">
                    <div class="panel-body panel-domain-option">
                        <div class="content">
                            {if $incartdomains}
                                <label class="radio">
                                    <input type="radio" class="icheck-control" name="domainoption" value="incart" id="selincart" /><span>{$LANG.cartproductdomainuseincart}</span>
                                </label>
                            {/if}
                            {if $registerdomainenabled}
                                <label class="radio">
                                    <input type="radio" class="icheck-control" name="domainoption" value="register" id="selregister"{if $domainoption eq "register"} checked{/if} /><span>{$LANG.cartregisterdomainchoice|sprintf2:$companyname}</span>
                                </label>
                            {/if}
                            {if $transferdomainenabled}
                                <label class="radio">
                                    <input type="radio" class="icheck-control" name="domainoption" value="transfer" id="seltransfer"{if $domainoption eq "transfer"} checked{/if} />{$LANG.carttransferdomainchoice|sprintf2:$companyname}
                                </label>
                            {/if}
                            {if $owndomainenabled}
                                <label class="radio">
                                    <input type="radio" class="icheck-control" name="domainoption" value="owndomain" id="selowndomain"{if $domainoption eq "owndomain"} checked{/if} />{$LANG.cartexistingdomainchoice|sprintf2:$companyname}
                                </label>
                            {/if}
                            {if $subdomains}
                                <label class="radio">
                                    <input type="radio" class="icheck-control" name="domainoption" value="subdomain" id="selsubdomain"{if $domainoption eq "subdomain"} checked{/if} />{$LANG.cartsubdomainchoice|sprintf2:$companyname}
                                </label>
                            {/if}
                        </div>
                    </div>
                    <div class="panel-body panel-domain-search pattern-bg-domain">
                        {if $incartdomains}
                            <div class="inline-form hidden" id="domainincart">
                                <div class="inline-form-element w-100">
                                    <select id="incartsld" name="incartdomain" class="form-control input-lg">
                                        {foreach key=num item=incartdomain from=$incartdomains}
                                            <option value="{$incartdomain}">{$incartdomain}</option>
                                        {/foreach}
                                    </select>
                                </div>
                                <div class="inline-form-element">                        
                                    <button type="submit" class="btn btn-lg btn-block btn-primary">
                                        {$LANG.orderForm.use}
                                    </button>
                                </div>
                            </div>
                        {/if}
                        {if $registerdomainenabled}
                            <div class="inline-form hidden" id="domainregister">
                                <div class="inline-form-element w-100">
                                    <input type="text" placeholder="{$rslang->trans('order.search_domain')}" id="registersld" value="{$sld}" class="form-control  input-lg" autocapitalize="none" data-toggle="tooltip" data-placement="top" data-trigger="manual" title="{lang key='orderForm.enterDomain'}" />
                                </div>
                                <div class="inline-form-element">
                                    <div  class="dropdown" data-dropdown-select>
                                        <div class="dropdown-toggle" data-toggle="dropdown" href="#" aria-expanded="true">
                                            <input name="domaintld" id="registertld" type="hidden" data-dropdown-select-value value="{if $tld}{$tld}{else}{$registertlds[0]}{/if}">
                                            <div class="tld-select">
                                                <span data-dropdown-select-value-view>
                                                    {if $tld}
                                                        {$tld}
                                                    {else}
                                                        {$registertlds[0]}
                                                    {/if}	
                                                </span>
                                                <b class="caret"></b>
                                            </div>
                                        </div>
                                        <div class="dropdown-menu dropdown-menu-search pull-right ps">
                                            <div class="dropdown-header">
                                                <input class="form-control input-sm" placeholder="{$LANG.search}..." type="text" data-dropdown-select-search>
                                            </div>
                                            <div class="nav-divider"> 
                                                <a href="">
                                                    -----
                                                </a> 
                                            </div>
                                            <div class="dropdown-menu-items" data-dropdown-select-list>
                                                {foreach from=$registertlds item=listtld}
                                                    <div class="dropdown-menu-item {if $tld == $listtld}active{elseif $registertlds[0] == $listtld}active{/if}" data-value="{$listtld}">
                                                        <a>{$listtld}</a>
                                                    </div>	
                                                {/foreach}
                                            </div>
                                            <div class="dropdown-menu-item dropdown-menu-no-data">
                                                <span class="text-info text-large">
                                                    {$LANG.norecordsfound}
                                                </span>
                                            </div>                                               
                                            <div class="ps__rail-x">
                                                <div class="ps__thumb-x" tabindex="0"></div>                    
                                            </div>
                                            <div class="ps__rail-y">
                                                <div class="ps__thumb-y" tabindex="0"></div>                   
                                            </div>      
                                        </div>	
                                    </div>								
                                </div>
                                <div class="inline-form-element">                        
                                    <button type="submit" class="btn btn-lg btn-primary">
                                        {$LANG.orderForm.check}
                                    </button>
                                </div>
                            </div>
                        {/if}
                        {if $transferdomainenabled}
                            <div class="inline-form hidden" id="domaintransfer">
                                <div class="inline-form-element w-100">
                                    <input type="text" id="transfersld" placeholder="{$rslang->trans('order.search_domain')}" value="{$sld}" class="form-control input-lg" autocapitalize="none" data-toggle="tooltip" data-placement="top" data-trigger="manual" title="{lang key='orderForm.enterDomain'}"/>
                                </div>
                                <div class="inline-form-element">
                                    <div  class="dropdown" data-dropdown-select>
                                        <div class="dropdown-toggle" data-toggle="dropdown" href="#" aria-expanded="true">
                                            <input name="domaintld" id="transfertld" type="hidden" data-dropdown-select-value value="{if $tld}{$tld}{else}{$transfertlds[0]}{/if}">
                                            <div class="tld-select">
                                                <span data-dropdown-select-value-view>
                                                    {if $tld}
                                                        {$tld}
                                                    {else}
                                                        {$transfertlds[0]}
                                                    {/if}	
                                                </span>
                                                <b class="caret"></b>
                                            </div>
                                        </div>
                                        <div class="dropdown-menu dropdown-menu-search pull-right ps">
                                            <div class="dropdown-header">
                                                <input class="form-control input-sm" placeholder="{$LANG.search}..." type="text" data-dropdown-select-search>
                                            </div>
                                            <div class="nav-divider"> 
                                                <a href="">
                                                    -----
                                                </a> 
                                            </div>
                                            <div class="dropdown-menu-items" data-dropdown-select-list>
                                                {foreach from=$transfertlds item=listtld}
                                                    <div class="dropdown-menu-item" data-value="{$listtld}">
                                                        <a>{$listtld}</a>
                                                    </div>	
                                                {/foreach}
                                            </div>
                                            <div class="dropdown-menu-item dropdown-menu-no-data">
                                                <span class="text-info text-large">
                                                    {$LANG.norecordsfound}
                                                </span>
                                            </div>
                                            <div class="ps__rail-x">
                                                <div class="ps__thumb-x" tabindex="0"></div>                    
                                            </div>
                                            <div class="ps__rail-y">
                                                <div class="ps__thumb-y" tabindex="0"></div>                   
                                            </div>          
                                        </div>	
                                    </div>								
                                </div>

                                <div class="inline-form-element">                        
                                    <button type="submit" class="btn btn-lg btn-primary">
                                        {$LANG.orderForm.transfer}
                                    </button>
                                </div>
                            </div>
                        {/if}
                        {if $owndomainenabled}
                            <div class="inline-form hidden" id="domainowndomain">
                                <div class="inline-form-element w-100">
                                    <input type="text" id="owndomainsld" value="{$sld}" placeholder="{$LANG.yourdomainplaceholder}" class="form-control input-lg" autocapitalize="none" data-toggle="tooltip" data-placement="top" data-trigger="manual" title="{lang key='orderForm.enterDomain'}" />
                                </div>
                                <div class="inline-form-element">
                                    <input type="text" id="owndomaintld" value="{$tld|substr:1}" placeholder="{$LANG.yourtldplaceholder}" class="form-control input-lg" autocapitalize="none" data-toggle="tooltip" data-placement="top" data-trigger="manual" title="{lang key='orderForm.required'}" />
                                </div>
                                <div class="inline-form-element">                        
                                    <button type="submit" class="btn btn-lg btn-primary">
                                        {$LANG.orderForm.use}
                                    </button>
                                </div>
                            </div>
                        {/if}
                        {if $subdomains}
                            <div class="inline-form hidden" id="domainsubdomain">
                                <div class="inline-form-element w-100">
                                    <input type="text" id="subdomainsld" value="{$sld}" placeholder="yourname" class="form-control input-lg" autocapitalize="none" data-toggle="tooltip" data-placement="top" data-trigger="manual" title="{lang key='orderForm.enterDomain'}" />
                                </div>
                                <div class="inline-form-element">
                                    <select id="subdomaintld" class="form-control input-lg">
                                        {foreach $subdomains as $subid => $subdomain}
                                            <option value="{$subid}">{$subdomain}</option>
                                        {/foreach}
                                    </select>
                                </div>
                                <div class="inline-form-element">                        
                                    <button type="submit" class="btn btn-lg btn-primary">
                                        {$LANG.orderForm.check}
                                    </button>
                                </div>
                            </div>
                        {/if}
                    </div>
                </div>
                {if $freedomaintlds}
                    <p class="text-muted domain-suggestions-warning">* {$LANG.orderfreedomainregistration} {$LANG.orderfreedomainappliesto}: {$freedomaintlds}</p>
                {/if}
            </form>
            <div id="primaryLookupSearching" class="domain-lookup-loader message message-lg message-no-data hidden">
                <div class="loader">
                    {include file="$template/includes/loader.tpl"}  
                </div>
            </div>
            <form method="post" action="cart.php?a=add&pid={$pid}&domainselect=1" id="frmProductDomainSelections">
                <input type="hidden" id="resultDomainOption" name="domainoption" />
                <input type="hidden" id="resultDomain" name="domains[]" />
                <input type="hidden" id="resultDomainPricingTerm" />
                <div id="DomainSearchResults" class="hidden">
                    <div id="searchDomainInfo" class="domain-checker-result-headline">
                        <div id="primaryLookupResult">
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
                            <div class="domain-available message message-success message-lg message-no-data">
                                <div class="message-icon">
                                    <i class="lm lm-check"></i>
                                </div>
                                <h2 class="message-text">
                                    {$LANG.domainavailable1} <strong></strong> {$LANG.domainavailable2}
                                </h2>
                                <div class="domain-price">
                                    <h4 class="price"></h4>
                                    <button type="submit" class="btn btn-primary" data-whois="0" data-domain="">
                                        <i class="ls ls-share m-r-8"></i>{lang key='continue'}
                                    </button>
                                </div>    
                            </div>
                            <div class="domain-unavailable message message-danger message-lg message-no-data ">
                                <div class="message-icon">
                                    <i class="lm lm-close"></i>
                                </div>
                                <h2 class="message-text">{lang key='orderForm.domainIsUnavailable'}</h2>
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

                            <div class="domain-error message message-danger message-lg message-no-data ">
                                <div class="message-icon">
                                    <i class="lm lm-close"></i>
                                </div>
                                <h2 class="message-text"></h2>
                            </div> 

                            {* <div class="btn btn-primary domain-contact-support headline">{$LANG.domainContactUs}</div> *}
                            <div class="transfer-eligible message message-success message-lg message-no-data">
                                <div class="message-icon">
                                    <i class="lm lm-check"></i>
                                </div>
                                <h2 class="message-text">
                                    {lang key='orderForm.transferEligible'}
                                </h2>
                                <h6 class="text-center text-light">{lang key='orderForm.transferUnlockBeforeContinuing'}</h6>
                                <div class="domain-price text-center">                           
                                    {lang key='orderForm.domainPriceTransferLabel'}
                                    <h4 class="price m-t-0"></h4>

                                    <button type="submit" class="btn btn-primary">
                                        <i class="ls ls-share m-r-8"></i>{lang key='continue'}                              
                                    </button>
                                </div>    
                            </div>

                            <div class="transfer-not-eligible message message-danger message-lg message-no-data ">
                                <div class="message-icon">
                                    <i class="lm lm-close"></i>
                                </div>
                                <h2 class="message-text">{lang key='orderForm.transferNotEligible'}</h2>
                                <h6 class="text-center text-light">
                                    {lang key='orderForm.transferNotRegistered'}
                                    <br />
                                    {lang key='orderForm.trasnferRecentlyRegistered'}
                                    <br />
                                    {lang key='orderForm.transferAlternativelyRegister'}
                                </h6>
                            </div> 
                        </div>
                    </div>

                    {if $registerdomainenabled}
                        {if $spotlightTlds}
                            <div id="spotlightTlds" class="spotlight-tlds clearfix">
                                <div class="spotlight-tlds-container">
                                    {foreach $spotlightTlds as $key => $data}
                                        <div class="spotlight-tld-container spotlight-tld-container-{$spotlightTlds|count}">
                                            <div id="spotlight{$data.tldNoDots}" class="spotlight-tld">
                                                <div class="spotlight-body">
                                                    <div class="spotlight-top">
                                                        <div class="spotlight-price">
                                                            <span>{$data.register}</span>
                                                        </div>
                                                        <div class="spotlight-content">
                                                            {if $data.group == "hot"}
                                                                {assign var="grouplabel" value="danger"}
                                                            {elseif $data.group == "new"}
                                                                {assign var="grouplabel" value="success"}
                                                            {elseif $data.group == "sale"}
                                                                {assign var="grouplabel" value="purple"}
                                                            {/if}
                                                            {if $data.group}
                                                                <span class="label-corner label-{$grouplabel}">{$data.groupDisplayName}</span>
                                                            {/if}
                                                            <span class="extension">{$data.tld}</span>
                                                        </div>
                                                        <div class="spotlight-footer domain-lookup-result">
                                                            <button type="button" class="btn unavailable btn-unavailable btn-block btn-sm hidden" disabled="disabled">
                                                                {lang key='domainunavailable'}
                                                            </button>
                                                            <button type="button" class="btn invalid btn-unavailable btn-block btn-sm hidden" disabled="disabled">
                                                                {lang key='domainunavailable'}
                                                            </button>
                                                            <button type="button" class="btn btn-info btn-block btn-sm hidden btn-add-to-cart" data-whois="0" data-domain="">
                                                                <span class="to-add">{lang key='orderForm.add'}</span>
                                                                <span class="added">{lang key='domaincheckeradded'}</span>
                                                                <span class="unavailable">{$LANG.domaincheckertaken}</span>
                                                            </button>
                                                            {* <button type="button" class="btn btn-block btn-sm btn-primary domain-contact-support hidden">
                                                            {lang key='domainChecker.contactSupport'}
                                                            </button> *}
                                                        </div>
                                                    </div>
                                                </div>  
                                            </div>
                                        </div>
                                    {/foreach}
                                </div>
                            </div>
                        {/if}

                        <div class="suggested-domains{if !$showSuggestionsContainer} hidden{/if}">
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
                                            <span class="added">{lang key='domaincheckeradded'}</span>
                                            <span class="unavailable">{$LANG.domaincheckertaken}</span>
                                        </button>
                                        <button type="button" class="btn btn-primary domain-contact-support hidden">
                                            {lang key='domainChecker.contactSupport'}
                                        </button>
                                    </div>
                                </li>
                            </ul>
                            <div class="panel-footer more-suggestions hidden text-center">
                                <a id="moreSuggestions" href="#" onclick="loadMoreSuggestions();
                                        return false;">{lang key='domainsmoresuggestions'}</a>
                                <span id="noMoreSuggestions" class="no-more small hidden">{lang key='domaincheckernomoresuggestions'}</span>
                            </div>
                            <div class="text-center text-muted domain-suggestions-warning">
                                <p>{lang key='domainssuggestionswarnings'}</p>
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
                            <div class="content">
                                <button id="btnDomainContinue" type="submit" class="btn btn-primary" disabled="disabled" data-btn-loader>
                                    <span>
                                        <i class="ls ls-share"></i>
                                        <span class="btn-text">{$LANG.continue}</span>
                                    </span>
                                    <div class="loader loader-button hidden">
                                        {include file="$template/includes/loader.tpl" classes="spinner-sm spinner-light"}  
                                    </div>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
{/if}