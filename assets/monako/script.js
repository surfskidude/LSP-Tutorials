
let monacoEnabled=false;
let editors={};
const ext2Lang={
    xlua: "lua",
    preload: "lua",
};

function getLanguage(fn) {
    const match = fn.match( /\.([^.]+)$/);
    if (match) {
        const ext = match[1];
        console.log(ext, ext2Lang[ext] ? ext2Lang[ext] : ext);
        return ext2Lang[ext] ? ext2Lang[ext] : ext;
    }
    return "text"
};

function createEditor(pn, value) {
    let editorId = 'editor-' + pn.replace(/[^a-z0-9]/gi, '-').toLowerCase();
    let tabBtn = $('<button>', {
	class: 'tabbtn',
	'data-target': editorId,
	text: pn.match(/[^/]+$/)[0]
    });
    let closeBtn = $('<span>', {
	class: 'closebtn',
	text: 'X'
    }).appendTo(tabBtn);
    closeBtn.on('click', function(event) {
	if(editors[editorId]) {
	    var shouldClose = confirm('The file has unsaved changes. Are you sure you want to close the tab?');
	    if (!shouldClose) return;
	}
	let p=$(this).parent();
	let id=p.data('target');
	$(`#${id}`).remove();
	p.remove();
    });
    let editorContainer = $('<div>', {
	class: 'editorcontainer',
	id: editorId
    });
    $('#tabheader').append(tabBtn);
    $('#editors').append(editorContainer);
    require(['vs/editor/editor.main'], function () {
	let editor = monaco.editor.create(editorContainer.get(0), {
	    value: value,
	    language: getLanguage(pn),
	    theme: 'vs-dark',
	    automaticLayout: true,
	});
	editorContainer.data('editor', editor);
	editor.onDidChangeModelContent(function (e) { console.log("C"); editors[editorId]=true; });
    });
    tabBtn.on('click', function() {
	let target = $(this).data('target');
	setActiveEditor(target);
    });
    editors[editorId]=false;
    setActiveEditor(editorId);
    return editorId;
}

function setActiveEditor(editorId) {
  $('.tabbtn').removeClass('active');
  $('.editorcontainer').hide();
  $(`[data-target="${editorId}"]`).addClass('active');
  $(`#${editorId}`).show();
}


$(function() {
    Split(['#left-pane', '#right-pane'], {
	sizes: [25, 75],
	minSize: 100,
	direction: 'horizontal',
	gutterSize: 5,
    });
    Split(['#editorpane', '#bottom-pane'], {
	sizes: [75, 25],
	minSize: 100,
	direction: 'vertical',
	gutterSize: 5,
    });
    let loaderScript = document.createElement('script');
    loaderScript.src = 'https://unpkg.com/monaco-editor@0.36.1/min/vs/loader.js';
    loaderScript.onload = function() {
	monacoEnabled=true;
	require.config({
	    paths: {
		'vs': 'https://unpkg.com/monaco-editor@0.36.1/min/vs'
	    }
	});


https://microsoft.github.io/monaco-editor/typedoc/interfaces/languages.IMonarchLanguage.html

        require(['vs/editor/editor.main'], function () {
            monaco.languages.register({ id: 'lsp' });
            // Load HTML and Lua languages
            Promise.all([
                monaco.languages.getLanguages().find((lang) => lang.id === 'html').loader(),
                monaco.languages.getLanguages().find((lang) => lang.id === 'lua').loader(),
            ]).then(([htmlLang, luaLang]) => {
                console.log(htmlLang, luaLang);
                // Set up the syntax highlighting for the 'lsp' language
                console.log(htmlLang.language.tokenizer);
                var luaMain = [
                    [/<\?((lsp)|=)?/, { token: '@rematch', switchTo: '@luaInSimpleState.root' }],
                    ...htmlLang.language.tokenizer.root
                ]
                monaco.languages.setMonarchTokensProvider('lsp', {
                    // Inherit the HTML language syntax highlighting
                        ...htmlLang.language,
                    // Merge the HTML and Lua tokenizers
                    tokenizer: {
                            ...htmlLang.language.tokenizer,
                            ...luaLang.language.tokenizer,
                        // Combine the root rules from both HTML and Lua
                        root: luaMain,
                        luaInSimpleState: [
                            [/<\?((lsp)|=)?/, 'metatag.lua'],
                            [/\?>/, { token: 'metatag.lua', switchTo: '@$S2.$S3' }],
                            { include: 'luaRoot' }
                        ],
                
                        luaInEmbeddedState: [
                            [/<\?((lua)|=)?/, 'metatag.lua'],
                            [/\?>/, { token: 'metatag.lua', switchTo: '@$S2.$S3', nextEmbedded: '$S3' }],
                            { include: 'luaRoot' }
                        ],
                        // Define the Lua context
                        luaRoot: [
                            ...luaLang.language.tokenizer.root,
                            // Add a rule to detect the closing ?> tag and switch back to the root context
                            [/\?>/, { token: 'tag', next: '@pop' }],
                        ],
                    },
                    // Include the '@keywords', '@symbols',
                    // '@operators', and '@escapes' match targets from
                    // the Lua language
                    keywords: luaLang.language.keywords,
                    symbols: luaLang.language.symbols,
                    operators: luaLang.language.operators,
                    escapes: luaLang.language.escapes,
                });
            });
        });



/***************  TEST CODE **************************/
   createEditor("html.html","<body></body>");
   createEditor("lua.lua","local function f() end");

    createEditor("lsp.lsp",
`
<?lsp
local username
local session = request:session()
local data=request:data()
if request:method() == "POST" then
   if data.username then
      username=data.username
      request:session(true).username=username
   elseif session then
      session:terminate()
   end
else
   username = session and session.username
end
?>

<form method="post">
   <?lsp if username then ?>
      <h1>Hello <?lsp=username?></h1>
      <input type = "submit" value="Logout">
   <?lsp else ?>
      <input type = "text" name="username">
      <input type = "submit" value="Login">
   <?lsp end ?>
</form>
` 
);






	
//	    editor.onDidChangeModelContent(function () {
//		textarea.val(editor.getValue());
//	    });
    }; // loaderScript
    document.head.appendChild(loaderScript);
});
