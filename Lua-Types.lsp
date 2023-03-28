<?lsp title="Lua Types" response:include".header.lsp"
 ?>


<p><a target="_blank" href="https://realtimelogic.com/products/lua-server-pages/">LSP is the Lua engine</a> included in the Barracuda App Server. To fully understand and make use of LSP, it's important to first have a good understanding of the Lua programming language. The tutorials provided here, starting with the 'Lua types' tutorial, will introduce you to the basics of Lua.</p>

<p>Please note that some examples may depend on declarations defined in previous examples, and may not work properly if not executed in the proper order. It is recommended to follow the tutorials in the order they are presented to ensure a smooth learning experience.</p>

<div class="rh">
  <div class="article-spacer">
  <iframe style="float:right" width="560" height="315" src="https://www.youtube-nocookie.com/embed/jUuqBZwwkQw" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    <h1>Lua Types Tutorial</h1>
    <p>This is a brief introduction to the eight basic types of values in Lua: number, string, boolean, table, function, nil, userdata, and thread. Each section introduces a different type. </p>
    <p>We use function <a  target="_blank" href="https://realtimelogic.com/ba/doc/?url=lua.html#_G_print">print()</a> to print out values or calculations on those values and function <a  target="_blank" href="https://realtimelogic.com/ba/doc/en/lua/man/manual.html#pdf-type">type()</a> to fetch the variable type.</p>
<div style="clear:both"></div>
    <div class="lspeditor" extype="lua" example="2.1"></div>
  </div>

  <details open>
    <summary>Numbers</summary>
    <p>Lua allows simple arithmetic on numbers using the usual operators to add, subtract, multiply, and divide. Lua supports integer and floating point numbers. Lua can also be compiled with integer only support.</p>
    <div class="lspeditor" extype="lua" example="2.2"></div>
    <p>We can assign values to variables using the = operator. </p>
    <div class="lspeditor" extype="lua" example="2.3"></div>
    <p>The variable x is created when the number 7 is assigned to it. We use the print() function again to print out the value of x. We can now use the value in x for other calculations. </p>
    <div class="lspeditor" extype="lua" example="2.4"></div>
    <p>Notice how print(x*2) does not change the value of x because it was not assigned using the =, but x = x * 9 multiplies the current value of x by 9 and stores the new value in x again.</p>
<p>Notice how x increases each time you click the Run button.</p>
  </details>

  <details open>
    <summary>Strings</summary>
    <p>We can assign strings to variables just like we can numbers: </p>
    <div class="lspeditor" extype="lua" example="2.5"></div>
    <p>We can concatenate (join together) strings using the .. operator between two strings. </p>
    <div class="lspeditor" extype="lua" example="2.6"></div>
    <p>Notice that the .. operator does not change the value of message unless the = assignment operator is used just like numbers. </p>
    <div class="lspeditor" extype="lua" example="2.7"></div>
    <p>Unlike some other languages, you cannot use the + operator to concatenate strings. The following code produces an error message: </p>
    <div class="lspeditor" extype="lua" example="2.8"></div>
  </details>

  <details open>
    <summary>Boolean</summary>
    <p>Boolean values have either the value true or false. If a value is not true, it must be false and vice versa. The not operator can be placed before a boolean value to invert it; i.e. not true is equal to false.</p>
    <div class="lspeditor" extype="lua" example="2.9"></div>
    <p>Boolean values are used to represent the results of logic tests. The equals == and not equals ~= operators will return boolean values depending on the values supplied to them. </p>
    <div class="lspeditor" extype="lua" example="2.10"></div>
  </details>

  <details open>
    <summary>Tables</summary>
    <p>Lua has a general-purpose aggregate datatype called a table. Aggregate data types are used for storing collections (such as lists, sets, arrays, and associative arrays) containing other objects (including numbers, strings, or even other aggregates). Lua is a unique language in that tables are used for representing most all other aggregate types.</p>
    <p>Tables are created using a pair of curly brackets {} . Let's create an empty table:</p>
    <div class="lspeditor" extype="lua" example="2.11"></div>
    <p>Notice how the print function prints the address of the table.</p>
    <p>We can construct tables containing other objects such as the numbers and strings described above:</p>
    <div class="lspeditor" extype="lua" example="2.12"></div>
    <p>We can print the values out using the notation: table.item. We can also put tables inside other tables. </p>
    <div class="lspeditor" extype="lua" example="2.13"></div>
  </details>

  <details open>
    <summary>Functions</summary>
    <p>In Lua, functions are assigned to variables just like numbers and strings. Functions are created using the function keyword. Here we create a simple function which will print a friendly message.</p>
    <div class="lspeditor" extype="lua" example="2.14"></div>
    <p>Since a function is a value just like any other, we should be able to assign functions to variables just like the other values, and we can:</p>
    <div class="lspeditor" extype="lua" example="2.15"></div>
  </details>

  <details open>
    <summary>nil values</summary>
    <p>nil is a special value which indicates no value. If a variable has
    the value nil, then it has no value assigned to it and will therefore no longer exist (or doesn't exist yet). By setting a variable to nil, you can delete a variable.</p>
    <div class="lspeditor" extype="lua" example="2.16"></div>
    <p>You can test to see if a variable exists by checking whether its value is nil. </p>
    <div class="lspeditor" extype="lua" example="2.17"></div>
  </details>

  <details open>
    <summary>Userdata</summary>
    <p>Userdata values are objects foreign to Lua such as objects implemented in C. These typically come about when an object in a C library is exposed to Lua. An example of a userdata value is a file handle. A userdata often behaves like a table, and you can largely ignore the difference unless you are implementing one. Userdata is a more advanced topic discussed further in the Lua Reference Manual.</p>
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
