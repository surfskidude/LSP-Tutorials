<?lsp title="LSP: Navigation Menu" response:include".header.lsp" ?>
<h1>Navigation Menu</h1>
<div class="rh">



<p>Most websites, including this one, rely on a navigation menu to guide users through sections efficiently. This tutorial uses a left-hand navigation menu to help you move between sections.</p>

<p>There are many ways to create a navigation menu. This page focuses on the approach used by this tutorial: server-side HTML assembly with Lua Server Pages (LSP).</p>

<p>With LSP, you can assemble HTML from shared files and generated content. A simple way to create a navigation menu is to use the server method <a target="_blank" href="https://realtimelogic.com/ba/doc/en/lua/lua.html#response_include">response:include()</a>. As illustrated below, each page in this tutorial includes two shared components: a header and a footer. The header renders the left-pane navigation menu.</p>

<div class="center"><img  style="max-width:600px" title="server-include-menu" alt="server-include-menu" src="images/server-include-menu.svg" /></div>


<p>To explore this in more depth, unpack the tutorial content from <code>intro.zip</code>. The links below also let you view the source code for this page, the header, and the footer directly.</p>

<ul>
  <li><a href="../showsource/?path=/Dynamic-Navigation-Menu.lsp">This page</a></li>
  <li><a href="../showsource/?path=/.header.lsp">.header.lsp</a></li>
  <li><a href="../showsource/?path=/footer.shtml">footer.shtml</a></li>
</ul>


<h2>More Details</h2>

<p>The <a href="https://makoserver.net/articles/Dynamic-Navigation-Menu" target="_blank">Dynamic Navigation Menu Tutorial</a> provides a detailed guide on using server-side includes to assemble content dynamically for each page.</p>

<p><code>response:include()</code> is quick and easy, but it may not be the best structure for a larger server-rendered application. One drawback is that every page needs Lua code at the top and bottom to include the header and footer.</p>

<h2>Professional Solution</h2>

<p>For a larger application, consider a structure based on the Model-View-Controller (MVC) design pattern. The tutorial <a target="_blank" href="https://makoserver.net/articles/How-to-Build-an-Interactive-Dashboard-App">How to Build an Interactive Dashboard App</a> includes a guide and ready-to-use template code.</p>

</div>
<p id="NextBut"><a href="BAS-API-Tutorial.lsp">Next Tutorial</a></p>
<?lsp response:include"footer.shtml" ?>
