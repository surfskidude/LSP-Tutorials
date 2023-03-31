<?lsp title="LSP: WebSockets" response:include".header.lsp" ?>
<h1>WebSockets Introduction</h1>
<div class="rh">

<div class="blogsidebar"><p>The Barracuda App Server provides two WebSocket implementations: the WebSocket client/server implementation designed for Lua that we cover in the following examples, and the <a target="_blank" href="https://github.com/RealTimeLogic/BAS/blob/main/examples/C-WebSockets/README.md">C WebSocket Server</a>.</div>

<p>WebSocket provides full-duplex and persistent client/server communication over TCP. It enables JavaScript clients to open bi-directional socket connections to a server. The WebSocket protocol is currently supported in all major browsers.</p>

<p>The main characteristic of WebSockets is the ability to perform bi-directional communication without breaking the connection. WebSocket connections are basically TCP socket connections that following the WebSocket rules to communicate. The WebSocket Protocol initially starts as an HTTP(S) connection and is morphed into an independent TCP-based protocol when the server and client have completed the initial Websocket handshake. Morphing the HTTP(s) connection into a persistent (secure) TCP connection is in WebSocket terminology called a "WebSocket Upgrade".</p>

<p>A WebSocket URL looks like this:<br/>
<b>ws(s)://host:port/path</b>
</p>

<p>The connection is made to the host on the given port number. You do not need to specify the port number if the server is using the default port numbers 80 and 443. The protocol starts with ws for non secure communication and wss for secure (SSL) communication. A WebSocket URL must always be an absolute URL, even when connecting back to the origin server.</p>

<p>An introduction to using WebSockets from JavaScript can be found on the web site HTML5 Rocks. Please consult the <a target="_blank" href="http://www.html5rocks.com/en/tutorials/websockets/basics/">HTML5 Rocks's WebSockets tutorial</a> if you need more information on how the JavaScript code works in the following example.</p>

<p>Note that the server side LSP page in the following example is accessed twice by the browser when you click the run button:</p>
<ol>
<li>The web application starting on line 18 is loaded into the browser.</li>
<li>JavaScript code now running in the browser connects to the same server side LSP page, but this time, the browser sends a WebSocket request.</li>
</ol>

<div class="lspeditor" example="8.1"></div>

<p>Clicking the above Run button should start the WebSocket connection if your browser supports WebSockets. You should see printouts in the server's console window and in the example's iframe above.</p>

<p><b>Example 8.1 Client Code:</b></p>
<ul>
<li><b>Line 23:</b> A function that implements a basic console print function. The function uses the jQuery JavaScript library for appending text to the HTML element on line 52.</li>
<li><b>Line 26:</b> We construct an absolute WebSocket URL by using server side code. Method request:url returns the URL of the LSP page. We apply a Lua regular expression and replaces http(s) with ws(s) on the returned string.</li>
<li><b>Line 27:</b> A URL modification required by the LSP example engine. This code is specific for the embedded tutorial engine, and you would not use this construction in a standard LSP page. The URL encoded parameters make it possible for the server side LSP example engine to route the WebSocket request to the LSP code for example 8.1.</li>
<li><b>Line 30:</b> We wrap the creation of the client side WebSocket object into a try/catch.  The code fails if the browser does not support WebSockets and "s" will be undefined on line 31 if we get an exception.</li>
<li><b>Lines 35 - 36:</b> We construct the WebSocket object's callback functions.</li>
</ul>

<p><b>Example 8.1 Server Code:</b></p>

<ul>
<li><b>Line 2:</b> The HTTP header Sec-WebSocket-Key is automatically set by the browser when the browser sends a WebSocket upgrade request to the LSP page. We simply use this construction to detect a WebSocket request. If it's not a WebSocket request, then the HTML and JavaScript code starting on line 18 is sent to the browser.</li>
<li><b>Line 4:</b> Function <a target="_blank" href="/ba/doc/?url=auxlua.html#ba_socket_req2sock">ba.socket.req2sock</a> morphs the HTTP request into a WebSocket connection -- in other words, it performs the WebSocket upgrade management. The function returns a socket object if the upgrade is successful. Note that calling function ba.socket.req2sock invalidates the request/response object and you can no longer use these two objects after calling this function.</li>
<li><b>Line 6 - 11:</b> We loop 5 times and for each iteration we do: send a message to the client and make the current thread sleep one second. At this point, we are still running in the context of one of the server's HTTP threads. The server keeps a pool of threads and we are using one thread for sending WebSocket data to the client. Please note that in a real case scenario, you would normally set the WebSocket in non blocking mode and immediately release the HTTP thread. In our basic example, we simply keep the HTTP thread working for 5 seconds before releasing the thread.</li>
<li><b>Line 13-14:</b> when we are done looping, the socket is closed and we return out of the LSP page, thus releasing the HTTP thread.</li>
</ul>

