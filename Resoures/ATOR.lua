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
			["Evolution"] = 2,
			["Nightmare"] = 2,
			["Oddball"] = 2,
			["Time Trial"] = 2,
			["Fatigue"] = 2,
		},
		SafeTimes = {
			Easy = 45,
			Normal = 50,
			Hard = 75,
			Severe = 90,
			Aberrant = 100,
			Freedom = 55,
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
		Special = { 3, 7, 72, 74, 76 },
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
			Gold = 600000000, -- 600M
		},
		[4] = {
			Level = 175,
			Gold = 800000000, -- 800M
		},
		[5] = {
			Level = 225,
			Gold = 100000000, -- 1B
		},
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
		["UPDATE5"] = {
			Level = 0,
			Prestige = 1,
		},
	},
}
