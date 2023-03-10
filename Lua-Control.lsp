<?lsp title="Lua Control" response:include".header.lsp" ?>
<div class="rh">
<h1>Control Structure Tutorial</h1>


<p>Lua control structures will be familiar to programmers. Sections 2.4.4 and 2.4.5 of the Reference Manual provide the necessary information.</p>

<details open>
  <summary>while</summary>
  <p>The conditional looping statement "while" has the form: </p>
  <strong><code>while</code></strong> <em>exp</em> <strong><code>do</code></strong> <em>block</em> <strong><code>end</code></strong>
  <p>A simple loop:</p>
  <div class="lspeditor" extype="lua" example="3.1"></div>
  <p>We can exit the control of a while statement using the break
  keyword as in the following example.</p>
  <div class="lspeditor" extype="lua" example="3.2"></div>
</details>

<details open>
  <summary>repeat</summary>
  <p>The conditional looping statement "repeat" has the form:</p>
  <strong><code>repeat</code></strong> <em>block</em> <strong><code>until</code></strong> <em>exp</em>
  <p>A simple loop:</p>
  <div class="lspeditor" extype="lua" example="3.3"></div>
  <p>Like the while statement, we can exit a repeat loop using a break statement:</p>
  <div class="lspeditor" extype="lua" example="3.4"></div>
  <p>cows_come_home is a variable which is not defined. When we access it we get the value nil, so this code means "until false" or forever.</p>
</details>

<details open>
  <summary>for</summary>
  <p>The iterating statement "for" has two forms. The first is "for" numerical iteration:</p>
  <div class="lspeditor" extype="lua" example="3.5"></div>
  <p>The second is for sequential iteration, e.g. to print the contents of a table. In the example below, 'for' is passed the 'pairs()' iterator function, whose purpose is to supply the values of each iteration:</p>
  <div class="lspeditor" extype="lua" example="3.6"></div>
</details>

<details open>
  <summary>if ... then ... else ... end</summary>
  <p>The statement "if" has the form:</p>
  <strong><code>if</code></strong> <em>exp</em> <strong><code>then</code></strong> <em>block</em> <em>{</em> <strong><code>elseif</code></strong> <em>exp</em> <strong><code>then</code></strong> <em>block } [</em> <strong><code>else</code></strong> <em>block ]</em> <strong><code>end</code></strong>
  <p>For example, if ... then ... end</p>
  <div class="lspeditor" extype="lua" example="3.7"></div>
  <p>if ... then ... else ... end</p>
  <div class="lspeditor" extype="lua" example="3.8"></div>
  <p>if ... then ... elseif ... else ... end</p>
  <div class="lspeditor" extype="lua" example="3.9"></div>
</details>

<p id="NextBut"><a href="Lua-Functions.lsp">Next Tutorial</a></p>

</div>
<?lsp response:include"footer.shtml" ?>
