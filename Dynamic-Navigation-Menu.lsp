<?lsp title="LSP: Navigation Menu" response:include".header.lsp" ?>
<h1>Navigation Menu</h1>
<div class="rh">



<p>Most websites, including this one, rely on a navigation menu to guide users through sections efficiently. This tutorial uses a left-hand navigation menu to help you move between sections.</p>

<p>There are many ways to create a navigation menu, but here, we will focus on how the navigation menu in this tutorial works, showcasing one approach to server-side dynamic HTML assembly with Lua Server Pages (LSP).</p>

<p>With LSP, you can dynamically assemble HTML from various sources. A simple approach to create a navigation menu is to use the server method <a target="_blank" href="https://realtimelogic.com/ba/doc/en/lua/lua.html#response_include">response:include()</a>. As illustrated below, each page in this tutorial includes two shared components: a header and a footer. The header is where the left-pane navigation menu is rendered. </p>

<div class="center"><img  style="max-width:600px" title="server-include-menu" alt="server-include-menu" src="images/server-include-menu.svg" /></div>


<p>To explore this in more depth, you can unpack the content of this tutorial found in intro.zip. The links below also let you directly view the source code for this page, the header, and the footer.</p>

<ul>
  <li><a href="../showsource/?path=/Dynamic-Navigation-Menu.lsp">This page</a></li>
  <li><a href="../showsource/?path=/.header.lsp">.header.lsp</a></li>
  <li><a href="../showsource/?path=/footer.shtml">footer.shtml</a></li>
</ul>


<h2>More Details</h2>

<p>The <a href="https://makoserver.net/articles/Dynamic-Navigation-Menu" target="_blank">Dynamic Navigation Menu Tutorial</a> provides a detailed guide on using server-side includes to assemble content dynamically for each page.</p>

<p>While using response:include() is quick and easy, it might not be the most optimal approach for a fully-featured, professional server-rendered application. One drawback is that every page needs Lua code at the top and bottom to include the header and footer.</p>

<h2>Professional Solution</h2>

<p>Consider a solution based on the Model-View-Controller (MVC) design pattern for a more professional setup. Check out the tutorial, <a target="_blank" href="https://makoserver.net/articles/How-to-Build-an-Interactive-Dashboard-App">How to Build an Interactive Dashboard App</a>, for a guide and a ready-to-use template code for your next project.</p>

</div>
<p id="NextBut"><a href="BAS-API-Tutorial.lsp">Next Tutorial</a></p>
<?lsp response:include"footer.shtml" ?>
