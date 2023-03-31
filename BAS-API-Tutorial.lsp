<?lsp title="LSP: BAS API" response:include".header.lsp" ?>

   <h1>Barracuda App Server API Tutorial</h1>

<p>The Barracuda App Server (BAS) API tutorial is a separate application that provides additional BAS specific tutorials.  The BAS API tutorial provides an introduction to the server's virtual file system, shows how to send emails and use the HTTP client library, etc..</p>

<p>The BAS API tutorial also includes examples on how to use the BAS Input/Output (I/O) library, which is an additional I/O provided by BAS, in addition to the default Lua I/O. The Lua I/O is only available when using High Level Operating Systems (HLOS). However, the BAS I/O is available to any environment including deep embedded systems with no native file system support.</p>

<p><br/></p>
<p style="margin:auto;width:280px" id="NextBut"><a target="_blank" href="/BAS-API-Tutorial/">Start BAS API Tutorial</a></p>

<p>
</p>
<p><b>Note:<br></b>
You may also run the BAS tutorials separately as follows:</p>
<pre class="code">mako -l::<?lsp=app.exio:realpath"BAS-API-Tutorial.zip"?></pre>

<?lsp response:include"footer.shtml" ?>
