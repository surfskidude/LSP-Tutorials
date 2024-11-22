


local errinfo = [[


=========================================================
This Lua application is not compatible with networks that
require proxy configurations.
=========================================================


]]

local fmt=string.format
local errmsg

local function beep()
   print(fmt("%c",7))
end


local function doerr(msg)
   errmsg=fmt("%s\n%s",msg,errinfo)
   print(errmsg)
   beep()
   ba.sleep(1000)
   error(msg)
end

local function check(ok,emsg)
   if not ok then doerr(emsg) end
end

local function addpath(p1,p2)
   return string.gsub(p1..p2,"//","/")
end

local tmpd = os.getenv"TMP" or os.getenv"TEMP" or "/tmp"
local hdir = os.getenv"HOME" or os.getenv"USERPROFILE"
check(hdir, "Cannot find your home directory")
local dio=ba.openio"disk"
local _,OS=dio:resourcetype()
local iswin = OS == "windows"
if iswin then
   tmpd=mako.dos2unix(tmpd)
   hdir=mako.dos2unix(hdir)
end
local appdir=hdir.."/lspapps"
if not _G.appdir then
   print("TMP dir:",tmpd)
   print("App dir:",appdir)
   _G.appdir=appdir
end
check(dio:stat(appdir) or dio:mkdir(appdir), "Cannot create "..appdir)
local appio=ba.mkio(dio,appdir)


local function download(url, to)
   print(fmt("Downloading %s",url))
   local time=os.time()
   local lastsize
   local http=require"httpm".create()
   local ok,err=http:download{
      io=dio,
      name=to,
      url=url,
      func=function(size,dsize)
              size=math.ceil(100*dsize/size)
              if lastsize ~= size and (time+1 < os.time() or size >= 100) then
                 lastsize = size
                 print(fmt("\tDownloading: %d%%\r",size))
                 time=os.time()
              end
           end
   }
   check(ok and http:status() == 200, "Cannot download: "..url)
end


local function copy(size,from,to)
   while size > 0 do
      local ok
      local chunk = size > 512 and 512 or size
      size = size - chunk
      local data = from:read(chunk)
      if data then
         ok=to:write(data)
      end
      check(ok,"I/O error")
   end
   return true
end


local function unpack(fromIo, toIo)
   local function recCopy(dir)
      for name,isdir,mtime,size in fromIo:files(dir,true) do
         local fn=dir..name
         if isdir then
            check(toIo:stat(fn) or toIo:mkdir(fn),
                  "Cannot create "..toIo:realpath(fn))
            recCopy(fn.."/")
         else
            local from,to
            from,err = fromIo:open(fn);
            check(from,err)
            to,err = toIo:open(fn, "w");
            check(to,err)
            print("\tExtracting ",toIo:realpath(fn))
            copy(size,from,to)
            to:close()
         end
      end
   end
   recCopy("/")
end

local function getTCCDir()
   if iswin then
      return addpath(mako.execpath,"/TCC")
   end
end

local function installORCheck(check)
   if not appio:stat"MakoModuleExample" then
      local mz = addpath(mako.execpath,"/../MakoModuleExample.zip")
      if not dio:stat(mz) then
         local mz = addpath(ba.openio"home":realpath"/", "MakoModuleExample.zip")
      end
      if not dio:stat(mz) then
         if check then return true end
         mz = addpath(tmpd, "/MakoModuleExample.zip")
         local ok,err = pcall(function()
                                 download("http://makoserver.net/download/MakoModuleExample.zip",mz)
                              end)
         trace(err)
         if not ok then return nil,err end
      end
      unpack(ba.mkio(dio,mz), appio)
      return true
   end
   
   if iswin then
      local tccd = getTCCDir()
      if not dio:stat(tccd) then
         if check then return true end
         local tccz = addpath(tmpd,"/tcc.zip")
         download("http://realtimelogic.com/downloads/tools/TCC-win.zip",tccz)
         unpack(ba.mkio(dio,tccz), ba.mkio(dio,mako.execpath))
      end
   end
   return not check and true or false
end

local function isAndroid()
   return os.getenv"HOME" == mako.execpath and
      mako.execpath:match("/cache/exec$")
end

return {
   check=function() return installORCheck(true) end,
   install=function() return installORCheck() end,
   installable=function() return not isAndroid() end,
   getTCCDir=getTCCDir,
   iswin=iswin,
   getModIo=function() return ba.mkio(appio,"MakoModuleExample") end
}
