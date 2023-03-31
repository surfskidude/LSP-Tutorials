<?lsp title="LSP: Navigation Menu" response:include".header.lsp" ?>

<style type="text/css">
 p.c4 {clear: left}
 div.c3 {width: 200px}
 div.c2 {margin: auto; width: 664px;}
 img.c1 {display: inline}
</style>
<h1>Server Side Generated Navigation Menu</h1>
<div class="rh">

<h5>The following tutorial is a modified version of the Mako Server tutorial <a href="https://makoserver.net/articles/Dynamic-Navigation-Menu" target="_blank">Dynamic Navigation Menu</a>. This version shows how the menu in this tutorial is assembled. Note that the original example includes ready to use example code that can be used as a base for your own design. You can download a <a target="_blank" href="https://makoserver.net/articles/Dynamic-Navigation-Menu#download">ready to run example with included authentication</a>.</h5>

<p>Most web applications include more than one page, and it is common to include a menu either on the top of each page or on one side of each page. More complex web applications may include sub menus that are either drop down menus or sub menus created on, for example, the left side of each page.<br /></p>

<p>In the figure below, the left image shows a typical web page that is part of a web application. The text in yellow shows where header data such as CSS and JavaScript, the navigation menu, and the main page content should be located. We will go into detail on how to create a menu later on in this tutorial. The image to the right in the figure below shows how this page can be split into three components and then dynamically re-assembled at runtime by using server side include. The reason we want to split this page into a "header", the main content, and a "footer", is that the header and footer are almost identical for all pages. We can reuse the header and footer in all pages for the web application by splitting the page up as shown below, thus simplifying coding by reducing repetitive work. We will also minimize the size of the web application since we do not have to duplicate common code for each webpage in the application. Instead, all webpages in the application perform a server side include on the header and footer.</p>

<div class="blogsidebar" style="float:none;width:90%">
<p>Creating a server side navigation menu (a simple dashboard) as shown in this tutorial is easy. However, for a more solid foundation, check out the tutorial  <a target="_blank" href="https://makoserver.net/articles/How-to-Build-an-Interactive-Dashboard-App">How to Build an Interactive Dashboard App</a>.</p>
</div>

<div class="center"><img  style="max-width:600px" title="server-include-menu" alt="server-include-menu" src="images/server-include-menu.svg" /></div>
<p class="caption">Figure 1: Shows how a page can be split up into three components, where common website code goes into the header and footer.</p>

<details>
  <summary>How to design the menu</summary>
  <p>HTML and CSS provide several options when it comes to creating a menu, and many of these options are based on HTML lists as shown below.</p>
  <a name="menu1" id="menu1"></a>
<table>
<tbody>
<tr>
<td>
<pre class="code">
&lt;div id="nav"&gt;
 &lt;ul&gt;
  &lt;li&gt;&lt;a href="About.lsp"&gt;About&lt;/a&gt;&lt;/li&gt;
  &lt;li&gt;&lt;a href="Introduction.lsp"&gt;Introduction&lt;/a&gt;&lt;/li&gt;
  &lt;li&gt;&lt;a href="HTML-Forms.lsp"&gt;HTML Forms&lt;/a&gt;&lt;/li&gt;
  &lt;li&gt;&lt;a href="Ajax.lsp"&gt;Ajax&lt;/a&gt;&lt;/li&gt;
 &lt;/ul&gt;
&lt;/div&gt;
</pre>
</td>
<td>
  <ul>
    <li><a href="About.lsp">About</a></li>
    <li><a href="Introduction.lsp">Introduction</a></li>
    <li><a href="HTML-Forms.lsp">HTML Forms</a></li>
    <li><a href="Ajax.lsp">Ajax</a></li>
  </ul>
</td>
</tr>
</tbody>
</table>

  <p class="caption">Figure 2: The HTML code for a menu and how the menu looks when CSS is not applied.</p>
  <p>The menu does not look particularly attractive when Cascading Style Sheets (CSS) is not applied to it. The menu on the top left of this page shows the same menu with CSS applied.</p>
  <p>A complete explanation for how the CSS works for the above menu is beyond the scope of this tutorial, but a few things are worth noting. We used CSS3 for the above menu, and most new browsers today can handle CSS3. The menu will also work in older browsers, but will have a dull look. The menu does not include any images. The gradient color is managed by using CSS3. You can find a number of online tools that can help you create CSS3 color gradients and one such tool is the <a href="http://www.colorzilla.com/gradient-editor/" target="_blank">CSS Gradient Generator</a>.</p>

</details>

