<?lsp

local links={
   {'About.lsp','About'},
   {'Introduction.lsp','Introduction'},
   {'Lua-Types.lsp','Lua Types'},
   {'Lua-Control.lsp','Lua Control'},
   {'Lua-Functions.lsp','Lua Functions'},
   {'Lua-Scope.lsp','Lua Scope'},
   {'Lua-Coroutines.lsp','Lua Coroutines'},
   {'Lua-Metamethods.lsp','Lua Metamethods'},
   {'Lua-Bindings.lsp','Lua to C Code'},
   {'HTML-Forms.lsp','LSP &amp; HTML Forms'},
   {'Ajax.lsp','Ajax'},
   {'WebSockets.lsp', 'WebSockets'},
   {'Sockets.lsp','Sockets'},
   {'Dynamic-Navigation-Menu.lsp','Navigation Menu'},
   {'SharkSSL.lsp','SSL/TLS &amp; Trust'},
   {'BAS-API-Tutorial.lsp','BAS API'},
   {'IoT.lsp','SMQ IoT Examples'},
   {'MQTT.lsp','MQTT Examples'},
   {'opc-ua.lsp','OPC-UA Example'},
   {'ide.lsp','Lua REPL'},
   {'GitHub.lsp','More @ GitHub'},
   {'Documentation.lsp','Documentation'},
   {'wfs.lsp','Web File Server'},
   {'Pac-Man.lsp','Pac-Man Game'},
   {'certmgr.lsp','Certificate Mgr'},
}

?>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title><?lsp=title?></title>
<link rel="stylesheet" href="intro-style.css" />
<script src="/rtl/jquery.js"></script>
<script src="ace/ace.js" type="text/javascript"></script>
<script src="examples.js" type="text/javascript"></script>
<?lsp if not app.noalert then ?>
<script>
$(function() {
      $('a[target="_blank"]').click(function() {
            jQuery.get("noalert.lsp");
            alert("Some links open in a separate window or browser tab. Simply close the window or tab when you are done.");
            $('a[target="_blank"]').unbind('click');
            return true;
         });
   });
</script>
<?lsp end ?>
</head>
<body>
<!-- <div id="ofheader"></div> -->
<!-- <div id="ofleft"></div> -->
<div id="mainContainer">
  <div id="header">
    <a target="_blank" href="https://realtimelogic.com/products/barracuda-application-server/"><img src="images/BAS-logo.png" /></a>
    <div id="navbut"><div></div><div></div><div></div></div>
    <div id="headertxt">BAS Tutorials</div>
  </div>
<!-- <div id="fixleft"></div> -->
<div id="leftSidebar">
    <div id="nav">
<ul>
<?lsp
for _,link in ipairs(links) do
   local isactive = title == link[2]
   response:write('<li><a href="',link[1],'"', isactive and ' class="selected"' or '','>',link[2],'</a></li>')
end
?>
</ul>
    </div>
</div>
  <div id="mainContent">
  <div class="innertube">
