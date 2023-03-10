local fmt=string.format
local tinsert = table.insert
local dio=ba.openio"disk"
local _,OS=dio:resourcetype()
local iswin = OS == "windows"


local cc -- C compiler path, name, and flags
local cinst = io:dofile(".lua/C-Install.lua",_ENV)
-- The Mako Module Example Source Code's directory
local modio = cinst.getModIo()
local modpath = modio:realpath""
if iswin then
   local tcc = cinst.getTCCDir()
   cc = '"'..dio:realpath(tcc)..'\\tcc" -shared'
else
   cc = "gcc -O -shared -fpic -shared"
end

local function compile(modname,cfile)
   local c = fmt('%s -Isrc/lua -o %s.%s %s %s',
                 cc,
                 modname, iswin and "dll" or "so",
                 cfile,
                 "src/lua/luaintf.c")
   local cmd = fmt('cd %s"%s"&&%s%s%s',
                   iswin and "/d " or "",
                   modpath,
                   c,
                   " 2>&1",
                   "&& (echo Compilation succeeded) || (echo Compilation failed!)")
   local rsp = ba.exec(cmd)
   local ok = rsp:find("Compilation succeeded",1,true) and true or false
   return ok,c,rsp
end


--So we can access this from LSP pages:
app.cc={compile=compile,modio=modio,modpath=modpath,iswin=iswin}