<p>See <a target="_blank" href="/ba/doc/?url=SockLib.html">Designing Socket Protocols in Lua</a> in the Barracuda App Server documentation if you want to get a deeper understanding of how to use WebSockets.</p>

<p><b>Download similar <a target="_blank" href="https://github.com/RealTimeLogic/LSP-Examples/tree/master/socket-examples">WebSocket examples from GitHub</a>.</b></p>
<a name="SMQ"></a>
<details open>
  <summary>Using SMQ for WebSocket Communication</summary>
  <p><a target="_blank" href="/ba/doc/?url=SMQ.html">Simple Message Queues</a> is a pub-sub protocol that uses WebSockets for the communication between browsers and the server. In fact, the SMQ broker, is built by using <a target="_blank" href="/ba/doc/?url=SockLib.html#cosocket">cosockets</a> provided by the server. The protocol's documentation focuses on IoT communication for devices, but the SMQ protocol can also be used for browser to server communication and vice versa. The broker provides an API that enables Lua code running on the server side to act as an SMQ client; thus you can easily design communication channels between browsers and the server.</p>

<blockquote>
<p>Why you should consider using SMQ and not raw WebSockets is explain in the tutorial <a target="_blank" href="https://realtimelogic.com/articles/Modern-Approach-to-Embedding-a-Web-Server-in-a-Device">Modern Approach to Embedding a Web Server in a Device</a></p>
</blockquote>

  <p>The following example requires some understanding of the Lua scope and using coroutines so you may want to take a look at these two tutorials (<a href="Lua-Scope.lsp">Scope</a> and <a href="Lua-Coroutines.lsp">Coroutine</a>) prior to running the two following examples. You may also want to check out the <a target="_blank" href="/ba/doc/?url=SMQ.html">SMQ introduction</a>, which provided a gentle introduction to SMQ pub/sub messaging.</p>
  <p>The SMQ example is split up into two parts: the server side in example 8.2 and the client side in example 8.3. The two examples are designed to provide the same features as example 8.1. Only the server sends data and the server keeps sending 5 messages before stopping. Notice that we cannot disconnect the connection from the server as we did in example 8.1 so the server side simply goes quiet after sending 5 messages.</p>
  <p><b>The SMQ URL:</b><br/>
  The SMQ connection sequence initially starts as HTTP(S), and it's common to use an LSP page as the URL destination. Due to how the example engine works, we have in the following example used a server directory function and a <a target="_blank" href="/ba/doc/?url=GettingStarted.html#directory">directory instance</a> instead of an LSP page. We create an SMQ broker instance on line 1 below. The directory function on line 3 simply redirects the incoming request to the broker. We create a directory on line 8-10 and insert the directory into the <a target="_blank" href="/ba/doc/?url=GettingStarted.html#VFS">virtual file system</a>.</p>
  <p><b>Server side code acting as client:</b><br/>
  The client acting server code starts on line 19. The function send5Messages's inner function "timeout" is similar to the loop in example 8.1, but uses a coroutine since we cannot block when using SMQ. We will cover coroutines in detail later. The function simply loops 5 times, publishes a message to the JavaScript client running in the browser on line 27, and sleeps until the next timer event on line 28. The <a target="_blank" href="/ba/doc/?url=lua.html#ba_timer">timer coroutine</a> starts as soon as function send5Messages is called (line 32).</p>
  <div class="lspeditor" extype="lua" example="8.2"></div>
  <p>To get the example started, the client side JavaScript code is designed such that it publishes a "hello" message as soon as it starts. The server side subscribes to this topic on line 36. When the client publishes the hello message, function send5Messages is called.</p>
  <p>Click the run button above to install the server side code. The client side code in the next example will not run unless the server side is installed.</p>
  <p>The client side code, which runs in the browser, is shown in example 8.3.</p>
  <div class="lspeditor" example="8.3"></div>
  <p>The connection to the broker on the server is established on line 10. The helper function SMQ.wsURL translates a relative URL to an absolute URL required by WebSockets. Notice that the relative URL corresponds to the location in the server's virtual file system where we install the broker in example 8.2.</p>
  <p>We subscribe to "self" on line 4. Self means subscribing to the client's ephemeral ID and makes it possible for the server to send a message directly to the client. This message is sent on line 27 in example 8.2.</p>
  <p>We publish to the topic "hello" on line 15 to start the send5Messages function on the server side.</p>
  <p>Clicking the above run method should show a hello message being printed 5 times, with a one second pause between each printed line.</p>
  <p>See the <a href="IoT.lsp">Internet of Things demos/tutorials</a> for more information on how to use SMQ.</p>
</details>

<p id="NextBut"><a href="Sockets.lsp">Next Tutorial</a></p>

</div>
<?lsp response:include"footer.shtml" ?>
