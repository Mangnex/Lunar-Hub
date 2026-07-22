if game.PlaceId == 3431407618 then
    return loadstring(request({Url="https://lunar-rest-api.vercel.app/script/Isle10",Method="GET"}).Body)()
else
   getgenv().SCRIPT_KEY = ""
   return loadstring(game:HttpGet("https://api.jnkie.com/api/v1/luascripts/public/6c2d6a099fbfccd234496ca4916f3aef40228e4caa4d64bb80c9fe6e27577967/download"))()
end
