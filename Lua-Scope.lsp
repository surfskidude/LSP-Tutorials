<?lsp title="Lua Scope" response:include".header.lsp" ?>

<h1>Lua Scope and Environment Tutorials</h1>

<div class="rh">

<details open>
  <summary>Variable scopes</summary>
  <p>A variable is visible when code can access it. The scope of a variable is the block of code where that variable can be seen. Scopes are created and destroyed as the program enters and leaves blocks. When code enters a nested block, it enters an inner scope. Inner scopes can see variables from outer scopes, but outer scopes cannot see variables created inside inner scopes.</p>
  <p>In Lua, blocks of code can be defined using functions and the <code>do</code>...<code>end</code> keywords:</p>
  <div class="lspeditor" extype="lua" example="9.1"></div>
  <p>The example above defines <code>x</code> and <code>why</code> as global variables and defines a function called <code>foo</code>. The function has its own inner scope. The <code>x</code> created inside the function is different from the global <code>x</code>. When the function returns, the inner scope ends and the inner <code>x</code> is no longer visible. A <code>do</code>...<code>end</code> block creates a similar local scope.</p>
</details>

<details open>
  <summary>Global Scope</summary>
  <p>A variable that is not declared inside a local block belongs to the current environment, which often behaves like the global scope. Values in this outer scope are accessible from inner scopes.</p>
  <div class="lspeditor" extype="lua" example="9.2"></div>
  <p>In the example above, <code>g</code> is in the outer scope because no enclosing block declares it as local. The function <code>foo</code> is also in that outer scope. When <code>foo()</code> runs, it can print <code>g</code> because inner scopes can see outer values.</p>
</details>

<details open>
  <summary>The "local" Keyword</summary>
  <p>Use the <code>local</code> keyword when you want a variable to exist only in the scope where it is defined.</p>
  <div class="lspeditor" extype="lua" example="9.3"></div>
  <p>A <code>local</code> variable belongs to lexical scope, meaning Lua can determine where it lives when the script is compiled. Local variables are usually faster than dynamically looked-up variables because Lua does not need to search the environment table at runtime.</p>
  <p>In the example above, "<code>gbA</code>" and "<code>foo</code>" are dynamically declared in the
   <a target="_blank" href="/ba/doc/luaref_index.html?url=manual.html#2.2">current environment (<samp>_ENV</samp>)</a>.
   Since foo is not in the lexical scope, Lua automatically looks up foo in the environment table <samp>_ENV</samp>.
   Try changing the call "<code>foo</code>()" on line 6 to "<samp>_ENV</samp>.<code>foo</code>()". It behaves the same as calling <code>foo</code> directly because both names refer to the same value in the environment table.</p>
</details>

<details open>
  <summary>Local Scope</summary>
  <p>Unlike JavaScript, Lua provides multilevel scoping. When we create a block we are creating a scope in which variables can live: </p>
  <div class="lspeditor" extype="lua" example="9.4"></div>
  <p>In the example above, <code>do</code>...<code>end</code> encloses a block that contains local variables. We can print those values while execution is inside the block. After the <code>end</code> keyword, the local variables are no longer visible. Reading the same names outside the block returns <code>nil</code>, which means no visible variable with that name was found.</p>
  <p>In the following example, <code>x</code> starts with the value 1. We create a block using the "do and end" keywords. We use the local keyword to specify that we want a new variable also called x which is only visible in this block or scope.</p>
  <div class="lspeditor" extype="lua" example="9.5"></div>
  <p>You can see that once the <code>do</code>...<code>end</code> scope has ended, the second declaration of x disappears, and we revert back to the old one.</p>
</details>

<details open>
  <summary>Global Scope and "<code>local</code>" Variables</summary>
  <p>The <code>local</code> keyword can be used in any scope, not just inner and function scopes. This may seem a little unintuitive, but even the global scope in Lua can become an inner scope if it is used as a module. </p>
  <p>As mentioned above, it is more efficient to use local variables (lexical scope) whenever possible because of how Lua is implemented.
    The technical reason for this is that <code>local</code> variables in the lexical scope are referenced via a direct assigned number, whereas global
    variables are stored in the environment table <samp>_ENV</samp>, which is accessed with a key (the variable name).
    Table lookups are very fast in Lua, but still not as fast as local register lookups. Local Lua variables are similar to stack variables in
    C code except that they can be saved as <a target="_blank" href="http://en.wikipedia.org/wiki/Closure_(computer_programming)">closures</a>.
    A closure is also known as an 'upvalue' in Lua terminology.</p>
  <p><b>Closure (Upvalue) Example:</b></p>
  <div class="lspeditor" extype="lua" example="9.6"></div>
  <p>In the example above, <code>funcFactory</code> returns an inner function that uses the variable declared on line 2. That variable is kept alive by the returned function. This captured variable is called a closure, or an upvalue in Lua terminology. Closures are also common in JavaScript, especially in browser event handlers.</p>
