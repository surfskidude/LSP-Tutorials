<?lsp title="Lua to C Code" response:include".header.lsp"
?>


<div class="rh">

<h1>Interfacing Lua with Existing C/C++ Code</h1>
<p>The following examples are designed for C and C++ programmers who want Lua scripts to call native code.</p>
<?lsp
local notInstalled,cc=false
if not page.installed then
   cc = io:dofile(".lua/C-Install.lua",app)
   if request:method() == "POST" and request:data"install" then
      local ok,err = cc.install()
      if ok then
         response:sendredirect(request:url())
      end
      response:write('<div class="alert alert-warning"><p>',err,'</p></div>')
      response:include"footer.shtml"
      return
   end
   notInstalled = cc.check()
end
?>

<details <?lsp=notInstalled and "open" or "closed"?>>
    <summary>Introduction</summary>
<br>
<div class="alert alert-success">
<p>When working with <b>embedded devices</b>, Lua can call lower-level C code through Lua bindings. For device management, this usually means exposing selected C functions to Lua so scripts can control hardware or firmware services safely.</p>
</div>

<p><b>Here’s a breakdown of the process:</b></p>
<ul>
<li><b>Lua Binding:</b> A binding connects the Lua virtual machine to native C functions or C++ methods, allowing Lua scripts to call custom native functions.</li>

<li><b>Manual or Automatic Creation:</b> Lua bindings can be created manually or automatically using tools like the <a target="_blank" href="https://realtimelogic.com/swig/">online Lua Binding Generator</a>.</li>

<li><b>Compilation:</b> The provided examples include C code demonstrating how to extend Lua APIs. This code can be compiled directly from this web page using the TCC compiler on Windows and GCC on other platforms.</li>
</ul>

<p>The figure below shows the usual flow for generating and integrating a Lua binding into firmware. The C examples on this page demonstrate the same ideas and can be compiled directly from the tutorial.</p>

<div class="center"><img src="/images/C2Lua-development-flow.svg" alt="Lua Binding Generator"/></div>
<p class="caption">Figure 1. The Development Flow: The C code is compiled only once, while Lua scripts are compiled just-in-time on the embedded device. This occurs during startup and when requested by the browser. The figure illustrates the use of a generator to create bindings; however, in this tutorial, the Lua bindings are created manually.</p>

<h2>What is a Lua Binding</h2>

<p>A Lua binding is a bridge between Lua code and functionality written in another language, typically C or C++. It exposes native functions, data structures, or APIs to Lua in a form that Lua scripts can call.</p>

<h4>The Virtual Stack</h4>
<p>Lua and C exchange values through a virtual stack. When Lua calls a C function, the arguments are placed on this stack. The C function reads values from the stack and pushes return values back onto it. This stack is central to almost every Lua C API operation.</p>
<p>To understand how Lua's virtual stack works in the context of C code, let's look at a simple Lua example:</p>

<div class="lspeditor" extype="lua" example="echoargs"></div>


<p>The function <code>echoargs</code> takes a variable number of arguments, prints them with the text "Args received: ", and returns all arguments unchanged. The three dots (<code>...</code>) mean the function accepts a variable number of arguments.</p>
<p>The variable number of arguments, represented by the ... in Lua, conceptually illustrates what a Lua binding receives when interacting with the Lua runtime. Every argument passed to a Lua function is pushed onto the virtual stack, allowing the binding to access them sequentially, process them, and return results to Lua. We can convert the echoargs Lua function into its equivalent Lua C API binding to demonstrate how Lua bindings handle these arguments. This conversion provides insight into how arguments are managed in C.</p>


<pre>
int lua_echoargs(lua_State *L)
{
   // Get the number of arguments passed to the function
   int nargs = lua_gettop(L);
   // Print the arguments using printf
   printf("Args received:");
   for (int i = 1; i <= nargs; i++) {
      printf(" %s", lua_tostring(L, i)); // 'i' is stack index
   }
   printf("\n");
   // Return all arguments to Lua
   return nargs;  // The number of results matches the number of input arguments
}
</pre>

