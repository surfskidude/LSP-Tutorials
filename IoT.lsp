<?lsp title="SMQ IoT Examples" response:include".header.lsp"

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

<p><a target="_blank" href="https://realtimelogic.com/products/simplemq/">SMQ</a> is an IoT protocol that lets you control and manage one to millions of IoT devices in real time from the same user interface. Broker instances are created programmatically on the server using Lua Server Pages. Since SMQ initiates the connection using HTTP(S), each broker instance is set up with a unique URL making it both easy and convenient to have one broker instance per customer. Isolating broker instances per customer greatly simplifies access control management design.</p>

<p>The <a target="_blank" href="/ba/doc/?url=SMQ.html">SMQ documentation</a> provides an introduction and a few basic hands-on examples.</p>

<p><strong>The following examples are for the three SMQ tutorials:</strong></p>

<ul>
    <li><a target="_blank" href="https://makoserver.net/articles/Designing-a-browser-based-Chat-Client-using-SimpleMQ">A basic chat client</a></li>
    <li><a target="_blank" href="https://makoserver.net/articles/Improving-the-browser-based-Chat-Client">Improving the chat client</a></li>
    <li><a target="_blank" href="https://makoserver.net/articles/Browser-to-Device-LED-Control-using-SimpleMQ">Device LED control</a></li>
</ul>

<h2>A basic chat client</h2>

<p>The basic HTML/JavaScript powered chat client that shows how to use publish and subscribe for sending messages to all connected clients and how to receive the published messages.</p>

<p><a target="_blank" href="/chat/BasicChat.html">Basic Chat Client</a></p>

<p> When running the example, open multiple browser windows. Text input is at the bottom of the chat page.</p>

<h2>Improving the chat client</h2>

<p>The improved chat client builds on the basic chat clients and shows how to use SMQ's one-to-one messages. Messages are still broadcasted to all connected clients, but one-to-one messages are used for building a list of all connected users. The user list is shown in the left pane and each list entry changes color when the user types.</p>

<p><a target="_blank" href="/chat/index.html">Improved Chat Client</a></p>

<p>When running the example, open multiple browser windows.</p>

<h2>Device LED control</h2>

<p>The device LED control example show how to use the SMQ IoT Protocol for designing a web based IoT device management user interface for controlling Light Emitting Diodes (LEDS) in one or multiple devices.</p>

<p><a target="_blank" href="/led-control/index.html">Device LED control</a></p>

<p>The SMQ LED web interface shows no connected devices. You must connect at least one SMQ C Client to your own SMQ broker. Download and compile the SMQ client C code as follows:</p>

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
<li>Click the <a target="_blank" href="/smq/">/smq/</a> URL to open the web based LED management controller.</li>
</ol>
</details>
<details open>
  <summary>Experimenting with the server side code</summary>

<p>The included ZIP file IoT.zip includes the SMQ IoT server code for the SMQ chat and SMQ LED examples. You may run the IoT examples as part of the main tutorial, but you may also run the IoT example separately.</p>

<p>Unzip IoT.zip, run the IoT in developer mode, and experiment with the code as follows:</p>

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
