{if isset($RSThemes['pages']['configuredomains'])}
    {include file=$RSThemes['pages']['configuredomains']['fullPath']}
{else}     
    <script>
    var _localLang = {
        'addToCart': '{$LANG.orderForm.addToCart|escape}',
        'addedToCartRemove': '{$LANG.orderForm.addedToCartRemove|escape}'
    }
    </script>

    {include file="orderforms/$carttpl/common.tpl"}

    <div class="main-content col-md-12">
        <div class="order-content">
            <form method="post" action="{$smarty.server.PHP_SELF}?a=confdomains" id="frmConfigureDomains">
            <input type="hidden" name="update" value="true" />
            <div class="section">
                <div class="section-header">
                    <p class="section-desc">{$LANG.orderForm.reviewDomainAndAddons}</p>
                </div>
                {if $errormessage}
                    <div class="alert alert-danger" role="alert">
                        <div class="alert-body">
                            <p>{$LANG.orderForm.correctErrors}:</p>
                            <ul>
                                {$errormessage}
                            </ul>
                        </div>
                    </div>
                {/if}
                {if $domains}
                <div class="section">
                    {foreach $domains as $num => $domain}
                        <div class="panel panel-default panel-form {if $domain.fields}panel-separated{/if}">
                            <div class="panel-body">                       
                                <div class="domain-information">
                                    <div class="domain-information-top d-flex space-between">
                                        <div class="domain-information-title">                                            
                                            <h2>{$domain.domain}</h2>
                                        </div>
                                        <button type="button" class="btn btn-sm btn-danger" onclick="removeItem('d', '{$num}')">
                                            <i class="ls ls-trash"></i> {$LANG.orderForm.remove}
                                        </button>
                                    </div>
                                    <div class="domain-information-info">
                                        <span class="domain-hosting-info">
                                        {if $domain.hosting}
                                            {$LANG.cartdomainshashosting}
                                        {else}
                                            <span class="domain-period-info"><a href="cart.php"><i class="ls ls-info-circle m-r-8"></i> {$LANG.cartdomainsnohosting}</a>
                                        {/if}
                                        </span>
                                        <span class="domain-period-info">{$LANG.orderregperiod}: {$domain.regperiod} {$LANG.orderyears}</span>
                                    </div>
                                </div>
                                {if $domain.dnsmanagement || $domain.emailforwarding || $domain.idprotection}
                                    <div class="row addon-products" data-inputs-container>
                                        {if $domain.dnsmanagement}
                                            <div class="col-sm-4">
                                                <div class="panel panel-check{if $domain.dnsmanagementselected} checked{/if}" data-virtual-input>
                                                    <div class="check">
                                                        <label>
                                                            <input class="icheck-control" type="checkbox" name="dnsmanagement[{$num}]"{if $domain.dnsmanagementselected} checked{/if} {if !$domain.dnsmanagement} disabled{/if} />
                                                            <div class="check-content">
                                                                <h6 class="check-title">{$LANG.domaindnsmanagement}<i class="ls ls-info-circle" data-toggle="tooltip" title="{$LANG.domainaddonsdnsmanagementinfo}"></i></h6>
                                                                <p class="check-subtitle">{$domain.dnsmanagementprice} / {$domain.regperiod} {$LANG.orderyears}</p>
                                                            </div>
                                                        </label>
                                                    </div>
                                                </div>
                                            </div>
                                        {/if}
                                        {if $domain.idprotection}
                                            <div class="col-sm-4">
                                                <div class="panel panel-check{if $domain.idprotectionselected} checked{/if}" data-virtual-input>
                                                    <div class="check">
                                                        <label>
                                                            <input class="icheck-control" type="checkbox" name="idprotection[{$num}]"{if $domain.idprotectionselected} checked{/if} />
                                                            <div class="check-content">
                                                                <h6 class="check-title">{$LANG.domainidprotection}<i class="ls ls-info-circle" data-toggle="tooltip" title="{$LANG.domainaddonsidprotectioninfo}"></i></h6>
                                                                <p class="check-subtitle">{$domain.idprotectionprice} / {$domain.regperiod} {$LANG.orderyears}</p>
                                                            </div>
                                                        </label>
                                                    </div>
                                                </div>
                                            </div>
                                        {/if}
                                        {if $domain.emailforwarding}
                                        <div class="col-sm-4">
                                            <div class="panel panel-check{if $domain.emailforwardingselected} checked{/if}" data-virtual-input>
                                                <div class="check">
                                                    <label>
                                                        <input class="icheck-control" type="checkbox" name="emailforwarding[{$num}]"{if $domain.emailforwardingselected} checked{/if}/>
                                                        <div class="check-content">
                                                            <h6 class="check-title"> 
                                                                {$LANG.domainemailforwarding}
                                                                <span class="ls ls-info-circle" data-toggle="tooltip" title="{$LANG.domainaddonsemailforwardinginfo}"></span>
                                                            </h6>                                               
                                                            <p class="check-subtitle">{$domain.emailforwardingprice} / {$domain.regperiod} {$LANG.orderyears}</p>
                                                        </div>
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                        {/if}
                                    </div>
                                {/if}
                            </div>

                            {if $domain.eppenabled}
                            <div class="panel-body panel-domain-additional">
                                <div class="form-group m-b-0">
                                    <div class="row">
                                        <div class="col-sm-3">
                                            <label class="control-label">{$LANG.domaineppcode}</label>
                                            <input type="text" name="epp[{$num}]" id="inputEppcode{$num}" value="{$domain.eppvalue}" class="form-control" />
                                        </div>
                                    </div>
                                    <span class="help-block m-b-0">
                                        {$LANG.domaineppcodedesc}
                                    </span>
                                </div>
                            </div>
                            {/if}
                            {if $domain.fields}
                                <div class="panel-body panel-domain-additional">
                                    {foreach from=$domain.fields key=domainfieldname item=domainfield}
                                        <div class="row form-group">
                                            <div class="col-sm-4"><label class="control-label">{$domainfieldname}:</div>
                                            <div class="col-sm-8">{$domainfield}</div>
                                        </div>
                                    {/foreach}
                                </div>
                            {/if}
                        </div>
                    {/foreach}
                </div>
                {/if}
            </div>
            {if $atleastonenohosting}
                <div class="section">
                    <div class="section-header">
                        <h3>{$LANG.domainnameservers}</h3>
                        <p>{$LANG.cartnameserversdesc}</p>
                    </div>
                    <div class="section-body">
                        <div class="panel panel-default panel-form ">
                            <div class="panel-body p-t-18">
                                <div class="row">
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label for="inputNs1">{$LANG.domainnameserver1}</label>
                                            <input type="text" class="form-control" id="inputNs1" name="domainns1" value="{$domainns1}" />
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label for="inputNs2">{$LANG.domainnameserver2}</label>
                                            <input type="text" class="form-control" id="inputNs2" name="domainns2" value="{$domainns2}" />
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label for="inputNs3">{$LANG.domainnameserver3}</label>
                                            <input type="text" class="form-control" id="inputNs3" name="domainns3" value="{$domainns3}" />
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label for="inputNs1">{$LANG.domainnameserver4}</label>
                                            <input type="text" class="form-control" id="inputNs4" name="domainns4" value="{$domainns4}" />
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label for="inputNs5">{$LANG.domainnameserver5}</label>
                                            <input type="text" class="form-control" id="inputNs5" name="domainns5" value="{$domainns5}" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>    
                </div>
            {/if}

            <div class="bottom-action-sticky container">
                <div class="container">
                    <div class="d-flex space-between">
                        <div class="content"></div>
                        <div class="content">
                            <button type="submit" data-btn-loader class="btn btn-primary">
                                <span>
                                    <i class="ls ls ls-share"></i>
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