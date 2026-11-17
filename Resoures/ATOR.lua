return {
	Missions = {
		Map = "Shiganshina",
		Objective = "Skirmish",
		Modifiers = {
			["No Perks"] = 0,
			["No Skills"] = 0,
			["No Memories"] = 0,
			["Fog"] = 0,
			["Injury Prone"] = 0,
			["Chronic Injuries"] = 0,
			["Glass Cannon"] = 0,
			["Evolution"] = 0,
			["Nightmare"] = 0,
			["Oddball"] = 0,
			["Time Trial"] = 0,
			["Fatigue"] = 0,
		},
		SafeTimes = {
			Easy = 45,
			Normal = 50,
			Hard = 60, -- 75
			Severe = 60, -- 90
			Aberrant = 60, -- 100
			Freedom = 60,
		},
		Difficulty = {
			Easy = 2, -- Grade E+
			Normal = 5, -- Grade D+
			Hard = 8, -- Grade C+
			Severe = 11, -- Grade B+
			Aberrant = 14, -- Grade A+
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
		Special = { 3, 7, 40, 72, 76 },
		SecondaryBrandes = {
			{ Name = "Offense1", Start = 11, Finish = 13 },
			{ Name = "Offense2", Start = 14, Finish = 25 },
		},
		Brandes = {
			{ Name = "Offense", Start = 1, Finish = 11 },
			{ Name = "Support", Start = 70, Finish = 80 },
			{ Name = "Defense", Start = 38, Finish = 43 },
		},
	},
	Prestige = {
		[1] = {
			Level = 100,
			Gold = 0,
		},
		[2] = {
			Level = 125,
			Gold = 0,
		},
		[3] = {
			Level = 150,
			Gold = 50000000, -- 50M / 600M
		},
		[4] = {
			Level = 175,
			Gold = 800000000, -- 800M
		},
		[5] = {
			Level = 225,
			Gold = 0,https://github.com/Mangnex/Lunar-Hub/blob/main/Resoures/ATOR.lua
		},
	},
	Slashs = {
		Easy = 1,
		Normal = 1,
		Hard = 3,
		Severe = 3,
		Aberrant = 5,
		Freedom = 10,
	},
	GasTanks = {
		[13379349730] = workspace:FindFirstChild("Unclimbable"):FindFirstChild("Props"):FindFirstChild("HQ"), -- Shiganshina
		[13904207646] = workspace:FindFirstChild("Climbable"):FindFirstChild("_Walls"):FindFirstChild("Gate"), -- Outskirts
		[14638336319] = workspace:FindFirstChild("Unclimbable"):FindFirstChild("Camps"):FindFirstChild("Camp"), -- Forest
		[15220308770] = workspace:FindFirstChild("Climbable"):FindFirstChild("Utgard") -- Utgard
	}
	Codes = {
		-- Permanent
		["TERRA70K"] = {
			Level = 25,
		},
		["WZINS"] = {
			Level = 25,
		},
		-- Temporal
		["MEMBERS1M200K"] = {
			Level = 25,
		},
		["LIKES1M450K"] = {
			Level = 25,
		},
		["VISITS1B100M"] = {
			Level = 25,
		},
		["MEMBERS1M100K"] = {
			Level = 25,
		},
	},
}
