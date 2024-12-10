<?lsp title="LSP: intro" response:include".header.lsp" ?>

<h1>Using LSP for Web Development</h1>

<p>Lua Server Pages (LSP) blend HTML and Lua code to create dynamic, server-driven web applications. Unlike static pages, LSP allows your server to produce custom responses on-the-fly—reading form input, generating personalized content, and interacting with server-side resources. By embedding Lua code directly into HTML templates, you can streamline your development process, handle routing more intuitively, and quickly build interactive, data-driven web experiences without the need for additional frameworks.</p>

<p>In these LSP tutorials, we’ll walk through some interactive examples demonstrating how to use LSP. However, for a more solid groundwork, we recommend reading <a target="_blank" href="https://makoserver.net/articles/HTML-Forms-and-LSP-for-Beginners">Introduction to Server-Generated Content Using Lua</a>, which lays out the fundamental concepts you’ll need.</p>

<h2>Planning on designing a SPA using React, Vue.js, etc.?</h2>

<p>Keep in mind that an LSP page does not have to return a complete HTML document. Instead, it can provide only the specific snippet of HTML needed at the moment. This makes LSP a perfect fit for tools like HTMX, which enables pages to update dynamically based on server responses—no full page reloads are required.</p>

<p>You can avoid complex client-side frameworks by focusing on <a target="_blank" href="https://htmx.org/essays/hypermedia-driven-applications/">hypermedia-driven design</a>, where the server returns manageable HTML fragments. This approach often results in more straightforward development and better performance since you’re only sending what’s actually needed. Together, LSP and Hypermedia-driven application design streamline server-driven modern interactivity while maintaining a clean, maintainable codebase.</p>

<p id="NextBut"><a href="HTML-Forms.lsp">First Tutorial</a></p>

<?lsp response:include"footer.shtml" ?>
