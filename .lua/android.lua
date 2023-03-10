
-- Mako Server update script for:
-- https://play.google.com/store/apps/details?id=net.makoserver.android

local function dirfunc(_ENV)
   response:write"<h1>Server Updated</h1>"
   response:write"<p>The server must be restarted!</p>"
end

local function deferred()
   local exio=ba.mkio(ba.openio"disk",mako.execpath)
   if exio then
      local http=require"httpm".create{shark=ba.sharkclient()}
      local download=true
      local function makodate(date)
         local retval
         local fp=exio:open("makodate.json", date and "w" or "r")
         if fp then
            if date then
               retval=fp:write(ba.json.encode{date=date})
            else
               local t=ba.json.decode(fp:read"*a")
               retval = t and t.date
            end
            fp:close()
            return retval
         end
      end
      local function httpCopy(from, to)
         return http:download{
            io=exio,
            name=to,
            url="https://makoserver.net/download/android/"..from,
         }
      end
      local d=makodate()
      local st=http:stat"https://makoserver.net/download/android/mako"
      if d then
         if (st and d == st.mtime) or not st then
            download=false
         end
      elseif not st then
         download=false
      end
      if download and httpCopy("mako","mako.new") and httpCopy("mako.zip","mako.zip.new") then
         trace"Updating the Mako Server"
         if exio:remove"mako" and
            exio:remove"mako.zip" and
            exio:rename("mako.new","mako") and
            exio:rename("mako.zip.new","mako.zip") then
            os.execute(string.format("chmod 777 %s/mako", mako.execpath))
            makodate(st.mtime)
            xdir = ba.create.dir(nil,120)
            xdir:setfunc(dirfunc)
            xdir:insert()
         end
      end
   end
end

ba.thread.run(deferred)
