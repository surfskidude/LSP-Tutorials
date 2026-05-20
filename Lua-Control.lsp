<?lsp title="Lua Control" response:include".header.lsp" ?>
<div class="rh">
<h1>Control Structure Tutorial</h1>


<p>Control structures decide which code runs and how many times it runs. Lua's control structures will look familiar if you have used languages such as C, JavaScript, or Python. For full details, see Sections 2.4.4 and 2.4.5 of the <a target="_blank" href="https://realtimelogic.com/ba/doc/luaref_index.html">Lua Reference Manual</a>.</p>


<details open>
  <summary>while</summary>
  <p>The conditional looping statement "<code>while</code>" has the form: </p>
  <p><code>while</code> <em>exp</em> <strong><code>do</code></strong> <em>block</em> <strong><code>end</code></strong></p>
  <p>A simple loop:</p>
  <div class="lspeditor" extype="lua" example="3.1"></div>
  <p>You can leave a <code>while</code> loop early with the <code>break</code> keyword, as shown in the next example.</p>
  <div class="lspeditor" extype="lua" example="3.2"></div>
</details>

<details open>
  <summary>repeat</summary>
  <p>The conditional looping statement "<code>repeat</code>" has the form:</p>
  <strong><code>repeat</code></strong> <em>block</em> <strong><code>until</code></strong> <em>exp</em>
  <p>A simple loop:</p>
  <div class="lspeditor" extype="lua" example="3.3"></div>
  <p>Like the while statement, we can exit a repeat loop using a break statement:</p>
  <div class="lspeditor" extype="lua" example="3.4"></div>
  <p><code>cows_come_home</code> is not defined, so reading it returns <code>nil</code>. In Lua, <code>nil</code> is treated as false in a condition, so this code means "repeat until false", which is an endless loop unless <code>break</code> runs.</p>
</details>

<details open>
  <summary>for</summary>
  <p>The <code>for</code> statement has two forms. The first is numeric iteration, which counts through a range of numbers:</p>
  <div class="lspeditor" extype="lua" example="3.5"></div>
  <p>The second form iterates over values supplied by an iterator function. In the example below, <code>pairs()</code> supplies each key and value from a table:</p>
  <div class="lspeditor" extype="lua" example="3.6"></div>
</details>

<details open>
  <summary>if ... then ... else ... end</summary>
  <p>The statement "<code>if</code>" has the form:</p>
  <strong><code>if</code></strong> <em>exp</em> <strong><code>then</code></strong> <em>block</em> <em>{</em> <strong><code>elseif</code></strong> <em>exp</em> <strong><code>then</code></strong> <em>block } [</em> <strong><code>else</code></strong> <em>block ]</em> <strong><code>end</code></strong>
  <p>For example, <code>if</code> ... <code>then</code> ... <code>end</code>:</p>
  <div class="lspeditor" extype="lua" example="3.7"></div>
  <p><code>if</code> ... <code>then</code> ... <code>else</code> ... <code>end</code>:</p>
  <div class="lspeditor" extype="lua" example="3.8"></div>
  <p><code>if</code> ... <code>then</code> ... <code>elseif</code> ... <code>else</code> ... <code>end</code>:</p>
  <div class="lspeditor" extype="lua" example="3.9"></div>
</details>

<p id="NextBut"><a href="Lua-Functions.lsp">Next Tutorial</a></p>

</div>
<?lsp response:include"footer.shtml" ?>
