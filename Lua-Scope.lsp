<?lsp title="Lua Scope" response:include".header.lsp" ?>

<h1>Lua Scope and Environment Tutorials</h1>

<div class="rh">

<details open>
  <summary>Variable scopes</summary>
  <p>Variables that we have access to are said to be visible. The scope of a variable is the containing block of code in which it is visible. Scopes are created and destroyed as the program executes and passes in and out of blocks. The variables contained within these blocks are created and destroyed according to the rules described on this page. When we enter a block and a new scope, we are entering an inner scope. Outer scopes are visible from inner scopes, but not vice versa.</p>
  <p>In Lua, blocks of code can be defined using functions and the <code>do</code>...<code>end</code> keywords:</p>
  <div class="lspeditor" extype="lua" example="9.1"></div>
  <p>The above example defines x and why as global variables and a
  function called foo which contains a scope. We create the variable x
  in the inner function scope. When we exit the function, the scope
  ends, and the variable x is deleted and is no longer visible. The
  <code>do</code>...<code>end</code> block contains similar functionality.</p>
</details>

<details open>
  <summary>Global Scope</summary>
  <p>Any variable <code>not in</code> a defined block is said to be in the global scope. Anything in the global scope is accessible by all inner scopes.</p>
  <div class="lspeditor" extype="lua" example="9.2"></div>
  <p>In the above example, g is in the global scope; i.e. no enclosing block is defined. The function foo is also in the global scope. 
      We enter the foo function scope when foo() is called. We can print the value of g because we can see the outer scope from the inner foo scope.</p>
</details>

<details open>
  <summary>The "local" Keyword</summary>
  <p>We use the keyword "<code>local</code>" to describe any variables we would
  like to keep local to the scope where they are defined in.</p>
  <div class="lspeditor" extype="lua" example="9.3"></div>
  <p>The '<code>local</code>' keyword is similar to the '<code>var</code>' keyword in JavaScript and is referred to as the lexical scope, a scope that is created at compile time. 
    Using variables declared as "<code>local</code>" are for this reason faster than using 
    dynamically declared variables since the dynamically declared variables must be looked up at runtime.</p>
  <p>In the above example, "<code>gbA</code>" and "<code>foo</code>" are dynamically declared in the
   <a target="_blank" href="/ba/doc/luaref_index.html?url=manual.html#2.2">current environment (<samp>_ENV</samp>)</a>.  
   Since foo is not in the lexical scope, Lua automatically looks up foo in the environment table <samp>_ENV</samp>. 
   Try changing the call "<code>foo</code>()" on line 6 to "<samp>_ENV</samp>.<code>foo</code>()". Notice that it will behave just as calling foo without explicitly specifying the environment table.</p>
</details>

<details open>
  <summary>Local Scope</summary>
  <p>Unlike JavaScript, Lua provides multilevel scoping. When we create a block we are creating a scope in which variables can live: </p>
  <div class="lspeditor" extype="lua" example="9.4"></div>
  <p>In the above example, "<code>do</code>...<code>end</code> " encloses a block containing the declaration of the local variables. You can see that we can print its value, when we are in the value's scope. When we exit the scope (the end keyword) we lose visibility of the local variables in that scope. When we print the value of the variables once outside the scope, we get nil. This means "variable not found". The keyword local is placed before any variable that we want to remain visible only to that scope and its inner scopes.</p>
  <p>In the following example, <code>x</code> starts with the value 1. We create a block using the "do and end" keywords. We use the local keyword to specify that we want a new variable also called x which is only visible in this block or scope.</p>
  <div class="lspeditor" extype="lua" example="9.5"></div>
  <p>You can see that once the <code>do</code>...<code>end</code> scope has ended, the second declaration of x disappears, and we revert back to the old one.</p>
</details>

<details open>
  <summary>Global Scope and "<code>local</code>" Variables</summary>
  <p>The <code>local</code> keyword can be used in any scope, not just inner and function scopes. This may seem a little unintuitive, but even the global scope in Lua can become an inner scope if it is used as a module. </p>
  <p>As we mentioned above, it is more efficient to use local variables ( lexical scope) whenever possible because of the implementation of Lua. 
    The technical reason for this is that <code>local</code> variables in the lexical scope are referenced via a direct assigned number, whereas global 
    variables are stored in the environment table <samp>_ENV</samp>, which is accessed with a key (the variable name). 
    Table lookups are very fast in Lua, but still not as fast as local register lookups. Local Lua variables are similar to stack variables in 
    C code except that they can be saved as <a target="_blank" href="http://en.wikipedia.org/wiki/Closure_(computer_programming)">closures</a>. 
    A closure is also known as an 'upvalue' in Lua terminology.</p>
  <p><b>Closure (Upvalue) Example:</b></p>
  <div class="lspeditor" extype="lua" example="9.6"></div>
  <p>In the above example, function "<code>funcFactory</code>" returns an inner function which uses the variable declared on line 2. This variable acts as a closure and remains valid as long as the returned function "x" is in use. Closures are also very common in JavaScript design, and the jQuery library we used in the Ajax tutorial typically requires that you use closures for the browser event handlers. Closures and anonymous functions are features found in most scripting languages.</p>
