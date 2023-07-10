<?lsp title="LSP: Sockets " response:include".header.lsp" ?>

<h1>Sockets (Network) Programming</h1>

<p>The Socket API provides both blocking sockets and 100% non-blocking sockets. Blocking sockets are suitable when used in combination with LSP pages. 
The following blocking socket example makes the LSP page wait until a response is returned from the NTP time server. 
The Lua code executing at the server converts the returned result to a printable format and sends the result to the browser.</p>
<?lsp if not demo.internet then ?>
<fieldset class="warning"><legend>NO INTERNET</legend>
<p>Warning: it appears that there is no Internet connection or a proxy prevents access. 
The following socket examples will fail if the server is unable to connect to the Internet!</p>
</fieldset>
<p><br/></p>

<?lsp
end
if ba.socket.udpcon then
?>

<details open>
  <summary>Blocking Sockets</summary>

<div class="lspeditor" example="7.10"></div>
<?lsp else ?>
<P><b style="color:red">Example disabled: your server is compiled without the UDP socket lib.</b></p>
<?lsp end ?>


<p>The above example is copied from the documentation. See the <a target="_blank" href="/ba/doc/?url=SockLib.html#BlockingSockets">blocking sockets documentation</a> 
for an explanation on how this example works.</p>
</details>

<details open>
  <summary>100% Non-Blocking Sockets</summary>
  <p>Non-blocking sockets are called <a target="_blank" href="/ba/doc/?url=SockLib.html#cosocket">cosockets</a>. The following example shows how to create a cosocket 
  by calling function <a target="_blank" href="/ba/doc/?url=auxlua.html#ba_socket_event">ba.socket.event</a> and by passing in the function to use as a cosocket.</p>
  <?lsp if ba.socket.udpcon then ?>
  <div class="lspeditor" example="7.11"></div>
  <?lsp else ?>
  <P><b style="color:red">Example disabled: your server is compiled without the UDP socket lib.</b></p>
  <?lsp end ?>
  <p>Notice how we use function "<code>trace</code>" and not "<code>print</code>". Function "<code>print</code>" in an LSP page emits data 
    as a response to the browser. We cannot use function "<code>print</code>" in a cosocket since the request/response object, 
      aka the <a target="_blank" href="/ba/doc/?url=lua.html#CMDE">command environment</a>, does not exist in a cosocket.</p>
  <p>Function "<code>trace</code>" emits the output to the server's trace buffer. You can also see the printout in the 
  console window if the server is running in console mode. Another option is to view the printout in real time by using the 
  <samp>TraceLogger</samp>: (1) Open the <a target="_blank" href="/rtl/tracelogger/">TraceLogger</a> in a separate browser window and 
  (2) run the above example. You should see the printout in the TraceLogger's console.</p>
  <a name="secure"></a>
</details>

<details open>
  <summary>Secure Sockets</summary>
  <h4>Secure Client Socket Example</h4>
  <p>Creating a secure socket connection is very easy with the socket API. For example, to create a secure TCP client connection, 
  add the attribute "<samp>shark</samp>" to the options (<sapm>op</samp>) argument for function 
    <a target="_blank" href="/ba/doc/?url=auxlua.html#ba_socket_connect">ba.socket.connect</a>. Attribute "<samp>shark</samp>" must be set to a 
    SharkSSL object. The Mako Server comes with a ready to use SharkSSL object that is initialized with the most common CA root certificates, 
    and this object is returned by function <a target="_blank" href="https://makoserver.net/documentation/features/#sharkclient">ba.sharkclient()</a>.</p>
  <div class="lspeditor" example="7.12"></div>
  <p>The above example connects to google.com at line 16. The port number 443 is the port number used by HTTPS. Attribute "<sapm>shark</samp>" is set 
  to the ready to use Mako Server SharkSSL object.</p>
  <p>Line 18 to 20 prints out information related to the secure communication. Function "<code>printTab</code>" takes a table as argument and 
  recursively prints out all the key,value attributes in the table. The function is used to recursively print out the Google server's certificate information.</p>
  <p>A basic HTTP request is sent at line 22.</p>
  <p>The code enters a loop at line 23 and keeps reading HTTP response data until the read function on line 24 times out.</p>
  <h4>Secure Server Socket Example</h4>
  <p>A secure server socket example is included in the BAS API tutorial.</p>
  <ol>
    <li><a target="_blank" href="BAS-API-Tutorial/">Start the BAS API tutorial</a></li>
    <li>Click Tutorials -> Miscellaneous</li>
    <li>Click Miscellaneous -> Sockets API</li>
    <li>Scroll down to "ELIZA the Psychotherapist Web Server"</li>
  </ol>
</details>

<p id="NextBut"><a href="Dynamic-Navigation-Menu.lsp">Next Tutorial</a></p>

<?lsp response:include"footer.shtml" ?>
