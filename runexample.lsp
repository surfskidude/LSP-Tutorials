<?lsp 

local src=request:data"src"
src=src and ba.b64decode(src)

local exio=app.exio
if not src or not exio then response:sendredirect"/" end
local fn="ex"..tostring(ba.rnd())
local fp=exio:open(fn..".lsp","w")
if not fp then response:sendredirect"/" end
fp:write(src)
fp:close()

title="Run LSP Example" response:include".header.lsp"
?>

<h2>Online Mako Server (Barracuda App Server)</h2>

<p>Click the Run button to execute the Lua code on the server side.</p>

<div class="lspeditor" id="edit" example="<?lsp=fn?>"></div>
<?lsp if src:find"trace%s*[%('\"]" then print'<p>The output from the <b>trace</b> function can be viewed in the <a target="_blank" href="/rtl/tracelogger/">TraceLogger</a>.</p>' end ?>

<script>
$(function() {
    $("#edit").find("button:nth-child(3)").remove();
});
</script>

<?lsp response:include"footer.shtml" ?>
