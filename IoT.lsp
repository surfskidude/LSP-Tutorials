<?lsp title="Protocols: SMQ IoT Examples" response:include".header.lsp"

local dio=ba.openio"disk"
local ci=io:dofile(".lua/C-Install.lua",_ENV)

local function getBatchFile()
   response:reset"buffer"
   local tcd=dio:realpath(ci.getTCCDir())
   response:setheader("Content-type","application/octet-stream")
   response:setheader(
     "Content-Disposition",'attachment; filename="CompileSmqLedDemo.bat"')
   response:setheader(
     "Cache-Control","no-store, no-cache, no-transform, must-revalidate, private")
   response:setheader("Pragma","private")
   response:setheader("Expires","0")
   response:write(string.format(
       '@set TCC="%s"\n%s',
       tcd,
       [[
@echo off
set CC=tcc
set AR=tcc
set RANLIB=echo
set ARFLAGS=-r -o
set EXTRALIBS=-lwsock32 -lrpcrt4
set EXT=.exe
set PATH=%TCC%;%PATH%
set PLAT=Win
set CFLAGS=-Isrc/arch/Windows -DNO_getaddrinfo
echo *********************    COMPILING USING TCC ***************************
echo on

make
@pause
led-smq.exe
]]))

   response:abort()
end

if request:method() == "POST" then pcall(getBatchFile) end

?>

<h1>SMQ IoT Tutorials and Examples</h1>
<div class="rh">
<?lsp if pcall(function() require"smq.hub" end) then ?>

<p><a target="_blank" href="https://realtimelogic.com/products/simplemq/">SMQ</a> is an IoT protocol for controlling and managing devices in real time from a web interface. Broker instances are created programmatically on the server using Lua Server Pages. Since SMQ starts its connection with HTTP(S), each broker can have its own URL. This makes it practical to give each customer a separate broker instance and keep access control simpler.</p>

<p>The <a target="_blank" href="/ba/doc/?url=SMQ.html">SMQ documentation</a> provides an introduction and a few basic hands-on examples.</p>

<p><strong>The examples below are for the three following SMQ tutorials:</strong></p>

<ul>
    <li><a target="_blank" href="https://makoserver.net/articles/Designing-a-browser-based-Chat-Client-using-SimpleMQ">A basic chat client</a></li>
    <li><a target="_blank" href="https://makoserver.net/articles/Improving-the-browser-based-Chat-Client">Improving the chat client</a></li>
    <li><a target="_blank" href="https://makoserver.net/articles/Browser-to-Device-LED-Control-using-SimpleMQ">Device LED control</a></li>
</ul>

<h2>Example 1: A basic chat client</h2>

<p>The basic HTML/JavaScript chat client shows how publish and subscribe can send messages to all connected clients and receive those published messages.</p>

<p><a target="_blank" href="/chat/BasicChat.html">Basic Chat Client</a></p>

<p>When running the example, open multiple browser windows. Text input is at the bottom of the chat page.</p>

<h2>Example 2: Improving the chat client</h2>

<p>The improved chat client builds on the basic chat client and shows how to use SMQ's one-to-one messages. Chat messages are still broadcast to all connected clients, but one-to-one messages build the list of connected users. The user list appears in the left pane, and each list entry changes color when that user types.</p>

<p><a target="_blank" href="/chat/index.html">Improved Chat Client</a></p>

<p>When running the example, open multiple browser windows.</p>

<h2>Example 3: Device LED control</h2>

<p>The device LED control example shows how to use the SMQ IoT protocol to build a web-based device management interface for controlling LEDs in one or more devices.</p>

<p><a target="_blank" href="/led-control/index.html">Device LED control</a></p>

<p>The SMQ LED web interface initially shows no connected devices. Connect at least one SMQ C client to your own SMQ broker. Download and compile the SMQ client C code as follows:</p>

<details open>
  <summary>SMQ C Client</summary>
<ol>
<li>Download the <a target="_blank" href="https://codeload.github.com/RealTimeLogic/SMQ/zip/master">SMQ C Client Example from GitHub</a>.</li>
<li>Unzip to any directory.</li>
<li>Using your favorite editor, open SMQ-master\examples\m2m-led.c and change the following:
<pre class="code">
#define SMQ_DOMAIN "http://simplemq.com"
</pre>
to
<pre class="code">
#define SMQ_DOMAIN "http://<?lsp=string.format('%s%s',app.rmIPv6pf(request:sockname()), mako.port == 80 and '' or (':'..mako.port))?>"
</pre>
</li>
<li>Compile the code for
<?lsp if ci.getTCCDir() then ?>
Windows by using the included <a target="_blank" href="https://www.visualstudio.com/vs/community/">Visual C++</a> project file. Alternatively, download the following batch file which is setup to compile the code using the included TCC compiler. <form style="width:80px;margin:10px auto" method="POST"><input type="submit" value="Download Batch File"/></form>
Move the downloaded batch file to the SMQ-master directory (where the Makefile is found) and double click the batch file to compile the code.
<?lsp if ci.check() then ?>
<b>Note:</b> the TCC compiler must first be installed by clicking the install button in the <a href="Lua-Bindings.lsp">Lua to C Code</a> tutorial.
<?lsp end ?>
<?lsp else ?>
POSIX (such as Linux) by using the provided makefile.
<?lsp end ?>
</li>
<li>Start the led-smq executable -- i.e. start the compiled code.</li>
<li>Click the <a target="_blank" href="/smq/">/smq/</a> URL to open the web-based LED management controller.</li>
</ol>
</details>
<details open>
  <summary>Experimenting with the server-side code</summary>

<p>The included ZIP file <code>IoT.zip</code> contains the SMQ IoT server code for the chat and LED examples. You can run these examples as part of the main tutorial or run the IoT application separately.</p>

<p>Unzip <code>IoT.zip</code>, run the IoT application in developer mode, and experiment with the code as follows:</p>

<pre class="code">mkdir IoT
cd IoT
unzip <?lsp=app.exio:realpath"IoT.zip"?>
cd ..
mako -l::IoT
</pre>
<p>This SMQ IoT example bundle and additional SMQ examples can be downloaded from <a target="_blank" href="https://github.com/RealTimeLogic/LSP-Examples/tree/master/SMQ-examples">GitHub</a>.
</details>
<?lsp else -- pcall
print'<p>This example requires a <a target="_blank" href="https://makoserver.net/download/overview/">newer Mako Server</a>!</p>'
end
?>
<p id="NextBut"><a href="MQTT.lsp">Next Tutorial</a></p>

</div>
<?lsp response:include"footer.shtml"

?>
