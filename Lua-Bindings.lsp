<?lsp title="Lua to C Code" response:include".header.lsp"
?>


<div class="rh">

<h1>Interfacing Lua to Existing C/C++ Code</h1>

The following examples include C code that demonstrates how to extend the Lua APIs provided by the server. You can compile this code directly from the web page using the included TCC compiler on Windows and GCC on other platforms.

<p>A Lua binding is essentially a bridge between the Lua virtual machine and native C functions or C++ methods. It allows you to call C functions from within a Lua script and add your own custom functions to the Lua virtual machine. Lua bindings can be created manually or generated automatically using tools like the <a <a target="_blank" href="https://realtimelogic.com/swig/">online Lua Binding Generator</a>. The following figure illustrates how this works, showing the process of generating a Lua binding and integrating it into your firmware.

<p>The following examples include C code that shows how to extend the Lua APIs provided by the server. The C code can be compiled from within this web page and is using the included TCC compiler on Windows and GCC on all other platforms.</p>

<div class="center"><img src="/images/C2Lua-development-flow.svg" alt="Lua Binding Generator"></div>
<p class="caption">Figure 1. The development flow. C code is compiled ONLY once. The Lua scripts are compiled just-in-time in the embedded device when requested by the browser.</p>


<?lsp

if not page.installed then
   local cc = io:dofile(".lua/C-Install.lua",app)
   if request:method() == "POST" and request:data"install" then
      local ok,err = cc.install()
      if ok then
         response:sendredirect(request:url())
      end
      response:write('<p class="warning">',err,'</p>')
      response:include"footer.shtml"
      return
   end
   if cc.check() then
?>
<h2>Install Required Modules</h2>
<p>The Lua binding examples require the Mako Server module plugin and a compiler.  Click the following button to install the required components.</p>



<form id="install" method="POST"><input type="submit" name ="install" value="Install"></form>
<script>
var installable = <?lsp= cc.installable() and 'true' or 'false'?>;
$("#install").click(function() {
    setTimeout(function() {
        $("#install").html(installable ? "<b>The installation progress is printed in the server's console Window.</b>" : "<b style='color:red'>The tutorials, which require a C compiler, are not compatible with this operating system.</b>");
    }, 500);
    return installable;
});
</script>
<?lsp

     if not demo.internet then
?>
<p class="warning">Warning: it appears that there is no Internet connection or a proxy prevents access. The installation process will fail if the server is unable to download the additional component!</p>
<?lsp
     end
     response:include"footer.shtml"
     return
   else
      local path = cc.getModIo():realpath""
      package.cpath=string.format(
        "%s?.%s;%s",path,cc.iswin and "dll" or "so", package.cpath)
      page.installed = true
      io:dofile(".lua/C-Compile.lua",app) -- Load

   end
end
?>

<p>The C examples in this tutorial are designed for the Mako Server. Lua bindings for the Mako Server are identical to Lua bindings for an embedded device (RTOS) using the Barracuda App Server library, but the bindings are initialized differently. In an embedded device, the libraries will be compiled and linked with the server and all other firmware components. However, Lua bindings for the pre-compiled Mako Server binary are loaded as DLLs (shared libraries).</p>

<p>The C example below is the same example as found in the Barracuda App Server documentation's <a target="_blank" href="/ba/doc/?url=GettingStarted.html#UsingLSP">Getting Started: Controlling the LED using LSP</a>, but the initialization code has been redesigned for the Mako Server. Click the above link for more information on how this example works and how to write Lua bindings.</p>

<div class="lspeditor" extype="C" example="LED" <?lsp=demo.config.nocompile and 'disabled="true"' or ''?>></div>

<?lsp if not demo.config.nocompile then ?>
<p>Clicking the above compile button should compile the C code and produce a DLL on Windows and a Shared Library on Linux.</p>

<div class="alert">
<p><b>Note:</b> you can modify the C code in the above example by using the inline editor, but you may have to restart the server before you can compile and use the new DLL. The server must be restarted if you have already loaded the DLL by using the Lua function "require". A loaded DLL is not released until the server terminates.</p>
</div>

<p>The following Lua and LSP examples require that you compile the C code and produce a DLL. If you test any of the examples below before compiling, you will get a Lua exception. If you want to see how the code fails, go ahead and test any of the examples below before compiling the above code.</p>

<?lsp end ?>

<?lsp app.loadex(_ENV,"Lua-Bindings") ?>

<p>We use the <a target="_blank" href="/ba/doc/luaref_index.html?url=manual.html#pdf-require">Lua function "require"</a> to dynamically load the "LED" library at runtime. The example below shows how to load the "LED" library and how to use the two Lua bindings 'setLed' and 'getLed' provided by this library.</p>

<div class="lspeditor" extype="lua" example="6.1"></div>

<p>Click the above Run button and pay attention to the printouts in the <a target="_blank" href="https://makoserver.net/documentation/getting-started/">server's command/console window</a>.</p>

