<?lsp title="Lua Coroutines" response:include".header.lsp" ?>
<h1>Coroutines Tutorial</h1>
<div class="rh">

<p>Coroutines are Lua routines that can pause and resume. They let several tasks take turns running without using operating system threads. A coroutine runs until it yields control, and later it can continue from the same place. This pattern is called cooperative multitasking.</p>

<details open>
  <summary>Multi-threading</summary>
  <p>Each task runs in a thread that is separate from the other
  threads. Having several tasks running at once is often called
  multi-threading. When there is more than one thread running at a time, an application is said to be multi-threaded.</p>
  <p>There are different ways in which multi-threading can be
  implemented. Some systems allocate a fixed amount of time to each
  thread and take control away when the time is up, passing control on
  to the next thread, etc. -- this is called pre-emptive
  multi-threading. Consequently, each thread need not concern itself
  with the time it occupies.</p>
  <p>In cooperative systems, a running task decides when to give other tasks a chance to run. Each task is expected to yield regularly so the application remains responsive. Lua's coroutines use this cooperative model.</p>
  <p>Coroutines in Lua are not operating system threads or processes.
  They are Lua objects with their own flow of control.
  Only one coroutine runs at a time, and it runs until it activates another coroutine or yields back to the coroutine that invoked it.
  Coroutines are a way to express multiple cooperating threads of control in a convenient and natural way,
  but they do not execute in parallel and therefore do not gain a direct performance benefit from multiple CPUs.
     However, since coroutines switch much faster than operating system threads and do not typically require
      complex and sometimes expensive locking mechanisms, using coroutines is typically faster than the equivalent program using full OS threads.</p>
</details>

<details open>
  <summary>Yielding</summary>
  <p>For multiple coroutines to share execution, each coroutine must stop after a sensible amount of work
  and pass control to another <code>ba.thread</code>.
  This pause is called yielding. A coroutine yields by calling <code>coroutine.yield()</code>. Yielding is similar to <code>return</code>, but with one key difference: later, the coroutine can resume from the same point. When a normal function returns, its scope is finished and you cannot reenter it.</p>
  <div class="lspeditor" extype="lua" example="10.1"></div>
</details>

<details open>
  <summary>Simple usage</summary>
  <p>To create a coroutine, first write the function that the coroutine should run.</p>
  <div class="lspeditor" extype="lua" example="10.2"></div>
  <p>We create a coroutine with <code>coroutine.create(fn)</code>. The function passed to <code>create</code> is the coroutine's entry point.
    The object returned by Lua is a thread:</p>
  <div class="lspeditor" extype="lua" example="10.3"></div>
  <p>We can find out what state the thread is in using the <code>coroutine.status()</code> function.</p>
  <div class="lspeditor" extype="lua" example="10.4"></div>
  <p>The state suspended means that the thread is alive, and as you would expect, not doing anything.
  Note that when we created the thread, it did not start executing.
  To start the thread, we use the <code>coroutine.resume()</code> function. Lua will enter the thread and leave when the thread yields. </p>
  <div class="lspeditor" extype="lua" example="10.5"></div>
  <p>The <code>coroutine.resume()</code> function returns the error status of the
  resume call. The output acknowledges that we entered the function foo
  and then exited with no errors. Normally, with a function we would not be able to carry on where we left off, but with coroutines we can resume: </p>
  <div class="lspeditor" extype="lua" example="10.6"></div>
  <p>We can see we executed the line after the yield in foo and again returned without error.
  However, if we look at the status, we can see that we exited the function foo and the coroutine terminated. </p>
  <div class="lspeditor" extype="lua" example="10.7"></div>
  <p>If we try to resume again, a pair of values is returned: an error flag and an error message: </p>
  <div class="lspeditor" extype="lua" example="10.8"></div>
  <p>Once a coroutine exits or returns like a normal function, it is dead and cannot be resumed.</p>
</details>

<details open>
  <summary>More details</summary>
  <p>The following is a more complex example demonstrating some important features of coroutines:</p>
  <div class="lspeditor" extype="lua" example="10.9"></div>
  <p>The example has a <code>for</code> loop that calls <code>odd()</code> for odd numbers and <code>even()</code> for even numbers. The output can be hard to follow at first, so the next sections walk through the outer loop one pass at a time. Comments have been added.</p>
  <pre class="cmd-output">
  ----    1
  A: odd  1       -- yield from odd()
  E: ok, value, status     true    1       suspended
  </pre>
  <p>In loop 1, we call the coroutine with <code>coroutine.resume(co, 5)</code>. The
  first time it is called, we enter the for loop in the coroutine
  function. Note that the function <code>odd()</code>, which is called by our
  coroutine function, yields. You do not have to yield in the coroutine
  function; this is an important and useful feature. We return the value 1 with the yield.</p>
  <pre class="cmd-output">
  ----    2
  B: odd  1       -- resume in odd with the values we left on the yield
  C: even 2       -- call even and exit prematurely
  E: ok, value, status     true    -1      suspended  -- yield in for loop
  </pre>
  <p>In loop 2, the main for loop yields and suspends the coroutine.
    The point to note here is that we can yield anywhere.
    We do not have to keep yielding from one point in our coroutine. We return -1 with the yield.</p>
  <pre class="cmd-output">
  ----    3
  A: odd  3       -- odd() yields again after resuming in for loop
  E: ok, value, status     true    3       suspended
  </pre>
  <p>We resume the coroutine in the for loop and when <code>odd()</code> is called it yields again.</p>
  <pre class="cmd-output">
  ----    4
  B: odd  3       -- resume in odd(), variable values retained
  C: even 4       -- even called()
  D: even 4       -- no return in even() this time
  A: odd  5       -- odd() called and a yield
  E: ok, value, status     true    5       suspended
  </pre>
  <p>In loop 4, we resume in <code>odd()</code> where we left off. Note that the variable values are preserved.
  The scope of the <code>odd()</code> function is preserved during a coroutine suspend.
    We traverse to the end of <code>even()</code>, this time exiting at the end of the function.
      In either case, when we exit a function without using <code>coroutine.yield()</code>, the scope and all its variables are destroyed.
        Only on a yield can we resume.</p>
  <pre class="cmd-output">
  ----    5
  B: odd  5       -- odd called again
  E: ok, value, status     true    nil     dead  -- for loop terminates
  </pre>
  <p>Once again we resume in <code>odd()</code>. This time the main for loop reaches the limit of 5 we passed into the coroutine.
  The value of 5 and the for loop state were preserved throughout execution of the coroutine.
  A coroutine preserves its own stack and state while in existence. When we exit our coroutine function, it dies, and we can no longer use it.</p>
