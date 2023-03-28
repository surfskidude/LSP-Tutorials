$(function() {
    function aceInstanceLoad(editor, link) {
        $.ajax({
            url : link,
            dataType: "text",
            success : function (data) {
                console.log(data);
                // editor.addClass('opened');
                editor.setValue(data);
                const len = data.split(/\r\n|\r|\n/).length;
                editor.setOptions({maxLines: len > 35 ? 35 : len});
                editor.gotoLine(1);
            }
        });
    }

    /** Addded  button to editors and add result iFrames */
    $('.lspeditor').each(function(e, codeElement) {
        const $this = $(codeElement)
        const type = $this.attr('extype') || 'lsp';
        const exampleNumber = $this.attr('example');
        
        const tn = type == "lsp" ? "LSP" : (type == "lua" ? "Lua" : "C");
        $this.append(`<h5>${tn} example: ${exampleNumber}</h5>`);

        const $code = $('<div>')
            .addClass('code-example')
            .appendTo($this);
        
        const aceInstance = ace.edit($code.get(0));
        aceInstance.setTheme("ace/theme/monokai");
        aceInstance.setShowPrintMargin(false);
        aceInstance.$blockScrolling = Infinity
        
        const mode = (type == "C") ? 'c_cpp' : type;
        aceInstance.getSession().setMode(`ace/mode/${mode}`);
        aceInstanceLoad(aceInstance, `examples/manage.lsp?ex=${exampleNumber}&type=${type}`);
        
        const $frame = $('<iframe>').appendTo($this);
        
        if( ! $(this).attr('disabled') ) {
            const $buttons = $('<div>').appendTo($this);

            /** Run code button */
            $('<button>')
            .addClass('btn primary')
            .html((type == "C" ? "Compile" : "Run"))
            .appendTo($buttons)
            .on('click', function() {
                $frame.addClass('opened');
                $.ajax({
                    url: `examples/save.lsp?ex=${exampleNumber}`,
                    data: aceInstance.getValue(),
                    contentType: false,
                    processData: false,
                    type: 'PUT',
                    success: (data) => {
                        $frame.on('load',  function() {
                            $frame.contents().find('body').first().css({color: '#FFFFFF', background: '#24262B'})
                        });
                        $frame.attr("src", `examples/manage.lsp?execute=true&ex=${exampleNumber}&type=${type}`);
                    },
                    error: function(){
                        console.log("Err");
                    }
                });
            });

            
            /** Revert code button */
            $('<button>')
            .addClass('btn danger')
            .html('Revert')
            .appendTo($buttons)
            .on('click', function() {
                var ex = type == "C" ?
                    (`examples/manage.lsp?ex=${exampleNumber}&type=C&revert=`) :
                    (`examples/${exampleNumber}.txt`);
                aceInstanceLoad(aceInstance, ex);
                $frame.removeClass('opened');
            });
        }
    });
    

    /** Nav menu */
    const $ls = $("#left-sidebar")
    $(".open-main-menu").click(function() {
        if ($ls.hasClass('active')) {
            $ls.removeClass('active')
        } else {
            $ls.addClass('active')
        }
    });

    $('.close-header-icon').click(() => {
        $ls.removeClass('active');
    })

});

