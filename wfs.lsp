<?lsp
title="Examples: Web File Server"
response:include".header.lsp"
local uri=app.wfshdir
local davuri = string.format("http://%s%s",app.rmIPv6pf(request:sockname()),uri)
?>

<h4>The Web File Server is a combined WebDAV and Web File Manager.</h4>

<iframe style="margin-left:10px;float:right" width="430" height="242" src="https://www.youtube.com/embed/i5ubScGwUOc" frameborder="0" allowfullscreen></iframe>

<h2>WebDAV</h2>

<p>The Web File Server can act as a <a target="_blank" href="https://realtimelogic.com/products/webdav/">WebDAV server</a> and Web File Manager.  The video to the right shows how to map/mount a WebDAV server from Windows and Mac. The Web File Manager can be accessed via the same URL as the Web File Manager.</p>

<p>WebDAV is a secure and convenient way to share files with users on a variety of different devices, including PCs, iPhones, Android devices, and Linux systems.</p>

<p style="clear:both"></p>
<p><strong><a target="_blank" href="/ba/doc/?url=lua.html#ba_create_wfs">Web File Server API Documentation</a></strong></p>
<div class="rh">

<details open>
  <summary>How to Map/Mount the WebDAV Server:</summary>
  <p>View the above video for instructions and use the following URL for mounting/mapping the directory where the server is installed:</p>
  <pre><?lsp=davuri?></pre>
  <p>Copy the above URL and paste into the dialog box as shown in the above video.</p>
</details>

<details open>
  <summary>Web File Manager</summary>
  <p>The Web File Manager is, by default, presenting a Human to Machine (H2M) interface, but it can also present the directory information in JSON.</p>
  <p>You can test both presentation modes by clicking the two following links:</p>
  <ul>
    <li><a target="_blank" href="<?lsp=uri?>"><?lsp=uri?></a></li>
    <li><a target="_blank" href="<?lsp=uri?>?cmd=lj"><?lsp=uri?>?cmd=lj</a></li>
  </ul>
</details>

</div>
<?lsp response:include"footer.shtml" ?>
