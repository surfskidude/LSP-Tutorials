<?lsp title="LSP &amp; HTML Forms" response:include".header.lsp" ?>

<div class="rh">
<h1>LSP and HTML Forms</h1>

<p>HTML forms collect user input and let the browser send that input to the server.
The server typically processes the received data and then dynamically produces a new HTML page,
   which is sent in the response message to the browser.</p>

<div class="lspeditor" example="5.1"></div>

<p>Click Run above to display the HTML form.
When the user fills out the form and clicks Submit, the browser sends the form data to the server.
In this first example, the browser sends a POST request, but the server does not yet process the submitted information.
To turn a simple HTML page into an interactive application, we must read and process the input on the server.
That server-side processing is done with <samp>Lua Server Pages (LSP)</samp>.</p>

<p>Let's add server-side Lua code to the example. This Lua code runs every time the page is requested.</p>

<div class="lspeditor" example="5.2"></div>

<p>When the user fills out the form above and clicks the submit button, the form data is sent for processing to the URL of the page loaded in the browser.
With LSP, you can keep the server-side processing in the same page or redirect the posted
data to a separate page, as is common when writing CGI scripts. LSP is often easier to use,
since LSP makes it easy to create dynamic response data.</p>

<p>An LSP page provides a number of pre-defined variables such as the <a target="_blank" href="/ba/doc/?url=en/lua/lua.html#request">request object</a>
and the <a target="_blank" href="/ba/doc/?url=en/lua/lua.html#response">response object</a>.
The request object makes it easy to retrieve information provided by the client (the browser) and the response object is used
when sending response data back to the client. We use method <a target="_blank" href="/ba/doc/?url=en/lua/lua.html#request_data">request:data</a> on line 6
in example 5.2 to fetch the <a target="_blank" href="http://en.wikipedia.org/wiki/Percent-encoding">URL encoded data</a> sent from the browser.
This data is sent when the user clicks the Submit button. The URL encoded data is automatically converted to a Lua table by the server
and the data is presented as key/value pairs, hence the data for the HTML input element on line 14 is represented as "<code>luaTable.name</code>"
by the server-side code (line 7).</p>

<p><b>Note:</b> all examples run in an HTML iframe just below the editor.
Clicking Run has the same effect as refreshing the LSP page inside that iframe.</p>

<p style="clear:both"></p>

<details open>
  <summary>Server Side Form Validation</summary>
  <p>JavaScript can validate a form in the browser, but the server must validate the data again. A user can bypass browser-side checks and send requests directly to the server.</p>
  <p>The example below is a modified version of example 5.2, where we perform server-side validation.
  The example introduces server-side form validation.</p>
  <div class="lspeditor" example="5.3"></div>
  <br/>
  <b>Example 5.3:</b>
  <ul>
    <li><b>Line 3 - 15:</b> This code is executed if the Submit button is pressed.</li>
    <li><b>Line 5-7:</b> A function that uses a <a target="_blank" href="/ba/doc/luaref_index.html?url=manual.html#6.4.1">Lua regular expression</a>
      to remove white space at either end of a string. The function returns <samp>nil</samp> if the argument '<samp>s</samp>' is <samp>nil</samp>.</li>
    <li><b>Line 9:</b> We use the trim function to create a whitespace stripped copy of the form data '<samp>name</samp>' and '<samp>email</samp>'. </li>
    <li><b>Line 10-13:</b> We validate the form data. Line 13 is using a
    <a target="_blank" href="/ba/doc/luaref_index.html?url=manual.html#6.4.1">Lua regular expression</a> for email validation.
    The form data  '<samp>name</samp>' and '<samp>email</samp>' is guaranteed to be set if the data is sent from our HTML
    form since the form includes these two named input elements;
    thus you might wonder why we need to check for '<samp>nil</samp>' values on line 11.
    A hacker probing the page using a command line based tool such as <a target="_blank" href="http://curl.haxx.se/">curl</a>
    can send a POST request without setting these parameters.</li>
    <li><b>Line 14:</b> We print out OK or Invalid Data without providing details on the invalid data.</li>
  </ul>
  <p>Click the above Run button and then the Submit button in the generated LSP page.
   The page should print out "Invalid Data" without indicating where it failed. Enter some valid data and the page will print out 'OK'.</p>
  <p>End users would find the form in example 5.3 extremely inconvenient to use since the data entered into the form ('<samp>name</samp>' and '<samp>email</samp>')
  is lost when the user clicks the submit button. Enter data in the form above and notice how the two input elements are
  cleared when the server sends the response data.</p>
  <p>Server-generated web applications usually preserve useful state between requests. In this example, that means keeping the user's input when the form contains an error.</p>
  <p>Example 5.4 modifies example 5.3 so the two fields '<samp>name</samp>' and '<samp>email</samp>' keep their values
  if the data entered is incorrect. This enables the user to correct the data without having to retype all of it.
  The page also indicates which input element was entered incorrectly. When all data is valid, the page would normally save the result and go
  to the next page. Note: this tutorial does not actually save the data. The comment on line 12 shows where the data should be saved.
  Line 14 would normally redirect to a new page. We simply redirect to a page displaying an image when the data is correct.
  Notice how the value of the two input fields ('<samp>name</samp>' and '<samp>email</samp>') are maintained on line 21 and 23 below.</p>
  <div class="lspeditor" example="5.4"></div>
  <p>Click the above Run button and then the Submit button in the generated LSP page without entering any data.
   You should see an Incorrect Data message next to the two input fields.
   Next, enter Hello in both input fields. You should see an Incorrect Data message next to the <samp>email</samp> field.
   The entered data is maintained (is persistent) and you can now modify the email field and correct the entered data
   without having to retype the data in the name field.</p>
</details>

<details open>
  <summary>Cross Site Scripting Attacks</summary>
  <p>The forms above are vulnerable to <a target="_blank" href="http://en.wikipedia.org/wiki/Cross-site_scripting">cross-site scripting</a> (XSS) attacks if user input is written back to the page without escaping. Example 5.2 is especially vulnerable because it emits form data "as is" in the HTML response. Copy the following HTML and JavaScript code, paste it into the name field in example 5.2, and click Submit.</p>
  <pre class="code" data-lang="JavaScript">&lt;script&gt;alert("hello");&lt;/script&gt;</pre>
  <p>Depending on the browser you use, you may get a JavaScript popup saying Hello. Some browsers include counter measures so you may have to try several browsers before you see the popup.</p>
  <p>A common way to prevent this kind of XSS attack is to escape characters that have special meaning in HTML. The following code shows one simple filter.</p>

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
  <p>Click Run after modifying the script, then try the XSS input again. The JavaScript code should now be shown as text in the HTML output and should not trigger the Hello popup.</p>
  <p><b>Library vs. inline code:</b><br/>It is common to create reusable Lua helper functions, such as the XSS filter above. Shared helper code is usually placed in a library instead of directly inside an LSP page.</p>
</details>

<p id="NextBut"><a href="Ajax.lsp">Next Tutorial</a></p>

<?lsp response:include"footer.shtml" ?>
