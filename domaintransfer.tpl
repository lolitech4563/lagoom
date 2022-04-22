{if isset($RSThemes['pages']['domaintransfer'])}
    {include file=$RSThemes['pages']['domaintransfer']['fullPath']}
{else}  
    {include file="orderforms/$carttpl/common.tpl"}

    <div class="col-md-3 pull-md-left sidebar hidden-xs hidden-sm">
        {include file="orderforms/{$carttpl}/sidebar-categories.tpl"}
    </div>
    <div class="col-md-9 main-content pull-md-right">
        {include file="orderforms/{$carttpl}/sidebar-categories-collapsed.tpl"}
       
        {*<h2>{lang key='orderForm.transferToUs'}</h2>*}
        <h3>{lang key='orderForm.transferExtend'}*</h3>
       
        <form method="post" action="cart.php" id="frmDomainTransfer">
            <input type="hidden" name="a" value="addDomainTransfer">
            <div class="row">
                <div class="col-sm-12">
                    <div class="panel panel-choose-domain m-b-8">
                        <div class="panel-body panel-domain-search pattern-bg-domain">
                            <div class="m-w-416 m-a">
                                <div id="transferUnavailable" class="alert alert-warning slim-alert text-center hidden"></div>
                                <div class="form-group">
                                    <label for="inputTransferDomain">{lang key='domainname'}</label>
                                    <input type="text" class="form-control" name="domain" id="inputTransferDomain" value="{$lookupTerm}" placeholder="{lang key='yourdomainplaceholder'}.{lang key='yourtldplaceholder'}" data-toggle="tooltip" data-placement="left" data-trigger="manual" title="{lang key='orderForm.enterDomain'}" />
                                </div>
                                <div class="form-group">
                                    <label for="inputAuthCode">{lang key='orderForm.authCode'}</label>
                                    <div class="form-tooltip">
                                        <input type="text" class="form-control" name="epp" id="inputAuthCode" placeholder="{lang key='orderForm.authCodePlaceholder'}" data-toggle="tooltip" data-placement="left" data-trigger="manual" title="{lang key='orderForm.required'}" />
                                        <i class="ls ls-info-circle tooltip-icon" data-toggle="tooltip" data-html="true" data-original-title="" title="{lang key='orderForm.authCodeTooltip'}"></i>
                                    </div>
                                </div>
                                {if $captcha->isEnabled() && !$captcha->recaptcha->isEnabled()}
                                    <div class="captcha-container" id="captchaContainer">
                                        <div class="default-captcha">
                                            <p>{lang key="cartSimpleCaptcha"}</p>
                                            <div class="pull-left input-group w-100">
                                                <div class="input-group-addon">
                                                    <img id="inputCaptchaImage" src="{$systemurl}includes/verifyimage.php" />
                                                </div>
                                                <input id="inputCaptcha" placeholder="{$LANG.enter_code}" type="text" name="code" maxlength="6" class="form-control" data-toggle="tooltip" data-placement="right" data-trigger="manual" title="{lang key='orderForm.required'}" />
                                            </div>
                                        </div>
                                    </div>
                                {elseif $captcha->isEnabled() && $captcha->recaptcha->isEnabled() && !$captcha->recaptcha->isInvisible()}
                                    <div class="form-group recaptcha-container" id="captchaContainer"></div> 
                                {/if}
                                <button type="submit" id="btnTransferDomain" class="btn btn-primary btn-transfer {$captcha->getButtonClass($captchaForm)}">
                                    <span id="addToCart"><i class="ls ls-basket m-r-8"></i>{lang key="ordernowbutton"}</span>
                                    <span class="loader loader-button">
                                        {include file="$template/includes/loader.tpl" classes="spinner-sm"}  
                                    </span>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>
        <p class="text-light small">* {lang key='orderForm.extendExclusions'}</p>
    </div>
{/if}