<details open>
  <summary>Web Based Device Management</summary>
  <p>We can now go ahead and design a web based LED device management page. Let's create a simple web page with one HTML form and an HTML checkbox. Server side code sets the LED by calling function setLed (line 4 below) if the user sends a HTTP POST command to the server. </p>
  <p>Function getLed is used for setting the checkbox's checked state. You can see how this works on line 10 below.</p>
  <div class="lspeditor" example="6.2"></div>
  <p>Clicking the above Run button should produce a web page with a checkbox and a submit button. You can toggle the LED state by clicking the checkbox. The LED's state is changed when you click the submit button.</p>
</details>

<details open>
  <summary>Improving the Checkbox</summary>
  <p>The following example is identical in functionality to example 6.3; however, we have used cascading style sheets (CSS) to produce a more graphically pleasing toggle button. As you can see from the example below, there is a fair amount of CSS required for producing a more professional looking toggle button. Many web sites provide ready to use CSS for standard widget types. The CSS in the example below was copied from an online site providing widget examples.</p>
  <div class="lspeditor" example="6.3"></div>
  <p>Clicking the above Run button should produce a web page with the same features as example 6.2, but with a more professional looking toggle button.</p>
  <p>Since example 6.2 and 6.3 sets the same LED, clicking the On button in example 6.3 and pushing the submit button will make example 6.2 show the checkbox "checked" when the page is refreshed. Clicking the run button is the same as sending a page refresh command -- i.e. a GET command to the server.</p>
  <b>Test as follows:</b>
  <ol>
    <li>Uncheck the checkbox in example 6.2 and click submit.</li>
    <li>Click run button in example 6.3. The switch should be in off state.</li>
    <li>Check the checkbox in example 6.2 and click submit.</li>
    <li>Click run button in example 6.3. The switch should be in on state.</li>
  </ol>
  <p><b>Auto submit by clicking the checkbox</b></p>
  <p>In example 6.3, we must perform a two step procedure for changing the LED state in the server:</p>
  <ol>
    <li>Click the checkbox.</li>
    <li>Click the submit button.</li>
  </ol>
  <p>By using JavaScript code, the two manual steps can be combined into one. Copy the following code snippet and paste it into the above editor (example 6.3) directly after the &lt;head&gt; element.</p>
  <textarea style="width:90%;height:140px;">
      &lt;script src='/rtl/jquery.js'&gt;&lt;/script&gt;
      &lt;script&gt;
          $(function() {
              $(":checkbox").click(function(){
                  $.post(window.location,this.checked ? {LED:""} : null);
              });
              $(":submit").remove();
          });
      &lt;/script&gt;
  </textarea>
  <p>The above code uses JavaScript code to install an "on click" handler for the checkbox and to remove the submit button. The "on click" handler uses AJAX to send a HTTP POST request to the server. We will go into the details of AJAX in the next tutorial.</p>
</details>

<details open>
  <summary>Advanced Lua Bindings</summary>
  <p><b>(Time consuming C calls and releasing the server mutex)</b></p>
  <p>The following C example reads from standard input and blocks the calling thread until you press the Enter key on the keyboard. Reading from standard input is not recommended in a production server, thus the example only serves to illustrate how to release the global server mutex for lengthy operations. The following example is from the Barracuda Server's C API documentation under section <a target="_blank" href="http://localhost/ba/doc/en/C/reference/html/md_en_C_md_LuaBindings.html#LOOAccess">Advanced Lua Bindings tutorial</a>.</p>
  <div class="lspeditor" extype="C" example="mymodule" <?lsp=demo.config.nocompile and 'disabled="true"' or ''?>></div>
  <p>You can test the two Lua examples below after clicking the above compile button. Example 6.5 will simply block the HTTP thread until you enter some text in the server's console window and will block until you hit the Enter button.</p>
  <div class="lspeditor" extype="lua" example="6.4"></div>
  <p>Click the above Run button and notice how the browser's load button keeps spinning. Go to the server's console window, enter some text, and hit the Enter button. The browser should stop spinning and you should see the text you entered in the server's console window.</p>
  <p>Hit the Run button again and click any link on this page such as the menu buttons to the left. You'll notice that you can still use the server even though one thread is blocked. More about how this works can be found in the documentation under section <a target="_blank" href="/ba/doc/?url=lua.html#threadscoroutines">Thread Mapping and Coroutines</a>.</p>
  <p>The following example wraps the call to the blocking "getline" function into a standard web page with an HTML form, thus providing a more visual view of how the blocking function affects the web page. To make it even more visual, we have added some JavaScript code that hides the form and shows an image as soon as you hit the submit button. The browser keeps the original page until the server sends the response message. It is, for this reason, possible to run JavaScript after a browser sends a POST request to the server and visually indicates that the request is blocking by showing an animated gif image.</p>
  <div class="lspeditor" example="6.5"></div>
  <p>Click the run button to display the HTML form and then click the submit button. An animated gif image is activated by the JavaScript code at the same time the browser sends the POST request. The animated image will be displayed in the browser until the server sends the response message, which will not be until you press the Enter key in the server's console window. Keep the server's console window next to the browser window when you press the Enter key. You should see the immediate effect in the browser window when you press the Enter key.</p>
  <p>We are using the popular JQuery JavaScript library in the example below. We will show you how to use this JavaScript library in the Ajax tutorial.</p>
</details>

<p id="NextBut"><a href="HTML-Forms.lsp">Next Tutorial</a></p>

</div>
<?lsp response:include"footer.shtml" ?>
