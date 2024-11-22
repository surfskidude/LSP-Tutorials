<?lsp

local links={
   {'About.lsp','About'},
   {'Introduction.lsp','Introduction'},

   {'Lua-Types.lsp',"Lua", {
         {'Lua-Types.lsp','Types'},
         {'Lua-Control.lsp','Control'},
         {'Lua-Functions.lsp','Functions'},
         {'Lua-Scope.lsp','Scope'},
         {'Lua-Coroutines.lsp','Coroutines'},
         {'Lua-Metamethods.lsp','Metamethods'},
         {'Lua-Bindings.lsp','Lua to C Code'},
      }
   },
   {'HTML-Forms.lsp','LSP', {
         {'HTML-Forms.lsp','HTML Forms'},
         {'Ajax.lsp','Ajax'},
         {'WebSockets.lsp', 'WebSockets'},
         {'Sockets.lsp','Sockets '},
         {'Dynamic-Navigation-Menu.lsp','Navigation Menu'},
         {'BAS-API-Tutorial.lsp','BAS API'},
      }
   },
   {'HTTP-Client.lsp','Protocols', {
         {'HTTP-Client.lsp','HTTP Client'},
         {'IoT.lsp','SMQ IoT Examples'},
         {'MQTT.lsp','MQTT Examples'},
         {'opc-ua.lsp','OPCUA Example'},
      }
   },
   {'ide.lsp','Examples', {
         {'ide.lsp','Lua REPL'},
         {'wfs.lsp','Web File Server'},
         {'Pac-Man.lsp','PacMan Game'},
         {'certmgr.lsp','Certificate Mgr'}
      }
   },
   {'GitHub.lsp','More @ GitHub'},
   {'Documentation.lsp','Documentation'},
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
   <div class="close-header-menu">
      <a class="close-header-icon">
         <img src="/images/icon-close-violet.svg" />
      </a>
   </div>
   <a class="main-logo" target="_blank" href="https://realtimelogic.com/products/barracuda-application-server/"><img src="images/BAS-logo.png" /></a>
   <nav id="main-nav"><ul>
      <?lsp
      for _,link in ipairs(links) do
         local isactive
         if link[3] then
            isactive = title:find("^"..link[2]) and true or false
         else
            isactive = title == link[2]
         end
         response:write('<li class="menu-level-1">')
         if link[3] then
            response:write('<details', isactive and ' open' or ' ','>');
            response:write('<summary><a href="',link[1],'" class="open-link-menu ', isactive and ' selected"' or '"','>',link[2],'</a></summary>')
            response:write('<ul class="', isactive and ' selected"' or '"','>');
            for _,link in ipairs(link[3]) do
               local isactive = title:find(link[2].."$") and true or false
               response:write('<li class="menu-level-2"><a href="',link[1],'" class="main-link-menu ', isactive and ' selected"' or '"','>',link[2],'</a></li>')
            end
            response:write'</ul>'
         else 
            response:write('<a href="',link[1],'" class="main-link-menu ', isactive and ' selected"' or '"','>',link[2],'</a>')
         end
         response:write'</li>'
      end
      ?>
   </ul></nav>
</section>
<header id="header">
   <span class="open-main-menu mobile-only"><img src="/images/icon-open-menu-violet.svg" /></span>
   <div class="header-title">Barracuda App Server Tutorials</div>
</header>
<main id="main-content">