<p>The <code>lua_echoargs</code> function above shows how a Lua binding handles arguments with the Lua C API and the virtual stack. It reads all arguments passed from Lua, prints them, and returns them without modification. Here's how it works:</p>
<ol>
<li><strong>Getting the Number of Arguments</strong>: The function uses lua_gettop to determine how many arguments were passed to the Lua function. Each argument corresponds to a position on the virtual stack, starting at index 1.</li>
<li><strong>Processing and Printing Arguments</strong>: The function iterates over the stack indices using a for loop. For each argument, it uses lua_tostring, which safely converts many Lua values into a string representation.</li>
<li><strong>Returning Arguments</strong>: After printing, the function returns all arguments to Lua. The return count matches the input count (nargs), which ensures the behavior is consistent with the original Lua function.</li>
</ol>

<blockquote><p>We use plain old C in this tutorial. Check out the <a target="_blank" href="https://realtimelogic.com/articles/SOL2-C-Lua-Binding-Tutorial">SOL2 C++ Lua Binding Tutorial</a> if you prefer using C++. This tutorial also shows how to embed the bindings in the server at compile time.</p></blockquote>


<h2>Getting Started</h2>

<p>The C examples in this tutorial are tailored for the Mako Server. The same binding concepts apply to an embedded monolithic RTOS device using the Barracuda App Server library; the main difference is initialization and deployment. On an embedded device, the libraries are compiled and linked with the server and firmware. With the precompiled Mako Server binary, Lua bindings are loaded as DLLs or shared libraries.</p>

<p>This tutorial focuses on calling C code from Lua. For information on calling Lua asynchronously from C, refer to the <a  target="_blank" href="https://realtimelogic.com/ba/doc/en/C/reference/html/md_en_C_md_LuaBindings.html#AsynchC2Lua">advanced Lua bindings</a> section in the documentation.</p>
</details>
<?lsp
if not page.installed then
if notInstalled then
?>
<h2>Install Required Modules</h2>
<p>The Lua binding examples require the Mako Server module plugin and a compiler. Click the following button to install the required components.</p>



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
<div class="alert alert-warning"><p>Warning: it appears that there is no Internet connection or a proxy prevents access. The installation process will fail if the server is unable to download the additional component!</p></div>
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
<h2>Examples</h2>
<p>The C example below is based on the Barracuda App Server documentation's <a target="_blank" href="https://realtimelogic.com/ba/doc/en/GettingStarted.html#DeviceMgm">Getting Started: Controlling the LED using LSP</a> example, but the initialization code has been adapted for the Mako Server. Open that documentation link for more background on how the binding works.</p>

<div class="lspeditor" extype="C" example="LED" <?lsp=demo.config.nocompile and 'disabled="true"' or ''?>></div>

<?lsp if not demo.config.nocompile then ?>
<p>Clicking the Compile button above should compile the C code and produce a DLL on Windows or a shared library on Linux.</p>

<div class="alert alert-success">
<p><b>Note:</b> you can modify the C code in the above example by using the inline editor, but you may have to restart the server before you can compile and use the new DLL. The server must be restarted if you have already loaded the DLL by using the Lua function "require". A loaded DLL is not released until the server terminates.</p>
</div>

<p>The following Lua and LSP examples require that you compile the C code and produce a DLL. If you test any of the examples below before compiling, you will get a Lua exception. If you want to see how the code fails, go ahead and test any of the examples below before compiling the above code.</p>

<?lsp end ?>

<?lsp app.loadex(_ENV,"Lua-Bindings") ?>

<p>We use the <a target="_blank" href="/ba/doc/luaref_index.html?url=manual.html#pdf-require">Lua function "require"</a> to load the "LED" library at runtime. The example below shows how to load the library and use its two Lua bindings: <code>setLed</code> and <code>getLed</code>.</p>

<div class="lspeditor" extype="lua" example="6.1"></div>

<p>Click the above Run button and pay attention to the printouts in the <a target="_blank" href="https://makoserver.net/documentation/getting-started/">server's command/console window</a>.</p>

