<?lsp title="Protocols: HTTP Client" response:include".header.lsp" ?>

<h1>HTTP Client</h1>

<p>The Barracuda App Server features three HTTP client modules. For ease of use, we recommend utilizing the 'httpm' module. It inherits functions from the other two modules, thereby providing all the methods offered across the three HTTP client modules.</p>

<p>Consider the following example: it utilizes the JSON method to establish a connection with the <a href="wfs.lsp">Web File Manager</a> found in our online tutorials. It solicits a JSON response by incorporating the URL-encoded data cmd=lj within the request.</p>

<div class="rh">

<div class="lspeditor" extype="lua" example="HTTP-Client"></div>

<p>Consult the Barracuda App Server documentation for further details on <a target="_blank" href="https://realtimelogic.com/ba/doc/?url=auxlua.html#httplib">APIs and additional HTTP usage examples</a>.</p>

<?lsp response:include"footer.shtml" ?>
</div>
