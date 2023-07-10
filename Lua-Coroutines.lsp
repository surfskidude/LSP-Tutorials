<?lsp title="Lua Coroutines" response:include".header.lsp" ?>
<h1>Coroutines Tutorial</h1>
<div class="rh">

<p>Coroutines are types of threads enabling us to execute several tasks at once. This is done in a controlled manner by passing control to each routine and waiting until the routine says it has finished. We can reenter the routine to continue at a later time, and by doing this repeatedly, we achieve cooperative multitasking.</p>

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
  <p>In other systems, a thread is concerned with how long it is
  taking. The thread knows it must pass control to other threads so that
  they can function as well -- this is called cooperative or
  collaborative multi-threading. Here, all of the threads are
  collaborating together to allow the application to operate
  properly. Lua's coroutines are of the cooperative type that must yield
  when they are done with their work.</p>
  <p>Coroutines in Lua are not operating system threads or processes. 
  Coroutines are blocks of Lua code which are created within Lua and have their own flow of control like threads. 
  Only one coroutine runs at a time, and it runs until it activates another coroutine or yields (returns to the coroutine that invoked it). 
  Coroutines are a way to express multiple cooperating threads of control in a convenient and natural way, 
  but do not execute in parallel, and thus gain no performance benefit from multiple CPU's.
     However, since coroutines switch much faster than operating system threads and do not typically require 
      complex and sometimes expensive locking mechanisms, using coroutines is typically faster than the equivalent program using full OS threads.</p>
</details>

<details open>
  <summary>Yielding</summary>
  <p>In order for multiple coroutines to share execution they must stop executing (after performing a sensible amount of processing) 
  and pass control to another <code>ba.thread</code>. 
  This act of submission is called yielding. Coroutines explicitly call a Lua function <code>coroutine.yield()</code>, 
    which is similar to using return in functions. What differentiates yielding from function returns is that at a 
      later point we can reenter the thread and carry on where we left off. When you exit a function 
        scope using return, the scope is destroyed and we cannot reenter it.</p>
  <div class="lspeditor" extype="lua" example="10.1"></div>
</details>

<details open>
  <summary>Simple usage</summary>
  <p>To create a coroutine we must have a function which represents it.</p>
  <div class="lspeditor" extype="lua" example="10.2"></div>
  <p>We create a coroutine using the <code>coroutine.create(fn)</code> function. We pass it an entry point for the thread which is a Lua function. 
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
  <p>Once a coroutine exits or returns like a function, it cannot be resumed.</p>
</details>

<details open>
  <summary>More details</summary>
  <p>The following is a more complex example demonstrating some important features of coroutines:</p>
  <div class="lspeditor" extype="lua" example="10.9"></div>
  <p>Basically, we have a for loop which calls two functions: <code>odd()</code> when it encounters an odd number and <code>even()</code> on even numbers. 
  The output may be a little difficult to understand, so we will study the outer loops one at a time. Comments have been added.</p>
  <pre class="cmd-output">
  ----    1
  A: odd  1       -- yield from odd()
  E: ok, value, status     true    1       suspended
  </pre>
  <p>In loop 1, we call our coroutine using coroutine.resume(co, 5). The
  first time it is called, we enter the for loop in the coroutine
  function. Note that the function <code>odd()</code>, which is called by our
  coroutine function, yields. You do not have to yield in the coroutine
  function; this is an important and useful feature. We return value of 1 with the yield.</p>
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
  <p>Event driven systems typically become complicated since a logically blocking sequence must be written in a state-machine style. 
  A coroutine has its own stack and can yield at any location in the program. Event driven systems can, therefore, be greatly 
  simplified when used in combination with coroutines.</p>
  <p>The following example shows how a <a target="_blank" href="/ba/doc/?url=lua.html#ba_timer">timer</a> can be run in coroutine mode when run as an interval timer:</p>
  <div class="lspeditor" extype="lua" example="10.10"></div>
  <p>Click the above Run method. The following examples require that you have a timer instance. Please note that the timer events are printed to 
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
  <p>Removing the reference, the anchoring point, will eventually make the garbage collector remove an active interval timer. 
  The timer should still print data in the server's console window since the garbage collector has so far not collected the timer object.</p>
  <div class="lspeditor" extype="lua" example="10.16"></div>
  <p>Performing a full sweep should collect the timer object and the printouts in server's console window should stop.</p>
  <div class="lspeditor" extype="lua" example="10.17"></div>
</details>

<details open>
  <summary>Timer Coroutine in an LSP page</summary>
  <p>In the above examples, we used the server's console window when printing from the timer thread. 
  We cannot use the print function in the LSP page since the LSP page's ephemeral request/response environment, 
  which we covered in the <a href="Lua-Scope.lsp#server">scope tutorial</a>, has expired when the timer runs.</p>
  <div class="lspeditor" example="10.18"></div>
  <p>Click the above Run button and watch the printouts in the server's console window. 
  Notice that you get a Lua exception when line 9 executes. 
  You get the exception since you are using the print method in the LSP page's request/response environment. 
  This ephemeral environment only exists as long as the LSP page is active and is long gone when the "<code>timeout</code>" timer function ends. 
    Try adding "<samp>_G</samp>" in front of the print function on line 9 to force the use of the global print function, which prints 
    to the server's console window and not to the response object. Click the Run button when you have fixed the code and watch the printouts 
    in the console window. You should no longer get an exception.</p>
  <h4>Using the '<code>app</code>' environment</h4>
  <p>Click the Revert button and re-run the example to make sure you get the original exception. Click on line 4 in the above editor and press enter so you push line 4 down to line 5. Add the following code on line 4:</p>
  <pre class="code">
  _ENV = app
  </pre>
  <p>Run the example and notice that you do not get an exception. The reason is that the timer function's environment is now set to the Lua application's environment. You can also test the script by setting the environment to the global _G environment.</p>
  <a name="MarkovChain"></a>
  <h4>Markov Chain Algorithm</h4>
  <p>The original Lua 5.0 book includes a Markov Chain Algorithm example in <a target="_blank" href="https://www.lua.org/pil/10.2.html">chapter 10.2</a>. The following example uses the same algorithm, but the "allwords" function is redesigned. Instead of reading from the command line, the "allwords" function uses the <a target="_blank" href="/ba/doc/?url=auxlua.html#httplib">HTTP client library</a> to fetch a web page. The web page is saved and an iterator function that utilizes coroutines is returned to the Markov Chain Algorithm.</p>
  <div class="lspeditor" extype="lua" example="10.19"></div>
</details>


<details open>
  <summary>Cosockets</summary>

<p>Lua CoSockets, an integral feature of the Barracuda App Server, utilize coroutines and seamlessly integrate with UDP and TCP sockets to implement non-blocking I/O operations, typically used for concurrent network programming. By abstracting away complex aspects of network programming, CoSockets make designing scalable network applications significantly more manageable. CoSockets are specifically designed to be used with the Barracuda App Server's integrated socket engine, enabling the development of high-performance, scalable network applications with relative ease. Please refer to the detailed <a target="_blank" href="https://realtimelogic.com/ba/doc/?url=SockLib.html#cosocket">CoSockets documentation</a> for an in-depth understanding and usage examples.</p>

</details>

</div>
<p id="NextBut"><a href="Lua-Metamethods.lsp">Next Tutorial</a></p>
<p><br/><br/><br/><br/></p>
<?lsp response:include"footer.shtml" ?>
