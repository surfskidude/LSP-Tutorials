<?lsp title="Lua Functions" response:include".header.lsp" ?>

<h1>Functions Tutorial</h1>

<div class="rh">

<p>A function is a reusable block of code. In Lua, the usual way to define a named function is with the <code>function</code> keyword:</p>

<strong><code>function</code></strong> <em>function_name</em> <strong><code>(</code></strong> <em>args</em> <strong><code>)</code></strong> <em>body</em> <strong><code>end</code></strong>


<p>The following example defines a simple function called <code>foo</code>. It receives one argument and returns twice that value:</p>

<div class="lspeditor" extype="lua" example="4.1"></div>

<details open>
  <summary>Functions are values</summary>
  <p>The above syntax is actually just a convenience for the following equivalent syntax:</p>
  <em>function_name</em> <strong><code>= function(</code></strong> <em>args</em> <strong><code>)</code></strong> <em>body</em> <strong><code>end</code></strong>
  <p>That means the same function can also be written like this:</p>
  <div class="lspeditor" extype="lua" example="4.2"></div>
  <p>This alternate syntax shows what Lua is really doing. <code>function(<samp>n</samp>) return <samp>n*2</samp> end</code> creates a function value at runtime. The assignment then stores that function in the variable <code>foo</code>. Before the assignment, the function has no name; after the assignment, you can call it through <code>foo</code>.</p>
  <p>As such, it is not necessary to name a function to use it. The following example creates a function anonymously and immediately calls it in an expression:</p>
  <div class="lspeditor" extype="lua" example="4.3"></div>
  <p>The important point is that <b>functions in Lua are values</b>, just like strings and numbers are values. They can be created at runtime, stored in variables, passed to other functions, and returned from functions. Values with this flexibility are called first-class values.</p>
</details>

<details open>
  <summary>Function values are references</summary>
  <p>When you pass functions around, Lua treats them as reference values, much like tables. Assigning one function variable to another does not copy the function body; it copies a reference to the same function.</p>
  <div class="lspeditor" extype="lua" example="4.4"></div>
</details>

<details open>
  <summary>Functions are dynamically typed</summary>
  <p>Functions, like other values in Lua, are also dynamically typed. This means that we only find out if a value is a function when we check at runtime:</p>
  <div class="lspeditor" extype="lua" example="4.5"></div>
  <p>Note that we could not call the object x above because it is a string, but when we assign the function foo to the variable x, we can call it:</p>
  <div class="lspeditor" extype="lua" example="4.6"></div>
  <p>Variables in Lua can hold different kinds of values over time. A variable that once held a string can later hold a function. This runtime flexibility is one of the main differences between Lua and statically typed languages such as C.</p>
  <p>Notice that the type of a function is always simply "function"
  without further qualification, regardless of the number and types of the function's parameters and return values:</p>
  <div class="lspeditor" extype="lua" example="4.7"></div>
  <p>This differs from C, where a function prototype declares argument and return types before use. In Lua, you do not declare the types of arguments or return values. This lets Lua handle multiple arguments, variable argument lists, and multiple return values with very little ceremony.</p>
  <p>For example, we can assign functions with different argument lists or return values to the same variable <code>x</code>. The variable does not enforce a fixed function shape:</p>
  <div class="lspeditor" extype="lua" example="4.8"></div>
  <p>This flexibility also means you must be careful with names. If you assign a new value to an existing variable, Lua accepts it. A statically typed language such as C may catch some naming mistakes at compile time, but Lua keeps the rules lightweight so you can write flexible code.</p>
</details>

<details open>
  <summary>Function destruction</summary>
  <p>Since functions are objects, they consume resources (system memory). Eventually they are destroyed. Like other objects, Lua destroys functions after they are no longer reachable:</p>
  <div class="lspeditor" extype="lua" example="4.9"></div>
  <p>Since <code>foo</code> is only a reference to a function, another variable such as <code>bar</code> can refer to the same function. Assigning <code>nil</code> to <code>foo</code> removes that reference. When no references remain, the function becomes unreachable and Lua's garbage collector can reclaim it.</p>
</details>

<p id="NextBut"><a href="Lua-Scope.lsp">Next Tutorial</a></p>
</div>
<?lsp response:include"footer.shtml" ?>
