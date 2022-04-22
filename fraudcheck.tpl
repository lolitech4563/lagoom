{if isset($RSThemes['pages']['fraudcheck'])}
    {include file=$RSThemes['pages']['fraudcheck']['fullPath']}
{else} 
    <div class="main-content"> 
        <div class="message message-danger message-lg message-no-data">
            <div class="message-icon">
                <i class="lm lm-close"></i>
            </div>
            <h2 class="message-text">{$errortitle}</h2>                    
            <p class="text-center text-light">{$error}</p>
            <a href="submitticket.php" class="btn btn-default">
                {$LANG.orderForm.submitTicket}
            </a>
        </div>
    </div>
{/if}    