</details>

<details id="_ENV" open>
  <summary>The Environment Table <samp>_ENV</samp></summary>
  <p>In the Lua scripting language, everything is stored in a table, including the <a target="_blank" href="/ba/doc/luaref_index.html?url=manual.html#2.2">current environment</a>. The environment is implicitly accessed when looking up dynamic variables, but you can also specifically reference variables in the current scope by using the <samp>_ENV</samp> table.</p>
  <div class="lspeditor" extype="lua" example="9.7"></div>
  <p>The <samp>_ENV</samp> is stored as a closure (a.k.a upvalue) in the current script and is, for this reason, also applied to all functions and inner functions in the script. A function can, however, change the environment as shown in the next example.</p>
  <div class="lspeditor" extype="lua" example="9.8"></div>
  <p>Notice how we save function "<code>print</code>" as a local variable "<samp>myprint</samp>" on line 1. 
      The above script would generate an exception without this construction.
      Change "<samp>myprint</samp>" to "<samp>print</samp>" on line 5 and the script will still work, but the script will 
      fail if you try the same change on line 7. Go ahead and make the changes above and you will see you get an exception when 
      line 7 is run. The reason we get the exception is that the "<samp>print</samp>" function is not defined in the new environment we create on line 6.</p>
  <a name="server"></a>
</details>

<details open>
  <summary>The Server's Environments</summary>
  <p>So by now you should understand that the current environment is a Lua table that can be explicitly referenced by using the name  '<samp>_ENV</samp>' 
  and that the environment can be changed at any time by assigning <samp>_ENV</samp> to a Lua table. 
  Variables can be in the lexical scope (static scope) or in the dynamic scope (<samp>_ENV</samp>). 
  If the variable is not in the lexical scope, it will be search for in the dynamic scope. 
  In example 9,8, we created a closure (<samp>myprint</samp>) so we could output text in the two functions (<code>foo</code> and <code>bar</code>) 
    overriding the default <samp>_ENV</samp>. This was necessary since the new environments we created in "<code>foo</code>" and "<code>bar</code>" did not have a <code>print</code> function.</p>
  <p>A new environment (a new table)  can be made to inherit another table. In Lua, this is done by using metatables. 
  The following examples introduces metatables and shows how to chain two tables 
    -- in other words, how to make Lua search for variables by following the chain. 
    You will learn more about metatables  in the <a href="Lua-Metamethods.lsp">Lua Methamethods tutorial</a>.</p>
  <div class="lspeditor" extype="lua" example="9.9"></div>
  <p>Running the above example prints out "<samp>Hello</samp>" and "<samp>world</samp>" on two separate lines in the iframe. Function print is not in the new environment table, but it still works since we chain the new environment to the LSP page's environment.</p>
  <p>In the above example, change <code>__index = _ENV</code> to <code>__index = _G</code> and rerun the example. Notice that '<samp>world</samp>' is now printed to the server's console window and not in the iframe. Recall that we have two print functions, one for the LSP page, which sends data as response to the client and the Lua global print function, which prints to the console.</p>
  <p>As a final test, remove or comment out line 8 where we set the metatable an rerun the example. You should now get an exception since the "<code>print</code>" function is not found.</p>
  <img style="float:right" src="/ba/doc/en/img/RequestResponseEnv.png" />
  <h4>The server's three environments</h4>
  <p>The Mako Server provides three environments, all accessible from LSP pages as shown in the image to the right.</p>
  <ul>
    <li>The global Lua environment <samp>_G</samp></li>
    <li>The LSP page's request/response environment</li>
    <li>The application's environment</li>
  </ul>
  <p>We have already introduced you to the LSP page's environment and the Lua global environment <samp>_G</samp>. 
  The application environment is an additional environment that can be used as a global environment for the application. 
  As an example, the Mako Server can load multiple applications and each application has it's own application 
  environment where you can keep common code for the application.</p>
  <p>The following example shows the relationship between the three environments.</p>
  <p style="clear:both"></p>
  <div class="lspeditor" example="9.10"></div>
  <p>Notice how the address for the request/response environment (<samp>_ENV</samp>) changes each time you click the 
  Run button, but that the app table and <samp>_G</samp> stay the same. 
  A new request/response environment is created each time the page is run. 
  This environment is also available to server side included pages and you can pass 
  variables from one LSP page to another LSP page by using this environment.</p>
  <p>The above example also prints out the app table and the global table on line 10 and 12. 
  The key/value data printed for the '<code>app</code>' table is generic code used by this tutorial's engine.</p>
</details>

<p id="NextBut"><a href="Lua-Coroutines.lsp">Next Tutorial</a></p>

</div>
<?lsp response:include"footer.shtml" ?>
