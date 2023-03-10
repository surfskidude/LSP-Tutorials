

-- Fixes older installations, where the path setup by DownloadTutorials.zip no longer is correct.

local function check(ok,emsg)
   if not ok then doerr(emsg) end
end
local fmt=string.format
local hdir = os.getenv"HOME" or os.getenv"USERPROFILE"
check(hdir, "Cannot find your home directory")
hdir=mako.dos2unix(hdir)
local dio=ba.openio"disk"
local appdir=hdir.."/lspapps"
check(dio:stat(appdir) or dio:mkdir(appdir), "Cannot create "..appdir)
local appio=ba.mkio(dio,appdir)


local function execPreload(appenv,zipname)
   local ok,err
   if appenv.io:stat".preload" then
      local f
      f,err = appenv.io:loadfile(".preload",appenv)
      if f then
         ok, err = pcall(f)
         if ok then err=nil end
      end
   else
      print(fmt("Info: %s/.preload not found",zipname))
   end
   if err then
      print(err)
      return nil,err
   end
   return true
end

apptab={} -- Keep references here so apps do not GC
local ok
 
local function start(zipname,appname)
   local io,err = ba.mkio(appio,zipname)
   if io then
      local rootapp = #appname == 0 and true or false
      print(fmt("Reloading %s as %s",zipname, rootapp and "'root application'" or appname))
      local resrdr=ba.create.resrdr(not rootapp and appname or nil,0,io)
      if resrdr then
         resrdr:insert()
         local appenv=setmetatable({io=io,dir=resrdr},{__index=_G})
         appenv.app = appenv
         ok,err=execPreload(appenv,zipname)
         if not err then
            resrdr:lspfilter(appenv)
            table.insert(apptab,resrdr)
            return
         end
         resrdr:unlink()
         if not err then
            print".preload failed"
         end
      else
         print"Cannot create resrdr"
      end
   end
   ok=false
end


local function deferred()
   local http=require"httpm".create()
   local st=http:stat(fmt("http://localhost:%d/IoT/",mako.port))
   if not st then
      pcall(function()
               _G.shutdownIoT() -- See IoT.zip:.preload
               start("IoT.zip","")
            end)
   end
end
ba.thread.run(deferred)
