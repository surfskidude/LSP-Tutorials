<?lsp
title="Examples: Web File Server"
response:include".header.lsp"
local uri=app.wfshdir
local davuri = string.format("http://%s%s",app.rmIPv6pf(request:sockname()),uri)
?>

<h4>The Web File Server combines WebDAV with a browser-based file manager.</h4>

<iframe style="margin-left:10px;float:right" width="430" height="242" src="https://www.youtube.com/embed/i5ubScGwUOc" frameborder="0" allowfullscreen></iframe>

<h2>WebDAV</h2>

<p>The Web File Server can act as both a <a target="_blank" href="https://realtimelogic.com/products/webdav/">WebDAV server</a> and a Web File Manager. The video to the right shows how to map or mount a WebDAV server from Windows and macOS. The Web File Manager is available at the same base URL.</p>

<p>WebDAV is a convenient way to share files with users on many devices, including PCs, iPhones, Android devices, and Linux systems.</p>

<p style="clear:both"></p>
<p><strong><a target="_blank" href="/ba/doc/?url=lua.html#ba_create_wfs">Web File Server API Documentation</a></strong></p>
<div class="rh">

<details open>
  <summary>How to Map/Mount the WebDAV Server:</summary>
  <p>View the video above for instructions and use the following URL to mount or map the directory where the server is installed:</p>
  <pre><?lsp=davuri?></pre>
  <p>Copy the URL above and paste it into the dialog box as shown in the video.</p>
</details>

<details open>
  <summary>Web File Manager</summary>
  <p>By default, the Web File Manager presents a human-to-machine (H2M) browser interface, but it can also return directory information as JSON.</p>
  <p>You can test both presentation modes by clicking the two following links:</p>
  <ul>
    <li><a target="_blank" href="<?lsp=uri?>"><?lsp=uri?></a></li>
    <li><a target="_blank" href="<?lsp=uri?>?cmd=lj"><?lsp=uri?>?cmd=lj</a></li>
  </ul>
</details>

</div>
<?lsp response:include"footer.shtml" ?>
