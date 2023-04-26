<?lsp
title="About" response:include".header.lsp"
local appuri=app.wfshdir.."applications/"
?>

<h1>Lua and LSP Tutorials</h1>
<div class="rh">

<?lsp app.loadex(_ENV,"About") ?>

<div class="article-spacer">
<p>Welcome to the tutorials for the high level Lua APIs provided by the Barracuda App Server (BAS) and Mako Server! The menu on the left includes links to all of the available tutorials. For the best learning experience, we recommend starting at the top of the menu and working your way down. These tutorials will introduce you to the APIs and help you get started with using BAS to develop your applications. Happy learning!</p>

<p>It's important to note that the browser is only used as an editor and to display the results of your code. The actual processing takes place on the server side. When you click the 'Run' button, the Lua code example displayed in the browser is sent to the server to be parsed and executed. The server will then send the response back to the browser for display.</p>
<div style="max-width:640px;margin:auto">
<object class="background-white" style="width:100%;padding: 10px;border-radius:10px;" id="LuaREPL" type="image/svg+xml" data="images/LuaREPL.svg"></object>
</div>
<script src="/assets/js/LuaREPL.js"></script>


<details open>
  <summary>Mako Server vs. Barracuda App Server</summary>
<p>The <a target="_blank" href="https://makoserver.net/">Mako Server</a> and the <a target="_blank" href="https://realtimelogic.com/products/barracuda-application-server/">Barracuda App Server</a> (BAS) are the same, but BAS is a source code library and not a standalone product. Just like the ANSI C library cannot be used before you at least create a "Hello World" program, so is the case with BAS. The Mako Server is the Barracuda App Server's "Hello World" equivalent.</p>
</details>

<?lsp if mako.daemon then ?>
<details open>
  <summary>Server is running in service (daemon) mode!</summary>
<p>The server is running as a background service and you cannot see the console printouts from the tutorials. However, the included TraceLogger also shows the console printouts.</p>
<p><b>We recommend that you <a target="_blank" href="/rtl/tracelogger/">open the TraceLogger in a separate window</a></b>.</p>
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
<p>Each of the ZIP files in the <a target="_blank" href="<?lsp=appuri?>">applications sub-directory</a> are separate web-applications. If you look in the console window where the server is running, you should see that the startdemo script has instructed the server to load multiple applications (ZIP files). Many of the applications are designed as "standalone" applications, and it is possible to instruct the server to load these separately.</p>
</details>
 
</div>
<p id="NextBut"><a href="Introduction.lsp">First Tutorial</a></p>
<?lsp response:include"footer.shtml" ?>
