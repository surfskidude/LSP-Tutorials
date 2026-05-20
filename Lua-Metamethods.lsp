<?lsp title="Lua Metamethods" response:include".header.lsp" ?>

<h1>Metamethods Tutorial</h1>

<p>This page introduces Lua metamethods. Metamethods let tables and userdata customize how they behave with operators, field lookup, and other Lua operations. They are also one of the building blocks used for object-oriented designs in Lua.</p>

<div class="rh">

<details open>
  <summary>Metamethods</summary>
  <p>Lua has a powerful extension mechanism that allows you to overload
  certain operations on Lua objects. Only tables and userdata objects
  can use this functionality. Each overloaded object has a metatable of
  function metamethods associated with it that are called when appropriate, just like operator overloads in C++.
  Unlike C++, you can modify the metamethods associated with an object at runtime.</p>
  <p>The metatable is a regular Lua table containing a set of
  metamethods that are associated with events in Lua. Events occur when
  Lua executes certain operations like: addition, string concatenation,
  comparisons, etc. Metamethods are regular Lua functions which are
  called when a specific event occurs. The events have names like "<code>add</code>"
  and "<code>concat</code>" (see manual section 2.8) which correspond with metamethod
  names like "<code>__add</code>" and "<code>__concat</code>" -- in other words, to add or concatenate two Lua objects.
  These are defined as usual in a table in key-value pairs.</p>
</details>

<details open>
  <summary>Metatables</summary>
  <p>Use <code>setmetatable()</code> to attach a metatable to a table.</p>
  <div class="lspeditor" extype="lua" example="11.1"></div>
  <br/><br/>
  <div class="lspeditor" extype="lua" example="11.2"></div>
  <p>In the example above, we create a table called <samp>x</samp> containing the
  value 3. We also create a metatable, <samp>mt</samp>, that contains the event overloads we want to attach to <samp>x</samp>.
  We are overloading the "<code>add</code>" event here. Notice how the function receives two arguments because "<code>add</code>" is a binary operation.
    We attach the metatable mt to the table <samp>x</samp>, and when we apply the addition operator to <samp>x</samp> (in <code>a = x+x</code>),
    we can see that a contains the results of the <code>__add metamethod</code>.</p>
  <p>Notice, however, that "<samp>a</samp>" is not an instance of our "<code>class</code>". It is just a plain table with no metamethod associated with it.</p>
  <div class="lspeditor" extype="lua" example="11.3"></div>
  <p>However, as long as one object in the operation has the right metamethod, Lua can use it. It does not matter which side of the <code>+</code> operator our object is on; Lua will still resolve the operation.</p>
  <div class="lspeditor" extype="lua" example="11.4"></div>
  <p>We can retrieve the metatable from an object with metamethods using <code>getmetatable(object)</code>:</p>
  <div class="lspeditor" extype="lua" example="11.5"></div>
  <p>Note, we could attach metamethods to the returned "<code>class</code>" in the above example by doing the following:</p>
  <div class="lspeditor" extype="lua" example="11.6"></div>
</details>

<details open>
  <summary>A note on "<code>classes</code>"</summary>
  <p>Without a metatable, the table <samp>x</samp> is similar to a
  structure (struct) in C. With overloaded operations attached through a metatable, <samp>x</samp> starts to behave more like
  a class instance in C++. We use that comparison carefully because Lua tables remain dynamic in ways C++ objects usually are not;
    e.g. attach more event overloads, change overloads at runtime,
    or manipulate the contents of the "<code>class</code>" dynamically (e.g. add or remove elements).</p>
</details>

<details open>
  <summary>String class example</summary>
  <p>The following example builds a very small string-like object. The constructor function <code>String</code> returns a table containing a string value with the metatable attached. The metatable defines operations for concatenating strings and repeating strings.</p>
  <div class="lspeditor" extype="lua" example="11.7"></div>
  <p>Note that the metamethods are added to the metatable <code>mt</code> after it has already been referenced by the <code>String()</code> constructor.
  The metatable is dynamic and can be altered even after instances of the <code>String</code> have been created.
  When metamethods are added or altered, it will affect all objects (in this case <code>Strings</code>) with the same metatable instantaneously.</p>
</details>


  <h1>More events</h1>
  <p>The following sections introduce two more metamethod events that Lua handles:</p>
<details open>
  <summary><samp>__index</samp></summary>
  <p>Two interesting metamethods are <samp>__index</samp> and <samp>__newindex</samp>. When we use
  the + operator, Lua automatically associates this with the <samp>__add</samp>
  event. If the key that we are looking for is not a built in one, we
  can use the <samp>__index</samp> event to catch lookups. This event is called
  whenever Lua looks for a key that is not already present in the table.
   For example, what if we want to get the length of a string in the above <code>String</code> class example?
   We could call the string length function, but what if we wanted to treat the length as a number entry in the <code>String</code> instance?
    Following on from the previous example:</p>
  <div class="lspeditor" extype="lua" example="11.8"></div>
  <p>We attach an <samp>__index</samp> event to the <code>String</code> class's metatable.
  The index metamethod looks for the key "<code>length</code>" and returns the length of the <code>String</code>.</p>
</details>

<details open>
  <summary><samp>__newindex</samp></summary>
  <p>Now suppose that we want to make sure that the "<code>value</code>" member
  remains the only field in the <code>String</code> class. We can do this using the
  <samp>__newindex</samp> metamethod. This method is called whenever we try to create
  a new key in the table, rather than update an existing one:</p>
  <div class="lspeditor" extype="lua" example="11.9"></div>
  <br/><br/>
  <div class="lspeditor" extype="lua" example="11.10"></div>
  <p>Here we just call the Lua <code>error()</code> function to create an error whenever the <samp>__newindex</samp> event is invoked.</p>
</details>

</div>
<p id="NextBut"><a href="Lua-Bindings.lsp">Next Tutorial</a></p>
<?lsp response:include"footer.shtml" ?>