<details open>
  <summary>Web Based Device Management</summary>
  <p>We can now design a web-based LED device management page. The page has one HTML form and one checkbox. When the browser sends an HTTP POST request, the server-side code calls <code>setLed</code> on line 4 to change the LED state.</p>
  <p>The <code>getLed</code> function sets the checkbox's checked state when the page is rendered. You can see this on line 10 below.</p>
  <div class="lspeditor" example="6.2"></div>
  <p>Clicking the above Run button should produce a web page with a checkbox and a submit button. You can toggle the LED state by clicking the checkbox. The LED's state is changed when you click the submit button.</p>
</details>

<details open>
  <summary>Improving the Checkbox</summary>
  <p>The following example keeps the same behavior as example 6.2, but uses Cascading Style Sheets (CSS) to make the checkbox look like a toggle switch. The amount of CSS may look large compared with the Lua code; that is normal for custom browser widgets.</p>
  <div class="lspeditor" example="6.3"></div>
  <p>Clicking the above Run button should produce a web page with the same features as example 6.2, but with a more professional looking toggle button.</p>
  <p>Examples 6.2 and 6.3 control the same LED state. If you turn the LED on in example 6.3 and submit the form, example 6.2 will show its checkbox checked the next time it is refreshed. Clicking Run is the same as refreshing the example page, which sends a GET request to the server.</p>
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
  <p>JavaScript can combine these two manual steps into one. Copy the following snippet and paste it into example 6.3 directly after the &lt;head&gt; element.</p>
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
  <p>The code above installs an "on click" handler for the checkbox and removes the submit button. The click handler uses AJAX to send an HTTP POST request to the server. The next tutorial explains AJAX in more detail.</p>
</details>

<details open>
  <summary>Advanced Lua Bindings</summary>
  <p><b>(Time consuming C calls and releasing the server mutex)</b></p>
  <p>The following C example reads from standard input and blocks the calling thread until you press Enter in the server console. Reading from standard input is not recommended in a production server; this example only demonstrates how to release the global server mutex during lengthy operations. The example comes from the Barracuda Server's C API documentation under <a target="_blank" href="http://localhost/ba/doc/en/C/reference/html/md_en_C_md_LuaBindings.html#LOOAccess">Advanced Lua Bindings tutorial</a>.</p>
  <div class="lspeditor" extype="C" example="mymodule" <?lsp=demo.config.nocompile and 'disabled="true"' or ''?>></div>
  <p>You can test the two Lua examples below after clicking the above compile button. Example 6.5 will simply block the HTTP thread until you enter some text in the server's console window and will block until you hit the Enter button.</p>
  <div class="lspeditor" extype="lua" example="6.4"></div>
  <p>Click the above Run button and notice how the browser's load button keeps spinning. Go to the server's console window, enter some text, and hit the Enter button. The browser should stop spinning and you should see the text you entered in the server's console window.</p>
  <p>Hit the Run button again and click any link on this page such as the menu buttons to the left. You'll notice that you can still use the server even though one thread is blocked. More about how this works can be found in the documentation under section <a target="_blank" href="/ba/doc/?url=lua.html#threadscoroutines">Thread Mapping and Coroutines</a>.</p>
  <p>The following example wraps the blocking <code>getline</code> call in a normal web page with an HTML form. This makes it easier to see how the blocking function affects the page. The JavaScript hides the form and shows an image as soon as you click Submit. The browser keeps displaying the original page until the server sends the response, so the animated image remains visible while the request is blocked.</p>
  <div class="lspeditor" example="6.5"></div>
  <p>Click the run button to display the HTML form and then click the submit button. An animated gif image is activated by the JavaScript code at the same time the browser sends the POST request. The animated image will be displayed in the browser until the server sends the response message, which will not be until you press the Enter key in the server's console window. Keep the server's console window next to the browser window when you press the Enter key. You should see the immediate effect in the browser window when you press the Enter key.</p>
  <p>We are using the popular JQuery JavaScript library in the example below. We will show you how to use this JavaScript library in the Ajax tutorial.</p>
</details>

<p id="NextBut"><a href="HTML-Forms.lsp">Next Tutorial</a></p>

</div>
<?lsp response:include"footer.shtml" ?>
