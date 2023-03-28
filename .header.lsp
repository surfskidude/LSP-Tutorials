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
<link rel="stylesheet" href="/assets/css/intro-style.css" />
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">
<script src="/rtl/jquery.js"></script>
<script src="/assets/js/common.js" type="text/javascript"></script>
<script src="/assets/js/ace/ace.js" type="text/javascript"></script>
<script src="/assets/js/ace/examples.js" type="text/javascript"></script>
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
<section id="left-sidebar">
   <div class="close-header-menu" >
      <a class="close-header-icon">
         <img src="/images/icon-close-violet.svg" />
      </a>
   </div>
   <a class="main-logo" target="_blank" href="https://realtimelogic.com/products/barracuda-application-server/"><img src="images/BAS-logo.png" /></a>
   <nav id="main-nav">
      <?lsp
      for _,link in ipairs(links) do
         local isactive = title == link[2]
         response:write('<a href="',link[1],'" class="main-link-menu ', isactive and ' selected"' or '"','>',link[2],'</a>')
      end
      ?>
   </nav>
</section>
<header id="header">
   <span class="open-main-menu mobile-only"><img src="/images/icon-open-menu-violet.svg" /></span>
   <div class="header-title">Barracuda App Server Tutorials</div>
</header>
<main id="main-content">