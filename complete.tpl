{if isset($RSThemes['pages']['complete'])}
    {include file=$RSThemes['pages']['complete']['fullPath']}
{else} 
    <div class="message message-success message-lg message-no-data">
        <div class="message-icon">
            <i class="lm lm-check"></i>
        </div>
        <h2 class="message-text">{$rslang->trans('order.order_placed')} #{$ordernumber}</h2>                    
        <p class="text-center text-light">{$LANG.orderfinalinstructions}</p>
        {if $expressCheckoutInfo}
            <div class="alert alert-info text-center">
                {$expressCheckoutInfo}
            </div>
        {elseif $expressCheckoutError}
            <div class="alert alert-danger text-center">
                {$expressCheckoutError}
            </div>
        {elseif $invoiceid && !$ispaid}
            <div class="alert alert-warning text-center">
                {$LANG.ordercompletebutnotpaid}
                <br /><br />
                <a href="viewinvoice.php?id={$invoiceid}" target="_blank" class="alert-link">
                    {$LANG.invoicenumber}{$invoiceid}
                </a>
            </div>
        {/if}
        {if $ispaid}
            <!-- Enter any HTML code which should be displayed when a user has completed checkout here -->
            <!-- Common uses of this include conversion and affiliate tracking scripts -->
        {/if}
        {foreach $addons_html as $addon_html}
            <div class="order-confirmation-addon-output">
                {$addon_html}
            </div>
        {/foreach}
        <a href="clientarea.php" class="btn btn-default">
            {$LANG.orderForm.continueToClientArea}
        </a>
    </div>
{/if}