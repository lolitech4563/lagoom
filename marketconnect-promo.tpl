<div class="mc-promo {$promotion->getClass()}" id="promo_{$product->productKey}">
    {assign var="promo_icon_temp" value=" "|explode:$promotion->getClass()}
    {assign var="promo_icon_temp2" value=$promo_icon_temp['0']}
    {if $promo_icon_temp2 == "ssl" || $promo_icon_temp2 == "symantec"}
        {assign var="promo_icon" value="symantec"}
    {elseif $promo_icon_temp2 == "weebly"}
        {assign var="promo_icon" value="weebly"}
    {elseif $promo_icon_temp2 == "spamexperts"}
        {assign var="promo_icon" value="spamexperts"}
    {elseif $promo_icon_temp2 == "sitelock"}
        {assign var="promo_icon" value="sitelock"}
    {elseif $promo_icon_temp2 == "codeguard"}
        {assign var="promo_icon" value="codeguard"}
    {elseif $promo_icon_temp2 == "sitelockvpn"}
        {assign var="promo_icon" value="vpn"}   
    {elseif $promo_icon_temp2 == "marketgoo"}
        {assign var="promo_icon" value="marketgoo"}        
     {elseif $promo_icon_temp2 == "ox"}
        {assign var="promo_icon" value="ox-apps"}            
    {/if}
    <div class="header">
    <div class="cta">
        <div class="price">
            {if $product->isFree()}
                {lang key="orderfree"}
            {elseif $product->pricing()->first()}
                {$product->pricing()->setQuantity($cartItem.qty)->first()->breakdownPrice()}
            {/if}
        </div>
        <button type="button" class="btn btn-sm btn-add" data-product-key="{$product->productKey}">
            <span class="text">
                {lang key="addtocart"}
            </span>
            <span class="arrow">
                <i class="ls ls-arrow-right"></i>
            </span>
        </button>
    </div>
        <div class="expander">
            <i class="lm lm-plus rotate down" data-toggle="tooltip" data-placement="right" title="Click to learn more"></i>
        </div>
        <div class="icon">
            {if file_exists("templates/lagom/assets/svg-illustrations/products/{$promo_icon}.tpl")}
                {include file="templates/lagom/assets/svg-illustrations/products/$promo_icon.tpl"}
            {/if}
        </div>
        <div class="content">
            <div class="headline">{$promotion->getHeadline()}</div>
            <div class="tagline">{$promotion->getTagline()}</div>
        </div>
    </div>
    <div class="body">
        {if $promotion->hasFeatures()}
            <ul>
                {foreach $promotion->getFeatures() as $feature}
                    <li><i class="ls ls-check"></i> {$feature}</li>
                {/foreach}
            </ul>
        {/if}
    </div>
</div>
