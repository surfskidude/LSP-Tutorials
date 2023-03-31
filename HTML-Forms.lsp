<?lsp title="LSP &amp; HTML Forms" response:include".header.lsp" ?>

<div class="rh">
<h1>LSP and HTML Forms</h1>

<p>HTML forms are used to collect user input and makes it possible for a browser to send user input to the server. The server typically processes the received data and then dynamically produces a new HTML page, which is sent in the response message to the browser.</p>

<div class="lspeditor" example="5.1"></div>

<p>Click the above Run button to display the HTML form. When the user fills out the above form and clicks the submit button, the form data is sent for processing to the server. Clicking the above run button and then the submit button in the generated page makes the browser send a POST request to the server; however, the server side is not processing the information in the above example. When we convert simple HTML pages into interactive applications we need to get user input to be processed at the server side. The server side processing is done by Lua Server Pages (LSP)</p>

<p>Let's add some server side Lua code to the above example. The server side code is run every time the page is accessed.</p>

<div class="lspeditor" example="5.2"></div>

<div class="center" style="margin:10px auto" class="blogsidebar">
<img title="compileLSP" src="images/compileLSP_thumb_1.gif" />
<p class="caption">Figure 1. Recompiling LSP is as simple as refreshing the browser window.</p>
</div>

<p>When the user fills out the form above and clicks the submit button, the form data is sent for processing to the URL of the page loaded in the browser. With LSP, you can keep the server side processing in the same page or you can redirect the POST'ed data to a separate page such as what is common when writing CGI scripts. You will find LSP much easier to use though, since LSP makes it easy to create dynamic response data.</p>

<p>An LSP page provides a number of pre-defined variables such as the  <a target="_blank" href="/ba/doc/?url=en/lua/lua.html#request">request object</a> and the  <a target="_blank" href="/ba/doc/?url=en/lua/lua.html#response">response object</a>. The request object makes it easy to retrieve information provided by the client (the browser) and the response object is used when sending response data back to the client. We use method <a target="_blank" href="/ba/doc/?url=en/lua/lua.html#request_data">request:data</a> on line 6 in example 5.2 to fetch the <a target="_blank" href="http://en.wikipedia.org/wiki/Percent-encoding">URL encoded data</a> sent from the browser. This data is sent when the user clicks the Submit button. The URL encoded data is automatically converted to a Lua table by the server and the data is presented as key/value pairs, hence the data for the HTML input element on line 14 is represented as "luaTable.name" at the server side (line 7).</p>

<p><b>Note:</b> all the examples run in an HTML iframe just below the editor. Clicking the Run button provides the same effect as clicking the browser's refresh button for the LSP code in the iframe.</p>

<p style="clear:both"></p>

