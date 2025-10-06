local Worlds = {
    ["Lobby"] = {
        Order = 1,
        PlaceId = 3475397644,
        Icon = "rbxassetid://14050961846",
        Background = "rbxassetid://7472361349",
        Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0.00, Color3.fromRGB(238, 154, 52)),
            ColorSequenceKeypoint.new(0.22, Color3.fromRGB(240, 166, 61)),
            ColorSequenceKeypoint.new(0.59, Color3.fromRGB(253, 223, 104)),
            ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 228, 108))
        }
    },
    ["Grassland"] = {
        Order = 2,
        PlaceId = 3475419198,
        Icon = "rbxassetid://14050962623",
        Background = "rbxassetid://15515691676",
        Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0.00, Color3.fromRGB(77, 159, 23)),
            ColorSequenceKeypoint.new(0.53, Color3.fromRGB(206, 249, 78)),
            ColorSequenceKeypoint.new(1.00, Color3.fromRGB(211, 255, 81))
        }
    },
    ["Jungle"] = {
        Order = 3,
        PlaceId = 3475422608,
        Icon = "rbxassetid://14050962238",
        Background = "rbxassetid://8042982078",
        Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0, 149, 152)),
            ColorSequenceKeypoint.new(0.45, Color3.fromRGB(84, 250, 157)),
            ColorSequenceKeypoint.new(1.00, Color3.fromRGB(88, 255, 158))
        }
    },
    ["Volcano"] = {
        Order = 4,
        PlaceId = 3487210751,
        Icon = "rbxassetid://14050964131",
        Background = "rbxassetid://9430074264",
        Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 56, 63)),
            ColorSequenceKeypoint.new(0.21, Color3.fromRGB(255, 67, 63)),
            ColorSequenceKeypoint.new(0.62, Color3.fromRGB(255, 249, 73)),
            ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 206, 60))
        }
    },
    ["Tundra"] = {
        Order = 5,
        PlaceId = 3623549100,
        Icon = "rbxassetid://14050961382",
        Background = "rbxassetid://14109662615",
        Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0.00, Color3.fromRGB(192, 192, 192)),
            ColorSequenceKeypoint.new(0.71, Color3.fromRGB(231, 231, 231)),
            ColorSequenceKeypoint.new(1.00, Color3.fromRGB(231, 231, 231))
        }
    },
    ["Ocean"] = {
        Order = 6,
        PlaceId = 3737848045,
        Icon = "rbxassetid://14050962029",
        Background = "rbxassetid://10320067075",
        Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0.00, Color3.fromRGB(37, 21, 255)),
            ColorSequenceKeypoint.new(0.29, Color3.fromRGB(52, 157, 255)),
            ColorSequenceKeypoint.new(0.48, Color3.fromRGB(62, 242, 255)),
            ColorSequenceKeypoint.new(1.00, Color3.fromRGB(64, 252, 255))
        }
    },
    ["Desert"] = {
        Order = 7,
        PlaceId = 3752680052,
        Icon = "rbxassetid://14050963099",
        Background = "rbxassetid://8035077339",
        Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0.00, Color3.fromRGB(226, 143, 59)),
            ColorSequenceKeypoint.new(0.57, Color3.fromRGB(251, 223, 161)),
            ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 235, 176))
        }
    },
    ["Fantasy"] = {
        Order = 8,
        PlaceId = 4174118306,
        Icon = "rbxassetid://14050962837",
        Background = "rbxassetid://10997974038",
        Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 158, 245)),
            ColorSequenceKeypoint.new(0.21, Color3.fromRGB(237, 167, 246)),
            ColorSequenceKeypoint.new(0.63, Color3.fromRGB(128, 228, 254)),
            ColorSequenceKeypoint.new(1.00, Color3.fromRGB(121, 233, 255))
        }
    },
    ["Toxic"] = {
        Order = 9,
        PlaceId = 4728805070,
        Icon = "rbxassetid://14050961074",
        Background = "rbxassetid://7472365719",
        Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0.00, Color3.fromRGB(38, 252, 0)),
            ColorSequenceKeypoint.new(0.51, Color3.fromRGB(220, 254, 75)),
            ColorSequenceKeypoint.new(1.00, Color3.fromRGB(247, 255, 87))
        }
    },
    ["Prehistoric"] = {
        Order = 10,
        PlaceId = 4869039553,
        Icon = "rbxassetid://14050961630",
        Background = "rbxassetid://7472364858",
        Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0.00, Color3.fromRGB(165, 70, 33)),
            ColorSequenceKeypoint.new(0.44, Color3.fromRGB(242, 206, 111)),
            ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 229, 125))
        }
    },
    ["Shinrin"] = {
        Order = 11,
        PlaceId = 125804922932357,
        Icon = "rbxassetid://121914622788747",
        Background = "rbxassetid://115802889732355",
        Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0.00, Color3.fromRGB(226, 143, 59)),
            ColorSequenceKeypoint.new(0.57, Color3.fromRGB(251, 223, 161)),
            ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 235, 176))
        }
    }
}

return Worlds
