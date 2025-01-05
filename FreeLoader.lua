if game.PlaceId == 3431407618 then
    return loadstring(request({Url="https://lunar-rest-api.vercel.app/script/Isle10",Method="GET"}).Body)()
else
   return loadstring(request({Url="https://lunar-rest-api.vercel.app/script/CoS",Method="GET"}).Body)()
end
