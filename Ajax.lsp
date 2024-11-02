<?lsp title="LSP: Ajax" response:include".header.lsp" ?>
<h1>Providing a Real Time Web Interface Using AJAX</h1>
<div class="rh">

<p>To create responsive, dynamic web applications, you need to load and submit data asynchronously without reloading the page. Modern techniques have evolved beyond traditional AJAX to methods that are faster, more flexible, and easier to code, such as the <samp>Fetch API</samp> and <samp>WebSockets</samp>. These technologies form the foundation for real-time, single-page applications (SPAs). In this tutorial, we will look into how to implement the AJAX technology using the Fetch API and WebSockets by showing how to implement AJAX over WebSockets.</p>

<details open>
<summary class="exth">Using the Fetch API</summary>

<p>The following examples from the <a target="_blank" href="https://makoserver.net/articles/Ajax-for-Beginners">Ajax for Beginners Tutorial</a> are designed to provide a hands-on understanding of real-time data handling and user interaction. Each step is broken down to show how these functions work, giving you a practical grasp of asynchronous web communication.</p>

<p>The following example is the JavaScript foundation for the two AJAX examples below. Every time the event triggers, the keyboard key number is converted to text, and the text is then appended to the HTML in the browser.</p>

<div class="lspeditor" example="7.1"></div>

<p>The following example shows how to use the JavaScript Fetch API in the browser and Lua Server Pages on the server side to handle client-server communication. Here, the JavaScript code captures keypress events and sends each character’s key code to the server, where it is echoed and sent back to the browser, which then updates the page in real-time with the server’s response.</p>

<?lsp if mako.daemon then ?>
<div class="alert alert-warning">
  <p><b>Note:</b> you cannot see the console output since the server is running as a background service, 
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

<p>By using WebSockets, we can multiplex data over a single connection, allowing us to implement an AJAX library on top of WebSockets while maintaining bi-directional, real-time data transfer.</p>

<p>This version has been adapted to run on the Lua example engine, with all code consolidated into a single file for simplicity. Before diving into this example, you may find it helpful to review the <a href="WebSockets.lsp">WebSockets Introduction</a> and the <a target="_blank" href="https://makoserver.net/articles/AJAX-over-WebSockets">AJAX over WebSockets Tutorial</a>, which provides insights into the mechanics of this example.</p>

<p>In this example, JavaScript leverages the <a target="_blank" href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Using_promises">Promise API</a> and JQuery. You can <a target="_blank" href="https://github.com/RealTimeLogic/LSP-Examples/blob/master/AJAX-Over-WebSockets/www/promise.html">download an alternative version from GitHub</a> that also uses async-await and the native DOM API instead of using JQuery.</p>

<div class="lspeditor" example="AjaxOverWebSockets"></div>

</details>

<p id="NextBut"><a href="WebSockets.lsp">Next Tutorial</a></p>

</div>
<?lsp response:include"footer.shtml" ?>
