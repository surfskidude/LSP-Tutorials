$(function() {
    
    $('iframe').each((e) => {
    
    });

    $('.lspeditor').each(function() {
        var type = $(this).attr('extype');
        var html = document.createElement('div')
        
        html.appendChild(document.createElement('div'));
        const div = document.createElement('div')
        div.className = 'editor-relative';

        const iframe = document.createElement('iframe');
        iframe.addEventListener('load', (e) => {
            console.log('event', e);
        })
        iframe.onload = function (e) {
            console.log('loaded iframe', e);
            e.target.document.body.style = 'color: white; font-size: 14px; line-height: 18px;';
        }
        if( ! $(this).attr('disabled') ) {
            const button = document.createElement('button')
            button.innerHTML = (type == "C" ? "Compile" : "Run");
            html.appendChild(button);
            const button2 = document.createElement('Revert')
            button2.innerHTML = (type == "C" ? "Compile" : "Run");
            html.appendChild(button2);
        }
        div.appendChild(iframe);
        html.appendChild(div)
        $(this).add(html);
    });
    $('.lspeditor > div').each(function() {
        var p = $(this).parent();
        var type = p.attr('extype');
        if(!type) type='lsp';
        var exno = p.attr('example');
        var editor = ace.edit(this);
        var tn = type == "lsp" ? "LSP" : (type == "lua" ? "Lua" : "C");
        p.before('<b>'+tn+' example: '+exno+'</b>');
        function editorLoad(fn) {
            $.ajax({
                url : fn,
                dataType: "text",
                success : function (data) {
                    editor.setValue(data);
                    var len=data.split(/\r\n|\r|\n/).length;
                    editor.setOptions({maxLines: len > 35 ? 35 : len});
                    editor.gotoLine(1);
                }
            });
        }
        p.children('button').click(function() {
            var p = $(this).parent();
            var ifr = p.children('iframe');
            if($(this).html() == "Revert") {
                var ex = type == "C" ?
                    ("examples/manage.lsp?ex="+exno+"&type=C&revert=") :
                    ("examples/"+exno+".txt");
                editorLoad(ex);
                ifr.hide();
            }
            else {
                ifr.show();
                $.ajax({
                    url: 'examples/save.lsp?ex='+exno,
                    data: editor.getValue(),
                    contentType: false,
                    processData: false,
                    type: 'PUT',
                    success: function(data){
                        const frame = ifr.get(0);
                        frame.addEventListener('load', function() {
                            ifr.contents().find('body').first().css({color: '#FFFFFF', background: '#24262B'})
                        })
                        ifr.attr("src","examples/manage.lsp?execute=true&ex="+
                                 exno+"&type="+type);
                        
                    },
                    error: function(){
                        console.log("Err");
                    }
                });
            }
        });
        editor.setTheme("ace/theme/monokai");
        editor.setShowPrintMargin(false);
        var mode = type;
        if(mode == "C") mode = "c_cpp";
        editor.getSession().setMode('ace/mode/'+mode);
        editorLoad("examples/manage.lsp?ex="+exno+"&type="+type);
    });

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

    var prevDisp;
    $(window).on('resize orientationchange load', function() {
        var disp = $("#navbut").css("display");
        if(disp != prevDisp) {
            prevDisp = disp;
            if(disp == "none") {
                $("#headertxt").html("Barracuda App Server Tutorials");
                smallMode=false;
            }
            else {
                $("#headertxt").html("BAS Tutorials");
                smallMode=true;
            }
        }
    });

});

