<?lsp


local maxsize,size=100*1024,0
local emsg="Incorrect usage"
if request:method() == "PUT" then
   local exno = request:data"ex"
   if exno then
      emsg=nil
      local data={}
      for chunk in request:rawrdr() do
         size=size+#chunk
         if size > maxsize then
            emsg="File too large"
            response:setstatus(413)
            break
         else
            if not data then data={} end
            table.insert(data,chunk)
         end
      end
      if not emsg then
         if app.saveEx(exno, table.concat(data)) then
            response:setstatus(204)
            response:abort()
         end
         emsg = "IO error"
      end
   else
      response:setstatus(405)
   end
else
   response:setstatus(405)
end
print(emsg)
?>

