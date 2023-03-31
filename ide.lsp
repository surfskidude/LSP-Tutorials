<?lsp title="Examples: Lua REPL" response:include".header.lsp" ?>

   <h1>Lua REPL</h1>

<p>The Lua Read-Eval-Print-Loop (REPL) is a web-based integrated development environment (IDE) for creating and testing Lua applications. With the Lua REPL, you can write and execute Lua code directly in your browser, as well as create, start, stop, and terminate Lua applications without having to restart the server. The Lua REPL provides a convenient and easy-to-use interface for developing Lua applications.</p>

<p>The Lua REPL is available in two versions: one for high-level operating systems and another for real-time operating systems (RTOS) with or without file system support. Please refer to the <a target="_blank" href="https://realtimelogic.com/ba/doc/?url=examples/lspappmgr/readme.html">LSP Application Manager documentation</a> for more information. See the video below for how to use the IDE.</p>

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
    <iframe width="560" height="349" src="https://www.youtube.com/embed/bUy8b6DAF_Q" frameborder="0" allowfullscreen></iframe>
</div>


<p>
</p>

<p>You may click the button below to open the LspAppMgr, but note that the IDE works best when loaded separately as follows:</p>

<div style="background-color:gainsboro;width:100%" >mako -l::<?lsp=app.exio:realpath"lspappmgr.zip"?></div>

<br/>
<br/>

<p id="NextBut"><a target="_blank" href="/rtl/appmgr/new-application.lsp">Open LspAppMgr</a></p>

<br/>


<?lsp response:include"footer.shtml" ?>
