<?lsp
title="Introduction"
response:include".header.lsp"
?>
<div class="rh">

<div class="article-spacer">
  <h2>Lua REPL Introduction</h2>
</div>

<details open>
<summary>How the interactive examples work</summary>
<p>The examples in these tutorials are loaded from the server and displayed in a fully functional web-based Lua/LSP editor. You can change any example and test it by clicking the Run button. Run saves your changes, executes the LSP page on the server, and displays the result below the editor in an iframe. Try it now and watch the result appear below.</p>
  <div class="lspeditor" example="1.1"></div>
<p>The Revert button restores the original example and hides the iframe. Click line 2 in the editor above, change 'Hello World' to 'LSP Rocks', and click Run. Then click Revert to restore the original code.</p>
</details>

<details open>
  <summary>LSP Tags</summary>
  <p>Lua code can be written right into your HTML like this:</p>
  <div class="lspeditor" example="1.2"></div>
  <p>Your Lua code goes inside the <code>&lt;?lsp</code> and <code>?&gt;</code> delimiters. In this example, <code>print</code> outputs "Hello". The expression tag outputs "world!" directly into the page.</p>
  <p>Lua script can be mixed freely with HTML or XML. LSP code tags use the XML-compliant form <code>&lt;?lsp &nbsp;&nbsp; ?&gt;</code>. Code between these tags is executed as Lua code. Expression tags use <code>&lt;?lsp= &nbsp;&nbsp; ?&gt;</code>; the expression result is written into the HTML/XML response.</p>
</details>

<details>
  <summary>Application server vs. web server</summary>

  <img src="https://realtimelogic.com/images/apps-server-vs-web-server.jpg" style="float:right;margin:15px;" />

  <p>An LSP page is automatically converted to a Lua script and then executed on the server when the page is accessed by a client such as a browser. The response from the LSP page is shown in your browser window.</p>

<p>"So what is the big deal?" you might ask. "Can JavaScript do this?" JavaScript usually runs in the browser, which means it can see the current page and whatever data the server sends to it. It cannot directly read server files, use server-side APIs, or make decisions using private server data unless the server exposes that information.</p>

  <p>LSP, on the other hand, runs on the same computer as the website you're visiting, which is known as the server. This means that it has access to all the information and files on that machine, which allows it to construct custom HTML pages to send to your browser, handle cookies, and run tasks or perform calculations with data from that website.</p>

  <p>The following example shows that an LSP page runs on the server. It produces no visible response in the browser. Instead, it prints a message to the console window where the server is running. Place the server console next to your browser and click Run. You should see the message in the server console.</p>
  <p style="clear:both"></p>

  <div class="lspeditor" example="1.3"></div>

  <p>Line 4 in the example above sets the variable <code>'print'</code> to the global <code>print</code> function. This hides the LSP page's default <code>print</code> function. Lua supports scopes and environments, which you will explore in the <a href="Lua-Scope.lsp">Lua Scope tutorial</a>. Delete line 4 and run the script again. The Hello World message should now appear in the browser window instead of the server console.</p>

  <p>In addition to <code>print</code>, the Barracuda App Server provides <code>response:write</code> for sending response data. <code>response:write</code> is faster than <code>print</code> because it writes directly to the response and does not need the extra behavior of the <a target="_blank" href="ba/doc/en/lua/man/manual.html#pdf-print">standard Lua print function</a>.</p>

  <p>The following example shows how to use <samp>response:write</samp>.</p>

  <div class="lspeditor" example="1.4"></div>
</details>

<p id="NextBut"><a href="Lua-Types.lsp">Next Tutorial</a></p>

</div>
<?lsp response:include"footer.shtml" ?>
