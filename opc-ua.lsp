<?lsp
title="Protocols: OPCUA Example" response:include".header.lsp"
local version = true == pcall(function() require("opcua_ns0") require("opcua.api") end) and ba.version() or 0
?>


<h1>OPC-UA Example</h1>


<p><a target="_blank" href="https://realtimelogic.com/products/opc-ua/">OPC Unified Architecture (OPC-UA)</a> is a machine to machine communication protocol for industrial automation.

<p>The OPC-UA examples bundled in the 'opc.zip' file (<a target="_blank" href="https://github.com/RealTimeLogic/OPC-UA-Examples/tree/master/web-client">also available from our GitHub repository</a>) include both a browser-based user interface and a server-side OPC-UA client. The user interface is implemented as an HTML and JavaScript-powered Single Page Application (SPA) that runs in the browser and communicates with the server-side client using WebSockets. The examples also include an OPC-UA server with the endpoint URL 'opc.tcp://<?lsp=demo.ipaddr?>:4841'. These examples can help you get started with OPC-UA and see how it can be used to build robust and efficient applications.</p>

<img src="https://realtimelogic.com/products/opc-ua/opc-ua-web-client.png" />

<p>The client's default OPC-UA endpoint address is to the local OPC-UA server. You can use any OPC-UA server address, such as the following public OPC-UA server: opc.tcp://opcuaserver.com:48010. You can also connect other (external) OPC-UA clients to the server example.</p>

<?lsp if version == 0	then ?>
<h3>OPC-UA Not Included</h3>
<p>This server does not include the OPC-UA libraries.</p>
<?lsp elseif version < 5019	then ?>
<h3>The two OPC-UA examples require a <a target="_blank" href="https://makoserver.net/download/overview/">newer Mako Server</a>!</h3>
<?lsp else ?>
<br/>
<p style="margin:auto;width:280px" id="NextBut"><a target="_blank" href="/opc/">Start The OPC-UA Web Client</a></p>
<?lsp end ?>

<ol>
<li>Click the above button to open the JavaScript powered OPC-UA Web Client</li>
<li>Click the asterisk and select communication method</li>
<li>Click connect to connect to the local OPC-UA server</li>
<li>Click the + sign to browse into the node tree</li>
<li>Click the name next to the +/- symbol to show the attributes in the right pane</li>
<li>Connect the client to another public server such as: opc.tcp://opcuaserver.com:48010, but make sure to select "None - None" as communication method</li>
<li>Browse the node tree</li>
<li>Use any OPC-UA client and connect to the local server (opc.tcp://<?lsp=demo.ipaddr?>:484); see the <a  target="_blank" href="https://realtimelogic.com/ba/opcua/thirdparty_clients.html">Third Party Clients Tutorial</a> for details</li>
</ol>

<div style="text-align:center">
<img src="https://realtimelogic.com/products/opc-ua/web-client-slides.gif" />
</div>

<?lsp response:include"footer.shtml" ?>
