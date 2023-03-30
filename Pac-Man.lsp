<?lsp title="Examples: Pac-Man Game" response:include".header.lsp" 
local sockname = app.rmIPv6pf(request:sockname())
?>

   <h1>TCP to WebSockets Tutorial</h1>
<p>The Telnet to PAC-MAN Web Game is a tutorial that shows how to route real-time TCP messages between a TCP client (in this case a telnet client) and a browser. The communication is routed via the server that translates standard TCP messages to and from WebSocket Messages.</p>

<?lsp if pacmanTelnetPort then ?>
<br/>
<fieldset>
    <legend>PAC-MAN</legend>
   <p><b>After starting the Pac-Man game in a browser by clicking the button below, use a telnet client and telnet to: <?lsp=pacmanTelnetPort == 23 and sockname or string.format("%s (port number %d)",sockname,pacmanTelnetPort)?>.</b></p>
<p><br></p>
<p style="margin:auto;width:300px" id="NextBut"><a target="_blank" class="button" href="/pacman/">Start the Pac-Man Game</a></p>
<br>
</fieldset>
<p><br></p>
<?lsp end ?>
<p>The game controller, which includes the telnet server, is designed entirely in the Lua scripting language. The game controller is responsible for proxying the traffic between the telnet client and the Pac-Man game running in the browser. The game controller's source code (Lua script) uses ready to use components such as the <a target="_blank" href="/ba/doc/?url=SockLib.html">high level socket/websocket API</a>.</p>
<div style="margin:auto;width:560px">
<iframe id="pacman" width="560" height="315" src="https://www.youtube.com/embed/56Vo3F3sD0k?ecver=1<?lsp 

if not page.played then
   response:write"&autoplay=1"
   page.played=true
end

?>" frameborder="0" allowfullscreen></iframe>
</div>

<h2>How the Telnet to Pac-Man Server Works</h2>
<ol>
<li>A browser navigates to the Pac-Man "game controller" running in the server.</li>
<li>The Pac-Man game, which is completely implemented in JavaScript, is loaded into the browser.</li>
<li>The browser loads all resources such as the MP3 sound files.</li>
<li>The game's JavaScript code opens a persistent websocket communication channel with the server.</li>
<li>The game is now ready to accept a telnet connection.</li>
<li>A telnet client connects to the server.</li>
<li>The game controller connects the two clients together and initiates the game.</li>
<li>Keyboard events are sent from the telnet client to the Pac-Man game running in the browser via the game controller proxy.</li>
<li>When the game ends, JavaScript code sends an event to the game controller, which then terminates the telnet connection.</li>
</ol>

<div class="center"><img src="images/PacMan.jpg" alt="Pac-Man"/></div>
<br/><br/>
<?lsp if not pacmanTelnetPort then ?>
<div class="blogsidebar" style="width:90%;float:none;margin: 0 auto;display:block">
<h3>The Pac-Man game is not loaded!</h3>
<p>You will see a "start Pac-Man button" here when the Pac-Man game is loaded by the wfs server. The Pac-Man game is not loaded when you run the "startdemo" script. You can stop the server and restart the server by using the "start-all" script.</p>

<b>Start:</b> <?lsp=ba.openio"home":realpath""?>start-all

<p>The "start-all" script instructs the wfs server to load all examples, including Pac-Man.</p>
<p>Note: a telnet client is required when running the Pac-Man game.</p>
</div>
<br/>
<?lsp end ?>

<?lsp response:include"footer.shtml" ?>
