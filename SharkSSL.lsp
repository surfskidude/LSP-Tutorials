<?lsp

--[[
This example shows how to use the Mako Server's integrated Let's
Encrypt plugin in automatic mode.

Simply run this file and follow the instructions.

The logic for managing the two modules acmebot and acmedns would
normally not be crammed into one LSP page, but we do it this way in
order to deliver one single example file. Most of the logic would
normally be put in a .preload/.config file or in a dedicated
module. 

This LSP page includes state management and the persistent state
information is stored in the persistent "page" table.
--]]

-- cert IO
local cIO = ba.openio"home" or ba.openio"disk"

local function decodeErr(err)
   if err:find("cannotresolve",1,true) or 
      err:find("cannotconnect",1,true) then
      err = "Server cannot connect to the Internet"
   end
   return err
end

local function loadSecurityModule()
   -- Load the 'DLL' or 'embedded' version of the security module 'tokengen'
   pcall(function() page.zonename=require"tokengen".info() end)
   if not page.zonename then
      pcall(function() page.zonename=require"etokengen".info() end)
   end
   return  page.zonename
end

local function emitIsSecure() ?>
<details open>
<summary style="background:#11772d">You are using an Encrypted Connection</summary>
<p><br/></p>
<h4>Cipher Suite: <?lsp=request:cipher()?></h4>
<p>A secure connection and an encrypted connection are not the same. Is this connection secure? Find out by reading the <a href='https://makoserver.net/articles/Lets-Encrypt'>full article</a>.</p>
</details>
<?lsp end
local function emitAcmeActive(dn)
-----------------------------------------------------------
?>
<details open>
<summary>Certificate Installed</summary>
<p>The Let's Encrypt signed certificate is installed and you may navigate to the secure URL by navigating to:</p>
<h3 class="center"><a target="_blank" href="https://<?lsp=string.format("%s:%d%s",dn,ba.serversslport,request:uri())?>">https://<?lsp=dn?></a></h3>

<p><b>Note:</b>the DNS translation to IP address fails if you have DNS rebinding protection enabled in your router or enabled by your DNS provider.</p>

</details>
<?lsp end
local function emitWaiting()
-----------------------------------------------------------
?>
<details open>
<summary>Communicating with Let's Encrypt</summary>
<div class="spinnerc">
<svg class="spinner" viewBox="0 0 50 50">
  <circle class="path" cx="25" cy="25" r="20" fill="none" stroke-width="5"></circle>
</svg>
</div>
<p id='info'>The server is communicating with Let's Encrypt and the online DNS service. Setting up the ACME DNS TXT record takes more than two minutes. Feel free to read the <a href='https://makoserver.net/articles/Lets-Encrypt'>full article</a> while waiting.</p>
<script>
$(function() {
    $('#info').hide();
    function busy() {
        $.getJSON(window.location.href,
                  function(rsp) {
                      if(rsp.busy)
                      {
                          $('#info').show();
                          setTimeout(busy, 2000);
                      }
                      else
                          location=location.href;
                  });
    }
    setTimeout(busy, 2000);
});
</script>
</details>
<?lsp end
local function emitRegister(error,email)
-----------------------------------------------------------'
   if not page.agreementURL then
      -- Fetch Let's Encrypt's terms (PDF) link.
      page.agreementURL=require"acme/engine".terms()
   end
?>

<details open>
<summary>Install Trusted Certificate</summary>
<?lsp=error and "<p class='err'>"..error or "<p>Simply enter your email address below to install a trusted <a target='blank' href='https://letsencrypt.org/'>Let's Encrypt</a> signed certificate for your private server."?></p>
<form method="post">
<table class="iw">
<tr><td>E-Mail Address:</td><td><input type="text" name="email" placeholder="The e-mail address sent to Let's Encrypt" value="<?lsp=email or""?>"/></td></tr>
</table>
<input type="submit" value="Submit"/> 
</form>
<p><b>Note:</b> You accept the <a target="_blank" href="<?lsp=page.agreementURL?>">Let's Encrypt Subscriber Agreement</a> by clicking the above submit button.</p>
</details>
<?lsp end
local function emitNoSecurityModule()
?>
<details open>
<summary>Security Module Not Installed</summary>

<p>This example requires a server with an installed security module. You can install (compile and integrate) a security module as explained in the <a href="http://realtimelogic.com/ba/doc/?url=Mako.html#securitymodule">Mako Server's Security Module section</a>.</p>
</details>
<?lsp end

title="Protocols: SSL/TLS &amp; Trust" response:include".header.lsp"
print"<h1>TLS: It's All About the Trust</h2><p>Trust is primary, encryption is secondary. <a href='#' id='why'>Why?</a></p>"

