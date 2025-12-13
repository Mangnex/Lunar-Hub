if game.PlaceId == 15696848933 or game.PlaceId == 123063406055708 then
  return loadstring(request({Url="https://lunar-rest-api.vercel.app/script/HL",Method="GET"}).Body)()
elseif game.PlaceId == 5233782396 then
 return loadstring(request({Url='https://api.catsec.xyz/script/6q1wq2no9mev7th6u12io5ov12269z5w',Method='GET'}).Body)()
else
 return loadstring(request({Url="https://lunar-rest-api.vercel.app/script/DA",Method="GET"}).Body)()
end
