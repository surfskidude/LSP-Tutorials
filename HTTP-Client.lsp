<?lsp title="Protocols: HTTP Client" response:include".header.lsp" ?>

<h1>HTTP Client</h1>

<p>The Barracuda App Server includes three HTTP client modules. For most code, use the <code>httpm</code> module. It combines functionality from the other modules and gives you the broadest API in one place.</p>

<p>The following example uses the JSON helper method to connect to the <a href="wfs.lsp">Web File Manager</a> used by these tutorials. The request includes the URL-encoded data <code>cmd=lj</code>, which asks the Web File Manager to return JSON.</p>

<div class="rh">

<div class="lspeditor" extype="lua" example="HTTP-Client"></div>

<p>See the Barracuda App Server documentation for <a target="_blank" href="https://realtimelogic.com/ba/doc/?url=auxlua.html#httplib">more HTTP client APIs and examples</a>.</p>

<?lsp response:include"footer.shtml" ?>
</div>
