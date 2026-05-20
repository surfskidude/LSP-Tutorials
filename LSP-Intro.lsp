<?lsp title="LSP: intro" response:include".header.lsp" ?>

<h1>Using LSP for Web Development</h1>

<p>Lua Server Pages (LSP) combine HTML and Lua code to create dynamic, server-driven web applications. A static page always sends the same content, but an LSP page can read form input, generate custom HTML, and use server-side resources before sending the response to the browser. Because Lua code can live directly inside the HTML template, you can build interactive pages without adding a separate web framework.</p>

<p>These tutorials use interactive examples to show how LSP works. For a slower introduction to the same fundamentals, read <a target="_blank" href="https://makoserver.net/articles/HTML-Forms-and-LSP-for-Beginners">Introduction to Server-Generated Content Using Lua</a>.</p>

<h2>Planning on designing a SPA using React, Vue.js, etc.?</h2>

<p>An LSP page does not have to return a complete HTML document. It can return only the small HTML fragment needed for the current interaction. This makes LSP a good fit for tools such as HTMX, where the browser updates part of the page using the server's response instead of reloading everything.</p>

<p>With <a target="_blank" href="https://htmx.org/essays/hypermedia-driven-applications/">hypermedia-driven design</a>, the server returns manageable HTML fragments and the browser swaps them into the page. This approach can keep applications simpler because the server remains responsible for most application logic while the browser handles focused updates.</p>

<p id="NextBut"><a href="HTML-Forms.lsp">First Tutorial</a></p>

<?lsp response:include"footer.shtml" ?>
