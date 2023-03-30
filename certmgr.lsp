<?lsp title="Examples: Certificate Mgr" response:include".header.lsp" ?>

   <h1>Certificate Management Tool</h1>


<p>The Certificate Management Tool is an indispensable tool for administrators and a must-have for anyone that uses SSL Certificates for websites, servers, secure IoT device management, or Code Signing Certificates for trusted software. See the <a target="_blank" href="https://realtimelogic.com/articles/How-to-act-as-a-Certificate-Authority-the-Easy-Way">Certificate Management Tool Home Page</a> for details.</p>

<p style="text-align:center"><b>Read up on <a href="SharkSSL.lsp">Trust Management</a> before using this tool.</b></p>

<br/>

<p style="margin:auto;width:400px" id="NextBut"><a target="_blank" href="certmgr/">Open the Certificate Management Tool</a></p>

<br/>
<p>The Certificate Management Tool can also be loaded separately as follows:</p>

<pre class="code">mako -l::<?lsp=app.exio:realpath"certmgr.zip"?></pre>

<h2>Video Tutorial</h2>
<p>The video shows how to create an Elliptic Curve Cryptography (ECC) certificate for the server, how to install the certificate in the server, and how to make the clients connecting to the server trust this certificate.</p>


<style>

.videoWrapper {
	position: relative;
	padding-bottom: 56.25%; /* 16:9 */
	padding-top: 25px;
	height: 0;
}
.videoWrapper iframe {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
}
</style>


<div class="videoWrapper">
    <!-- Copy & Pasted from YouTube -->
    <iframe width="560" height="349" src="https://www.youtube.com/embed/wBEZWj75_60" frameborder="0" allowfullscreen></iframe>
</div>

<?lsp response:include"footer.shtml" ?>
