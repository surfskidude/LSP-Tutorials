<?lsp title="LSP: Ajax" response:include".header.lsp" ?>
<h1>Providing a Real Time Web Interface Using AJAX</h1>
<div class="rh">

<p>Responsive web applications often need to send or receive data without reloading the whole page. Traditional AJAX solved this problem, and modern browser APIs such as <samp>Fetch API</samp> and <samp>WebSockets</samp> make the same idea easier and more flexible. This tutorial shows how to use Fetch with LSP and then how to build an AJAX-style layer over WebSockets.</p>

<details open>
<summary class="exth">Using the Fetch API</summary>

<p>The following examples from the Ajax for Beginners tutorial give you hands-on practice with asynchronous browser-to-server communication. Each step focuses on one small piece so you can see how the browser sends data and how the server responds.</p>

<div class="alert alert-warning">
<p><b>Note:</b> You can find a detailed explanation of how the following examples work in the <a target="_blank" href="https://makoserver.net/articles/Ajax-for-Beginners">written AJAX tutorial</a>.</p>
</div>




<p>The following example is the JavaScript foundation for the two AJAX examples below. Each time a key event occurs, the key code is converted to text and appended to the HTML in the browser.</p>

<div class="lspeditor" example="7.1"></div>

<p>The following example uses the JavaScript Fetch API in the browser and Lua Server Pages on the server. JavaScript captures keypress events and sends each key code to the server. The server echoes the value back, and the browser updates the page with the response.</p>

<?lsp if mako.daemon then ?>
<div class="alert alert-warning">
  <p><b>Note:</b> you cannot see the console output because the server is running as a background service,
  however, you can still see the server's output by opening the <a target="_blank" href="/rtl/tracelogger/">TraceLogger</a>.</p>
</div>
<?lsp end ?>

<div class="lspeditor" example="7.2"></div>

<p>The example below demonstrates how to send JSON data to the server upon clicking a button. This setup includes server-side code that processes incoming data in real-time, parsing each chunk with a stream-based JSON parser. To test it, click 'Run' to start the example, then enter valid JSON in the HTML area and click 'Send.' For sample data, you can copy JSON objects from <a target="_blank" href="https://www.json.org/">json.org</a>.</p>

<div class="lspeditor" example="7.3"></div>


</details>


<details open>
  <summary id="AJAXoverWebSockets" class="exth">AJAX over WebSockets</summary>

<p>This example is a modified version of the code featured in our <a target="_blank" href="https://makoserver.net/articles/AJAX-over-WebSockets">AJAX over WebSockets Tutorial</a>.</p>

<p>With WebSockets, we can send several logical messages over one persistent connection. This lets us implement an AJAX-style request/response library on top of WebSockets while keeping bidirectional, real-time communication.</p>

<p>This version has been adapted to run in the Lua example engine, with all code placed in a single file for simplicity. Before working through it, review the <a href="WebSockets.lsp">WebSockets Introduction</a> and the <a target="_blank" href="https://makoserver.net/articles/AJAX-over-WebSockets">AJAX over WebSockets Tutorial</a> if you want more background.</p>

<p>In this example, JavaScript leverages the <a target="_blank" href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Using_promises">Promise API</a> and JQuery. You can <a target="_blank" href="https://github.com/RealTimeLogic/LSP-Examples/blob/master/AJAX-Over-WebSockets/www/promise.html">download an alternative version from GitHub</a> that uses async-await and the native DOM API instead of using JQuery.</p>

<div class="lspeditor" example="AjaxOverWebSockets"></div>

</details>

<p id="NextBut"><a href="WebSockets.lsp">Next Tutorial</a></p>

</div>
<?lsp response:include"footer.shtml" ?>
