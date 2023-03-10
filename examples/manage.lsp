<?lsp

local fmt=string.format
local data = request:data()

-- C code management
local function manageC()
   local cex={ -- Special C examples
      LED="src/module/LED.c",
      mymodule="src/module/mymodule.c"
   }
   if data.ex and cex[data.ex] then
      if data.execute then -- compile
         local ok,cmd,rsp = app.compileC(data.ex)
         if not ok and rsp and not app.cc.iswin and rsp:find("not found",1,true) then
            rsp = rsp.."\nGCC is required.\nInstall GCC as follows: sudo apt-get install gcc"
         end
         response:write(
           "<html><body style='background:white;word-wrap: break-word;'><pre>",
           cmd,"</pre>",
           "<pre style='background:",ok and "white" or "red","'>",
           rsp,
           "</pre></body></html>")
         return
      end
      local io = app.cc.modio
      local fp = not data.revert and app.openC(data.ex)
      if not fp then fp = io:open(cex[data.ex]) end
      if fp then
         local ex,err = fp:read"*a"
         if ex then
            response:write(ex)
         else
            response:senderror(500,err or "?")
         end
         fp:close()
         response:abort()
      end
   end
   response:senderror(404,"Example not found")
end

-- Lua and LSP management
local function manageLSP(fp)
   local ex,err = fp:read"*a"
   if ex then
      err=nil
      if data.execute then
         local t=data.type
         if t =="lsp" or t =="lua" then
            -- Convert LSP to Lua
            local env
            if t =="lua" then
               local s = request:session(true)
               if not s.env then
                  s.env={}
               end
               env=s.env
               setmetatable(env,{__index = _ENV})
               ex=fmt("%s<%slsp\n%s\n%s>%s",
                      "<html><body><pre>",
                      '?',ex,'?',
                      "</pre></body></html>")
            else
               env=_ENV
            end
            ex,err = ba.parselsp(ex)
            if ex then
               local func
               -- Compile Lua code
               local name=fmt("example-%s.lsp",data.ex)
               func,err = load(ex,name,"t",env)
               if func then
                  local ok
                  ok,err = pcall(func,env,name,io,page,app)
                  if ok then err=nil end
               end
            end
         else
            trace("unknown type:",type)
         end
      else
         response:write(ex)
      end
   end
   if err then response:write(err) end
end

if data.ex then
   if data.type == "C" then
      manageC()
      return
   end
   local exio=app.exio
   local fp = exio:open(fmt("%s.lsp",data.ex))
   if fp then
      manageLSP(fp)
   else
      fp = io:open(fmt("examples/%s.txt",data.ex))
      if fp then
         manageLSP(fp)
      end
   end
   if fp then
      fp:close()
      response:abort()
   end
end
response:senderror(404,"Example not found")
?>

