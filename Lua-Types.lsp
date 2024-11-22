<?lsp title="Lua Types" response:include".header.lsp"
 ?>

<h1>Lua</h1>
<p>When comparing Lua to traditional C code for embedded development, Lua generally offers a significant advantage in terms of development speed and ease of use due to its higher-level features like dynamic typing, automatic memory management, and a simpler syntax, allowing developers to focus on application logic rather than low-level hardware details, while C remains the preferred choice for situations demanding extreme performance and direct hardware control. If you're a C programmer, check out the tutorial <a target="_blank" href="https://realtimelogic.com/articles/Using-Lua-for-Embedded-Development-vs-Traditional-C-Code">Why Smart C Coders Use Both C and Lua in Their Projects</a>.</p>

<div class="youtube-video">
  <iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/jUuqBZwwkQw" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

<h2>Follow the Tutorial Order:</h2>

<p>Some examples rely on declarations from earlier sections and may not function correctly if executed out of sequence. To ensure a smooth learning experience, it’s recommended to follow the tutorials in the order presented.</p>

<div class="rh">
  <div class="article-spacer">

    <h2>Lua Types Tutorial</h2>
    <p>This is a brief introduction to the eight basic types of values in Lua: number, string, boolean, table, function, nil, userdata, and thread. Each section introduces a different type. </p>
    <p>We use function <a target="_blank" href="https://realtimelogic.com/ba/doc/?url=lua.html#_G_print"><samp>print()</samp></a> to print out values or calculations on those values and function <a  target="_blank" href="https://realtimelogic.com/ba/doc/en/lua/man/manual.html#pdf-type"><samp>type()</samp></a> to fetch the variable type.</p>
<div style="clear:both"></div>
    <div class="lspeditor" extype="lua" example="2.1"></div>
  </div>

  <details open>
    <summary>Numbers</summary>
    <p>Lua allows simple arithmetic on numbers using the usual operators to add, subtract, multiply, and divide. Lua supports integer and floating point numbers. Lua can also be compiled with integer only support.</p>
    <div class="lspeditor" extype="lua" example="2.2"></div>
    <p>We can assign values to variables using the <samp>=</samp> operator. </p>
    <div class="lspeditor" extype="lua" example="2.3"></div>
    <p>The variable <code>x</code> is created when the number <samp>7</samp> is assigned to it. We use the <code>print()</code> function again to print out the value of <samp>x</samp>. We can now use the value in <samp>x</samp> for other calculations. </p>
    <div class="lspeditor" extype="lua" example="2.4"></div>
    <p>Notice how print(x*2) does not change the value of x because it was not assigned using the <samp>=</samp>, but <samp>x = x * 9</samp> multiplies the current value of <samp>x</samp> by 9 and stores the new value in <samp>x</samp> again.</p>
<p>Notice how x increases each time you click the Run button.</p>
  </details>

  <details open>
    <summary>Strings</summary>
    <p>We can assign strings to variables just like we can <code>numbers</code>: </p>
    <div class="lspeditor" extype="lua" example="2.5"></div>
    <p>We can concatenate (join together) strings using the <code>..</code> operator between two strings. </p>
    <div class="lspeditor" extype="lua" example="2.6"></div>
    <p>Notice that the <code>..</code> operator does not change the value of message unless the = assignment operator is used just like numbers. </p>
    <div class="lspeditor" extype="lua" example="2.7"></div>
    <p>Unlike some other languages, you cannot use the <code>+</code> operator to concatenate strings. The following code produces an error message: </p>
    <div class="lspeditor" extype="lua" example="2.8"></div>
  </details>

  <details open>
    <summary>Boolean</summary>
    <p>Boolean values have either the value <code>true</code> or <code>false</code>. If a value is not <code>true</code>, it must be <code>false</code> and vice versa. The not operator can be placed before a boolean value to invert it; i.e. not <code>true</code> is equal to <code>false</code>.</p>
    <div class="lspeditor" extype="lua" example="2.9"></div>
    <p>Boolean values are used to represent the results of logic tests. The equals <samp>==</samp> and not equals <samp>~=</samp> operators will return boolean values depending on the values supplied to them. </p>
    <div class="lspeditor" extype="lua" example="2.10"></div>
  </details>

  <details open>
    <summary>Tables</summary>
    <p>Lua uses a versatile data structure called a table, which can store collections like lists, sets, arrays, and associative arrays. These collections can hold various types of data, including numbers, strings, or even other tables. What makes Lua unique is that tables are used to represent almost all aggregate types, making them a powerful and flexible tool in the language.</p>
    <p>Tables are created using a pair of curly brackets <samp>{}</samp> . Let's create an empty table:</p>
    <div class="lspeditor" extype="lua" example="2.11"></div>
    <p>Notice how the print function prints the address of the table.</p>
    <p>We can construct tables containing other objects such as the numbers and strings described above:</p>
    <div class="lspeditor" extype="lua" example="2.12"></div>
    <p>We can print the values out using the notation: table.item. We can also put tables inside other tables. </p>
    <div class="lspeditor" extype="lua" example="2.13"></div>
  </details>

  <details open>
    <summary>Functions</summary>
    <p>In Lua, functions are assigned to variables just like numbers and strings. Functions are created using the <samp>function</samp> keyword. Here we create a simple function which will print a friendly message.</p>
    <div class="lspeditor" extype="lua" example="2.14"></div>
    <p>Since a <samp>function</samp> is a value just like any other, we should be able to assign functions to variables just like the other values, and we can:</p>
    <div class="lspeditor" extype="lua" example="2.15"></div>
  </details>

  <details open>
    <summary>nil values</summary>
    <p><samp>nil</samp> is a special value which indicates no value. If a variable has
    the value <samp>nil</samp>, then it has no value assigned to it and will therefore no longer exist (or doesn't exist yet). By setting a variable to nil, you can delete a variable.</p>
    <div class="lspeditor" extype="lua" example="2.16"></div>
    <p>You can test to see if a variable exists by checking whether its value is nil. </p>
    <div class="lspeditor" extype="lua" example="2.17"></div>
  </details>

  <details open>
    <summary>Userdata</summary>
    <p>Userdata values are objects external to Lua, often implemented in C and exposed to Lua through a library. A common example of a userdata value is a file handle. Userdata often behaves similarly to a table, and for most purposes, you can treat it as such unless you're implementing one yourself. This is a more advanced topic and is covered in greater detail in the <a target="_blank" href="https://realtimelogic.com/ba/doc/luaref_index.html">Lua Reference Manual</a>.</p>
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
    <p>This is called dynamic typing. This means that you do not have to specify what type a variable is. The variable knows what type it is from the value or object assigned to it.</p>
  </details>

  <!-- <div class="article-spacer"> OG MARKUP
    <summary>Querying type</summary>
    <p>As Lua is a reflective language, we can use the Lua function type() to get a description of the type of a particular object.</p>
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
