{if isset($RSThemes['pages']['error'])}
    {include file=$RSThemes['pages']['error']['fullPath']}
{else}  
    {include file="orderforms/lagom/common.tpl"}

    <div class="message message-danger message-lg message-no-data">
        <div class="message-icon">
            <i class="lm lm-close"></i>
        </div>
        <h2 class="message-text">{$errortitle}</h2>                    
        <p class="text-center text-light">{$errormsg}</p>
        <a href="javascript:history.go(-1)" class="btn btn-default">
            {$LANG.problemgoback}
        </a>
    </div>
{/if}