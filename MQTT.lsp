<?lsp 
title="Protocols: MQTT Examples"
response:include".header.lsp"
local version = ba.version() or 0
?>
<style>
iframe{
height:500px;
}
</style>
<h1>MQTT Examples</h1>
<div class="rh">

<p>The two code-less MQTT examples below can easily be started from your web browser. The first example demonstrates how to connect to AWS IoT Core, while the second example illustrates the potential consequences of not taking MQTT security seriously.</p>
<p>For additional examples, check out:</p>
<ol>
<li><a target="_blank" href="https://realtimelogic.com/articles/Your-First-MQTT-Lua-Program">Your First MQTT Lua Program</a></li>
<li><a target="_blank" href="https://realtimelogic.com/ba/doc/?url=MQTT.html">The MQTT documentation</a></li>
<li><a target="_blank" href="https://github.com/RealTimeLogic/LSP-Examples/tree/master/Sparkplug">The MQTT Sparkplug example</a></li>
<li><a target="_blank" href="https://realtimelogic.com/articles/Streaming-ESP32CAM-Images-to-Multiple-Browsers-via-MQTT">Streaming CAM Images to Multiple Browsers via MQTT</a></li>

</ol>
<p>The two code-less MQTT examples work as follows:</p>

<?lsp if version < 4870 then ?>
<p>The examples require a <a href="https://makoserver.net/download/overview/">newer Mako Server</a>!</p>
<?lsp else ?>

<div class="background-white" style="max-width:800px;margin:auto">
<img src="images/MQTT.svg" alt="Execute Lua MQTT code" />
</div>


<h2>Example 1: How to Connect to AWS IoT Core using MQTT</h2>

<p>This example shows you how to connect to AWS IoT Core using MQTT over a secure HTTPS connection on port 443. It's designed to work with the <a target="_blank" href="https://makoserver.net/articles/How-to-Connect-to-AWS-IoT-Core-using-MQTT-amp-ALPN">YouTube video tutorial "How to Get Started with AWS IoT Core Quick Connect"</a> and our article  <a target="_blank" href="https://makoserver.net/articles/How-to-Connect-to-AWS-IoT-Core-using-MQTT-amp-ALPN">How to Connect to AWS IoT Core using MQTT &amp; ALPN</a>. To use this example, simply follow the instructions in the video, except for running the Python code. Instead of running the Python code, you will be running the code below. This example is ready to run and will help you get started with AWS IoT Core in no time.</p>

<p><b>Instructions:</b></p>
<ol>
<li>Sign up for a <a target="_blank" href="https://aws.amazon.com/iot-core/">free AWS account</a> if you do not have an AWS account.</li>
<li>Follow the <a target="_blank" href="https://youtu.be/6w9a6y_-T2o ">AWS video tutorial</a> until you get to the section for running Python on your computer (3:45 marker). Do not run the Python code.</li>
<li>Click the <samp>Run</samp> button below the MQTT-AWS example. The example will then run in a new frame just below the example source code.</li>
<li>Using the file explorer, drag the '<samp>connect_device_package.zip</samp>' zip file and drop the file on the drop folder that will appear 
after clicking the run button. See the video for details on this ZIP file.</li>
<li>The MQTT example will now connect to AWS IoT Core and start publishing messages to the topic "<samp>topic_1</samp>".</li>
<li>The MQTT example also subscribes to "<samp>topic_1</samp>" and "<samp>topic_2</samp>". Messages received for these two topics are redirected 
via WebSockets to a JavaScript powered console in the browser.</li>
<li>Continue with the video tutorial from 5:18 until end of the video.</li>
<li>As explained in the video, publish your own messages using the AWS console to any of the two topics "<samp>topic_1</samp>" or "<samp>topic_2</samp>". 
These messages will then appear in the JavaScript powered console below.
</li>
</ol>

<div class="lspeditor" example="MQTT-AWS"></div>

<p>In addition to the server side MQTT client running in the Lua virtual machine, the above example also includes supporting code designed 
for making a configuration-free experience for the user. The drag and drop logic running in the browser is designed in JavaScript. 
The JavaScript code sends the uploaded ZIP file to the server by using an HTTP PUT command. The JavaScript code then moves on 
  to opening a WebSocket connection as soon as the upload completes. The WebSocket connection enables 
  the server side Lua code to redirect messages received from the MQTT broker to the JavaScript powered console in the browser. 
  The supporting server side Lua code also contains code for receiving the ZIP file via HTTP PUT, creating a "<samp>hidden</samp>" temporary file 
  for the uploaded ZIP file, mounting the uploaded ZIP file as an <a target="_blank" href="/ba/doc/?url=lua.html#ba_ioinfo">IO object</a>, 
  and extracting the certificate and private key from the uploaded ZIP file. 
  See the tutorial <a target="_blank" href="https://makoserver.net/articles/How-to-Connect-to-AWS-IoT-Core-using-MQTT-amp-ALPN">How to
   Connect to AWS IoT Core using MQTT &amp; ALPN</a> for details on how the secure and trusted MQTT connection is established.</p>



<h2 id="pentest">How Hackers Can Penetrate Your MQTT Solution:</h2>

<p>MQTT, by default, lacks layered access control, meaning one breached device can compromise the entire network of connected devices. This example demonstrates the dangers of neglecting layered access control in MQTT solutions. The following attack targets MQTT brokers with no password requirements. However, even standard MQTT brokers with password protection lack layered access control by default. This vulnerability allows an attacker to use credentials from any compromised device to perform a similar attack.</p>


<blockquote><p>This is the accompanying example for the tutorial <a target="_blank" href="https://realtimelogic.com/articles/How-Hackers-Can-Easily-Penetrate-Your-MQTT-Solution">How Hackers Can Penetrate Your MQTT Solution</a>. See the tutorial for the details.</p></blockquote>

<p>The ready-to-run MQTT penetration test program below is slightly more advanced than the one described in the written tutorial. Instead of printing MQTT data to the server's console as it arrives, this program sends the data to the browser over a WebSocket connection, where it is displayed in real-time.</p>

<div style="max-width:625px;margin:auto">
<img src="images/exploiting-mqtt-using-lua.png" />
</div>

<div class="lspeditor" example="MQTT-Pentest"></div>


<?lsp end ?>

<p id="NextBut"><a href="ide.lsp">Next Tutorial</a></p>

</div>
<?lsp response:include"footer.shtml" ?>