<details open>
  <summary>Server Side Form Validation</summary>
  <p>Although form validation can be done in JavaScript code on the client side, form validation must still be done on the server side for security reasons.</p>
  <p>The example below is a modified version of example 5.2, where we perform server side validation. The example provides an introduction on how to validate code on the server.</p>
  <div class="lspeditor" example="5.3"></div>
  <br/>
  <b>Example 5.3:</b>
  <ul>
    <li><b>Line 3 - 15:</b> This code is executed if the Submit button is pressed.</li>
    <li><b>Line 5-7:</b> A function that uses a <a target="_blank" href="/ba/doc/luaref_index.html?url=manual.html#6.4.1">Lua regular expression</a> to remove white space at either end of a string. The function returns nil if the argument 's' is nil.</li>
    <li><b>Line 9:</b> We use the trim function to create a whitespace stripped copy of the form data 'name' and 'email'. </li>
    <li><b>Line 10-13:</b> We validate the form data. Line 13 is using a <a target="_blank" href="/ba/doc/luaref_index.html?url=manual.html#6.4.1">Lua regular expression</a> for email validation. The form data 'name' and 'email' is guaranteed to be set if the data is sent from our HTML form since the form includes these two named input elements; thus you might wonder why we need to check for 'nil' values on line 11. A hacker probing the page using a command line based tool such as <a target="_blank" href="http://curl.haxx.se/">curl</a> can send a POST request without setting these parameters.</li>
    <li><b>Line 14:</b> We print out OK or Invalid Data without providing details on the invalid data.</li>
  </ul>
  <p>Click the above Run button and then the Submit button in the generated LSP page. The page should print out "Invalid Data" without indicating where it failed. Enter some valid data and the page will print out 'OK'.</p>
  <p>End users would find the form in example 5.3 extremely inconvenient to use since the data entered into the form (name and email) is lost when the user clicks the submit button. Enter data in the form above and notice how the two input elements are cleared when the server sends the response data.</p>
  <p>It's typical for server side generated web applications to be designed such that the application's state is preserved. What this means for the above example is that we must find a way to save the data entered by the user.</p>
  <p>The following example 5.4 is a modified version of example 5.3, which maintains the two elements 'data' and 'email' if the data entered is incorrect. This enables the user to correct the data without having to retype all of it. The page also indicates what input element that was entered incorrectly. When all data is entered correctly, the page saves the result and goes to the next page. Note: we are not actually saving the data. You can see by the comment on line 12 where the data should be saved. Line 14 would normally redirect to a new page. We simply redirect to a page displaying an image when the data is correct. Notice how the value of the two input fields (name &amp; email) are maintained on line 21 and 23 below.</p>
  <div class="lspeditor" example="5.4"></div>
  <p>Click the above Run button and then the Submit button in the generated LSP page without entering any data. You should see an Incorrect Data message next to the two input fields. Next, enter Hello in both input fields. You should see an Incorrect Data message next to the email field. The entered data is maintained (is persistent) and you can now modify the email field and correct the entered data without having to retype the data in the name field.</p>
</details>

<details open>
  <summary>Cross Site Scripting Attacks</summary>
  <p>All forms above are open to <a target="_blank" href="http://en.wikipedia.org/wiki/Cross-site_scripting">cross site scripting</a> (XSS) attacks, in particular example 5.2, since this example emits the form data "as is" in the HTML response. Copy the following HTML and Javascript code, paste the data into the name field in example 5.2, and click Submit. </p>
  <pre class="code">&lt;script&gt;alert("hello");&lt;/script&gt;</pre>
  <p>Depending on the browser you use, you may get a JavaScript popup saying Hello. Some browsers include counter measures so you may have to try several browsers before you see the popup.</p>
  <p>A common method used to prevent XSS attacks is to create a filter that translates symbols to the HTML escaped version of the symbols. The following code shows one way to create such a filter.</p>

  <pre class="code">
  -- Trim whitespace
  local function trim(s)
     return s:gsub("^%s*(.-)%s*$", "%1")
  end

  -- Symbols to escape
  local escSyms= {
     ['&']="&amp;amp;",
     ['<']="&amp;lt;",
     ['>']="&amp;gt;",
  }
  -- Escape symbols
  local function escape(c) return escSyms[c] end

  -- Trim and escape data from request:data()
  local function xssfilter(inData)
     local outData={}
     for key,value in pairs(inData) do
        outData[key] = trim(value):gsub("[&<>]", escape)
     end
     return outData
  end
  </pre>

  <p>You can try the above filter code in example 5.2. Copy the filter code and add it to example 5.2 within the LSP tag. Then, modify the following:</p>
  <pre class="code">
  <b>From:</b>
     local luaTable = request:data()
  <b>To:</b>
     local luaTable = xssfilter(request:data())
  </pre>
  <p>Click the run button after you have modified the script, and try to re-enter the XSS JavaScript code above. The JavaScript code should now be emitted in the HTML output and not cause the Hello popup message.</p>
  <p><b>Library v.s. inline code:</b><br/>It's common to create a set of helper functions in Lua such as the above XSS filter code. Common code is typically put in a library and not directly inside an LSP page.</p>
</details>

<p id="NextBut"><a href="Ajax.lsp">Next Tutorial</a></p>

<?lsp response:include"footer.shtml" ?>
