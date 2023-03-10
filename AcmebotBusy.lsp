<?lsp
local acmebot=require"acmebot"
local jobs=acmebot.status()
response:json{busy=jobs > 0 and true or false}
?>
