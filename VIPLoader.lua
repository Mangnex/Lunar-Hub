if game.PlaceId == 15696848933 or game.PlaceId == 123063406055708 then
  return loadstring(request({Url="https://lunar-rest-api.vercel.app/script/HL",Method="GET"}).Body)()
elseif game.PlaceId == 5233782396 then
  getgenv().SCRIPT_KEY = ""
 return loadstring(game:HttpGet("https://api.jnkie.com/api/v1/luascripts/public/ecb44bf5d377aae4932921c46820a9d76446200a0a2aef2477c1cbf24a99473e/download"))()
else
 return loadstring(request({Url="https://lunar-rest-api.vercel.app/script/DA",Method="GET"}).Body)()
end
