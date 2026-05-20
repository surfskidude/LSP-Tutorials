<?lsp title="LSP: BAS API" response:include".header.lsp" ?>

   <h1>Barracuda App Server API Tutorial</h1>

<p>The Barracuda App Server (BAS) API tutorial is a separate application with additional BAS-specific lessons. It introduces the server's virtual file system, shows how to send email, demonstrates the HTTP client library, and covers other server APIs.</p>

<p>The BAS API tutorial also shows how to use the BAS Input/Output (I/O) library. BAS I/O complements the default Lua I/O library. Lua I/O is available on high-level operating systems, while BAS I/O can also work in deeply embedded systems that do not have a native file system.</p>

<p><br/></p>
<a class="btn primary" target="_blank" href="/BAS-API-Tutorial/">Start BAS API Tutorial</a>

<p>
</p>
<p><b>Note:<br></b>
You can also run the BAS tutorials separately as follows:</p>
<pre class="code" data-lang="bash">mako -l::<?lsp=app.exio:realpath"BAS-API-Tutorial.zip"?></pre>

<?lsp response:include"footer.shtml" ?>
