return {
	Missions = {
		Objective = "Skirmish",
		Modifiers = {
			"No Perks",
			"No Skills",
			"No Memories",
			"Fog",
			"Injury Prone",
			"Chronic Injuries",
			"Glass Cannon",
			"Evolution",
			"Nightmare",
			"Oddball",
			"Time Trial",
		},
		SafeTime = 40,
		Difficulty = {
			Easy = 0, -- Grade E-
			Normal = 2, -- Grade E+
			Hard = 5, -- Grade D+
			Severe = 9, -- Grade C+
			Aberrant = 12, -- Grade F+
			Freedom = 15, -- Grade S-
		},
	},
	UpgradePrices = {
		[1] = 4000,
		[2] = 10000,
		[3] = 16000,
		[4] = 24000,
		[5] = 40000,
		[6] = 60000,
		[7] = 88000,
		[8] = 140000,
		[9] = 200000,
		[10] = 300000,
		[11] = 400000,
		[12] = 560000,
		[13] = 800000,
		[14] = 1080000,
		[15] = 1355360,
	},
	Abilities = {
		Brandes = {
			{ Name = "Offense", Start = 1, Finish = 11 },
			{ Name = "Support", Start = 70, Finish = 80 },
			{ Name = "Defense", Start = 38, Finish = 43 },
		},
		Special = { 3, 7, 40, 72, 76 },
		Spears = { 81, 82, 83, 84 },
		Others = { 12, 13, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37 },
	},
	Prestige = {
		[0] = {
			Level = 100,
			Gold = 0,
		},
		[1] = {
			Level = 125,
			Gold = 0,
		},
		[2] = {
			Level = 150,
			Gold = 0,
		},
		[3] = {
			Level = 175,
			Gold = 200000000, -- 200M / 600M
		},
		[4] = {
			Level = 175,
			Gold = 800000000, -- 800M
		},
		[5] = {
			Level = 225,
			Gold = 0,
		},
	},
	Slashs = {
		Easy = 1,
		Normal = 5,
		Hard = 5,
		Severe = 5,
		Aberrant = 10,
		Freedom = 10,
	},
	Detonations = {
		Aberrant = 30,
		Freedom = 30,
	},
	GasTanks = {
		[13379349730] = function() -- Shiganshina
			return workspace:FindFirstChild("Unclimbable"):FindFirstChild("Props"):FindFirstChild("HQ")
		end,
		[14012874501] = function() -- Troast
			return workspace:FindFirstChild("Unclimbable"):FindFirstChild("Props"):FindFirstChild("HQ")
		end,
		[13904207646] = function() -- Outskirts
			return workspace:FindFirstChild("Climbable"):FindFirstChild("_Walls"):FindFirstChild("Gate")
		end,
		[14638336319] = function() -- Forest
			return workspace:FindFirstChild("Unclimbable"):FindFirstChild("Camps"):FindFirstChild("Camp")
		end,
		[15220308770] = function() -- Utgard
			return workspace:FindFirstChild("Climbable"):FindFirstChild("Utgard")
		end,
		[17688739434] = function() -- Docks
			return workspace:FindFirstChild("Unclimbable"):FindFirstChild("Buildings"):FindFirstChild("Hanger")
		end,
		[15824912319] = function() -- Stoheh
			return workspace:FindFirstChild("Unclimbable"):FindFirstChild("Props"):FindFirstChild("HQ")
		end,
		[126678335159530] = function() -- Chapel
			return workspace:FindFirstChild("Unclimbable"):FindFirstChild("Reloads")
		end,
	},
	Codes = {
		-- Permanent
		["TERRA70K"] = {
			Level = 25,
		},
		["WZINS"] = {
			Level = 25,
		},
		-- Temporal
		-- None for the moment (23/11/26)
	},
	Developers = {
		81636850,
		52735883,
		1629719130,
		97550650,
		761016259,
		59888460,
		61434434,
		2796898393,
		1522248174,
		923860344,
		29927547,
		95863469,
		357732700,
	},
}