local acmebot=require"acme/bot"
if request:header"x-requested-with" then -- AJAX from $.getJSON() above
   local jobs=acmebot.status()
   response:json{busy=jobs > 0 and true or false}
end

if request:issecure() then
   emitIsSecure()
else
   if not page.zonename and not loadSecurityModule() then
      emitNoSecurityModule()
   else
      local op={
      }
      local acmedns=require"acme/dns"
      local email,domain=acmedns.auto(app.acmeOP) -- Starts engine if previosly registered
      local jobs,_,lastError = acmebot.status(true)
      if request:method() == "POST" then
         local d={} -- Extract email from form data and use 'name@' as the sub domain name (excluding @)
         for k,v in pairs(request:data()) do d[k]=v:gsub("^%s*(.-)%s*$", "%1") end -- trim start/end
         local email email=d.email
         if email and #email > 8 and email:find'@' and email:find'@' > 3 then
            local dn = email:match"[^@]+"
            acmedns.auto(email, dn:gsub("[^%w]",""), app.acmeOP) -- Activate acme/dns
            emitWaiting()
         else
            emitRegister"Invalid email address"
         end
      elseif jobs > 0 then
         emitWaiting()
      elseif lastError then
         emitRegister(decodeErr(lastError))
      elseif acmedns.active()=="auto" then
         emitAcmeActive(domain)
      else
         emitRegister()
      end
   end
end

?>

<script>
$(function() {
    $("#why").click(function() {
        console.log("why");
        $(this).parent().after("<p>Because TLS is rendered useless when the certificate is not trusted and when the user is forced to bypass the browser security in order to access the server. The user cannot differentiate between a man in the middle and the non trusted server's certificate. See the article <a target='_blank' href='https://realtimelogic.com/articles/How-Anyone-Can-Hack-Your-Embedded-Web-Server'>Anyone can hack your HTTPS Server</a> for more details.</p>");
        $(this).replaceWith("Why?");
        return false;
    });
});
</script>

<details>
<summary>What is Trust?</summary>
<p>The Barracuda App Server includes <a target='_blank' href='https://realtimelogic.com/products/sharkssl/'>SharkSSL</a> and just like any other TLS stack, SharkSSL supports the two required TLS encryption technologies:</p>
<ol>
<li>Asymmetric Encryption (RSA or ECC)</li>
<li>Symmetric Encryption (AES-GCM, ChaCha20-Poly1305, etc)</li>
</ol>
<p>Trust is established during the initial asymmetric encryption, which is used for deriving keys used by symmetric encryption. The browser validates the server's certificate as part of the asymmetric encryption handshaking. The following figure shows how the server sends its certificate to the browser.</p>

<div class="center background-white"><img src="images/ssl-trust.gif" alt="SSL"/></div>

<p>The browser does not trust the server's certificate unless: (1) it has a hard-copy of the Certificate Authority (CA) certificate that was used to sign the server's certificate, and (2) the domain name in the URL matches any of the names in the server's certificate.</p>
See the tutorial <a target='_blank' href='https://realtimelogic.com/articles/Certificate-Management-for-Embedded-Systems'>Introduction to asymmetric algorithms</a> for details.
</details>

<details>
<summary>How to Trust the Included Certificate</summary>

<p>The server automatically installs a default certificate, thus you may change the URL from http:// to https:// at any time. The default certificate is not trusted by your browser, but you can establish trust by installing the Certificate Authority (CA) certificate that was used to sign the server's default certificate.</p>

<p><b>Establish trust, using the default certificate, by making sure the two following conditions are met:</b></p>
<ol>
<li>Install <a href="https://realtimelogic.com/downloads/root-certificate/" target="_blank">Real Time Logic's CA certificate</a>
<li>Make sure your browser URL matches any of the names listed in the certificate.</li>
</li>
</ol>

<p>The default certificate is a so called SAN certificate and includes the following (domain) names: localhost, 127.0.0.1, and MakoServer. Use the name localhost if the server and browser are on the same computer; otherwise set up an entry in your <a target="_blank" href="https://en.wikipedia.org/wiki/Hosts_(file)"> hosts file</a> for the name MakoServer.</p>


</details>
<details>
<summary>How to Create Your Own Chain of Trust</summary>
<p>You may use the <a href="certmgr.lsp">Certificate Management App</a> to create a complete chain of trust, including the CA certificate, and any number of server certificates. Note that none of the created certificates will be trusted by any browser unless you install the CA certificate in all browsers intended to access the server.</p>
</details>




<?lsp response:include"footer.shtml" ?>
