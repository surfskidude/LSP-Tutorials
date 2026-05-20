<?lsp title="Lua Types" response:include".header.lsp"
 ?>

<h1>Lua</h1>
<p>Lua is often faster to develop with than traditional C code, especially for embedded applications that need business logic, device management, or web interfaces. Lua gives you dynamic typing, automatic memory management, and a compact syntax, so you can focus more on application behavior and less on low-level plumbing. C is still the right choice for direct hardware access and the most performance-critical code. If you're a C programmer, see <a target="_blank" href="https://realtimelogic.com/articles/Using-Lua-for-Embedded-Development-vs-Traditional-C-Code">Why Smart C Coders Use Both C and Lua in Their Projects</a>.</p>

<div class="youtube-video">
  <iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/jUuqBZwwkQw" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

<h2>Follow the Tutorial Order:</h2>

<p>Some examples rely on variables or functions introduced earlier. For the smoothest learning path, follow the tutorials in the order shown in the menu.</p>

<div class="rh">
  <div class="article-spacer">

    <h2>Lua Types Tutorial</h2>
    <p>This page introduces Lua's eight basic value types: number, string, boolean, table, function, nil, userdata, and thread. Each section shows one type with a small runnable example.</p>
    <p>We use <a target="_blank" href="https://realtimelogic.com/ba/doc/?url=lua.html#_G_print"><samp>print()</samp></a> to display values and calculations. We use <a  target="_blank" href="https://realtimelogic.com/ba/doc/en/lua/man/manual.html#pdf-type"><samp>type()</samp></a> to ask Lua what type a value has.</p>
<div style="clear:both"></div>
    <div class="lspeditor" extype="lua" example="2.1"></div>
  </div>

  <details open>
    <summary>Numbers</summary>
    <p>Lua supports simple arithmetic with the usual operators for addition, subtraction, multiplication, and division. Lua can use both integer and floating-point numbers, and it can also be compiled in integer-only mode for some embedded targets.</p>
    <div class="lspeditor" extype="lua" example="2.2"></div>
    <p>We can assign values to variables using the <samp>=</samp> operator. </p>
    <div class="lspeditor" extype="lua" example="2.3"></div>
    <p>The variable <code>x</code> is created when the number <samp>7</samp> is assigned to it. We use the <code>print()</code> function again to print out the value of <samp>x</samp>. We can now use the value in <samp>x</samp> for other calculations. </p>
    <div class="lspeditor" extype="lua" example="2.4"></div>
    <p>Notice that <code>print(x*2)</code> does not change <code>x</code>; it only prints a calculation. The assignment <samp>x = x * 9</samp> stores a new value back into <code>x</code>.</p>
