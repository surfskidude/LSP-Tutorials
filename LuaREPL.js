function activate(self) {
    let svg=self.contentDocument;
    function setClass(rElem,sElem) {
        if(rElem) rElem.removeClass("svgSofGlow");
        sElem.addClass("svgSofGlow");
    }
    function svgEdit() {
        setClass(null, $("#svgResults",svg).html("Edit Lua"));
    };
    function svgSave(){
        setClass($("#svgResults",svg),$("#svgSave",svg));
    };
    function svgExecute(){
        setClass($("#svgSave",svg),$("#svgExecute",svg));
    };
    function svgResponse(){
        setClass($("#svgExecute",svg),$("#svgResponse",svg));
    };
    function svgResults() {
        setClass($("#svgResponse",svg), $("#svgResults",svg).html("Results"));
    };
    let action=[svgEdit,svgSave,svgExecute,svgResponse,svgResults];
    let cnt=0;
    svgEdit();
    setInterval(function() {
        action[++cnt % action.length]();
    },1000);
};

$(function() {
    document.getElementById("LuaREPL").onload = function() { activate(this); }
});

