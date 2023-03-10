<?lsp
title="Introduction"
response:include".header.lsp"
?>
<div class="rh">

<div class="article-spacer">
  <h1>Lua REPL Introduction</h1>
</div>

<details open>
<summary>How the interactive examples work</summary>
<p>The examples provided in these tutorials are loaded from the server using AJAX and displayed in a fully functional web-based Lua/LSP editor. You have the ability to edit any of the examples and save your changes by clicking the 'Run' button. This button not only saves your changes, but also executes the LSP page on the server and displays the result below in an iframe. Give it a try by clicking the 'Run' button below and see the result appear in the iframe.</p>
  <div class="lspeditor" example="1.1"></div>
<p>The revert button reverts the example back to the original code and hides the iframe.  Click line 2 in the above editor, modify the text 'Hello World' to 'LSP Rocks', and click the Run button. You can then try the Revert button and revert the example back to its original form.</p>
</details>

<details open>
  <summary>LSP Tags</summary>
  <p>Lua code can be written right into your HTML like this:</p>
  <div class="lspeditor" example="1.2"></div>
  <p>Your Lua code goes inside the <strong>&lt;?lsp</strong> and <strong>?&gt;</strong> delimiters. Here we use the function print to output "Hello". We also output the text "world!" by using the expression tag.</p>
  <p>Lua script can be freely intermixed with HTML or XML. LSP tags are XML compliant <strong>&lt;?lsp &nbsp;&nbsp; ?&gt;</strong>. Code between these tags is executed as Lua code. Expressions are provided by the <strong>&lt;?lsp= &nbsp;&nbsp; ?&gt;</strong> tag. The result of an expression is emitted as HTML/XML.</p>
</details>

<details>
  <summary>Application server v.s. web server</summary>

  <img src="https://realtimelogic.com/images/apps-server-vs-web-server.jpg" style="float:right;margin-left:15px;" />

  <p>An LSP page is automatically converted to a Lua script and then executed on the server when the page is accessed by a client such as a browser. The response from the LSP page is shown in your browser window.</p>

<p>"So what is the big deal?" You might say. "I can do that with JavaScript.", but that is incorrect. JavaScript generally runs in the browser or client. This means it only really knows what's going on in your browser, plus whatever information it gets from the server you're connecting to. In addition JavaScript's knowledge is limited.</p>

  <p>LSP, on the other hand, runs on the same computer as the website you're visiting, which is known as the server. This means that it has access to all the information and files on that machine, which allows it to construct custom HTML pages to send to your browser, handle cookies, and run tasks or perform calculations with data from that website.</p>

  <p>The following example shows how an LSP page runs on the server. The example produces no visual response in the browser, but is instead printing a message to the console window where the server is running. Reposition the server's console window next to your browser window, and click the run button. You should see a printout in the server's console window.</p>
  <p style="clear:both"></p>

  <div class="lspeditor" example="1.3"></div>

  <p>Line 4 in the above example sets variable 'print' to the global variable print, thus hiding the default print function in the LSP page. Lua provides scoping and environments. You will learn more about how this works in the <a href="Lua-Scope.lsp">Lua Scope tutorials</a>. Delete line 4 above and re-run the script. You should now see the Hello World message being printed in the browser window and not in the server's console window.</p>

  <p>In addition to using function print for sending response data, the Barracuda App Server also provides a method in the response object for sending response data. The method response:write is faster than function print since it does not deal with the specialties in the <a target="_blank" href="ba/doc/en/lua/man/manual.html#pdf-print">standard Lua print function.</a>

  <p>The following example shows how to use response:write.</p>

  <div class="lspeditor" example="1.4"></div>
</details>

<p id="NextBut"><a href="Lua-Types.lsp">Next Tutorial</a></p>

</div>
<?lsp response:include"footer.shtml" ?>
