<?lsp
title="About" response:include".header.lsp"
local appuri=app.wfshdir.."applications/"
?>

<h1>Lua and LSP Tutorials</h1>
<div class="rh">

<?lsp app.loadex(_ENV,"About") ?>

<div class="article-spacer">
<p>Welcome to the tutorials for the <a target="_blank" href="https://realtimelogic.com/ba/doc/">high-level Lua APIs provided by the Barracuda App Server</a> (BAS) and Mako Server. The menu on the left links to all tutorials. For the best learning experience, start at the top and work your way down. The pages introduce the APIs step by step and show how BAS can be used to build applications.</p>

<p>The browser is used as an editor and as a place to display results. The actual processing happens on the server. When you click Run, the code shown in the browser is sent to the server, parsed, executed, and then returned to the browser as a response.</p>
<div style="max-width:640px;margin:auto">
<object class="background-white" style="width:100%;padding: 10px;border-radius:10px;" id="LuaREPL" type="image/svg+xml" data="images/LuaREPL.svg"></object>
</div>
<script src="/assets/js/LuaREPL.js"></script>

<?lsp if mako.daemon then ?>
<p></p>
<div class="alert alert-warning">
<h3>Note:</h3>
<p>The server is running in service (daemon) mode, which means it operates in the background. You will not see tutorial output written with <a target="_blank" href="https://realtimelogic.com/ba/doc/en/lua/lua.html#_G_trace">trace()</a> in a console window, but the same output is available in the included TraceLogger.</p>
<p>For the best experience, <a target="_blank" href="/rtl/tracelogger/">open the TraceLogger in a separate window</a>.</p>
</div>


<details open>
  <summary>Mako Server vs. Barracuda App Server</summary>
<p>The <a target="_blank" href="https://makoserver.net/">Mako Server</a> is built with the <a target="_blank" href="https://realtimelogic.com/products/barracuda-application-server/">Barracuda App Server</a> (BAS). BAS is a source code library, not a standalone product. Mako Server is a ready-to-run example of BAS packaged as a server, much like a "Hello World" program demonstrates a library in use.</p>
</details>

<?lsp
end
if not demo.config.NoInstallInfo then
?>
<details>
  <summary>Installation Directory</summary>
<p>You have unpacked the server in the directory:<br/><b><?lsp=mako and mako.execpath or ba.openio"home":realpath""?></b>.</p>

<p>Stopping the server terminates the tutorials. You can restart the tutorials at any time by starting the <b>startdemo</b> script, which can be found in the installation directory.</p>
</details>

<?lsp if app.ipaddr then
local addr= ba.serverport == 80 and "http://"..app.ipaddr or string.format("http://%s:%d", app.ipaddr,ba.serverport)
?>
<details>
  <summary>Server Address</summary>
<p>The IP address of this computer is <?lsp= app.ipaddr?>. You can access this computer from other computers in your network by navigating to <a target="_blank" href='<?lsp=addr?>'><?lsp=addr?></a>.</p>
</details>
<?lsp
end end
?>

<details>
  <summary>How the Tutorials and Demos are Packaged</summary>
<p>Each ZIP file in the <a target="_blank" href="<?lsp=appuri?>">applications sub-directory</a> is a separate web application. In the server console, you should see that the <code>startdemo</code> script loads multiple applications from ZIP files. Many of these applications are designed to run standalone, so the server can also load them separately.</p>
</details>

</div>
<p id="NextBut"><a href="Introduction.lsp">First Tutorial</a></p>
<?lsp response:include"footer.shtml" ?>
