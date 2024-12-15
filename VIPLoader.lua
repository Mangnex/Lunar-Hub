if game.PlaceId == 15696848933 then
  return loadstring(request({Url="https://lunar-rest-api.vercel.app/script/HL",Method="GET"}).Body)()
elseif game.PlaceId == 5233782396 then
 return loadstring(request({Url="https://lunar-rest-api.vercel.app/script/CoS",Method="GET"}).Body)()
else
 return loadstring(request({Url="https://lunar-rest-api.vercel.app/script/DA",Method="GET"}).Body)()
end