<p>Click Run more than once and notice how <code>x</code> increases each time.</p>
  </details>

  <details open>
    <summary>Strings</summary>
    <p>We can assign strings to variables just like we assign numbers:</p>
    <div class="lspeditor" extype="lua" example="2.5"></div>
    <p>We can concatenate (join together) strings using the <code>..</code> operator between two strings. </p>
    <div class="lspeditor" extype="lua" example="2.6"></div>
    <p>Notice that the <code>..</code> operator does not change <code>message</code> unless you also use the <code>=</code> assignment operator. This is the same idea you saw with numbers.</p>
    <div class="lspeditor" extype="lua" example="2.7"></div>
    <p>Unlike some other languages, you cannot use the <code>+</code> operator to concatenate strings. The following code produces an error message: </p>
    <div class="lspeditor" extype="lua" example="2.8"></div>
  </details>

  <details open>
    <summary>Boolean</summary>
    <p>Boolean values are either <code>true</code> or <code>false</code>. The <code>not</code> operator reverses a boolean value; for example, <code>not true</code> evaluates to <code>false</code>.</p>
    <div class="lspeditor" extype="lua" example="2.9"></div>
    <p>Boolean values are used to represent the results of logic tests. The equals <samp>==</samp> and not equals <samp>~=</samp> operators will return boolean values depending on the values supplied to them. </p>
    <div class="lspeditor" extype="lua" example="2.10"></div>
  </details>

  <details open>
    <summary>Tables</summary>
    <p>Lua's main data structure is the table. Tables can act as lists, arrays, maps, records, sets, and nested structures. A table can contain numbers, strings, functions, other tables, and more.</p>
    <p>Tables are created with curly brackets <samp>{}</samp>. Let's create an empty table:</p>
    <div class="lspeditor" extype="lua" example="2.11"></div>
    <p>Notice how the print function prints the address of the table.</p>
    <p>We can construct tables containing other objects such as the numbers and strings described above:</p>
    <div class="lspeditor" extype="lua" example="2.12"></div>
    <p>We can read table fields with dot notation, such as <code>table.item</code>. We can also put tables inside other tables.</p>
    <div class="lspeditor" extype="lua" example="2.13"></div>
  </details>

  <details open>
    <summary>Functions</summary>
    <p>In Lua, functions are values. You can assign them to variables just like numbers and strings. Functions are created with the <samp>function</samp> keyword. Here we create a simple function that prints a friendly message.</p>
    <div class="lspeditor" extype="lua" example="2.14"></div>
    <p>Since a <samp>function</samp> is a value just like any other, we should be able to assign functions to variables just like the other values, and we can:</p>
    <div class="lspeditor" extype="lua" example="2.15"></div>
  </details>

  <details open>
    <summary>nil values</summary>
    <p><samp>nil</samp> is a special value that means "no value". If a variable has the value <samp>nil</samp>, Lua treats it as not set. Assigning <samp>nil</samp> to a variable is how you remove that variable's value.</p>
    <div class="lspeditor" extype="lua" example="2.16"></div>
    <p>You can test to see if a variable exists by checking whether its value is nil. </p>
    <div class="lspeditor" extype="lua" example="2.17"></div>
  </details>

  <details open>
    <summary>Userdata</summary>
    <p>Userdata values are objects created outside Lua, often in C, and exposed to Lua through a library. A common example is a file handle. Userdata is an advanced topic; when you use it, you usually call methods on it rather than inspect its internal structure. See the <a target="_blank" href="https://realtimelogic.com/ba/doc/luaref_index.html">Lua Reference Manual</a> for details.</p>
    <div class="lspeditor" extype="lua" example="2.18"></div>
  </details>

  <details open>
    <summary>Thread</summary>
    <p>A thread value represents an independent (cooperative) thread of execution. These are discussed further in <a href="Lua-Coroutines.lsp">Coroutines Tutorial</a>.</p>
  </details>

  <details open>
    <summary>Dynamic typing</summary>
    <p>You might have noticed that while we created the above variables, we did not have to specify which type of variable we were creating.</p>
    <div class="lspeditor" extype="lua" example="2.19"></div>
    <p>In other languages such as C, we have to specify the type of a variable when we create it. In Lua, we can also assign different types of values to the same variable. </p>
    <div class="lspeditor" extype="lua" example="2.20"></div>
    <p>This is called dynamic typing. You do not declare a variable's type ahead of time; Lua determines the type from the value currently assigned to the variable.</p>
  </details>

  <!-- <div class="article-spacer"> OG MARKUP
    <summary>Querying type</summary>
    <p>Lua can inspect values at runtime. Use <code>type()</code> when you want to see the type of a particular value.</p>
    <div class="lspeditor" extype="lua" example="2.21"></div>
  </div> -->

  <details open>
    <summary>Querying type</summary>
    <p>As Lua is a reflective language, we can use the Lua function type() to get a description of the type of a particular object.</p>
    <div class="lspeditor" extype="lua" example="2.21"></div>
  </details>

<p id="NextBut"><a href="Lua-Control.lsp">Next Tutorial</a></p>
</div>
<?lsp response:include"footer.shtml" ?>
