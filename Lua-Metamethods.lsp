<?lsp title="Lua Metamethods" response:include".header.lsp" ?>

<h1>Metamethods Tutorial</h1>

<p>This is a brief introduction to the concepts of Lua metamethods. Metamethods are used as a base with object oriented designing in Lua.</p>

<div class="rh">

<details open>
  <summary>Metamethods</summary>
  <p>Lua has a powerful extension mechanism which allows you to overload
  certain operations on Lua objects. Only tables and userdata objects
  can use this functionality. Each overloaded object has a metatable of
  function metamethods associated with it that are called when appropriate, just like operator overloads in C++. Unlike C++, you can modify the metamethods associated with an object at runtime.</p>
  <p>The metatable is a regular Lua table containing a set of
  metamethods that are associated with events in Lua. Events occur when
  Lua executes certain operations like: addition, string concatenation,
  comparisons, etc. Metamethods are regular Lua functions which are
  called when a specific event occurs. The events have names like "add"
  and "concat" (see manual section 2.8) which correspond with metamethod
  names like "__add" and "__concat" -- in other words, to add or concatenate two Lua objects. These are defined as usual in a table in key-value pairs.</p>
</details>

<details open>
  <summary>Metatables</summary>
  <p>We use the function setmetatable() to associate a metatable with an appropriate object.</p>
  <div class="lspeditor" extype="lua" example="11.1"></div>
  <br/><br/>
  <div class="lspeditor" extype="lua" example="11.2"></div>
  <p>In the above example, we create a table called x containing a
  value, 3. We create a metatable containing the event overloads that we would like to attach to the table in mt. We are overloading the "add" event here. Notice how the function receives two arguments because "add" is a binary operation. We attach the metatable mt to the table x, and when we apply the addition operator to x (in a = x+x), we can see that a contains the results of the __add metamethod.</p>
  <p>Notice, however, that "a" is not an instance of our "class". It is just a plain table with no metamethod associated with it.</p>
  <div class="lspeditor" extype="lua" example="11.3"></div>
  <p>However, as long as an object with the appropriate metamethod is part of the event operation, Lua will behave properly. It does not matter which side of the + operator our class is since Lua will resolve this.</p>
  <div class="lspeditor" extype="lua" example="11.4"></div>
  <p>We can retrieve the metatable from an object with metamethods using getmetatable(object):</p>
  <div class="lspeditor" extype="lua" example="11.5"></div>
  <p>Note, we could attach metamethods to the returned "class" in the above example by doing the following:</p>
  <div class="lspeditor" extype="lua" example="11.6"></div>
</details>

<details open>
  <summary>A note on "classes"</summary>
  <p>Without the metatable attached, the table x could be likened to a
  structure (struct) in C. With the ability to overload operations that
  occur on the table, we might say that the table x becomes analogous to
  a class instance in C++. The reason why we are being cautious to call this a class is that we can do things with this "class instance" that we cannot do in C++; e.g. attach more event overloads, change overloads at runtime, or manipulate the contents of the "class" dynamically (e.g. add or remove elements).</p>
</details>

<details open>
  <summary>String class example</summary>
  <p>The following is a very simple string class. We define a constructor class String to return a table containing our string with the metatable attached. We define a couple of functions to concatenate strings together and multiply strings.</p>
  <div class="lspeditor" extype="lua" example="11.7"></div>
  <p>Note that the metamethods are added to the metatable mt after it has been referenced by the String() constructor. The metatable is dynamic and can be altered even after instances of the String have been created. When metamethods are added or altered, it will affect all objects (in this case Strings) with the same metatable instantaneously.</p>
</details>


  <h1>More events</h1>
  <p>The following are notes on other metamethod events that Lua handles:</p>
<details open>
  <summary>__index</summary>
  <p>Two interesting metamethods are __index and __newindex. When we use
  the + operator, Lua automatically associates this with the __add
  event. If the key that we are looking for is not a built in one, we
  can use the __index event to catch look ups. This event is called
  whenever we are looking for a key associated with an object that is not one of the built in ones. For example, what if we want to get the length of a string in the above String class example? We could call the string length function, but what if we wanted to treat the length as a number entry in the String instance? Following on from the previous example:</p>
  <div class="lspeditor" extype="lua" example="11.8"></div>
  <p>We attach an __index event to the String class's metatable. The index metamethod looks for the key "length" and returns the length of the String.</p>
</details>

<details open>
  <summary>__newindex</summary>
  <p>Now suppose that we want to make sure that the "value" member
  remains the only field in the String class. We can do this using the
  __newindex metamethod. This method is called whenever we try to create
  a new key in the table and not look up an existing one:</p>
  <div class="lspeditor" extype="lua" example="11.9"></div>
  <br/><br/>
  <div class="lspeditor" extype="lua" example="11.10"></div>
  <p>Here we just call the Lua error() function to create an error whenever the __newindex event is invoked.</p>
</details>

</div>
<p id="NextBut"><a href="Lua-Bindings.lsp">Next Tutorial</a></p>
<?lsp response:include"footer.shtml" ?>