</details>

<details open>
  <summary>Creating a Timer in Coroutine Mode</summary>
  <p>Event-driven systems can become complicated when a sequence that feels logically blocking must be written as a state machine.
  A coroutine has its own stack and can yield at any location in the program. Event driven systems can, therefore, be greatly
  simplified when combined with coroutines.</p>
  <p>The following example shows how a <a target="_blank" href="/ba/doc/?url=lua.html#ba_timer">timer</a> can be run in coroutine mode when run as an interval timer:</p>
  <div class="lspeditor" extype="lua" example="10.10"></div>
  <p>Click the Run button above. The following examples require a timer instance. The timer events are printed to
  the server's console window so please keep the console window next to your browser window. Alternatively,
  open the <a target="_blank" href="/rtl/tracelogger/">TraceLogger</a> in a separate browser window.</p>
  <p>One can dynamically change the interval time by calling <code>timer:reset</code>.</p>
  <div class="lspeditor" extype="lua" example="10.11"></div>
  <p>Calling <code>timer:set</code> on a running timer has the same effect as calling <code>timer:reset</code>.</p>
  <div class="lspeditor" extype="lua" example="10.12"></div>
  <p>Stopping the timer.</p>
  <div class="lspeditor" extype="lua" example="10.13"></div>
  <p>You cannot reset a cancelled timer.</p>
  <div class="lspeditor" extype="lua" example="10.14"></div>
  <p>You can restart a stopped timer with <code>timer:set</code>.</p>
  <div class="lspeditor" extype="lua" example="10.15"></div>
  <p>Removing the reference, which is the anchoring point, will eventually let the garbage collector remove an active interval timer.
  The timer should still print data in the server's console window since the garbage collector has so far not collected the timer object.</p>
  <div class="lspeditor" extype="lua" example="10.16"></div>
  <p>Performing a full garbage collection sweep should collect the timer object, and the printouts in the server's console window should stop.</p>
  <div class="lspeditor" extype="lua" example="10.17"></div>
</details>

<details open>
  <summary>Timer Coroutine in an LSP page</summary>
  <p>In the examples above, we used the server's console window when printing from the timer thread.
  We cannot use the print function in the LSP page since the LSP page's ephemeral request/response environment,
  which we covered in the <a href="Lua-Scope.lsp#server">scope tutorial</a>, has expired when the timer runs.</p>
  <div class="lspeditor" example="10.18"></div>
  <p>Click the above Run button and watch the printouts in the server's console window.
  Notice that you get a Lua exception when line 9 executes.
  You get the exception since you are using the print method in the LSP page's request/response environment.
  This temporary environment only exists while the LSP page is active and is gone by the time the "<code>timeout</code>" timer function runs.
    Try adding "<samp>_G</samp>" in front of the print function on line 9 to force the use of the global print function, which prints
    to the server's console window and not to the response object. Click the Run button when you have fixed the code and watch the printouts
    in the console window. You should no longer get an exception.</p>
  <h4>Using the '<code>app</code>' environment</h4>
  <p>Click Revert and rerun the example to confirm the original exception. Then click line 4 in the editor above, press Enter to make room, and add the following code on line 4:</p>
  <pre class="code">
  _ENV = app
  </pre>
  <p>Run the example and notice that the exception is gone. The timer function's environment is now the Lua application's environment, which continues to exist after the LSP request has ended. You can also test the script by setting the environment to the global <samp>_G</samp> environment.</p>
  <a name="MarkovChain"></a>
  <h4>Markov Chain Algorithm</h4>
  <p>The original Lua 5.0 book includes a Markov Chain Algorithm example in <a target="_blank" href="https://www.lua.org/pil/10.2.html">chapter 10.2</a>. The following example uses the same algorithm, but the "allwords" function is redesigned. Instead of reading from the command line, the "allwords" function uses the <a target="_blank" href="https://realtimelogic.com/ba/doc/en/lua/auxlua.html#httplib">HTTP client library</a> to fetch a web page. The web page is saved and an iterator function that utilizes coroutines is returned to the Markov Chain Algorithm.</p>
  <div class="lspeditor" extype="lua" example="10.19"></div>
</details>


<details open>
  <summary>Cosockets</summary>

<p>Lua CoSockets are a Barracuda App Server feature built on coroutines. They let Lua code use UDP and TCP sockets in a non-blocking style, which is useful for concurrent network programming. CoSockets hide much of the complexity of event-driven socket code while still using the server's high-performance socket engine. See the <a target="_blank" href="https://realtimelogic.com/ba/doc/?url=SockLib.html#cosocket">CoSockets documentation</a> for deeper examples.</p>

</details>

</div>
<p id="NextBut"><a href="Lua-Metamethods.lsp">Next Tutorial</a></p>
<p><br/><br/><br/><br/></p>
<?lsp response:include"footer.shtml" ?>