<details>
  <summary style="clear:both">Dynamic header generation</summary>
  <p>We have thus far showed you how to create a menu by using the HTML list element and styling it using CSS. The code for the menu in Figure 2 shows standard static HTML. We could have put this HTML into our header file that is to be included by all pages in our web application "as is", but the problem with this solution is that we would not see the selected (active) page visually in the menu. What we want is to have the menu button for the selected page visually appear active. The menu button you click should appear active. Having a "selected" menu button for the active page makes it easier for the web application user to know what page is active. Making the selected menu button appear active can easily be achieved by creating a class for this purpose in the CSS file. This class can then be applied to the selected page button.</p>
  <pre class="code">
  &lt;li&gt;&lt;a <strong>class="selected"</strong> href="Dynamic-Navigation-Menu.lsp"&gt;Navigation Menu&lt;/a&gt;&lt;/li&gt;
  </pre>
  <p class="caption">Figure 4: The menu button appears active when the "selected" class is set for the anchor element.</p>
  <p>We only want the "selected" class on the menu button for the currently active webpage, thus our only option is to dynamically create the HTML for the menu. The following code fragment shows how to create the &lt;li&gt; elements in the menu.</p>
  <pre class="code">
  <span> 1</span> local links={
  <span> 2</span>    {'About.lsp','About'},
  <span> 3</span>    {'Introduction.lsp','Introduction'},
  <span> 4</span>    {'HTML-Forms.lsp','HTML Forms'},
  <span> 5</span>    {'Ajax-for-Beginners.lsp','Ajax'},
  <span> 6</span> }
  <span> 7</span> for index,link in ipairs(links) do
  <span> 8</span>    local isactive -- Set isactive to true or false
  <span> 9</span>    response:write('&lt;li&gt;&lt;a href="',link[1],'"',
  <span>10</span>                   isactive and ' <strong>class="selected"</strong>' or '',
  <span>12</span>                   '&gt;',link[2],'&lt;/a&gt;&lt;/li&gt;')
  <span>13</span> end
  </pre>
  <p class="caption">Figure 5: Shows how to dynamically create the &lt;li&gt; elements in the menu.</p>
  <p>Line 1 to 7 declares a two dimensional Lua array and this array includes all links and page titles for the web application.</p>
  <p>Line 8 iterates over the outer array. The iterator returns the index position and the inner array. We have five elements in our outer array so line 9 to 12 will execute five times. The inner array contains the link and the page title.</p>
  <p>Line 9 must set the variable isactive to true if the current page matches the current element in the array we are looping over. We will explain later how this is done.</p>
  <p>Line 10 to 12 dynamically creates the &lt;li&gt; elements in the menu. Notice that we add the class "selected" to the &lt;li&gt; element to make the menu button appear active if variable isactive is true.</p>
  <p>The only part missing in the puzzle is how to set the isactive variable on line 9. To do this, we first need to look at one of the pages in our web application that includes the header. The following example shows the Dynamic-Navigation-Menu.lsp page.</p>
  <pre class="code">
  <span> 1</span> &lt;?lsp <strong>title="Navigation Menu" response:include".header.lsp"</strong> ?&gt;
  <span> 2</span> &lt;h1&gt;Dynamic Navigation Menu&lt;/h1&gt;
  <span> 3</span>
  <span> 4</span> &lt;?lsp <strong>response:include"footer.shtml"</strong> ?&gt;
  </pre>
  <p class="caption">Figure 6: Shows the Dynamic-Navigation-Menu.lsp page and how the LSP header file and the HTML footer file are included at runtime.</p>
  <p>Notice the global variable assignment <strong>title="Navigation Menu"</strong> on line 1 above. The Mako Server provides a short lived global environment, and this environment is only active as long as the request is active. The global variable title will also be available when the .header.lsp file executes. The title is used on line 9 in figure 5, and the correct code for this line in Figure 5 is as follows:</p>
  <pre class="code">
  <span> 9</span> local isactive = title == link[2]
  </pre>
  <p>The variable isactive is set to true in .header.lsp If the title set in the parent page matches the current title in the array we are looping over. The short lived environment makes it possible for the parent page to set a variable for the included page. The short lived environment is explained in the main documentation. See the <a href="/ba/doc/?url=en/lua/lua.html#CMDE" target="_blank">Command (Request/Response) Environmment</a> for details.</p>
  <p>We also use the global title variable when emitting the HTML title element in .header.lsp:</p>
  <pre class="code">
  &lt;title&gt;&lt;?lsp=title?&gt;&lt;/title&gt;
  </pre>
  <p>Notice that the .header.lsp file name starts with a dot. File names that start with a dot are hidden and cannot be accessed via a browser. The file is only visible to server side code such as to function response:include. The HTML footer page uses the extension shtml, and this file is also only visible to server side code. The difference between the header and the footer is that the header is an LSP page and is executed on the server and the footer is just a static HTML file.</p>
</details>

<details open>
  <summary class="exth">View the Example Code</summary>
  <ul>
    <li><a target='_blank' href="../showsource/?path=/.header.lsp">.header.lsp</a></li>
    <li><a target='_blank' href="../showsource/?path=/footer.shtml">footer.shtml</a></li>
    <li><a target='_blank' href="../showsource/?path=/Dynamic-Navigation-Menu.lsp">Dynamic-Navigation-Menu.lsp</a></li>
  </ul>
</details>

</div>
<p id="NextBut"><a href="SharkSSL.lsp">Next Tutorial</a></p>
<?lsp response:include"footer.shtml" ?>