</details>

<details id="_ENV" open>
  <summary>The Environment Table <samp>_ENV</samp></summary>
  <p>In the Lua scripting language, everything is stored in a table, including the <a target="_blank" href="/ba/doc/luaref_index.html?url=manual.html#2.2">current environment</a>. The environment is implicitly accessed when looking up dynamic variables, but you can also specifically reference variables in the current scope by using the <samp>_ENV</samp> table.</p>
  <div class="lspeditor" extype="lua" example="9.7"></div>
  <p><samp>_ENV</samp> is stored as a closure, also called an upvalue, in the current script. Because of this, functions and inner functions can use the same environment. A function can also replace its environment, as shown in the next example.</p>
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
  <p>At this point, you have seen that the current environment is a Lua table that can be explicitly referenced by using the name '<samp>_ENV</samp>'
  and that the environment can be changed at any time by assigning <samp>_ENV</samp> to a Lua table.
  Variables can be in the lexical scope (static scope) or in the dynamic scope (<samp>_ENV</samp>).
  If the variable is not in lexical scope, Lua searches for it in the dynamic scope.
  In example 9,8, we created a closure (<samp>myprint</samp>) so we could output text in the two functions (<code>foo</code> and <code>bar</code>)
    overriding the default <samp>_ENV</samp>. This was necessary since the new environments we created in "<code>foo</code>" and "<code>bar</code>" did not have a <code>print</code> function.</p>
  <p>A new environment (a new table) can be made to inherit from another table. In Lua, this is done with metatables.
  The following example introduces metatables and shows how to chain two tables
    -- in other words, how to make Lua search for variables by following the chain.
    You will learn more about metatables in the <a href="Lua-Metamethods.lsp">Lua Metamethods tutorial</a>.</p>
  <div class="lspeditor" extype="lua" example="9.9"></div>
  <p>Running the above example prints out "<samp>Hello</samp>" and "<samp>world</samp>" on two separate lines in the iframe. Function print is not in the new environment table, but it still works since we chain the new environment to the LSP page's environment.</p>
  <p>In the above example, change <code>__index = _ENV</code> to <code>__index = _G</code> and rerun the example. Notice that '<samp>world</samp>' is now printed to the server's console window and not in the iframe. Recall that we have two print functions, one for the LSP page, which sends data as response to the client and the Lua global print function, which prints to the console.</p>
  <p>As a final test, remove or comment out line 8 where we set the metatable and rerun the example. You should get an exception because the "<code>print</code>" function is not found.</p>
  <img style="float:right;max-width:300px" src="https://realtimelogic.com/ba/doc/en/img/RequestResponseEnv.svg" />
  <h4>The server's three environments</h4>
  <p>The Mako Server provides three environments, all accessible from LSP pages as shown in the image to the right.</p>
  <ul>
    <li>The global Lua environment <samp>_G</samp></li>
    <li>The LSP page's request/response environment</li>
    <li>The application's environment</li>
  </ul>
  <p>We have already introduced you to the LSP page's environment and the Lua global environment <samp>_G</samp>.
  The application environment is an additional environment that can be used as a global environment for the application.
  For example, the Mako Server can load multiple applications, and each application has its own application
  environment where you can keep common code for the application.</p>
  <p>The following example shows the relationship between the three environments.</p>
  <p style="clear:both"></p>
  <div class="lspeditor" example="9.10"></div>
  <p>Notice how the address for the request/response environment (<samp>_ENV</samp>) changes each time you click the
  Run button, but that the app table and <samp>_G</samp> stay the same.
  A new request/response environment is created each time the page is run.
  This environment is also available to server-side included pages and you can pass
  variables from one LSP page to another LSP page by using this environment.</p>
  <p>The example above also prints the app table and the global table on lines 10 and 12.
  The key/value data printed for the '<code>app</code>' table is generic code used by this tutorial's engine.</p>
</details>

<p id="NextBut"><a href="Lua-Coroutines.lsp">Next Tutorial</a></p>

</div>
<?lsp response:include"footer.shtml" ?>
