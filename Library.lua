local Library = {}

function Library.IsMobileUser()
    if game:GetService("UserInputService").TouchEnabled and not game:GetService("UserInputService").KeyboardEnabled then
        return true
    else
        return false
    end
end

function Library.IsPrivateServer()
    if game.PrivateServerId ~= "" then
        if game.PrivateServerOwnerId ~= 0 then
            return true
        else
            return false
        end
    else
        return false
    end
end

return Library
