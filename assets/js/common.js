$(function() {
  $('.lspeditor').each(function() {
      var type = $(this).attr('extype');
      var html = "<div></div>";
      if( ! $(this).attr('disabled') ) {
          html += ('<button>'+
                   (type == "C" ? "Compile" : "Run")+
                   '</button><button>Revert</button>');
      }
      html += '<iframe></iframe>';
      $(this).html(html);
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
                      ifr.attr("src","examples/manage.lsp?execute=true&ex="+
                               exno+"&type="+type);
                  },
                  error: function(){
                      console.log("Err");
                  }
              });
          }
      });
      editor.setTheme("monokai");
      editor.setShowPrintMargin(false);
      editor.$blockScrolling = Infinity;
      var mode = type;
      if(mode == "C") mode = "c_cpp";
      editor.getSession().setMode('ace/mode/'+mode);
      editorLoad("examples/manage.lsp?ex="+exno+"&type="+type);
  });


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

