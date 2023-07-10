<?lsp title="Lua Functions" response:include".header.lsp" ?>

<h1>Functions Tutorial</h1>

<div class="rh">

<p>Functions are conventionally defined in Lua with the function keyword as follows:</p>

<strong><code>function</code></strong> <em>function_name</em> <strong><code>(</code></strong> <em>args</em> <strong><code>)</code></strong> <em>body</em> <strong><code>end</code></strong>


<p>The following example shows a simple function called "foo" that receives a single argument and returns twice its value:</p>

<div class="lspeditor" extype="lua" example="4.1"></div>

<details open>
  <summary>Functions are values</summary>
  <p>The above syntax is actually just a convenience for the following equivalent syntax:</p>
  <em>function_name</em> <strong><code>= function(</code></strong> <em>args</em> <strong><code>)</code></strong> <em>body</em> <strong><code>end</code></strong>
  <p>Thus, the above function can just as equally be written:</p>
  <div class="lspeditor" extype="lua" example="4.2"></div>
  <p>This alternate syntax shows most clearly the real nature of
  functions in Lua. <code>function(<samp>n</samp>) return <samp>n*2</samp> end</code> itself is an expression
  that evaluates at runtime to a value (here, a function). This alone
  creates a function. The left-hand side of the statement then assigns
  the function to the variable foo. However, before the function is
  assigned to foo, the function has no name. It is an anonymous though
  still usable function, but when it is assigned to the variable foo, the function gains the name foo and can be called using that name.</p>
  <p>As such, it is not necessary to name a function to use it. The following example creates a function anonymously and immediately calls it in an expression:</p>
  <div class="lspeditor" extype="lua" example="4.3"></div>
  <p>The important point of all this is that <b>functions in Lua are values</b> just like string and numbers are values. 
  As values, they can be created during runtime, stored in variables, and passed to and returned from other functions. 
  Since functions in Lua have all the rights and privileges to do all the fun things that other values do, they are said to be first class values.</p>
</details>

<details open>
  <summary>Function values are references</summary>
  <p>When functions in Lua are passed around as values, they are treated
  as reference values just like tables. The reference refers to an
  object with a unique identity and lifetime containing the function
  body (code implementation). Therefore, when a function variable is
  assigned to another, the function code itself is not copied, but
  rather the reference is copied.</p>
  <div class="lspeditor" extype="lua" example="4.4"></div>
</details>

<details open>
  <summary>Functions are dynamically typed</summary>
  <p>Functions, like other values in Lua, are also dynamically typed. This means that we only find out if a value is a function when we check at runtime:</p>
  <div class="lspeditor" extype="lua" example="4.5"></div>
  <p>Note that we could not call the object x above because it is a string, but when we assign the function foo to the variable x, we can call it:</p>
  <div class="lspeditor" extype="lua" example="4.6"></div>
  <p>Functions, i.e. variables, in Lua can be dynamically changed at runtime. Dynamically changing the variable type at runtime is a powerful feature not found in statically typed languages such as C.</p>
  <p>Notice that the type of a function is always simply "function"
  without further qualification, regardless of the number and types of the function's parameters and return values:</p>
  <div class="lspeditor" extype="lua" example="4.7"></div>
  <p>This differs from C in which the type of a function (its prototype) contains argument and return type information that must be explicitly specified before use. In Lua you do not need to declare types for values returned by functions or for arguments passed to functions! This allows Lua to deal with function arguments and return values in a flexible manner. Lua handles multiple arguments, variable argument lists, and multiple return values.</p>
  <p>In particular, we have no problem assigning functions with different argument lists or return values to the variable x since x has no notion of the object assigned to it:</p>
  <div class="lspeditor" extype="lua" example="4.8"></div>
  <p>One must be careful not to name variables the same. A statically typed language, such as C, gives you compile errors when two or more functions are named the same, but this is not the case with a dynamic language such as Lua. Lua also  allows us to easily write very flexible code.</p>
</details>

<details open>
  <summary>Function destruction</summary>
  <p>Since functions are objects, they consume resources (system memory). Eventually they are destroyed. Like other objects, Lua destroys functions after they are no longer reachable:</p>
  <div class="lspeditor" extype="lua" example="4.9"></div>
  <p>Since foo is just a reference to a function body, we can assign other variables to have the same value. We can also delete the reference to foo by assigning the value nil to it. This effectively deletes the foo variable. Once we delete the reference from both foo and bar, the function is unreachable, and Lua will delete it -- i.e. Lua's Garbage Collector collects the unused function.</p>
</details>

<p id="NextBut"><a href="Lua-Scope.lsp">Next Tutorial</a></p>
</div>
<?lsp response:include"footer.shtml" ?>
