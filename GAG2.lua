-- THIS SCRIPT IS NOT MINE, I JUST UPLOADED THERE

if type(getgenv) ~= "function" then
	local _env = _G
	getgenv = function()
		return _env
	end
end
pcall(function()
	local g = (getgenv and getgenv()) or _G
	if type(g) == "table" then
		g.GAG2_FARM_LOADED = true
	end
end)

local CFG = {
	configVersion = 16,
	scriptVersion = "10.13.0",
	autoStart = true,
	pipelineMode = true,
	fastFarm = true,
	farmActivePause = 0.08,
	farmIdlePause = 0.12,
	harvestLoopInterval = 0.05,
	harvestPassesPerCycle = 4,
	harvestTeleportStep = 8,
	actionFps = 60, -- FPS cap during harvest/collect/water bursts (idle stays at fpsCap)
	harvestClusterRange = 45, -- collect everything within this radius of one anchor (server allows ~55)
	maintenanceInterval = 14,
	petManagerInterval = 12,
	buyMaxSecondsActive = 2.5,
	cycleInterval = 2,
	minMoneyKeep = 500,
	inventoryLimit = 100,
	inventorySellAt = 92,
	harvestBatchSoftLimit = 88,
	harvestMaxPerCycle = 220,
	harvestLogTop = 8,
	onlyHarvestRipe = true,
	harvestDynamicMinRatio = 0.05,
	harvestDynamicMinWhenBestAbove = 500,
	buyGearWhenMoneyAbove = 50,
	gearMinMoneyReserve = 80000,
	wateringCanMinMoneyReserve = 3000,
	buySeedsFallbackBelowTier = false, -- never plant cheap junk (Strawberry sells 3); Bamboo backbone fills the plot
	buyFallbackOnlyBelowMoney = 20000,
	buyTrustFire = false,
	maxBuySeconds = 6,
	maxBuyAttemptsPerCycle = 4,
	seedBuyBlockSeconds = 90,
	buyCratesWhenMoneyAbove = 25000,
	autoExpandGarden = true,
	maxGardenExpansionBought = 20,
	antiAfkInterval = 60,
	-- Anti idle-kick (VirtualUser + micro-nudge). serverGuard = recover after server hop / respawn.
	antiKick = { enabled = true, nudgeInterval = 55, virtualUser = true, idleKickSec = 600 },
	serverGuard = { enabled = true, watchInterval = 4, recoverCooldown = 8, staleHeartbeatSec = 30 },
	maxActionDistance = 14,
	teleportHeight = 2.5,
	wateringCans = { "Super Watering Can", "Common Watering Can" },
	sprinklers = {
		-- Super is strictly better value than Legendary in current game data:
		-- Super $300k r55 growx5 sizeLuck100 vs Legendary $1.2m r40 growx4 sizeLuck65.
		"Super Sprinkler",
		"Rare Sprinkler",
		"Uncommon Sprinkler",
		"Common Sprinkler",
	},
	-- Never PLANT these (mail/event reserve). Already-planted crops are still harvested & sold.
	skipSeeds = { "Rainbow", "Gold" },
	eventOnlySeeds = { "Rainbow", "Gold" },
	priorityBuySeeds = {
		-- Bamboo is the backbone crop: cheap (~700), ALWAYS in stock (~80% restock),
		-- fast (120s prime), high value (sell 800, yield 7-11). The old maxOwned=6
		-- left a ~200-slot plot to fill with Strawberry (sell 3). Fill it with Bamboo.
		Bamboo = { minMoney = 700, maxPerCycle = 30, maxOwned = 400 },
		Mushroom = { minMoney = 12000, maxPerCycle = 5, maxOwned = 40 },
	},
	minBuySeedScore = 600, -- only buy seeds worth >= this (avg yield x sell); Bamboo=7200/GlowMushroom=700 pass, junk (Strawberry 13, Coconut 60, Tulip 210) fails
	-- never buy a seed whose shop price > score*ratio (blocks traps like Banana $30k)
	maxPriceScoreRatio = 8,
	-- Idle-capacity fill: expansions can grow the plot far past Bamboo's restock
	-- supply, leaving most of it empty (and capital idle) during Bamboo droughts.
	-- When the priority crop is out of stock AND real empty spots remain, plant the
	-- best in-stock affordable crop as a filler. Fillers are cleanupSeeds, so Bamboo
	-- reclaims their spots on the next restock. Relaxes minBuySeedScore but KEEPS the
	-- ROI gate, so trap seeds (Banana) stay blocked.
	fillIdleWithFallback = true,
	fallbackFillMinScore = 80, -- relaxed filler floor (Corn passes; pure trash blocked)
	fallbackFillMinFreeSpots = 20, -- only fill when >= this many spots are genuinely idle
	skipPlantBelowPrice = 0,
	skipHarvestBelowScore = 0,
	-- Harvest EVERYTHING ripe. The old high thresholds (150/80/40) skipped
	-- low-value fruit, which then sat ripe forever and clogged the plot so no
	-- new (good) seeds could be planted -> money bled. Always clearing the
	-- plot keeps it cycling; planting logic decides VALUE, harvest just clears.
	harvestScoreTiers = {
		{ money = 0, minScore = 0 },
	},
	maxSeedsPerCycle = 12,
	maxPlantsPerCycle = 24,
	plantFallbackBelowTier = true,
	sprinklerGridStep = 14,
	sprinklerMinDistance = 10,
	maxSprinklersPerCycle = 6,
	wildPetScanInterval = 0.25,
	wildPetRushInterval = 0.05,
	wildPetDetectEvery = 1,
	wildPetMaxTameAttempts = 4,
	wildPetRushAttempts = 20,
	wildPetTameDistance = 14,
	wildPetInstantListen = true,
	eventCollectInterval = 0.35,
	eventCollectIntervalWeather = 0.1,
	eventRushInterval = 0.06,
	eventRushSpawnWait = 0.03,
	eventInstantListen = true,
	eventBurstDuringWeather = true,
	eventBurstMaxSeconds = 6,
	eventMaxPerSweep = 24,
	eventReadyTimeout = 1.2,
	eventCollectDistance = 12,
	eventSpawnWait = 0.15,
	collectSeedPacks = true,
	logToFile = true,
	logToConsole = false,
	silent = true,
	verboseLogs = true,
	telemetryErrors = true,
	telemetryVerbose = false,
	telemetryStatusInterval = 120,
	logFlushInterval = 2,
	logMaxPending = 200,
	optimizeClient = true,
	optimizeInterval = 20,
	memoryTrimInterval = 120,
	lowPower = true,
	fpsCap = 8,
	disable3DRender = true,
	muteAudio = true,
	dashboard = { enabled = true, toggleKey = "RightShift", opacity = 1, liveInterval = 0.5 },
	harvestDebug = false,
	cleanupLowValuePlants = true,
	cleanupMoneyAbove = 3000,
	cleanupMinBestScore = 0,
	cleanupMaxPerCycle = 20,
	cleanupRetryCooldown = 45,
	cleanupOnlyWhenGardenFull = false, -- purge junk plants continuously to convert the plot to Bamboo/high-value faster
	cleanupReplacementMinScore = 1000,
	cleanupReplacementRatio = 0.5,
	cleanupSeeds = {
		Carrot = true,
		Blueberry = true,
		Apple = true,
		Strawberry = true,
		Tomato = true,
		Corn = true,
		Grape = true,
		Pineapple = true,
		Cactus = true,
		["Green Bean"] = true,
		Banana = true,
		Coconut = true,
		Tulip = true,
		["Baby Cactus"] = true,
		Mango = true,
		["Dragon Fruit"] = true,
	},
	harvestDebugInterval = 30,
	harvestDebugImportantSeeds = {
		Bamboo = true,
		Mushroom = true,
		["Moon Bloom"] = true,
		["Dragon's Breath"] = true,
		["Venus Fly Trap"] = true,
	},
	mail = {
		enabled = true,
		targetUsername = "xXDark_LumineXx",
		message = "Donation",
		autoClaim = true,
		claimCooldown = 8,
		maxClaimsPerCycle = 16,
		pets = { "Raccoon", "Dragonfly", "Unicorn" },
		seeds = { "Rainbow", "Gold" },
		minPetPriority = 70, -- mail any pet with priority >= this (covers Golden/variant rares)
		keepBestPetCount = 0,
		keepSeedMinCount = 0, -- farm accounts never plant Rainbow/Gold -> mail ALL of them
		maxPetsPerCycle = 18, -- batch up to ~18 pets in one SendBatch (server cap ~20 items/gift)
		maxSeedsPerCycle = 18, -- server caps a gift at ~20 items total (pets + seeds)
		maxPerSeed = 50,
		cooldown = 8, -- server gift cooldown ~10s; 8 keeps us ready without spamming
		loopInterval = 10,
	},
	-- Pet policy (overridable from getgenv). farm = pets equipped for utility
	-- (Deer = +10% grow speed). priority/keep = rare pets we always tame and
	-- mail to main (never equipped). Anything not listed here is ignored.
	pets = {
		farm = { "Deer" },
		priority = { "Raccoon", "Dragonfly", "Unicorn" },
	},
	smartPets = {
		maxPerCycle = 1,
		rushPriority = 70,
		rushMaxPerCycle = 10,
		rushMaxSpendFraction = 0.98,
		rushAttempts = 20,
		minPriorityForEmptySlot = 30,
		minUpgradeGain = 10,
		maxSpendFraction = 0.35,
		reserveFraction = 0.25,
		reserveFlat = 5000,
		skipCommonBelowPriority = 30,
		forceReequip = true,
	},
	enabled = {
		harvest = true,
		sell = true,
		plant = true,
		water = true,
		gear = true,
		buy = true,
		crates = true,
		expansion = true,
		antiAfk = true,
		events = true,
		pets = true,
		wildPets = true,
	},
	smartWater = {
		enabled = true,
		rewaterAfterMinutes = 8,
		sweepInterval = 8,
		maxPerSweep = 24,
		logEmptyEvery = 20,
	},
	moneyTiers = {
		{ money = 50000, minSeedPrice = 500 },
		{ money = 20000, minSeedPrice = 100 },
		{ money = 5000, minSeedPrice = 25 },
		{ money = 1000, minSeedPrice = 5 },
		{ money = 0, minSeedPrice = 0 },
	},
	-- Discord webhook routing is done SERVER-SIDE (URLs never live in this script).
	-- Client only reports natural catches; the license server decides where to forward.
	webhook = {
		reportPets = true, -- report naturally-obtained pets to the server
		detectNewPets = true, -- detect brand-new pet GUIDs (not only wild-tamed)
		mailSuppressSeconds = 60, -- treat new pets within N sec of mailbox activity as mail (skip)
	},
	-- snapshot pushed to getgenv().GAG2_STATS for the web cabinet / admin live view
	statsSnapshot = { enabled = true, interval = 4 },
}

-- A table is treated as a "list" (config array) when it has a [1] element or
-- is empty. Lists are REPLACED wholesale on merge (so shrinking e.g. mail.pets
-- in getgenv doesn't leave stale entries); dictionaries are merged recursively.
local function isConfigList(t)
	return type(t) == "table" and (t[1] ~= nil or next(t) == nil)
end

function deepMerge(dst, src)
	if type(src) ~= "table" then
		return dst
	end
	for k, v in pairs(src) do
		if type(v) == "table" and type(dst[k]) == "table" and not isConfigList(v) then
			deepMerge(dst[k], v)
		else
			dst[k] = v
		end
	end
	return dst
end

if getgenv then
	local env = getgenv()
	if type(env.GAG2_FARM_CFG) == "table" then
		-- применяем пользовательские настройки (даже частичные)
		deepMerge(CFG, env.GAG2_FARM_CFG)
	end
	env.GAG2_FARM_CFG = CFG
end

local function copyConfigValue(v)
	if type(v) ~= "table" then
		return v
	end
	if isConfigList(v) then
		local t = {}
		for i, x in ipairs(v) do
			t[i] = x
		end
		return t
	end
	local out = {}
	for k, x in pairs(v) do
		out[k] = copyConfigValue(x)
	end
	return out
end

local REMOTE_CFG_ROOTS = { "mail", "pets", "skipSeeds", "eventOnlySeeds", "enabled" }

function exportRemoteFarmConfig()
	local out = {}
	for _, root in ipairs(REMOTE_CFG_ROOTS) do
		if CFG[root] ~= nil then
			out[root] = copyConfigValue(CFG[root])
		end
	end
	return out
end

function applyRemoteFarmConfig(overlay)
	if type(overlay) ~= "table" then
		return false
	end
	deepMerge(CFG, overlay)
	if getgenv then
		getgenv().GAG2_FARM_CFG = CFG
	end
	if type(invalidatePetPolicyCache) == "function" then
		invalidatePetPolicyCache()
	end
	if wr then
		wr("[CFG] remote config applied")
	end
	return true
end

if getgenv then
	getgenv().GAG2_EXPORT_FARM_CFG = exportRemoteFarmConfig
	getgenv().GAG2_APPLY_FARM_CFG = applyRemoteFarmConfig
	if type(getgenv().GAG2_PENDING_FARM_CFG) == "table" then
		applyRemoteFarmConfig(getgenv().GAG2_PENDING_FARM_CFG)
		getgenv().GAG2_PENDING_FARM_CFG = nil
	end
end

function applyLowPowerProfile()
	if not CFG.lowPower then
		return
	end
	if CFG.verboseLogs then
		CFG.silent = false
		CFG.logToConsole = CFG.logToConsole ~= false
		CFG.logToFile = CFG.logToFile ~= false
		CFG.logFlushInterval = math.min(tonumber(CFG.logFlushInterval) or 2, 4)
		CFG.logMaxPending = math.max(tonumber(CFG.logMaxPending) or 200, 120)
	else
		CFG.silent = CFG.silent ~= false
		CFG.logToConsole = false
		CFG.logToFile = false
	end
	if not CFG.fastFarm then
		CFG.farmActivePause = math.max(tonumber(CFG.farmActivePause) or 0.2, 0.35)
		CFG.farmIdlePause = math.max(tonumber(CFG.farmIdlePause) or 0.75, 1.1)
		CFG.harvestMaxPerCycle = math.min(tonumber(CFG.harvestMaxPerCycle) or 88, 48)
		CFG.harvestBatchSoftLimit = math.min(tonumber(CFG.harvestBatchSoftLimit) or 88, 48)
		CFG.maxPlantsPerCycle = math.min(tonumber(CFG.maxPlantsPerCycle) or 24, 14)
		CFG.maxSeedsPerCycle = math.min(tonumber(CFG.maxSeedsPerCycle) or 12, 8)
	end
	-- wild pets stay fast even in low-power (Raccoon/Dragonfly sniping)
	CFG.wildPetScanInterval = math.min(tonumber(CFG.wildPetScanInterval) or 0.35, 0.45)
	CFG.wildPetRushInterval = math.min(tonumber(CFG.wildPetRushInterval) or 0.1, 0.15)
	CFG.petManagerInterval = math.max(tonumber(CFG.petManagerInterval) or 12, 14)
	CFG.maintenanceInterval = math.max(tonumber(CFG.maintenanceInterval) or 14, 16)
	-- Rainbow/Gold + event collection stays at FULL speed in low-power (like wild-pet
	-- sniping) so overnight farming earns the same — only rendering/FPS is throttled.
	CFG.eventRushInterval = math.min(tonumber(CFG.eventRushInterval) or 0.06, 0.08)
	CFG.eventCollectIntervalWeather = math.min(tonumber(CFG.eventCollectIntervalWeather) or 0.1, 0.12)
	CFG.eventCollectInterval = math.min(tonumber(CFG.eventCollectInterval) or 0.35, 0.4)
	-- eventMaxPerSweep intentionally NOT reduced in low-power (was capped to 16).
	CFG.optimizeInterval = math.max(tonumber(CFG.optimizeInterval) or 20, 120)
	CFG.logFlushInterval = math.max(tonumber(CFG.logFlushInterval) or 2, 30)
	CFG.logMaxPending = math.min(tonumber(CFG.logMaxPending) or 200, 40)
	CFG.memoryTrimInterval = math.max(tonumber(CFG.memoryTrimInterval) or 120, 60)
	CFG.fpsCap = math.min(tonumber(CFG.fpsCap) or 8, 6)
	CFG.maintenanceInterval = math.max(tonumber(CFG.maintenanceInterval) or 14, 20)
	CFG.petManagerInterval = math.max(tonumber(CFG.petManagerInterval) or 12, 18)
	if type(CFG.dashboard) == "table" then
		CFG.dashboard.enabled = CFG.dashboard.enabled ~= false
		CFG.dashboard.liveInterval = math.max(tonumber(CFG.dashboard.liveInterval) or 0.5, 1.5)
	end
	if type(CFG.statsSnapshot) == "table" then
		CFG.statsSnapshot.interval = math.max(tonumber(CFG.statsSnapshot.interval) or 4, 20)
	end
	if type(CFG.mail) == "table" then
		CFG.mail.cooldown = math.min(tonumber(CFG.mail.cooldown) or 60, 45)
		CFG.mail.maxSeedsPerCycle = math.max(tonumber(CFG.mail.maxSeedsPerCycle) or 10, 15)
	end
end

function applyFastFarmProfile()
	if CFG.fastFarm == false then
		return
	end
	CFG.farmActivePause = math.min(tonumber(CFG.farmActivePause) or 0.08, 0.08)
	CFG.farmIdlePause = math.min(tonumber(CFG.farmIdlePause) or 0.12, 0.12)
	CFG.harvestMaxPerCycle = math.max(tonumber(CFG.harvestMaxPerCycle) or 100, 100)
	CFG.harvestBatchSoftLimit = math.max(tonumber(CFG.harvestBatchSoftLimit) or 100, 100)
	CFG.harvestLoopInterval = math.min(tonumber(CFG.harvestLoopInterval) or 0.05, 0.08)
	CFG.harvestPassesPerCycle = math.max(tonumber(CFG.harvestPassesPerCycle) or 4, 3)
	CFG.maxPlantsPerCycle = math.max(tonumber(CFG.maxPlantsPerCycle) or 24, 20)
	CFG.maxSeedsPerCycle = math.max(tonumber(CFG.maxSeedsPerCycle) or 12, 10)
	CFG.harvestTeleportStep = math.min(tonumber(CFG.harvestTeleportStep) or 8, 5)
end

applyLowPowerProfile()
applyFastFarmProfile()

getgenv().GAG2_HOOKS = {}
getgenv().GAG2_HOOK_GEN = (getgenv().GAG2_HOOK_GEN or 0) + 1
local HOOK_GEN = getgenv().GAG2_HOOK_GEN

pcall(function()
	if type(getgenv().GAG2_FARM_STOP) == "function" then
		getgenv().GAG2_FARM_STOP()
	end
end)
getgenv().GAG2_FARM_GEN = (getgenv().GAG2_FARM_GEN or 0) + 1
local FARM_GEN = getgenv().GAG2_FARM_GEN

function farmGenActive()
	return (getgenv().GAG2_FARM_GEN or 0) == FARM_GEN
end

local FARM_STATE = getgenv().GAG2_FARM_STATE
if type(FARM_STATE) ~= "table" then
	FARM_STATE = {
		running = false,
		events = false,
		wild = false,
		live = false,
		maintenance = false,
		petsMgr = false,
		harvest = false,
	}
end
getgenv().GAG2_FARM_STATE = FARM_STATE

function getFarmState()
	local st = getgenv().GAG2_FARM_STATE
	if type(st) ~= "table" then
		return nil
	end
	return st
end

function hookStillActive()
	return (getgenv().GAG2_HOOK_GEN or 0) == HOOK_GEN
end

local PET_PRIORITY = {
	Raccoon = 100,
	Unicorn = 95,
	["Golden Dragonfly"] = 90,
	GoldenDragonfly = 90,
	Dragonfly = 85,
	["Black Dragon"] = 80,
	BlackDragon = 80,
	["Ice Serpent"] = 75,
	IceSerpent = 75,
	Bee = 70,
	Owl = 40,
	Deer = 35,
	Monkey = 30,
	Robin = 28,
	Frog = 20,
	Bunny = 15,
}

-- Portal dropdown catalog (license server parses this table on deploy — add new pets here)
local GAG2_PORTAL_PETS = {
	"Raccoon",
	"Unicorn",
	"Dragonfly",
	"Golden Dragonfly",
	"Black Dragon",
	"Ice Serpent",
	"Bee",
	"Queen Bee",
	"Disco Bee",
	"Honey Bee",
	"Bear Bee",
	"Petal Bee",
	"Golden Bee",
	"Butterfly",
	"Mimic Octopus",
	"Red Fox",
	"Fennec Fox",
	"Hedgehog",
	"Blood Hedgehog",
	"Kitsune",
	"Corrupted Kitsune",
	"Owl",
	"Night Owl",
	"Cooked Owl",
	"Dog",
	"Cat",
	"Bunny",
	"Golden Lab",
	"Black Bunny",
	"Moon Cat",
	"Chicken",
	"Deer",
	"Spotted Deer",
	"Frog",
	"Echo Frog",
	"Snail",
	"Monkey",
	"Silver Monkey",
	"Giant Ant",
	"Praying Mantis",
	"Caterpillar",
	"Pig",
	"Rooster",
	"Squirrel",
	"Turtle",
	"Sea Otter",
	"Polar Bear",
	"Grey Mouse",
	"Brown Mouse",
	"Hyacinth Macaw",
	"Scarlet Macaw",
	"Toucan",
	"Capybara",
	"Pterodactyl",
	"Triceratops",
	"Dilophosaurus",
	"Stegosaurus",
	"Brontosaurus",
	"Raptor",
	"Tyrannosaurus Rex",
}

-- Real price multipliers from SharedModules.MutationData (verified in-game 2026-06).
-- The old values (Bloodlit 4, Starstruck 6, Electric 3, Frozen 3) massively
-- UNDERvalued mutated fruit, so the bot deprioritised/cleaned away 50-60x plants.
local MUTATION_MULT = {
	Bloodlit = 60,
	Starstruck = 50,
	Rainbow = 30,
	Electric = 25,
	Frozen = 14,
	Gold = 10,
	Golden = 10,
	Chained = 8,
}

local SEED_DATA = setmetatable({
	Apple = { yield = { 1, 1 }, price = 5 },
	Banana = { yield = { 1, 1 }, price = 5 },
	Grape = { yield = { 1, 1 }, price = 5 },
	Carrot = { yield = { 3, 4 }, price = 10 },
	Strawberry = { yield = { 4, 5 }, price = 15 },
	Blueberry = { yield = { 1, 2 }, price = 8 },
	Tulip = { yield = { 3, 4 }, price = 12 },
	Tomato = { yield = { 2, 3 }, price = 10 },
	Corn = { yield = { 1, 1 }, price = 5 },
	Cactus = { yield = { 1, 2 }, price = 8 },
	Pineapple = { yield = { 1, 3 }, price = 15 },
	Mushroom = { yield = { 2, 5 }, price = 20 },
	Bamboo = { yield = { 7, 11 }, price = 50 },
	Sunflower = { yield = { 1, 1 }, price = 10 },
	Coconut = { yield = { 1, 1 }, price = 10 },
	Mango = { yield = { 1, 1 }, price = 15 },
	Cherry = { yield = { 1, 1 }, price = 15 },
	Acorn = { yield = { 1, 3 }, price = 20 },
	["Green Bean"] = { yield = { 1, 2 }, price = 15 },
	["Dragon Fruit"] = { yield = { 1, 1 }, price = 30 },
	Pomegranate = { yield = { 1, 1 }, price = 25 },
	["Venus Fly Trap"] = { yield = { 1, 1 }, price = 50 },
	["Poison Apple"] = { yield = { 1, 1 }, price = 40 },
	["Moon Bloom"] = { yield = { 1, 1 }, price = 60 },
	["Dragon's Breath"] = { yield = { 1, 1 }, price = 100 },
	["Ghost Pepper"] = { yield = { 1, 1 }, price = 80 },
	["Poison Ivy"] = { yield = { 1, 1 }, price = 75 },
	["Baby Cactus"] = { yield = { 1, 1 }, price = 50 },
	["Glow Mushroom"] = { yield = { 1, 1 }, price = 100 },
	Romanesco = { yield = { 1, 1 }, price = 80 },
	["Horned Melon"] = { yield = { 1, 1 }, price = 120 },
	Gold = { yield = { 1, 1 }, price = 500 },
	Rainbow = { yield = { 1, 1 }, price = 1000 },
}, {
	__index = function()
		return { yield = { 1, 1 }, price = 10 }
	end,
})

function normalizeSeedName(raw)
	if type(raw) ~= "string" or raw == "" then
		return nil
	end
	if SEED_DATA[raw] then
		return raw
	end
	local lower = raw:lower()
	for name in pairs(SEED_DATA) do
		if name:lower() == lower then
			return name
		end
	end
	-- event drops often arrive as "Rainbow Seed" / "Gold Seed" in tools or inventory
	local base = lower:gsub("%s+seed%s*$", "")
	if base == "golden" then
		base = "gold"
	end
	if base ~= lower then
		for name in pairs(SEED_DATA) do
			if name:lower() == base then
				return name
			end
		end
	end
	return raw
end

local GEAR_PRICES = {}
local EXPANSION_PRICES = {}
local SELL_VALUES = {
	Carrot = 5,
	Strawberry = 3,
	Tomato = 9,
	Blueberry = 5,
	Apple = 12,
	Pinetree = 100,
	Bamboo = 800,
	Pumpkin = 350,
	Cactus = 40,
	Pineapple = 30,
	["Green Bean"] = 10,
	Banana = 35,
	Grape = 45,
	Mushroom = 13000,
	Coconut = 60,
	Mango = 90,
	["Thorn Rose"] = 140,
	["Dragon Fruit"] = 150,
	Acorn = 200,
	Cherry = 350,
	Sunflower = 1750,
	["Venus Fly Trap"] = 3000,
	Lotus = 6500,
	Pomegranate = 900,
	Beanstalk = 2000,
	["Poison Apple"] = 900,
	["Moon Bloom"] = 9000,
	["Dragon's Breath"] = 3400,
	["Poison Ivy"] = 1700,
	["Glow Mushroom"] = 700,
	["Ghost Pepper"] = 2500,
	["Horned Melon"] = 200,
	Corn = 34,
	["Baby Cactus"] = 70,
	Tulip = 60,
	Romanesco = 1500,
}
local CollectionService = game:GetService("CollectionService")
local RS = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local LP = Players.LocalPlayer
while not LP do
	task.wait(0.05)
	LP = Players.LocalPlayer
end

local SharedModules, Gardens, NET
local NET_OK = false

local ownedPetCache = {}
local petIdByName = {}
local petIdToName = {}
local petIdsByName = {}
local petEquipKeyByName = {}
-- PetEquipController maps some pets to top-level inventory folders (e.g. Raccoon -> Raccoons).
local PET_INV_ALT_FOLDERS = { Raccoon = "Raccoons" }
local petEquipFailUntil = {}
local seedPriority = {}
local lastEquippedTarget = {}

local logFolder = "GAG2_FARM_LOGS"
local logFileName = "gag2_farm_" .. tostring(LP.UserId) .. ".log"
local logPath = logFolder .. "/" .. logFileName
local logFallbackPath = logFileName
local petCacheFileName = "gag2_pets_" .. tostring(LP.UserId) .. ".txt"
local petCachePath = logFolder .. "/" .. petCacheFileName
local petCacheLegacyPath = petCacheFileName
local petCacheSavePending = false
local lastPetCacheSave = 0
local lastLogFlush = 0
local pendingLog = {}
local fullLogCache = ""
local logInitDone = false
local logWarned = false

function ensureLogFolder()
	if makefolder and (not isfolder or not isfolder(logFolder)) then
		pcall(makefolder, logFolder)
	end
end

function cleanupLegacyPetWorkspaceFiles()
	if not delfile or not isfile then
		return
	end
	local removed = 0
	local function tryDelete(path)
		if isfile(path) then
			pcall(delfile, path)
			removed = removed + 1
		end
	end
	-- Old single-file cache at workspace root (content was Bunny/Deer/Frog/Owl lines).
	tryDelete(petCacheLegacyPath)
	-- Some executors created one file per pet name from older builds — purge them.
	for name in pairs(PET_PRIORITY) do
		tryDelete(name)
		tryDelete(name .. ".txt")
	end
	if removed > 0 then
		wr(string.format("[CFG] cleaned %d legacy pet file(s) from workspace root", removed))
	end
end

function initLogFile()
	if logInitDone then
		return
	end
	logInitDone = true
	if not CFG.logToFile or not writefile then
		return
	end
	ensureLogFolder()
	local header = string.format("\n=== GAG2 Farm log start %s user=%d ===\n", os.date("%Y-%m-%d %H:%M:%S"), LP.UserId)
	pcall(writefile, logPath, header)
	pcall(writefile, logFallbackPath, header)
end

function flushLogs(force)
	if not CFG.logToFile or not writefile then
		return
	end
	initLogFile()
	if not force and os.clock() - lastLogFlush < CFG.logFlushInterval then
		return
	end
	if #pendingLog == 0 then
		return
	end
	lastLogFlush = os.clock()
	local chunk = table.concat(pendingLog, "\n") .. "\n"
	table.clear(pendingLog)
	local ok1, ok2
	if appendfile then
		ok1 = pcall(appendfile, logPath, chunk)
		ok2 = pcall(appendfile, logFallbackPath, chunk)
	else
		fullLogCache = fullLogCache .. chunk
		ok1 = pcall(writefile, logPath, fullLogCache)
		ok2 = pcall(writefile, logFallbackPath, fullLogCache)
	end
	if not ok1 and not ok2 and not logWarned then
		logWarned = true
		warn("[FARM] log write failed: executor file API rejected writefile/appendfile")
	end
end

-- ==========================================================================
--  Telemetry -> license server (errors with stack + context for admin panel)
-- ==========================================================================
local telemetryDedup = {}

function traceErr(err, level)
	level = level or 2
	if debug and debug.traceback then
		return debug.traceback(tostring(err), level)
	end
	return tostring(err)
end

function shouldReportTelemetry(msg, level)
	if level == "fatal" then
		return true
	end
	if level == "error" and CFG.telemetryErrors ~= false then
		return true
	end
	if not CFG.telemetryVerbose then
		return false
	end
	if level == "warn" then
		return true
	end
	local s = tostring(msg):lower()
	return s:find("exception", 1, true) or s:find("crash", 1, true)
end

function installGlobalErrorReporter()
	if getgenv().GAG2_ERROR_HOOK then
		return
	end
	getgenv().GAG2_ERROR_HOOK = true
	pcall(function()
		game:GetService("ScriptContext").Error:Connect(function(msg, trace)
			if CFG.telemetryErrors == false then
				return
			end
			local text = tostring(msg)
			if not text:find("GAG2", 1, true) and not text:find("FARM", 1, true) then
				return
			end
			reportTelemetry({
				level = "fatal",
				message = text:sub(1, 500),
				stack = type(trace) == "string" and trace:sub(1, 4000) or nil,
				context = { phase = "ScriptContext" },
			})
		end)
	end)
end

function safeDefer(label, fn)
	task.defer(function()
		if not hookStillActive() then
			return
		end
		local ok, err = xpcall(fn, traceErr)
		if not ok then
			reportTelemetry({
				level = "fatal",
				message = tostring(label) .. ": " .. tostring(err),
				stack = tostring(err),
				context = { phase = label },
			})
		end
	end)
end

function buildTelemetryContext(extra)
	local ctx = {
		scriptVersion = CFG.scriptVersion,
		cycle = STATS and STATS.cycles or 0,
		money = STATS and STATS.money or 0,
		lastStatus = STATS and STATS.lastStatus or "",
		user = LP and LP.Name or nil,
		userId = LP and LP.UserId or nil,
		placeId = game.PlaceId,
		jobId = game.JobId,
		netOk = NET_OK == true,
		plot = LP and LP:GetAttribute("PlotId") or nil,
		mailTarget = CFG.mail and CFG.mail.targetUsername or nil,
		uptimeSec = STATS and math.floor(os.clock() - (STATS.startClock or os.clock())) or 0,
	}
	if type(extra) == "table" then
		for k, v in pairs(extra) do
			ctx[k] = v
		end
	end
	return ctx
end

function reportTelemetry(opts)
	opts = opts or {}
	local level = opts.level or "error"
	local message = tostring(opts.message or opts.msg or "unknown")
	if message == "" then
		return
	end

	local sig = level .. "|" .. message:sub(1, 160)
	local now = os.clock()
	if telemetryDedup[sig] and (now - telemetryDedup[sig]) < 25 then
		return
	end
	telemetryDedup[sig] = now

	local stack = opts.stack or opts.trace
	if not stack and (level == "error" or level == "fatal") then
		stack = traceErr(message, 3)
	end

	local fn = getgenv().GAG2_REPORT_TELEMETRY
	if type(fn) ~= "function" then
		if CFG.telemetryErrors or CFG.verboseLogs then
			wr("[TELEM] reporter missing — runtime not loaded yet")
		end
		return
	end
	pcall(fn, {
		type = "telemetry",
		level = level,
		message = message,
		stack = stack,
		context = buildTelemetryContext(opts.context),
		ts = os.time(),
	})
end

function wr(msg)
	local toConsole = CFG.verboseLogs or (CFG.logToConsole and not CFG.silent)
	if toConsole then
		print(msg)
	end
	if not CFG.logToFile then
		return
	end
	local line = os.date("%H:%M:%S") .. " -- " .. tostring(msg)
	table.insert(pendingLog, line)
	local cap = tonumber(CFG.logMaxPending) or 200
	while #pendingLog > cap do
		table.remove(pendingLog, 1)
	end
	flushLogs(false)
end

function skipLoadingScreen()
	pcall(function()
		LP:SetAttribute("LoadingScreenActive", false)
	end)
	pcall(function()
		LP:SetAttribute("LoadingScreenDone", true)
	end)
	pcall(function()
		local gui = LP:FindFirstChild("PlayerGui")
		if not gui then
			return
		end
		for _, c in gui:GetChildren() do
			if c:IsA("ScreenGui") then
				local n = c.Name:lower()
				if n:find("loading") or c:GetAttribute("LoadingScreen") then
					c.Enabled = false
				end
			end
		end
	end)
	pcall(function()
		local cam = workspace.CurrentCamera
		if cam and cam.CameraType == Enum.CameraType.Scriptable then
			cam.CameraType = Enum.CameraType.Custom
		end
		local lsc = cam and cam:FindFirstChild("LoadingScreenCam")
		if lsc then
			lsc:Destroy()
		end
	end)
end

function waitForChildTimeout(parent, name, timeoutSec)
	local existing = parent:FindFirstChild(name)
	if existing then
		return existing
	end
	return parent:WaitForChild(name, timeoutSec)
end

function waitForCoreAssets(timeoutSec)
	timeoutSec = timeoutSec or 120
	local deadline = os.clock() + timeoutSec
	wr("[BOOT] Waiting for ReplicatedStorage.SharedModules...")
	skipLoadingScreen()

	local sm
	while os.clock() < deadline do
		skipLoadingScreen()
		sm = RS:FindFirstChild("SharedModules")
		if sm then
			break
		end
		task.wait(0.25)
	end
	if not sm then
		sm = waitForChildTimeout(RS, "SharedModules", math.max(1, deadline - os.clock()))
	end
	if not sm then
		wr("[BOOT] ERROR: SharedModules missing — game not loaded")
		return nil, nil, nil
	end

	local gardens = workspace:FindFirstChild("Gardens")
		or waitForChildTimeout(workspace, "Gardens", math.max(1, deadline - os.clock()))

	if not LP.Character then
		pcall(function()
			LP.CharacterAdded:Wait()
		end)
	end

	skipLoadingScreen()
	pcall(function()
		LP:SetAttribute("LoadingScreenDone", true)
	end)

	local netMod = waitForChildTimeout(sm, "Networking", math.max(1, deadline - os.clock()))
	local net
	if netMod then
		local ok, result = pcall(require, netMod)
		if ok then
			net = result
		end
	end

	wr(string.format("[BOOT] Core assets OK (NET=%s Gardens=%s)", net and "yes" or "no", gardens and "yes" or "no"))
	return sm, gardens, net
end

SharedModules, Gardens, NET = waitForCoreAssets(120)
NET_OK = NET ~= nil

function saveOwnedPets(force)
	if not writefile then
		return
	end
	local now = os.clock()
	if not force and now - lastPetCacheSave < 5 then
		petCacheSavePending = true
		return
	end
	lastPetCacheSave = now
	petCacheSavePending = false
	ensureLogFolder()
	local list = {}
	-- Persist only farm/priority pets — never Bunny/Owl/Frog junk in workspace files.
	for name in pairs(ownedPetCache) do
		if isWantedPet(name) then
			table.insert(list, name)
		end
	end
	table.sort(list)
	pcall(writefile, petCachePath, table.concat(list, "\n"))
end

function loadOwnedPets()
	if not readfile or not isfile then
		return
	end
	cleanupLegacyPetWorkspaceFiles()
	local path = isfile(petCachePath) and petCachePath or petCacheLegacyPath
	if not isfile(path) then
		return
	end
	local ok, data = pcall(readfile, path)
	if not ok or type(data) ~= "string" then
		return
	end
	for line in data:gmatch("[^\r\n]+") do
		local name = line:match("^%s*(.-)%s*$")
		if name ~= "" then
			ownedPetCache[name] = true
		end
	end
end

loadOwnedPets()

local STATS = {
	startClock = os.clock(),
	startMoney = nil,
	money = 0,
	inv = 0,
	invLimit = CFG.inventoryLimit,
	harvested = 0,
	soldCount = 0,
	soldValue = 0,
	bought = 0,
	planted = 0,
	petsEquipped = {},
	bestPets = "-",
	cycles = 0,
	lastStatus = "starting...",
	mailStatus = "pending",
	weather = "",
	eventSeeds = {},
	eventSeedsLine = "-",
}

function getPetPriority(name)
	if not name then
		return 0
	end
	return PET_PRIORITY[name] or PET_PRIORITY[name:gsub("%s+", "")] or 0
end

function countKnownPets()
	local n = 0
	for name in pairs(ownedPetCache) do
		if isWantedPet(name) then
			n = n + 1
		end
	end
	return n
end

function getPetUpgradeFloor()
	local maxSlots = LP:GetAttribute("MaxEquippedPets") or 3
	local priorities = {}
	for name in pairs(ownedPetCache) do
		table.insert(priorities, getPetPriority(name))
	end
	table.sort(priorities, function(a, b)
		return a > b
	end)
	if #priorities < maxSlots then
		return 0, maxSlots - #priorities
	end
	return priorities[maxSlots] or 0, 0
end

-- skipSeeds gate: block planting only. Harvest/sell ignores this list.
function isNoPlantSeed(name)
	if type(name) ~= "string" or name == "" then
		return false
	end
	local norm = normalizeSeedName(name) or name
	for _, sn in ipairs(CFG.skipSeeds or {}) do
		if sn == name or sn == norm then
			return true
		end
	end
	return false
end

function shouldPlantSeed(name)
	return not isNoPlantSeed(name)
end

function isEventOnlySeed(name)
	for _, sn in ipairs(CFG.eventOnlySeeds or { "Rainbow", "Gold" }) do
		if sn == name then
			return true
		end
	end
	return false
end

function isShopBuyBlocked(name)
	return isEventOnlySeed(name)
end

function getPriorityBuyCfg(name)
	local list = CFG.priorityBuySeeds
	if type(list) ~= "table" then
		return nil
	end
	local cfg = list[name]
	if type(cfg) == "table" then
		return cfg
	end
	for _, entry in ipairs(list) do
		if type(entry) == "string" and entry == name then
			return {}
		end
		if type(entry) == "table" and entry.seed == name then
			return entry
		end
	end
	return nil
end

function reprice()
	local scored = {}
	for name, data in pairs(SEED_DATA) do
		if isNoPlantSeed(name) then
			continue
		end
		local avg = (data.yield[1] + data.yield[2]) / 2
		local sellValue = SELL_VALUES[name] or data.price
		table.insert(scored, { name = name, pps = avg * sellValue, price = data.price })
	end
	table.sort(scored, function(a, b)
		if a.pps ~= b.pps then
			return a.pps > b.pps
		end
		return a.price > b.price
	end)
	seedPriority = {}
	for _, s in ipairs(scored) do
		table.insert(seedPriority, s.name)
	end
	if scored[1] then
		wr(
			string.format(
				"[CFG] Top seeds: %s(%.0f) %s(%.0f) %s(%.0f)",
				scored[1].name,
				scored[1].pps,
				scored[2] and scored[2].name or "-",
				scored[2] and scored[2].pps or 0,
				scored[3] and scored[3].name or "-",
				scored[3] and scored[3].pps or 0
			)
		)
	end
end

function loadPrices()
	if not SharedModules then
		return
	end
	local mod = SharedModules:FindFirstChild("SeedData")
	if mod then
		local ok, data = pcall(require, mod)
		if ok and type(data) == "table" then
			local n = 0
			for _, v in pairs(data) do
				if type(v) == "table" and v.SeedName and v.PurchasePrice and SEED_DATA[v.SeedName] then
					SEED_DATA[v.SeedName].price = v.PurchasePrice
					n = n + 1
				end
			end
			if n > 0 then
				wr(string.format("[CFG] Loaded %d seed prices", n))
			end
		end
	end
	local mod2 = SharedModules:FindFirstChild("GearShopData")
	if mod2 then
		local ok, data = pcall(require, mod2)
		if ok and type(data) == "table" and type(data.Data) == "table" then
			for _, item in pairs(data.Data) do
				if type(item) == "table" and item.ItemName and item.Cost then
					GEAR_PRICES[item.ItemName] = item.Cost
				end
			end
			wr("[CFG] Loaded gear prices")
		end
	end
	local sharedData = RS:FindFirstChild("SharedData")
	local expMod = sharedData and sharedData:FindFirstChild("ExpansionPrices")
	if expMod then
		local ok3, mod3 = pcall(require, expMod)
		if ok3 and type(mod3) == "table" then
			for i, entry in ipairs(mod3) do
				if type(entry) == "table" and entry.Price then
					EXPANSION_PRICES[i] = entry.Price
				end
			end
			if #EXPANSION_PRICES > 0 then
				wr(string.format("[EXPAND] Loaded %d expansion prices", #EXPANSION_PRICES))
			end
		end
	end
	if #EXPANSION_PRICES == 0 then
		EXPANSION_PRICES = { 5000, 25000, 100000, 500000, 2500000 }
	end
	local sellMod = SharedModules:FindFirstChild("SellValueData")
	if sellMod then
		local ok4, sellData = pcall(require, sellMod)
		if ok4 and type(sellData) == "table" then
			for k, v in pairs(sellData) do
				if type(v) == "number" then
					SELL_VALUES[k] = v
				end
			end
		end
	end
end

if SharedModules then
	loadPrices()
	reprice()
else
	wr("[BOOT] Skipped price load — SharedModules unavailable")
end

function isFailMessage(v)
	if v == false then
		return true
	end
	if v == nil then
		return false
	end
	if type(v) == "string" then
		local lo = v:lower()
		if
			lo:find("fail")
			or lo:find("error")
			or lo:find("invalid")
			or lo:find("denied")
			or lo:find("reject")
			or lo:find("cannot")
			or lo:find("can't")
			or lo:find("too far")
			or lo:find("cooldown")
			or lo:find("wait")
			or lo:find("not ")
			or lo:find("no inventory")
		then
			return true
		end
	end
	if type(v) == "table" then
		if v.Success == false or v.Ok == false then
			return true
		end
		if type(v.Reason) == "string" and isFailMessage(v.Reason) then
			return true
		end
		if type(v.Error) == "string" and isFailMessage(v.Error) then
			return true
		end
	end
	return false
end

function callRemote(remote, ...)
	if not remote then
		return false, nil, "no remote"
	end
	local fn = remote.Invoke or remote.Fire
	if not fn then
		return false, nil, "no fn"
	end
	local ok, a, b, c = pcall(fn, remote, ...)
	if not ok then
		return false, nil, tostring(a)
	end
	-- Mailbox SendBatch/Claim return (success:boolean, errMsg:string)
	if type(a) == "boolean" then
		if a then
			return true, a, b
		end
		return false, a, tostring(b or "remote rejected")
	end
	if isFailMessage(a) then
		return false, a, tostring(a)
	end
	if isFailMessage(b) then
		return false, b, tostring(b)
	end
	return true, a, nil
end

function getPetNet()
	return NET and (NET.Pets or (NET.Actions and NET.Actions.Pets))
end

function getMailNet()
	if not NET then
		return nil
	end
	if NET.Mailbox then
		return NET.Mailbox
	end
	if NET.Actions and NET.Actions.Mailbox then
		return NET.Actions.Mailbox
	end
	return nil
end

function normalizeMailUsername(raw)
	if type(raw) ~= "string" then
		return ""
	end
	local name = raw:gsub("^%s*@?", ""):gsub("%s+$", "")
	return name
end

function findMyPlot()
	if not Gardens then
		return nil
	end
	for _, p in Gardens:GetChildren() do
		if p:GetAttribute("OwnerUserId") == LP.UserId then
			return p
		end
	end
end

function getPlotId(plot)
	if not plot then
		return 0
	end
	local n = plot.Name:match("Plot(%d+)")
	return n and tonumber(n) or 0
end

function getPlotRemoteIds(plot)
	local ids, seen = {}, {}
	local function add(v)
		v = tonumber(v)
		if v and v >= 0 and not seen[v] then
			seen[v] = true
			table.insert(ids, v)
		end
	end
	add(LP:GetAttribute("PlotId"))
	local plotId = getPlotId(plot)
	add(plotId - 1) -- SimpleSpy for Plot4 showed trailing \003.
	add(plotId)
	if #ids == 0 then
		add(0)
	end
	return ids
end

function getMoney()
	local ls = LP:FindFirstChild("leaderstats")
	local s = ls and ls:FindFirstChild("Sheckles")
	return s and s.Value or 0
end

function getBuyMoneyReserve(forPrice)
	forPrice = forPrice or 0
	local money = getMoney()
	local keep = CFG.minMoneyKeep or 0
	if LP:GetAttribute("TutorialComplete") == false then
		return 0
	end
	if CollectionService:HasTag(LP, "InTutorial") then
		return 0
	end
	if money < keep + forPrice then
		return math.max(0, money - forPrice)
	end
	return keep
end

function canAffordSeed(price)
	return getMoney() >= price + getBuyMoneyReserve(price)
end

function getHRP()
	local char = LP.Character
	return char and char:FindFirstChild("HumanoidRootPart")
end

function distTo(pos)
	local hrp = getHRP()
	if not hrp then
		return math.huge
	end
	return (hrp.Position - pos).Magnitude
end

function teleportNear(pos, maxDist)
	maxDist = maxDist or CFG.maxActionDistance
	local hrp = getHRP()
	if not hrp then
		return false
	end
	if distTo(pos) <= maxDist then
		return true
	end
	hrp.CFrame = CFrame.new(pos)
	task.wait(0.06)
	return distTo(pos) <= maxDist + 4
end

-- ===== Action FPS burst + paced firing (perf-critical) =====
-- lowPower idles at a low FPS cap to save CPU, but the Packet networking layer
-- coalesces multiple Fires issued in the SAME frame into one (only ~1 lands).
-- So action throughput is FPS-bound. We briefly raise the cap during action
-- bursts (harvest/collect/water) and yield one frame between fires so each lands.
local _RunSvc = game:GetService("RunService")
local _burstDepth, _idleFps = 0, nil
function fpsBurstBegin()
	if type(setfpscap) ~= "function" then
		return
	end
	if _burstDepth == 0 then
		_idleFps = (CFG.fpsCap and CFG.fpsCap > 0) and CFG.fpsCap or 8
		pcall(setfpscap, CFG.actionFps or 60)
	end
	_burstDepth = _burstDepth + 1
end
function fpsBurstEnd()
	if type(setfpscap) ~= "function" then
		return
	end
	_burstDepth = math.max(0, _burstDepth - 1)
	if _burstDepth == 0 then
		pcall(setfpscap, _idleFps or 8)
	end
end
-- Fire a remote then yield exactly one frame so the Packet layer flushes it.
function firePaced(remote, ...)
	local ok = callRemote(remote, ...)
	_RunSvc.Heartbeat:Wait()
	return ok
end

function teleportToPlot(plot)
	if shouldDeferFarmTeleport() then
		return false
	end
	local vis = plot and plot:FindFirstChild("Visual")
	if not vis then
		return false
	end
	for _, c in vis:GetChildren() do
		if c.Name:find("PlantAreaColumn") and c:IsA("BasePart") then
			return teleportNear(c.Position + Vector3.new(0, CFG.teleportHeight, 0), 999)
		end
	end
	for _, c in vis:GetChildren() do
		if c:IsA("BasePart") then
			return teleportNear(c.Position + Vector3.new(0, CFG.teleportHeight, 0), 999)
		end
	end
	return false
end

function getPlantAreaParts(plot)
	local parts = {}
	local vis = plot and plot:FindFirstChild("Visual")
	if not vis then
		return parts
	end
	for _, c in vis:GetDescendants() do
		if c:IsA("BasePart") and CollectionService:HasTag(c, "PlantArea") then
			table.insert(parts, c)
		end
	end
	if #parts == 0 then
		for _, c in vis:GetChildren() do
			if c:IsA("BasePart") and c.Name:find("PlantArea") then
				table.insert(parts, c)
			end
		end
	end
	if #parts == 0 then
		for _, c in vis:GetChildren() do
			if c:IsA("BasePart") then
				table.insert(parts, c)
			end
		end
	end
	return parts
end

function raycastPlantArea(plot, worldPos)
	local parts = getPlantAreaParts(plot)
	if #parts == 0 then
		return worldPos
	end
	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Include
	params.FilterDescendantsInstances = parts
	local origin = Vector3.new(worldPos.X, worldPos.Y + 80, worldPos.Z)
	local hit = workspace:Raycast(origin, Vector3.new(0, -200, 0), params)
	return hit and hit.Position or worldPos
end

function waterRemotePos(hitPos)
	-- WateringcanController fires UseWateringCan(hit.Position - Vector3(0, 0.3, 0), ...).
	-- The old -35 offset put the point ~35 studs below the plant => server "too far away".
	return hitPos - Vector3.new(0, 0.3, 0)
end

function getStock(folderName, itemName)
	local sv = RS:FindFirstChild("StockValues")
	local shop = sv and sv:FindFirstChild(folderName)
	local items = shop and shop:FindFirstChild("Items")
	local nv = items and items:FindFirstChild(itemName)
	return (nv and nv:IsA("NumberValue") and nv.Value) or 0
end

function getToolsByAttr(attr)
	local tools = {}
	local backpack = LP:FindFirstChildOfClass("Backpack")
	if backpack then
		for _, t in backpack:GetChildren() do
			if t:IsA("Tool") and t:GetAttribute(attr) then
				table.insert(tools, t)
			end
		end
	end
	local char = LP.Character
	if char then
		for _, t in char:GetChildren() do
			if t:IsA("Tool") and t:GetAttribute(attr) then
				table.insert(tools, t)
			end
		end
	end
	return tools
end

function findToolsByNames(names)
	local out, seen = {}, {}
	local function check(container)
		if not container then
			return
		end
		for _, t in container:GetChildren() do
			if not t:IsA("Tool") or seen[t] then
				continue
			end
			for _, n in ipairs(names) do
				if t.Name == n or t.Name:find("Watering", 1, true) then
					seen[t] = true
					table.insert(out, t)
					break
				end
			end
		end
	end
	check(LP:FindFirstChildOfClass("Backpack"))
	check(LP.Character)
	return out
end

function petInventoryReady()
	local ok, state = pcall(function()
		local mod = RS:FindFirstChild("ClientModules") and RS.ClientModules:FindFirstChild("PlayerStateClient")
		if not mod then
			return nil
		end
		local client = require(mod)
		local replica = client.GetLocalReplica and client:GetLocalReplica()
		return replica and replica.Data
	end)
	if not ok or type(state) ~= "table" then
		return false
	end
	local inv = state.Inventory
	return type(inv) == "table" and type(inv.Pets) == "table"
end

function getPlayerReplicaData()
	local ok, data = pcall(function()
		local mod = RS:FindFirstChild("ClientModules") and RS.ClientModules:FindFirstChild("PlayerStateClient")
		if not mod then
			return nil
		end
		local client = require(mod)
		local replica = client.GetLocalReplica and client:GetLocalReplica()
		return replica and replica.Data
	end)
	if ok and type(data) == "table" then
		return data
	end
end

local seedBuyBlock = {}
local lastNoBuyReason = ""
local lastNoBuyLog = 0

function isSeedBuyBlocked(name)
	local untilT = seedBuyBlock[name]
	return untilT ~= nil and os.clock() < untilT
end

function blockSeedBuy(name)
	seedBuyBlock[name] = os.clock() + (CFG.seedBuyBlockSeconds or 90)
end

function clearSeedBuyBlocks()
	seedBuyBlock = {}
end

function getPersonalSeedStock(name)
	local data = getPlayerReplicaData()
	if not data then
		return nil
	end
	local buckets = {
		data.SeedShop and data.SeedShop.Stock,
		data.SeedShop and data.SeedShop.Items,
		data.SeedShopStock,
		data.Shops and data.Shops.SeedShop,
		data.ShopStocks and data.ShopStocks.SeedShop,
	}
	for _, bucket in ipairs(buckets) do
		if type(bucket) == "table" then
			local v = bucket[name]
			if type(v) == "number" then
				return v
			end
			if type(v) == "table" then
				return v.Stock or v.Count or v.Amount
			end
		end
	end
	return nil
end

function getSeedShopStock(name)
	if isSeedBuyBlocked(name) then
		return 0
	end
	local personal = getPersonalSeedStock(name)
	if personal ~= nil then
		return personal
	end
	return getStock("SeedShop", name)
end

function getOwnedSeedCount(name)
	local total = 0
	for _, tool in ipairs(getToolsByAttr("SeedTool")) do
		local st = tool:GetAttribute("SeedTool") or tool.Name
		if st == name then
			local qty = tool:GetAttribute("Quantity")
				or tool:GetAttribute("Amount")
				or tool:GetAttribute("Count")
				or tool:GetAttribute("Stack")
			total = total + (qty or 1)
		end
	end
	local data = getPlayerReplicaData()
	local seeds = data and data.Inventory and data.Inventory.Seeds
	if type(seeds) == "table" then
		local v = seeds[name]
		if type(v) == "number" then
			total = total + v
		elseif type(v) == "table" then
			total = total + (v.Count or v.Amount or v.Quantity or v.Qty or 0)
		end
	end
	return total
end

function getTotalOwnedSeedCount()
	local total = 0
	for _, tool in ipairs(getToolsByAttr("SeedTool")) do
		local qty = tool:GetAttribute("Quantity")
			or tool:GetAttribute("Amount")
			or tool:GetAttribute("Count")
			or tool:GetAttribute("Stack")
		total = total + (qty or 1)
	end
	local data = getPlayerReplicaData()
	local seeds = data and data.Inventory and data.Inventory.Seeds
	if type(seeds) == "table" then
		for _, v in pairs(seeds) do
			if type(v) == "number" then
				total = total + v
			elseif type(v) == "table" then
				total = total + (v.Count or v.Amount or v.Quantity or v.Qty or 0)
			end
		end
	end
	return total
end

local lastSeedRestockRequest = 0

function hookSeedShopEvents()
	if not NET or not NET.SeedShop then
		return
	end
	getgenv().GAG2_HOOKS = getgenv().GAG2_HOOKS or {}
	if getgenv().GAG2_HOOKS.seedShop then
		return
	end
	getgenv().GAG2_HOOKS.seedShop = true
	local pr = NET.SeedShop.PersonalRestock
	if pr and pr.OnClientEvent then
		pr.OnClientEvent:Connect(function()
			clearSeedBuyBlocks()
		end)
	end
end

function refreshSeedShopState()
	if not NET or not NET.SeedShop then
		return
	end
	local now = os.clock()
	if now - lastSeedRestockRequest < 15 then
		return
	end
	lastSeedRestockRequest = now
	local pr = NET.SeedShop.PersonalRestock
	if pr and pr.Fire then
		pcall(pr.Fire, pr)
	end
	task.wait(0.15)
end

function firePurchaseSeed(name)
	local remote = NET and NET.SeedShop and NET.SeedShop.PurchaseSeed
	if not remote or not remote.Fire then
		return false, "no remote"
	end
	local ok, resp = pcall(remote.Fire, remote, name)
	if not ok then
		return false, tostring(resp)
	end
	if isFailMessage(resp) then
		return false, tostring(resp)
	end
	return true
end

function getMinSeedPriceForMoney(money)
	for _, tier in ipairs(CFG.moneyTiers) do
		if money >= tier.money then
			return tier.minSeedPrice
		end
	end
	return 0
end

function getSeedScore(name)
	local d = SEED_DATA[name]
	if not d then
		return 0
	end
	local avg = (d.yield[1] + d.yield[2]) / 2
	return avg * (SELL_VALUES[name] or d.price)
end

-- ROI gate: a seed is worth buying only if its shop price isn't absurd vs its
-- per-harvest value. Stops the bot from wasting money on trap seeds (e.g. Banana
-- at $30000 that sells for ~35). Plants regrow forever, so a small ratio is safe.
function seedRoiOk(name)
	local d = SEED_DATA[name]
	if not d then
		return true
	end
	local ratio = CFG.maxPriceScoreRatio or 0
	if ratio <= 0 then
		return true
	end
	local score = getSeedScore(name)
	if score <= 0 then
		return false
	end
	return (d.price or 10) <= score * ratio
end

function getMinHarvestScoreForMoney(money)
	local minScore = CFG.skipHarvestBelowScore or 0
	for _, tier in ipairs(CFG.harvestScoreTiers or {}) do
		if money >= tier.money then
			minScore = math.max(minScore, tier.minScore or 0)
			break
		end
	end
	return minScore
end

function equipTool(t)
	local char = LP.Character
	if not char then
		return false
	end
	pcall(function()
		t.Parent = char
	end)
	task.wait(0.1)
	return t.Parent == char
end

function unequipTool(t)
	pcall(function()
		t.Parent = LP.Backpack
	end)
end

local ownedGear = {}
local gearCacheExpiry = 0

function refreshOwnedGear()
	if os.clock() < gearCacheExpiry and next(ownedGear) then
		return ownedGear
	end
	ownedGear = {}
	if not NET or not NET.GearShop then
		return ownedGear
	end
	local fn = NET.GearShop.RequestEquippableState.Invoke or NET.GearShop.RequestEquippableState.Fire
	local ok, r = pcall(fn, NET.GearShop.RequestEquippableState)
	if ok and type(r) == "table" then
		local raw = r.OwnedEquippableGears
		if type(raw) == "table" then
			for k, v in pairs(raw) do
				if type(v) == "string" then
					ownedGear[v] = true
				elseif type(k) == "string" then
					ownedGear[k] = true
				end
			end
			for _, v in ipairs(raw) do
				if type(v) == "string" then
					ownedGear[v] = true
				end
			end
		end
	end
	gearCacheExpiry = os.clock() + 8
	return ownedGear
end

function hasGear(name)
	refreshOwnedGear()
	return ownedGear[name] == true
end

function equipGear(name)
	if not NET or not NET.GearShop then
		return false
	end
	return callRemote(NET.GearShop.EquipGear, name)
end

function previewInventory()
	if not NET or not NET.NPCS or not NET.NPCS.PreviewSellAll then
		return nil
	end
	local fn = NET.NPCS.PreviewSellAll.Invoke or NET.NPCS.PreviewSellAll.Fire
	local ok, prev = pcall(fn, NET.NPCS.PreviewSellAll)
	if ok and type(prev) == "table" then
		return prev
	end
end

function getInventoryFruitCount()
	local prev = previewInventory()
	return prev and (prev.FruitCount or 0) or 0
end

function getPlantSeedName(plant)
	if not plant then
		return nil
	end
	return plant:GetAttribute("SeedName") or plant:GetAttribute("Seed") or plant:GetAttribute("PlantName") or plant.Name
end

function getFruitName(fruit, plant)
	if not fruit then
		return getPlantSeedName(plant)
	end
	return fruit:GetAttribute("CorePartName")
		or fruit:GetAttribute("FruitName")
		or fruit:GetAttribute("SeedName")
		or getPlantSeedName(plant)
end

function getFruitScore(fruit, plant)
	local fname = getFruitName(fruit, plant)
	local sm = fruit:GetAttribute("SizeMulti") or fruit:GetAttribute("SizeMultiplier") or 1
	local mut = tostring(
		fruit:GetAttribute("Mutation") or fruit:GetAttribute("MutationName") or plant:GetAttribute("Mutation") or ""
	)
	local base = SELL_VALUES[fname] or (SEED_DATA[fname] and SEED_DATA[fname].price) or 10
	local mutMult = MUTATION_MULT[mut] or 1
	if mut ~= "" and mutMult == 1 then
		mutMult = 1.5
	end
	return base * (sm ^ 2.65) * mutMult
end

local sellAll

function isFruitReady(fruit)
	if not CFG.onlyHarvestRipe then
		return true
	end
	local age = fruit:GetAttribute("Age")
	local maxAge = fruit:GetAttribute("MaxAge")
	if age and maxAge and age < maxAge then
		return false
	end
	local ready = fruit:GetAttribute("FruitGrowthReady")
	if ready == false then
		return false
	end
	return true
end

function fruitLabel(entry)
	return string.format("%s %.0f", tostring(entry.fruit or entry.seed), entry.score or 0)
end

function getPlantPos(plant)
	local base = plant:FindFirstChild("Base")
	if base then
		return base.Position
	end
	local pp = plant.PrimaryPart
	if pp then
		return pp.Position
	end
	local ok, pivot = pcall(plant.GetPivot, plant)
	if ok then
		return pivot.Position
	end
end

function getInstancePos(inst)
	if not inst then
		return nil
	end
	if inst:IsA("BasePart") then
		return inst.Position
	end
	if inst:IsA("Model") then
		return getPlantPos(inst)
	end
	local parentModel = inst:FindFirstAncestorWhichIsA("Model")
	if parentModel then
		return getPlantPos(parentModel)
	end
end

local lastHarvestDebug = 0

function collectFruits(plot)
	if not CFG.enabled.harvest or not NET or not NET.Garden then
		return 0, 0, 0
	end
	local pl = plot:FindFirstChild("Plants")
	if not pl then
		return 0, 0, 0
	end

	local entries = {}
	local minHarvestScore = getMinHarvestScoreForMoney(getMoney())
	local debugSeeds = {}
	local plantById = {}
	local seenKeys = {}
	for _, plant in pl:GetChildren() do
		if not plant:IsA("Model") then
			continue
		end
		local pid = plant:GetAttribute("PlantId")
		if pid then
			plantById[pid] = plant
		end
		local ff = pid and plant:FindFirstChild("Fruits")
		local seedName = getPlantSeedName(plant)
		if not ff then
			if CFG.harvestDebugImportantSeeds[seedName] then
				local childNames = {}
				for _, child in ipairs(plant:GetChildren()) do
					table.insert(childNames, child.ClassName .. ":" .. child.Name)
					if #childNames >= 6 then
						break
					end
				end
				debugSeeds[plant.Name] = {
					seed = seedName,
					children = #plant:GetChildren(),
					ids = 0,
					ready = 0,
					noFolder = true,
					age = plant:GetAttribute("Age"),
					maxAge = plant:GetAttribute("MaxAge"),
					plantReady = plant:GetAttribute("PlantGrowthReady"),
					childList = table.concat(childNames, "|"),
				}
			end
			continue
		end
		local pos = getPlantPos(plant)
		local seenFids = {}
		local debugInfo = CFG.harvestDebugImportantSeeds[seedName]
				and {
					seed = seedName,
					children = #ff:GetChildren(),
					ids = 0,
					ready = 0,
				}
			or nil
		local fruitNodes = {}
		for _, node in ff:GetChildren() do
			table.insert(fruitNodes, node)
		end
		for _, node in ff:GetDescendants() do
			table.insert(fruitNodes, node)
		end
		for _, fruit in ipairs(fruitNodes) do
			local fid = fruit:GetAttribute("FruitId")
			if fid and not seenFids[fid] then
				seenFids[fid] = true
				if debugInfo then
					debugInfo.ids = debugInfo.ids + 1
				end
				if isFruitReady(fruit) then
					if debugInfo then
						debugInfo.ready = debugInfo.ready + 1
					end
					local score = getFruitScore(fruit, plant)
					if score >= minHarvestScore then
						seenKeys[pid .. "|" .. fid] = true
						table.insert(entries, {
							pid = pid,
							fid = fid,
							score = score,
							pos = getInstancePos(fruit) or pos,
							seed = getPlantSeedName(plant),
							fruit = getFruitName(fruit, plant),
						})
					end
				end
			end
		end
		if debugInfo then
			debugSeeds[plant.Name] = debugInfo
		end
	end

	-- Universal pass: plants harvested via HarvestPrompt without a Fruits/FruitId folder
	-- (e.g. Bamboo, Mushroom). The game collects these via CollectFruit(PlantId, FruitId or "").
	local okTagged, tagged = pcall(function()
		return CollectionService:GetTagged("HarvestPrompt")
	end)
	if okTagged and type(tagged) == "table" then
		local promptCount = 0
		for _, prompt in ipairs(tagged) do
			if promptCount >= 400 then
				break
			end
			promptCount = promptCount + 1
			if prompt:GetAttribute("Collected") then
				continue
			end
			local host = prompt.Parent
			local ancestor = host and host:FindFirstAncestorWhichIsA("Model")
			if not ancestor then
				continue
			end
			local apid = ancestor:GetAttribute("PlantId")
			local plant = apid and plantById[apid]
			if not plant then
				continue
			end
			local afid = ancestor:GetAttribute("FruitId") or ""
			local key = apid .. "|" .. afid
			if seenKeys[key] then
				continue
			end
			seenKeys[key] = true
			local fruitInst = (afid ~= "" and ancestor:GetAttribute("FruitId")) and ancestor or nil
			local score
			if fruitInst then
				score = getFruitScore(fruitInst, plant)
			else
				local sn = getPlantSeedName(plant)
				score = SELL_VALUES[sn] or (SEED_DATA[sn] and SEED_DATA[sn].price) or 10
			end
			if score >= minHarvestScore then
				table.insert(entries, {
					pid = apid,
					fid = afid,
					score = score,
					pos = getInstancePos(host) or getInstancePos(ancestor) or getPlantPos(plant),
					seed = getPlantSeedName(plant),
					fruit = getPlantSeedName(plant),
				})
				if debugSeeds[plant.Name] then
					debugSeeds[plant.Name] = nil
				end
			end
		end
	end

	if CFG.harvestDebug and os.clock() - lastHarvestDebug > CFG.harvestDebugInterval then
		lastHarvestDebug = os.clock()
		for plantName, info in pairs(debugSeeds) do
			if info.ids == 0 or info.ready == 0 then
				wr(
					string.format(
						"[HARVESTDBG] %s plant=%s Fruits=%s children=%d fruitIds=%d ready=%d age=%s/%s plantReady=%s childList=%s",
						info.seed,
						plantName,
						tostring(not info.noFolder),
						info.children or 0,
						info.ids or 0,
						info.ready or 0,
						tostring(info.age or "?"),
						tostring(info.maxAge or "?"),
						tostring(info.plantReady),
						tostring(info.childList or "-")
					)
				)
			end
		end
	end
	if #entries == 0 then
		return 0, 0, 0
	end

	table.sort(entries, function(a, b)
		return a.score > b.score
	end)
	if not CFG.fastFarm and entries[1].score >= CFG.harvestDynamicMinWhenBestAbove then
		local minScore = entries[1].score * CFG.harvestDynamicMinRatio
		local filtered = {}
		for _, entry in ipairs(entries) do
			if entry.score >= minScore then
				table.insert(filtered, entry)
			end
		end
		if #filtered > 0 then
			entries = filtered
		end
	end
	local topParts = {}
	for i = 1, math.min(CFG.harvestLogTop, #entries) do
		table.insert(topParts, fruitLabel(entries[i]))
	end
	wr(
		string.format(
			"[HARVEST] %d ripe fruits | TOP: %s | worst=%.0f",
			#entries,
			table.concat(topParts, ", "),
			entries[#entries].score
		)
	)

	teleportToPlot(plot)
	local done, soldDuring, soldValueDuring, lastPos = 0, 0, 0, nil
	local invCount = getInventoryFruitCount()
	if invCount >= CFG.inventorySellAt and sellAll then
		local sold, soldVal = sellAll()
		soldDuring = soldDuring + (sold or 0)
		soldValueDuring = soldValueDuring + (soldVal or 0)
		invCount = getInventoryFruitCount()
	end
	if invCount >= CFG.inventoryLimit then
		wr(string.format("[HARVEST] skipped: inventory full after sell attempt (%d/%d)", invCount, CFG.inventoryLimit))
		return 0, soldDuring, soldValueDuring
	end
	local limit = math.min(#entries, CFG.harvestMaxPerCycle)
	-- Spatial sort so nearby fruits are consecutive -> we collect whole clusters
	-- from a single anchor (server accepts CollectFruit within ~55 studs, proven).
	-- This minimises teleports; the per-frame pacing below makes every Fire land.
	table.sort(entries, function(a, b)
		if not a.pos then
			return false
		end
		if not b.pos then
			return true
		end
		if math.abs(a.pos.X - b.pos.X) > 8 then
			return a.pos.X < b.pos.X
		end
		if math.abs(a.pos.Z - b.pos.Z) > 8 then
			return a.pos.Z < b.pos.Z
		end
		return (a.score or 0) > (b.score or 0)
	end)
	local clusterRange = CFG.harvestClusterRange or 45
	local anchor = nil
	fpsBurstBegin()
	for i = 1, limit do
		local e = entries[i]
		if invCount >= CFG.inventorySellAt and sellAll then
			local sold, soldVal = sellAll()
			soldDuring = soldDuring + (sold or 0)
			soldValueDuring = soldValueDuring + (soldVal or 0)
			invCount = getInventoryFruitCount()
			if invCount >= CFG.inventoryLimit then
				wr(string.format("[HARVEST] paused: inventory still full (%d/%d)", invCount, CFG.inventoryLimit))
				break
			end
		end
		-- Cluster anchor: only relocate when the next fruit is outside collect range.
		if e.pos and (not anchor or (e.pos - anchor).Magnitude > clusterRange) then
			local hrp = getHRP()
			if hrp then
				hrp.CFrame = CFrame.new(e.pos + Vector3.new(0, CFG.teleportHeight, 0))
			end
			anchor = e.pos
			_RunSvc.Heartbeat:Wait()
		end
		-- firePaced yields one frame after firing so the Packet layer flushes it
		-- (rapid same-frame fires get coalesced and silently dropped otherwise).
		if firePaced(NET.Garden.CollectFruit, e.pid, e.fid) then
			done = done + 1
			invCount = invCount + 1
		end
	end
	fpsBurstEnd()
	if done > 0 then
		local nextEntry = entries[done + 1]
		wr(
			string.format(
				"[HARVEST] Collected priority batch %d/%d (available=%d next=%s soldDuring=%d inv=%d/%d)",
				done,
				limit,
				#entries,
				nextEntry and fruitLabel(nextEntry) or "-",
				soldDuring,
				getInventoryFruitCount(),
				CFG.inventoryLimit
			)
		)
		if sellAll then
			local s, v = sellAll()
			soldDuring = soldDuring + (s or 0)
			soldValueDuring = soldValueDuring + (v or 0)
		end
	end
	return done, soldDuring, soldValueDuring
end

sellAll = function()
	if not CFG.enabled.sell or not NET or not NET.NPCS then
		return 0, 0
	end
	local totalS, totalP = 0, 0
	local fnPrev = NET.NPCS.PreviewSellAll.Invoke or NET.NPCS.PreviewSellAll.Fire
	local fnSell = NET.NPCS.SellAll.Invoke or NET.NPCS.SellAll.Fire
	for _ = 1, 50 do
		local ok, prev = pcall(fnPrev, NET.NPCS.PreviewSellAll)
		if not ok or type(prev) ~= "table" then
			break
		end
		local fc = prev.FruitCount or 0
		if fc == 0 then
			break
		end
		local ok2, resp = pcall(fnSell, NET.NPCS.SellAll)
		if ok2 and type(resp) == "table" and not isFailMessage(resp) then
			totalS = totalS + (resp.SoldCount or fc)
			totalP = totalP + (resp.SellPrice or 0)
		else
			break
		end
	end
	if totalS > 0 then
		wr(string.format("[SELL] %d = $%.0f", totalS, totalP))
	end
	return totalS, totalP
end

function countTools()
	local n = 0
	local backpack = LP:FindFirstChildOfClass("Backpack")
	if backpack then
		for _, t in backpack:GetChildren() do
			if t:IsA("Tool") then
				n = n + 1
			end
		end
	end
	local char = LP.Character
	if char then
		for _, t in char:GetChildren() do
			if t:IsA("Tool") then
				n = n + 1
			end
		end
	end
	return n
end

function countSeedTool(name)
	local n = 0
	for _, tool in ipairs(getToolsByAttr("SeedTool")) do
		local st = tool:GetAttribute("SeedTool") or tool.Name
		if st == name then
			n = n + 1
		end
	end
	return n
end

function purchaseGearVerified(name)
	if hasGear(name) then
		return false
	end
	local stock = getStock("GearShop", name)
	if stock <= 0 then
		return false
	end
	local price = GEAR_PRICES[name]
	if not price or getMoney() < price + CFG.minMoneyKeep then
		return false
	end
	local isWaterCan = name:find("Watering", 1, true) ~= nil
	local reserve = isWaterCan and (CFG.wateringCanMinMoneyReserve or 3000) or (CFG.gearMinMoneyReserve or 0)
	if getMoney() - price < reserve then
		return false
	end
	local moneyBefore = getMoney()
	local ok = callRemote(NET.GearShop.PurchaseGear, name)
	if not ok then
		return false
	end
	task.wait(0.2)
	if getMoney() >= moneyBefore then
		return false
	end
	ownedGear[name] = true
	wr(string.format("[BUY] %s ($%d, stock=%d)", name, price, stock))
	equipGear(name)
	return true
end

function autoBuyGear()
	if not CFG.enabled.gear or getMoney() < CFG.buyGearWhenMoneyAbove then
		return 0
	end
	refreshOwnedGear()
	local bought = 0
	-- watering cans are reusable tools; only buy if we don't already hold one
	if #getToolsByAttr("WateringCan") == 0 then
		for _, n in ipairs(CFG.wateringCans) do
			if purchaseGearVerified(n) then
				bought = bought + 1
			end
		end
	end
	for _, n in ipairs(CFG.sprinklers) do
		if purchaseGearVerified(n) then
			bought = bought + 1
		end
	end
	return bought
end

function pickBestInStockSeed(tried, minPrice)
	local money = getMoney()
	local bestName, bestScore
	for name in pairs(SEED_DATA) do
		if
			not (tried and tried[name])
			and not isSeedBuyBlocked(name)
			and not isShopBuyBlocked(name)
			and not getPriorityBuyCfg(name)
		then
			local price = SEED_DATA[name].price or 10
			if
				price >= (minPrice or 0)
				and getSeedScore(name) >= (CFG.minBuySeedScore or 0)
				and seedRoiOk(name)
				and getSeedShopStock(name) > 0
				and canAffordSeed(price)
			then
				local score = getSeedScore(name)
				if not bestScore or score > bestScore then
					bestName, bestScore = name, score
				end
			end
		end
	end
	return bestName
end

function pickRelaxedShopSeed(tried)
	return pickBestInStockSeed(tried, 0)
end

-- Idle-capacity filler: pick the highest-score in-stock crop we can afford,
-- relaxing the minBuySeedScore floor down to fallbackFillMinScore (these are
-- throwaway fillers) but keeping the ROI gate so trap seeds stay blocked.
function pickIdleFillSeed(tried)
	local minScore = CFG.fallbackFillMinScore or 0
	local bestName, bestScore
	for name in pairs(SEED_DATA) do
		if
			not (tried and tried[name])
			and not isSeedBuyBlocked(name)
			and not isShopBuyBlocked(name)
			and not getPriorityBuyCfg(name)
			and not isNoPlantSeed(name)
		then
			local score = getSeedScore(name)
			if
				score >= minScore
				and seedRoiOk(name)
				and getSeedShopStock(name) > 0
				and canAffordSeed(SEED_DATA[name].price or 10)
			then
				if not bestScore or score > bestScore then
					bestName, bestScore = name, score
				end
			end
		end
	end
	return bestName
end

-- When money tier requires expensive seeds but shop only stocks cheap ones, relax tier.
function tierBlocksAllShopStock()
	local minPrice = getMinSeedPriceForMoney(getMoney())
	if minPrice <= 0 then
		return false
	end
	for name in pairs(SEED_DATA) do
		if
			not isSeedBuyBlocked(name)
			and not isShopBuyBlocked(name)
			and getSeedShopStock(name) > 0
			and seedRoiOk(name)
			and getSeedScore(name) >= (CFG.minBuySeedScore or 0)
		then
			local price = SEED_DATA[name].price or 10
			if price >= minPrice and canAffordSeed(price) then
				return false
			end
		end
	end
	for name in pairs(SEED_DATA) do
		if
			not isSeedBuyBlocked(name)
			and not isShopBuyBlocked(name)
			and getSeedShopStock(name) > 0
			and seedRoiOk(name)
			and getSeedScore(name) >= (CFG.minBuySeedScore or 0)
			and canAffordSeed(SEED_DATA[name].price or 10)
		then
			return true
		end
	end
	return false
end

function resolveSeedMinPrice(money, allowBelowTier)
	if allowBelowTier then
		return 0
	end
	return getMinSeedPriceForMoney(money)
end

function purchaseSeedVerified(name, allowBelowTier, relaxed)
	local info = SEED_DATA[name]
	local price = info and info.price or 10
	local money = getMoney()
	if not canAffordSeed(price) then
		return false, "money"
	end
	if not seedRoiOk(name) then
		return false, "roi"
	end
	if not relaxed then
		local minPrice = resolveSeedMinPrice(money, allowBelowTier)
		if price < minPrice then
			return false, "tier"
		end
	end
	local stock = getSeedShopStock(name)
	if stock <= 0 then
		return false, "stock"
	end
	if countTools() >= 95 then
		return false, "tools"
	end
	local moneyBefore = money
	local seedsBefore = getOwnedSeedCount(name)
	local ok, err = firePurchaseSeed(name)
	if not ok then
		return false, "remote"
	end
	for _ = 1, 10 do
		task.wait(0.15)
		if getMoney() < moneyBefore - 1 then
			seedBuyBlock[name] = nil
			wr(string.format("[BUY] %s ($%d, stock=%d)", name, price, stock))
			return true
		end
		if getOwnedSeedCount(name) > seedsBefore then
			seedBuyBlock[name] = nil
			wr(string.format("[BUY] %s ($%d, stock=%d)", name, price, stock))
			return true
		end
	end
	if CFG.buyTrustFire then
		wr(string.format("[BUY] %s ($%d, stock=%d) [fire]", name, price, stock))
		return true
	end
	blockSeedBuy(name)
	return false, "verify"
end

function countPlants(plot)
	local pl = plot and plot:FindFirstChild("Plants")
	if not pl then
		return 0
	end
	local n = 0
	for _ in pl:GetChildren() do
		n = n + 1
	end
	return n
end

function countPlantableSpots(plot)
	local vis = plot:FindFirstChild("Visual")
	if not vis then
		return 0
	end
	local total = 0
	for _, c in vis:GetChildren() do
		if c.Name:find("PlantAreaColumn") and c:IsA("BasePart") then
			local sz = c.Size
			total = total + math.max(math.floor(sz.X / 4) * math.floor(sz.Z / 4), 1)
		end
	end
	return total
end

function pickBestBuySeed(allowBelowTier, tried)
	local money = getMoney()
	local minPrice = resolveSeedMinPrice(money, allowBelowTier)
	for _, name in ipairs(seedPriority) do
		if
			not (tried and tried[name])
			and not isSeedBuyBlocked(name)
			and not isShopBuyBlocked(name)
			and not getPriorityBuyCfg(name)
		then
			local price = SEED_DATA[name] and SEED_DATA[name].price or 10
			if
				price >= minPrice
				and getSeedScore(name) >= (CFG.minBuySeedScore or 0)
				and seedRoiOk(name)
				and getSeedShopStock(name) > 0
				and canAffordSeed(price)
			then
				return name, price
			end
		end
	end
	return pickBestInStockSeed(tried, minPrice)
end

function pickPriorityStockSeed(tried, boughtCounts)
	local money = getMoney()
	local list = CFG.priorityBuySeeds
	if type(list) ~= "table" then
		return nil
	end

	local candidates = {}
	local function consider(name, cfg)
		cfg = cfg or {}
		if tried and tried[name] then
			return
		end
		if isSeedBuyBlocked(name) or isEventOnlySeed(name) then
			return
		end
		if not getPriorityBuyCfg(name) then
			return
		end
		if not seedRoiOk(name) then
			return
		end
		local minMoney = cfg.minMoney or 50000
		local maxPer = cfg.maxPerCycle or 5
		if money < minMoney then
			return
		end
		if (boughtCounts[name] or 0) >= maxPer then
			return
		end
		-- don't hoard: keep at most maxOwned in reserve to plant as spots free up
		if cfg.maxOwned and getOwnedSeedCount(name) >= cfg.maxOwned then
			return
		end
		local price = SEED_DATA[name] and SEED_DATA[name].price or 10
		if getSeedShopStock(name) <= 0 then
			return
		end
		if not canAffordSeed(price) then
			return
		end
		table.insert(candidates, { name = name, score = getSeedScore(name), minMoney = minMoney })
	end

	for name, cfg in pairs(list) do
		if type(name) == "string" and SEED_DATA[name] then
			consider(name, type(cfg) == "table" and cfg or {})
		elseif type(cfg) == "table" and cfg.seed then
			consider(cfg.seed, cfg)
		elseif type(cfg) == "string" then
			consider(cfg, {})
		end
	end

	table.sort(candidates, function(a, b)
		if a.minMoney ~= b.minMoney then
			return a.minMoney > b.minMoney
		end
		return a.score > b.score
	end)
	return candidates[1] and candidates[1].name
end

function buyPriorityStockSeeds()
	if not CFG.enabled.buy then
		return 0
	end
	refreshSeedShopState()
	local bought = 0
	local tried = {}
	local boughtCounts = {}
	local guard = 0
	while guard < 10 do
		guard = guard + 1
		local name = pickPriorityStockSeed(tried, boughtCounts)
		if not name then
			break
		end
		local ok, reason = purchaseSeedVerified(name, true, true)
		if ok then
			bought = bought + 1
			boughtCounts[name] = (boughtCounts[name] or 0) + 1
			wr("[BUY] stock: " .. name)
		else
			tried[name] = true
			if reason == "money" or reason == "stock" then
				break
			end
		end
		task.wait(0.05)
	end
	return bought
end

function seedShopDebugSummary(limit)
	local rows = {}
	for name in pairs(SEED_DATA) do
		local stock = getSeedShopStock(name)
		if stock > 0 then
			local price = SEED_DATA[name] and SEED_DATA[name].price or 10
			table.insert(rows, { name = name, price = price, stock = stock, score = getSeedScore(name) })
		end
	end
	table.sort(rows, function(a, b)
		return a.score > b.score
	end)
	local out = {}
	for i = 1, math.min(limit or 5, #rows) do
		local r = rows[i]
		table.insert(out, string.format("%s($%d x%d)", r.name, r.price, r.stock))
	end
	return #out > 0 and table.concat(out, ", ") or "stock=0"
end

function autoBuySeeds()
	if not CFG.enabled.buy then
		return 0
	end
	refreshSeedShopState()
	local plot = findMyPlot()
	if not plot then
		return 0
	end

	local stockBought = buyPriorityStockSeeds()

	local freeSpots = math.max(0, countPlantableSpots(plot) - countPlants(plot))
	if freeSpots < 1 then
		return stockBought
	end

	local bought = 0
	local limit = math.min(freeSpots, CFG.maxSeedsPerCycle, CFG.maxBuyAttemptsPerCycle or 4)
	local fallback = tierBlocksAllShopStock()
	if fallback and CFG.verboseLogs then
		wr("[BUY] tier relax: shop has no seeds at money tier")
	end
	local relaxed = fallback
	local tried = {}
	local triedNames = {}
	local failReasons = {}
	local idleFillTried = false
	local guard = 0
	local buyStart = os.clock()
	local maxBuySec = (CFG.pipelineMode ~= false and CFG.buyMaxSecondsActive) or CFG.maxBuySeconds or 6
	while bought < limit do
		if os.clock() - buyStart >= maxBuySec then
			failReasons.timeout = 1
			break
		end
		guard = guard + 1
		if guard > 20 then
			break
		end
		local name = pickBestBuySeed(fallback, tried)
		if not name and CFG.buySeedsFallbackBelowTier and not fallback then
			fallback = true
			name = pickBestBuySeed(true, tried)
			if name then
				wr("[BUY] fallback: " .. name)
			end
		end
		if not name and not relaxed then
			relaxed = true
			name = pickRelaxedShopSeed(tried)
			if name then
				wr("[BUY] relaxed: " .. name)
			end
		end
		-- Last resort: priority crop is out of stock and the plot has real idle
		-- spots -> fill with the best affordable in-stock filler instead of leaving
		-- capital idle. Gated so it only triggers during genuine Bamboo droughts.
		if
			not name
			and CFG.fillIdleWithFallback
			and not idleFillTried
			and stockBought == 0
			and freeSpots >= (CFG.fallbackFillMinFreeSpots or 0)
		then
			idleFillTried = true
			relaxed = true
			name = pickIdleFillSeed(tried)
			if name then
				wr("[BUY] idle-fill: " .. name)
			end
		end
		if not name then
			break
		end
		table.insert(triedNames, name)
		local ok, reason = purchaseSeedVerified(name, fallback or relaxed, relaxed)
		if ok then
			bought = bought + 1
		else
			tried[name] = true
			failReasons[reason or "fail"] = (failReasons[reason or "fail"] or 0) + 1
		end
		task.wait(0.05)
	end
	if bought == 0 and stockBought == 0 and freeSpots > 0 then
		local reasons = {}
		for k, v in pairs(failReasons) do
			table.insert(reasons, k .. "=" .. v)
		end
		table.sort(reasons)
		local reasonStr = #reasons > 0 and table.concat(reasons, ",") or "-"
		-- троттлинг: не спамим один и тот же повод чаще раза в 20 сек
		local now = os.clock()
		if reasonStr ~= lastNoBuyReason or (now - lastNoBuyLog) >= 20 then
			lastNoBuyReason = reasonStr
			lastNoBuyLog = now
			wr(
				string.format(
					"[BUY] no seed bought (freeSpots=%d money=$%.0f tools=%d ownedSeeds=%d tried=%s reasons=%s shop=%s)",
					freeSpots,
					getMoney(),
					countTools(),
					getTotalOwnedSeedCount(),
					#triedNames > 0 and table.concat(triedNames, ",") or "-",
					reasonStr,
					seedShopDebugSummary(5)
				)
			)
		end
	end
	return bought + stockBought
end

function buildSprinklerGrid(plot)
	local areas = getPlantAreaParts(plot)
	local points = {}
	for _, area in ipairs(areas) do
		local cf, sz = area.CFrame, area.Size
		local cols = math.max(1, math.floor(sz.X / CFG.sprinklerGridStep))
		local rows = math.max(1, math.floor(sz.Z / CFG.sprinklerGridStep))
		for cx = 0, cols do
			for cz = 0, rows do
				local lx = -sz.X / 2 + (cx / math.max(cols, 1)) * sz.X
				local lz = -sz.Z / 2 + (cz / math.max(rows, 1)) * sz.Z
				local world = cf:PointToWorldSpace(Vector3.new(lx, 0, lz))
				table.insert(points, raycastPlantArea(plot, world))
			end
		end
	end
	if #points == 0 then
		local center = areas[1]
		if center then
			table.insert(points, raycastPlantArea(plot, center.Position))
		end
	end
	return points
end

function getHighValuePlantPositions(plot)
	local positions = {}
	local pl = plot:FindFirstChild("Plants")
	if not pl then
		return positions
	end
	for _, plant in pl:GetChildren() do
		if plant:IsA("Model") then
			local seed = getPlantSeedName(plant)
			local score = seed and getSeedScore(seed) or 0
			local pos = getPlantPos(plant)
			if pos and score > 0 then
				table.insert(positions, { pos = pos, score = score })
			end
		end
	end
	table.sort(positions, function(a, b)
		return a.score > b.score
	end)
	return positions
end

function sortGridByPlants(grid, plantPositions)
	if #plantPositions == 0 then
		return grid
	end
	table.sort(grid, function(a, b)
		local function nearestScore(p)
			local best = 0
			for _, pp in ipairs(plantPositions) do
				local d = (p - pp.pos).Magnitude
				if d < 40 then
					best = math.max(best, pp.score * (1 - d / 40))
				end
			end
			return best
		end
		return nearestScore(a) > nearestScore(b)
	end)
	return grid
end

function placeSprinklers(plot)
	if not CFG.enabled.gear or not NET or not NET.Place then
		return 0
	end
	local tools = getToolsByAttr("Sprinkler")
	if #tools == 0 then
		for _, n in ipairs(CFG.sprinklers) do
			if hasGear(n) then
				equipGear(n)
				task.wait(0.15)
				break
			end
		end
		tools = getToolsByAttr("Sprinkler")
	end
	if #tools == 0 then
		return 0
	end

	local plotIds = getPlotRemoteIds(plot)
	if #plotIds == 0 then
		wr("[SPRINKLER] WARN: no plot ids")
	end

	local grid = buildSprinklerGrid(plot)
	grid = sortGridByPlants(grid, getHighValuePlantPositions(plot))
	local usedSpots = {}
	local sprFolder = plot:FindFirstChild("Sprinklers")
	if sprFolder then
		for _, s in sprFolder:GetChildren() do
			local pp = s.PrimaryPart or s:FindFirstChildWhichIsA("BasePart")
			if pp then
				table.insert(usedSpots, pp.Position)
			end
		end
	end

	local function spotFree(pos)
		for _, u in ipairs(usedSpots) do
			if (u - pos).Magnitude < CFG.sprinklerMinDistance then
				return false
			end
		end
		return true
	end

	local placed = 0
	local gridIdx = 1
	for ti = 1, math.min(#tools, CFG.maxSprinklersPerCycle) do
		local tool = tools[ti]
		if not tool or not tool.Parent then
			continue
		end
		local name = tool:GetAttribute("Sprinkler")
		if not name then
			continue
		end

		local ground
		while gridIdx <= #grid do
			local candidate = grid[gridIdx]
			gridIdx = gridIdx + 1
			if spotFree(candidate) then
				ground = candidate
				break
			end
		end
		if not ground then
			break
		end

		teleportNear(ground + Vector3.new(0, CFG.teleportHeight, 0), 999)
		if not equipTool(tool) then
			continue
		end

		local before = sprFolder and #sprFolder:GetChildren() or 0
		local ok, err, after = false, nil, before
		for _, plotId in ipairs(plotIds) do
			ok, _, err = callRemote(NET.Place.PlaceSprinkler, ground, name, tool, plotId)
			task.wait(0.12)
			after = sprFolder and #sprFolder:GetChildren() or 0
			if ok and after > before then
				break
			end
		end

		if ok and after > before then
			wr(string.format("[SPRINKLER] Placed %s @ grid", name))
			table.insert(usedSpots, ground)
			placed = placed + 1
		elseif err and tostring(err):lower():find("far") then
			teleportNear(ground + Vector3.new(0, CFG.teleportHeight, 0), 999)
			for _, plotId in ipairs(plotIds) do
				ok, _, err = callRemote(NET.Place.PlaceSprinkler, ground, name, tool, plotId)
				task.wait(0.12)
				after = sprFolder and #sprFolder:GetChildren() or 0
				if ok and after > before then
					break
				end
			end
			if ok and after > before then
				wr(string.format("[SPRINKLER] Placed %s (retry)", name))
				table.insert(usedSpots, ground)
				placed = placed + 1
			end
		end
		unequipTool(tool)
	end
	return placed
end

local weatherState = { rainbow = false, starfall = false, rain = false }
local eventPriorityActive = false
local eventDropBusy = {}
local eventDropsSinceStatus = 0

local waterHistory = {}
local lastWaterSkipLog = 0
local lastWaterAttempt = 0
local lastWaterFailLog = 0
local lastWaterEmptyLog = 0
local lastWaterSweep = 0
local lastPetEquipFailLog = 0

function fireWateringCan(pos, canType, tool)
	local remote = NET and NET.WateringCan and NET.WateringCan.UseWateringCan
	if not remote or not remote.Fire then
		return false, "no remote"
	end
	-- We no longer GATE success on WateringCanFx: that event is unreliable
	-- (timing/identity) and produced false "no fx (server rejected?)" failures,
	-- which triggered a 3-position retry storm + "too far" spam. UseWateringCan
	-- has no Response, so a clean Fire from close range (caller teleports onto
	-- the plant) is treated as success. firePaced yields one frame so it flushes.
	local ok, err = pcall(remote.Fire, remote, pos, canType, tool)
	_RunSvc.Heartbeat:Wait()
	if not ok then
		return false, tostring(err)
	end
	return true, nil
end

function needsWatering(plant)
	if not CFG.smartWater.enabled then
		return true
	end
	local pid = plant:GetAttribute("PlantId")
	if not pid then
		return true
	end
	local age, maxAge = plant:GetAttribute("Age"), plant:GetAttribute("MaxAge")
	if age and maxAge and age >= maxAge then
		return false
	end
	local last = waterHistory[pid]
	return not last or (os.clock() - last) > CFG.smartWater.rewaterAfterMinutes * 60
end

function tryWaterAt(plot, pos, ct, tool)
	local hit = raycastPlantArea(plot, pos)
	-- Teleport DIRECTLY onto the plant (not "within 20 studs"). The old
	-- teleportNear(maxDist+6) often left us ~15-20 studs out, so the server
	-- rejected the water as too far. Setting CFrame onto the spot is reliable.
	local hrp = getHRP()
	if hrp then
		hrp.CFrame = CFrame.new(hit + Vector3.new(0, CFG.teleportHeight, 0))
	end
	if not equipTool(tool) then
		if CFG.verboseLogs and os.clock() - lastWaterFailLog > 8 then
			lastWaterFailLog = os.clock()
			wr("[WATER] fail: could not equip watering-can tool")
		end
		return false
	end
	_RunSvc.Heartbeat:Wait()
	-- Signature (verified): UseWateringCan(Vector3 pos, String canType, Instance tool).
	-- Mirror the game client: pos = plant-area hit - 0.3 on Y.
	local ok = fireWateringCan(waterRemotePos(hit), ct, tool)
	return ok
end

function resolveWateringTools()
	local tools = getToolsByAttr("WateringCan")
	if #tools == 0 then
		tools = findToolsByNames(CFG.wateringCans)
	end
	if #tools > 0 then
		return tools
	end
	-- Own the can but it's not in the backpack yet: equip the gear and wait for the
	-- Tool to materialise. We must return a REAL Tool instance (the server needs it).
	refreshOwnedGear()
	for _, n in ipairs(CFG.wateringCans) do
		if not hasGear(n) then
			continue
		end
		equipGear(n)
		for _ = 1, 15 do
			task.wait(0.2)
			tools = getToolsByAttr("WateringCan")
			if #tools == 0 then
				tools = findToolsByNames({ n })
			end
			if #tools > 0 then
				return tools
			end
		end
	end
	return tools
end

function waterAll(plot)
	if not CFG.enabled.water or not NET or not NET.WateringCan then
		return 0
	end
	if weatherState.rain then
		return 0
	end
	local tools = resolveWateringTools()
	if #tools == 0 then
		if os.clock() - lastWaterSkipLog > 30 then
			lastWaterSkipLog = os.clock()
			wr("[WATER] skip: no watering-can tool (buy/equip gear first)")
		end
		return 0
	end

	local plants = plot:FindFirstChild("Plants")
	if not plants then
		return 0
	end
	local targets = {}
	local plantCount = 0
	for _, p in plants:GetChildren() do
		if p:IsA("Model") then
			plantCount = plantCount + 1
		end
		if p:IsA("Model") and needsWatering(p) then
			local seed = getPlantSeedName(p)
			local pos = getPlantPos(p)
			if pos then
				table.insert(targets, {
					plant = p,
					pos = pos,
					score = seed and getSeedScore(seed) or 0,
				})
			end
		end
	end
	if #targets == 0 then
		local every = CFG.smartWater and (tonumber(CFG.smartWater.logEmptyEvery) or 20) or 20
		if CFG.verboseLogs and os.clock() - lastWaterEmptyLog > every then
			lastWaterEmptyLog = os.clock()
			wr(
				string.format(
					"[WATER] no targets (plants=%d tools=%d rain=%s)",
					plantCount,
					#tools,
					tostring(weatherState.rain)
				)
			)
		end
		return 0
	end
	table.sort(targets, function(a, b)
		return a.score > b.score
	end)

	teleportToPlot(plot)
	local done = 0
	local limit = math.max(tonumber(CFG.smartWater and CFG.smartWater.maxPerSweep) or 24, 1)
	fpsBurstBegin()
	for _, tool in ipairs(tools) do
		local ct = tool:GetAttribute("WateringCan") or tool.Name
		if equipTool(tool) then
			for _, t in ipairs(targets) do
				if done >= limit then
					break
				end
				if needsWatering(t.plant) and tryWaterAt(plot, t.pos, ct, tool) then
					done = done + 1
					local pid = t.plant:GetAttribute("PlantId")
					if pid then
						waterHistory[pid] = os.clock()
					end
				end
			end
			unequipTool(tool)
		end
		if done >= limit then
			break
		end
	end
	fpsBurstEnd()
	if done > 0 then
		wr(string.format("[WATER] %d/%d", done, #targets))
	elseif CFG.verboseLogs and os.clock() - lastWaterFailLog > 6 then
		lastWaterFailLog = os.clock()
		wr(string.format("[WATER] tried %d target(s), success=0", #targets))
	end
	return done
end

function shouldWaterThisCycle(plantedCount)
	if not (CFG.enabled.water and CFG.smartWater and CFG.smartWater.enabled) then
		return false
	end
	if weatherState and weatherState.rain then
		return false
	end
	if (tonumber(plantedCount) or 0) > 0 then
		return true
	end
	local interval = math.max(tonumber(CFG.smartWater.sweepInterval) or 8, 2)
	if os.clock() - lastWaterSweep >= interval then
		return true
	end
	return false
end

function sortSeedTools(tools)
	local minPrice = CFG.skipPlantBelowPrice or 0
	local sorted = {}
	local fallback = {}
	for _, tool in ipairs(tools) do
		local st = tool:GetAttribute("SeedTool")
		if st then
			if isNoPlantSeed(st) then
				continue
			end
			local price = SEED_DATA[st] and SEED_DATA[st].price or 0
			local entry = { tool = tool, seed = st, score = getSeedScore(st) }
			if price >= minPrice then
				table.insert(sorted, entry)
			elseif CFG.plantFallbackBelowTier then
				table.insert(fallback, entry)
			end
		end
	end
	if #sorted == 0 then
		sorted = fallback
	end
	table.sort(sorted, function(a, b)
		return a.score > b.score
	end)
	return sorted
end

function plantAll(plot)
	if not CFG.enabled.plant or not NET or not NET.Plant then
		return 0
	end
	local sorted = sortSeedTools(getToolsByAttr("SeedTool"))
	if #sorted == 0 then
		local raw = getToolsByAttr("SeedTool")
		if #raw > 0 then
			local skipNames = {}
			for _, tool in ipairs(raw) do
				local st = tool:GetAttribute("SeedTool") or tool.Name
				if st and isNoPlantSeed(st) and not skipNames[st] then
					skipNames[st] = true
				end
			end
			local listed = {}
			for n in pairs(skipNames) do
				table.insert(listed, n)
			end
			table.sort(listed)
			if #listed > 0 then
				wr("[PLANT] skip: skipSeeds in backpack (hold/mail, not plant): " .. table.concat(listed, ", "))
			else
				wr("[PLANT] skip: no plantable seed tools in backpack")
			end
		end
		return 0
	end
	teleportToPlot(plot)
	local areas = getPlantAreaParts(plot)
	if #areas == 0 then
		return 0
	end

	local occupied = {}
	local plants = plot:FindFirstChild("Plants")
	if plants then
		for _, p in plants:GetChildren() do
			local base = p:FindFirstChild("Base")
			if base then
				table.insert(occupied, base.Position)
			end
		end
	end

	local function findSpot()
		for _ = 1, 40 do
			local a = areas[math.random(#areas)]
			local cf, sz = a.CFrame, a.Size
			local localPos = Vector3.new(-sz.X / 2 + math.random() * sz.X, 0.5, -sz.Z / 2 + math.random() * sz.Z)
			local pos = cf:PointToWorldSpace(localPos)
			local ok = true
			for _, o in ipairs(occupied) do
				if (pos - o).Magnitude < 3.5 then
					ok = false
					break
				end
			end
			if ok then
				return raycastPlantArea(plot, pos)
			end
		end
	end

	local done = 0
	for _, entry in ipairs(sorted) do
		local tool, st = entry.tool, entry.seed
		while tool and tool.Parent and done < CFG.maxPlantsPerCycle do
			local pos = findSpot()
			if not pos then
				break
			end
			teleportNear(pos + Vector3.new(0, CFG.teleportHeight, 0), CFG.maxActionDistance + 4)
			if not equipTool(tool) then
				break
			end
			if callRemote(NET.Plant.PlantSeed, pos, st, tool) then
				done = done + 1
				table.insert(occupied, pos)
				task.wait(0.05)
			else
				break
			end
		end
		unequipTool(tool)
		if done >= CFG.maxPlantsPerCycle then
			break
		end
	end
	if done > 0 then
		wr("[PLANT] " .. done)
	end
	return done
end

local cleanupRetryAt = {}

-- Best seed we could replant with: backpack first, then buyable shop stock.
-- During droughts the backpack is often empty while Bamboo or idle-fill crops
-- are still in the shop; without this, cleanup stalls and junk persists.
function getCleanupReplacementScore()
	local tools = sortSeedTools(getToolsByAttr("SeedTool"))
	local best = tools[1] and tools[1].score or 0
	if best >= CFG.cleanupReplacementMinScore then
		return best
	end

	refreshSeedShopState()
	local shopBest = 0
	for name in pairs(SEED_DATA) do
		if
			not isNoPlantSeed(name)
			and not isSeedBuyBlocked(name)
			and not isShopBuyBlocked(name)
			and getSeedShopStock(name) > 0
			and seedRoiOk(name)
			and canAffordSeed(SEED_DATA[name].price or 10)
		then
			local score = getSeedScore(name)
			if getPriorityBuyCfg(name) then
				shopBest = math.max(shopBest, score)
			elseif CFG.fillIdleWithFallback and score >= (CFG.fallbackFillMinScore or 0) then
				shopBest = math.max(shopBest, score)
			end
		end
	end
	if shopBest >= CFG.cleanupReplacementMinScore then
		return shopBest
	end
	if CFG.fillIdleWithFallback and shopBest > best then
		return shopBest
	end
	return best
end

function removeLowValuePlants(plot)
	if not CFG.cleanupLowValuePlants or not NET or not NET.Shovel or not NET.Shovel.UseShovel then
		return 0
	end
	if getMoney() < CFG.cleanupMoneyAbove then
		return 0
	end
	local plants = plot:FindFirstChild("Plants")
	if not plants then
		return 0
	end
	local capacity = countPlantableSpots(plot)
	local plantCount = countPlants(plot)
	if CFG.cleanupOnlyWhenGardenFull and plantCount < capacity then
		return 0
	end

	local replacementScore = getCleanupReplacementScore()
	if
		replacementScore
		< (CFG.fillIdleWithFallback and (CFG.fallbackFillMinScore or 0) or CFG.cleanupReplacementMinScore)
	then
		return 0
	end

	local all, bestScore = {}, 0
	for _, plant in plants:GetChildren() do
		if plant:IsA("Model") then
			local seed = getPlantSeedName(plant)
			local score = seed and getSeedScore(seed) or 0
			bestScore = math.max(bestScore, score)
			table.insert(all, { plant = plant, seed = seed, score = score })
		end
	end
	if bestScore < CFG.cleanupMinBestScore then
		return 0
	end

	table.sort(all, function(a, b)
		return a.score < b.score
	end)
	local tools = getToolsByAttr("Shovel")
	if #tools == 0 then
		return 0
	end
	local tool = tools[1]
	if not equipTool(tool) then
		return 0
	end

	local removed, tried = 0, 0
	local shovelName = tool:GetAttribute("Shovel") or "Shovel"
	for _, entry in ipairs(all) do
		if removed >= CFG.cleanupMaxPerCycle then
			break
		end
		if not entry.seed or not CFG.cleanupSeeds[entry.seed] then
			continue
		end
		-- remove only whitelisted junk that's far worse than what we can replant
		if entry.score >= replacementScore * CFG.cleanupReplacementRatio then
			continue
		end

		local pid = entry.plant.Name
		if not pid then
			continue
		end
		if cleanupRetryAt[pid] and cleanupRetryAt[pid] > os.clock() then
			continue
		end
		local beforeParent = entry.plant.Parent
		tried = tried + 1
		local pos = getPlantPos(entry.plant)
		if pos then
			teleportNear(pos + Vector3.new(0, CFG.teleportHeight, 0), CFG.maxActionDistance + 4)
		end
		callRemote(NET.Shovel.UseShovel, pid, "", shovelName, tool)
		task.wait(0.25)
		if beforeParent and not entry.plant.Parent then
			removed = removed + 1
			wr(string.format("[CLEANUP] removed %s score=%.0f best=%.0f", entry.seed, entry.score, bestScore))
		else
			cleanupRetryAt[pid] = os.clock() + CFG.cleanupRetryCooldown
		end
	end
	unequipTool(tool)
	if tried > 0 and removed == 0 then
		wr(
			string.format(
				"[CLEANUP] tried %d low-value plants with shovel args (plantModelName,'',%s,tool); none removed yet",
				tried,
				shovelName
			)
		)
	end
	return removed
end

local CRATE_RARITY = {
	["Common Guild Crate"] = 1,
	["Uncommon Guild Crate"] = 2,
	["Rare Guild Crate"] = 3,
	["Epic Guild Crate"] = 4,
	["Super Guild Crate"] = 5,
	["Legendary Guild Crate"] = 6,
	["Mythic Guild Crate"] = 7,
}

function autoOpenCrates()
	if not CFG.enabled.crates or not NET or not NET.CrateShop then
		return 0
	end
	if getMoney() < CFG.buyCratesWhenMoneyAbove then
		return 0
	end
	local items = RS.StockValues:FindFirstChild("CrateShop")
	items = items and items:FindFirstChild("Items")
	if not items then
		return 0
	end
	local opened = 0
	local crates = {}
	for _, v in items:GetChildren() do
		if v:IsA("NumberValue") and v.Value > 0 and CRATE_RARITY[v.Name] then
			table.insert(crates, { name = v.Name, stock = v.Value, r = CRATE_RARITY[v.Name] })
		end
	end
	table.sort(crates, function(a, b)
		return a.r > b.r
	end)
	for _, c in ipairs(crates) do
		if getMoney() < CFG.buyCratesWhenMoneyAbove then
			break
		end
		if callRemote(NET.CrateShop.PurchaseCrate, c.name) then
			opened = opened + 1
			task.wait(0.2)
			local fn = NET.Crate.OpenCrate.Invoke or NET.Crate.OpenCrate.Fire
			pcall(fn, NET.Crate.OpenCrate, c.name)
		end
	end
	return opened
end

function getGardenExpansionLevel()
	local data = getPlayerReplicaData()
	if data and type(data.OwnedExpansions) == "number" then
		return data.OwnedExpansions
	end
	local plot = findMyPlot()
	if plot then
		local v = plot:GetAttribute("GardenExpansion")
		if type(v) == "number" then
			return v
		end
	end
	return 0
end

function buyGardenExpansion()
	if not CFG.enabled.expansion or not CFG.autoExpandGarden or not NET or not NET.Actions then
		return false
	end
	if not NET.Actions.ExpandGarden then
		return false
	end
	local cur = getGardenExpansionLevel()
	local nextIdx = cur + 1
	if nextIdx > #EXPANSION_PRICES or cur >= CFG.maxGardenExpansionBought then
		return false
	end
	local price = EXPANSION_PRICES[nextIdx]
	if not price or getMoney() < price then
		return false
	end
	local ok, res = callRemote(NET.Actions.ExpandGarden)
	if ok then
		wr(string.format("[EXPAND] %d -> %d ($%.0f)", cur, nextIdx, price))
		return true
	end
	return false
end

function checkWeather()
	local wv = RS:FindFirstChild("WeatherValues")
	if not wv then
		return
	end
	local wasRainbow, wasStarfall = weatherState.rainbow, weatherState.starfall
	weatherState.rainbow = wv:GetAttribute("Rainbow_Playing") == true
	weatherState.starfall = wv:GetAttribute("Starfall_Playing") == true
	weatherState.rain = wv:GetAttribute("Rain_Playing") == true
	if weatherState.rainbow and not wasRainbow then
		wr("[EVENT] Rainbow STARTED")
	end
	if weatherState.starfall and not wasStarfall then
		wr("[EVENT] Starfall STARTED")
	end
end

function getDropDisplayName(item)
	local dn = item:GetAttribute("DisplayName")
		or item:GetAttribute("ItemName")
		or item:GetAttribute("SeedPack")
		or item:GetAttribute("PackName")
	if dn and dn ~= "" then
		return tostring(dn)
	end
	if item:GetAttribute("SeedPack") then
		return "SeedPack"
	end
	if item:GetAttribute("RainbowSeed") == true then
		return "Rainbow Seed"
	end
	if item:GetAttribute("GoldSeed") == true then
		return "Gold Seed"
	end
	return item.Name
end

function isEventWeatherActive()
	return weatherState.rainbow or weatherState.starfall
end

function shouldDeferFarmTeleport()
	if not eventPriorityActive then
		return false
	end
	local drops = workspace:FindFirstChild("DroppedItems")
	if not drops then
		return false
	end
	for _, item in drops:GetChildren() do
		if shouldCollectDrop(item) then
			return true
		end
	end
	return false
end

function isRushSeedDrop(item)
	if not item or not item.Parent then
		return false
	end
	if item:GetAttribute("RainbowSeed") == true then
		return true
	end
	if item:GetAttribute("GoldSeed") == true then
		return true
	end
	local name = getDropDisplayName(item):lower()
	if name:find("rainbow", 1, true) then
		return true
	end
	if name:find("gold", 1, true) and name:find("seed", 1, true) then
		return true
	end
	return false
end

function hasRushSeedsVisible()
	if isEventWeatherActive() then
		return true
	end
	local drops = workspace:FindFirstChild("DroppedItems")
	if drops then
		for _, item in drops:GetChildren() do
			if isRushSeedDrop(item) then
				return true
			end
		end
	end
	if CFG.collectSeedPacks then
		local map = workspace:FindFirstChild("Map")
		local folders = {
			map and map:FindFirstChild("SeedPackSpawnClient"),
			map and map:FindFirstChild("SeedPackSpawnServerLocations"),
		}
		for _, folder in ipairs(folders) do
			if folder then
				for _, item in folder:GetChildren() do
					if isRushSeedDrop(item) or isValuableEventDrop(item) then
						return true
					end
				end
			end
		end
	end
	return false
end

function shouldCollectDrop(item)
	if not item.Parent then
		return false
	end
	if isEventWeatherActive() then
		return true
	end
	local name = getDropDisplayName(item):lower()
	return name:find("rainbow") ~= nil
		or name:find("starfall") ~= nil
		or name:find("gold") ~= nil
		or name:find("seedpack") ~= nil
		or name:find("seed pack") ~= nil
end

local GENERIC_DROP_NAMES = {
	part = true,
	meshpart = true,
	model = true,
	folder = true,
	attachment = true,
	weldconstraint = true,
	proximityprompt = true,
}

function isValuableEventDrop(item)
	if not item or not item.Parent then
		return false
	end
	if item:GetAttribute("SeedPack") then
		return true
	end
	if item:GetAttribute("RainbowSeed") == true then
		return true
	end
	if item:GetAttribute("GoldSeed") == true then
		return true
	end
	if item:GetAttribute("DisplayName") or item:GetAttribute("ItemName") then
		return true
	end
	local name = item.Name:lower()
	if GENERIC_DROP_NAMES[name] then
		return false
	end
	return shouldCollectDrop(item)
end

function getDropPosition(item)
	if not item or not item.Parent then
		return nil
	end
	local visual = item:FindFirstChild("Visual")
	if visual then
		if visual:IsA("Model") then
			local ok, cf = pcall(function()
				return visual:GetBoundingBox()
			end)
			if ok and cf then
				return cf.Position
			end
			local pp = visual.PrimaryPart or visual:FindFirstChildWhichIsA("BasePart")
			if pp then
				return pp.Position
			end
		elseif visual:IsA("BasePart") then
			return visual.Position
		end
	end
	if item:IsA("BasePart") then
		return item.Position
	end
	if item:IsA("Model") then
		local pp = item.PrimaryPart or item:FindFirstChildWhichIsA("BasePart")
		return pp and pp.Position
	end
end

function firePrompt(prompt)
	if not prompt then
		return
	end
	if typeof(fireproximityprompt) == "function" then
		pcall(fireproximityprompt, prompt, 0)
	end
	pcall(function()
		prompt.Enabled = true
		prompt.MaxActivationDistance = math.max(prompt.MaxActivationDistance or 8, 18)
		prompt.RequiresLineOfSight = false
		prompt:InputHoldBegin()
		task.wait(math.max(prompt.HoldDuration or 0, 0.08) + 0.12)
		prompt:InputHoldEnd()
	end)
	if typeof(getconnections) == "function" then
		local ok, conns = pcall(getconnections, prompt.Triggered)
		if ok and type(conns) == "table" then
			for _, conn in ipairs(conns) do
				pcall(function()
					if conn.Function then
						conn.Function(LP)
					elseif conn.Fire then
						conn:Fire(LP)
					end
				end)
			end
		end
	end
end

function getEventSeedWatchKeys(item)
	local keys = {}
	if item:GetAttribute("RainbowSeed") == true then
		keys[#keys + 1] = "Rainbow"
	end
	if item:GetAttribute("GoldSeed") == true then
		keys[#keys + 1] = "Gold"
	end
	local dn = getDropDisplayName(item):lower()
	if dn:find("rainbow", 1, true) then
		keys[#keys + 1] = "Rainbow"
	end
	if dn:find("gold", 1, true) and dn:find("seed", 1, true) then
		keys[#keys + 1] = "Gold"
	end
	local seen = {}
	local out = {}
	for _, k in ipairs(keys) do
		if not seen[k] then
			seen[k] = true
			out[#out + 1] = k
		end
	end
	return out
end

function snapshotEventSeeds(keys)
	local snap = {}
	for _, k in ipairs(keys) do
		snap[k] = getOwnedSeedCount(k)
	end
	return snap
end

function eventSeedsIncreased(before, keys)
	for _, k in ipairs(keys) do
		if getOwnedSeedCount(k) > (before[k] or 0) then
			return true
		end
	end
	return false
end

function isActiveMapSeedSpawn(item)
	if not item or not item.Parent then
		return false
	end
	local folder = item.Parent.Name
	if folder == "SeedPackSpawnClient" then
		return false
	end
	if folder == "DroppedItems" then
		return isValuableEventDrop(item)
	end
	if folder == "SeedPackSpawnServerLocations" then
		if item:GetAttribute("RainbowSeed") == true then
			return true
		end
		if item:GetAttribute("GoldSeed") == true then
			return true
		end
		local sp = item:GetAttribute("SeedPack")
		if type(sp) == "string" and sp ~= "" then
			return true
		end
		if isEventWeatherActive() then
			return true
		end
		return false
	end
	return isValuableEventDrop(item)
end

function forceTouchCollect(item, pos)
	local hrp = getHRP()
	if not hrp or not pos then
		return
	end
	local part = getDropPrimaryPart(item)
	if part and part:IsA("BasePart") then
		pcall(function()
			part.CanTouch = true
		end)
	end
	pcall(function()
		hrp.CanTouch = true
	end)
	hrp.CFrame = CFrame.new(pos + Vector3.new(0, 1.2, 0))
	pcall(function()
		hrp.AssemblyLinearVelocity = Vector3.zero
	end)
	pcall(function()
		hrp.AssemblyAngularVelocity = Vector3.zero
	end)
end

function getDropPrimaryPart(item)
	if not item or not item.Parent then
		return nil
	end
	if item:IsA("BasePart") then
		return item
	end
	if item:IsA("Model") then
		return item.PrimaryPart or item:FindFirstChildWhichIsA("BasePart")
	end
	return nil
end

function isDropReady(item)
	if not item or not item.Parent then
		return false
	end
	if item:GetAttribute("RainbowSeed") == true then
		return true
	end
	if item:GetAttribute("GoldSeed") == true then
		return true
	end
	if item:GetAttribute("SeedPack") then
		return true
	end
	local dn = item:GetAttribute("DisplayName") or item:GetAttribute("ItemName")
	if type(dn) == "string" and dn ~= "" then
		return true
	end
	local name = item.Name:lower()
	if name:find("rainbow") or name:find("gold") or name:find("seedpack") then
		return true
	end
	return isEventWeatherActive()
end

function waitForDropReady(item, timeout)
	timeout = timeout or CFG.eventReadyTimeout
	local t0 = os.clock()
	while item.Parent and os.clock() - t0 < timeout do
		if isDropReady(item) then
			return true
		end
		task.wait(0.05)
	end
	return isDropReady(item)
end

function clearRushFlagsIfStale(maxAge)
	maxAge = maxAge or 4
	local now = os.clock()
	local g = getgenv()
	if g.GAG2_RUSH_SEED then
		local at = tonumber(g.GAG2_RUSH_SEED_AT) or 0
		if at == 0 or (now - at) > maxAge then
			g.GAG2_RUSH_SEED = false
			g.GAG2_RUSH_SEED_AT = nil
			wr("[RUSH] cleared stale GAG2_RUSH_SEED")
		end
	end
	if g.GAG2_RUSH_PET then
		local at = tonumber(g.GAG2_RUSH_PET_AT) or 0
		if at == 0 or (now - at) > maxAge then
			g.GAG2_RUSH_PET = false
			g.GAG2_RUSH_PET_AT = nil
		end
	end
end

function tryCollectDrop(item)
	if not item.Parent then
		return true
	end
	if eventDropBusy[item] then
		return false
	end
	eventDropBusy[item] = true
	local rush = isRushSeedDrop(item)
	if rush then
		getgenv().GAG2_RUSH_SEED = true
		getgenv().GAG2_RUSH_SEED_AT = os.clock()
	end
	local spawnWait = rush and (CFG.eventRushSpawnWait or 0.03) or CFG.eventSpawnWait
	local stepWait = rush and 0.03 or 0.08
	local promptWait = rush and 0.03 or 0.06
	local readyTimeout = rush and 0.5 or (CFG.eventReadyTimeout or 1.2)
	local watchKeys = getEventSeedWatchKeys(item)
	if #watchKeys == 0 then
		watchKeys = { "Rainbow", "Gold" }
	end
	local beforeSeeds = snapshotEventSeeds(watchKeys)
	local ok, result = pcall(function()
		if not isActiveMapSeedSpawn(item) then
			return false
		end
		if not waitForDropReady(item, readyTimeout) then
			return false
		end
		if not item.Parent then
			return true
		end
		if eventSeedsIncreased(beforeSeeds, watchKeys) then
			return true
		end
		local pos = getDropPosition(item)
		if not pos then
			return false
		end
		local collectDist = rush and 3 or 5
		local attempts = rush and 8 or 6
		for _ = 1, attempts do
			if not item.Parent then
				return true
			end
			if eventSeedsIncreased(beforeSeeds, watchKeys) then
				return true
			end
			teleportNear(pos + Vector3.new(0, CFG.teleportHeight or 2, 0), collectDist)
			task.wait(spawnWait)
			forceTouchCollect(item, pos)
			task.wait(stepWait)
			for _, desc in item:GetDescendants() do
				if desc:IsA("ProximityPrompt") then
					firePrompt(desc)
					task.wait(promptWait)
				end
			end
			forceTouchCollect(item, pos)
			task.wait(stepWait)
			if not item.Parent then
				return true
			end
			if eventSeedsIncreased(beforeSeeds, watchKeys) then
				return true
			end
		end
		return not item.Parent or eventSeedsIncreased(beforeSeeds, watchKeys)
	end)
	eventDropBusy[item] = nil
	if rush then
		getgenv().GAG2_RUSH_SEED = false
		getgenv().GAG2_RUSH_SEED_AT = nil
	end
	if not ok then
		wr("[EVENT] collect error: " .. tostring(result))
		return false
	end
	return result
end

function collectEventDrops()
	if not CFG.enabled.events then
		return 0
	end
	local eventActive = isEventWeatherActive()
	local drops = workspace:FindFirstChild("DroppedItems")
	local children = {}
	if drops then
		for _, item in drops:GetChildren() do
			if eventActive then
				if shouldCollectDrop(item) then
					table.insert(children, item)
				end
			elseif isValuableEventDrop(item) then
				table.insert(children, item)
			end
		end
	end

	if CFG.collectSeedPacks then
		local map = workspace:FindFirstChild("Map")
		local folders = {
			map and map:FindFirstChild("SeedPackSpawnClient"),
			map and map:FindFirstChild("SeedPackSpawnServerLocations"),
		}
		for _, folder in ipairs(folders) do
			if folder then
				for _, item in folder:GetChildren() do
					if item.Parent and item.Parent.Name == "SeedPackSpawnClient" then
						continue
					end
					if not isActiveMapSeedSpawn(item) then
						continue
					end
					if eventActive or isValuableEventDrop(item) then
						table.insert(children, item)
					end
				end
			end
		end
	end

	if #children == 0 then
		return 0
	end
	local hrp = getHRP()
	local hrpPos = hrp and hrp.Position
	table.sort(children, function(a, b)
		local ra, rb = isRushSeedDrop(a), isRushSeedDrop(b)
		if ra ~= rb then
			return ra
		end
		if hrpPos then
			local pa, pb = getDropPosition(a), getDropPosition(b)
			local da = pa and (pa - hrpPos).Magnitude or math.huge
			local db = pb and (pb - hrpPos).Magnitude or math.huge
			if math.abs(da - db) > 2 then
				return da < db
			end
		end
		local na, nb = getDropDisplayName(a):lower(), getDropDisplayName(b):lower()
		local ar, br = na:find("rainbow", 1, true) ~= nil, nb:find("rainbow", 1, true) ~= nil
		if ar ~= br then
			return ar
		end
		local ag, bg = na:find("gold", 1, true) ~= nil, nb:find("gold", 1, true) ~= nil
		if ag ~= bg then
			return ag
		end
		if na ~= nb then
			return na < nb
		end
		return tostring(a) < tostring(b)
	end)
	local maxN = CFG.eventMaxPerSweep or 24
	local count = 0
	for i = 1, math.min(#children, maxN) do
		local item = children[i]
		if tryCollectDrop(item) then
			count = count + 1
			eventDropsSinceStatus = eventDropsSinceStatus + 1
			local label = getDropDisplayName(item)
			if isRushSeedDrop(item) then
				wr("[SEED RUSH] Got " .. label)
			else
				wr("[EVENT] Got " .. label)
			end
		end
	end
	if eventActive and count > 0 then
		wr(string.format("[EVENT] Sweep %d/%d", count, #children))
	end
	return count
end

function collectEventBurst()
	-- Burst not only during rainbow/starfall WEATHER, but whenever gold/rainbow
	-- SEED drops are present (e.g. "Golden Moon" gold-seed rain is NOT a weather
	-- in WeatherData, so the old isEventWeatherActive() check missed it entirely).
	local burstNow = isEventWeatherActive() or hasRushSeedsVisible()
	if not CFG.eventBurstDuringWeather or not burstNow then
		return collectEventDrops()
	end
	fpsBurstBegin()
	local total, burstEnd = 0, os.clock() + (CFG.eventBurstMaxSeconds or 6)
	while os.clock() < burstEnd do
		local n = collectEventDrops()
		total = total + n
		if n == 0 then
			break
		end
		task.wait(CFG.eventRushInterval or CFG.eventCollectIntervalWeather or 0.06)
	end
	fpsBurstEnd()
	return total
end

local function onEventDropAdded(item)
	local st = getFarmState()
	if not st or not st.events or not CFG.enabled.events then
		return
	end
	if not item or not item.Parent then
		return
	end
	if item.Parent.Name == "SeedPackSpawnClient" then
		return
	end
	if not isActiveMapSeedSpawn(item) then
		return
	end
	local rush = isRushSeedDrop(item)
	if not rush and not shouldCollectDrop(item) then
		return
	end
	safeDefer(rush and "seedRushInstant" or "eventInstant", function()
		task.wait(rush and 0.01 or 0.04)
		if not item.Parent then
			return
		end
		if tryCollectDrop(item) then
			local label = getDropDisplayName(item)
			wr(rush and ("[SEED RUSH] instant: " .. label) or ("[EVENT] Instant: " .. label))
		end
	end)
end

function markPetOwned(name)
	if not name or name == "" then
		return
	end
	name = normalizePetName(name) or name
	if not isWantedPet(name) then
		return false
	end
	ownedPetCache[name] = true
	-- Only persist wanted pets (Deer + priority rares), not Bunny/Owl/Frog clutter.
	saveOwnedPets()
	return true
end

function extractPetName(payload)
	if type(payload) == "string" then
		return looksLikeGuid(payload) and nil or payload
	end
	if type(payload) ~= "table" then
		return nil
	end
	return payload.Name or payload.PetName or payload.Type or payload.PetType or payload.DisplayName or payload.ItemName
end

function normalizePetName(raw)
	if type(raw) ~= "string" or raw == "" then
		return nil
	end
	if getPetPriority(raw) > 0 then
		return raw
	end
	local compact = raw:gsub("%s+", ""):lower()
	for name in pairs(PET_PRIORITY) do
		if compact == name:gsub("%s+", ""):lower() then
			return name
		end
	end
	for name in pairs(PET_PRIORITY) do
		local n = name:gsub("%s+", ""):lower()
		if compact:find(n, 1, true) then
			return name
		end
	end
	return nil
end

function looksLikeGuid(value)
	return type(value) == "string"
		and value:match("^%x%x%x%x%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%x%x%x%x%x%x%x%x$") ~= nil
end

-- ===== Pet policy (config-driven, from CFG.pets) =====
-- farm     = equipped for utility (Deer = +10% grow speed)
-- priority = rare pets we always tame and mail to main (never equipped)
local _petPolicyCache = nil
function invalidatePetPolicyCache()
	_petPolicyCache = nil
end
function petPolicy()
	if _petPolicyCache then
		return _petPolicyCache
	end
	local function setOf(list)
		local out = {}
		if type(list) == "table" then
			for _, raw in ipairs(list) do
				local n = normalizePetName(raw) or raw
				if type(n) == "string" and n ~= "" then
					out[n] = true
				end
			end
		end
		return out
	end
	local p = CFG.pets or {}
	_petPolicyCache = { farm = setOf(p.farm), priority = setOf(p.priority) }
	return _petPolicyCache
end

function isFarmPet(name)
	name = normalizePetName(name) or name
	return petPolicy().farm[name] == true
end

function isPriorityPet(name)
	name = normalizePetName(name) or name
	return petPolicy().priority[name] == true
end

-- Any pet we deliberately want (tame on sight): farm utility OR rare priority.
function isWantedPet(name)
	return isFarmPet(name) or isPriorityPet(name)
end

-- Unequipped pets the server will accept for RequestEquipByName — mirrors PetEquipController:
-- tonumber(Inventory.Pets[petName]) or Inventory[altFolder][petName].
function getEquipablePetFolderCount(name)
	name = normalizePetName(name) or name
	if type(name) ~= "string" or name == "" then
		return 0
	end
	local inv = getPlayerInventory()
	if not inv then
		return 0
	end
	local alt = PET_INV_ALT_FOLDERS[name]
	if alt and type(inv[alt]) == "table" then
		local n = tonumber(inv[alt][name])
		if n and n > 0 then
			return n
		end
	end
	if type(inv.Pets) == "table" then
		local n = tonumber(inv.Pets[name])
		if n and n > 0 then
			return n
		end
		-- Do NOT count GUID-keyed pet tools ({[guid]={Name=...,PetId=...}}) here:
		-- PetEquipController ignores tools with PetId and RequestEquipByName only
		-- works for legacy count/folder pets. GUID pets remain owned/mail-able, but
		-- are not equipable through this controller.
	end
	return 0
end

-- name -> owned count (folder counts + per-GUID entries) from the inventory replica.
function countOwnedPetsByName()
	local counts = {}
	local inv = getPlayerInventory()
	if inv and type(inv.Pets) == "table" then
		for k, v in pairs(inv.Pets) do
			if type(k) == "string" and not looksLikeGuid(k) and type(v) == "number" and v > 0 then
				local name = normalizePetName(k) or k
				counts[name] = (counts[name] or 0) + v
			elseif type(v) == "table" then
				local name = normalizePetName(extractPetName(v))
					or (looksLikeGuid(k) and petNameById(k))
					or (type(v) == "string" and normalizePetName(v))
				if name then
					counts[name] = (counts[name] or 0) + 1
				end
			elseif type(v) == "string" then
				local id = looksLikeGuid(k) and k or (looksLikeGuid(v) and v or nil)
				local name = looksLikeGuid(v) and nil or normalizePetName(v)
				if not name and type(k) == "string" and not looksLikeGuid(k) then
					name = normalizePetName(k)
				end
				if name then
					counts[name] = (counts[name] or 0) + 1
				end
			end
		end
	end
	for name, _ in pairs(PET_INV_ALT_FOLDERS) do
		local folderCount = getEquipablePetFolderCount(name)
		if folderCount > (counts[name] or 0) then
			counts[name] = folderCount
		end
	end
	return counts
end

function waitForPetFolder(name, timeout)
	name = normalizePetName(name) or name
	timeout = timeout or 8
	local deadline = os.clock() + timeout
	while os.clock() < deadline do
		if getEquipablePetFolderCount(name) > 0 then
			return true
		end
		task.wait(0.25)
	end
	return getEquipablePetFolderCount(name) > 0
end

function extractPetId(payload)
	if type(payload) == "string" then
		return looksLikeGuid(payload) and payload or nil
	end
	if type(payload) ~= "table" then
		return nil
	end
	local id = payload.Id or payload.ID or payload.PetId or payload.PetID or payload.UUID or payload.Guid
	return type(id) == "string" and id or nil
end

function rememberPet(name, id, equipKey)
	name = normalizePetName(name)
	if not name or getPetPriority(name) <= 0 then
		return
	end
	markPetOwned(name)
	if id and id ~= "" then
		petIdToName[id] = name
		petIdByName[name] = id
		petIdsByName[name] = petIdsByName[name] or {}
		local seen = false
		for _, pid in ipairs(petIdsByName[name]) do
			if pid == id then
				seen = true
				break
			end
		end
		if not seen then
			table.insert(petIdsByName[name], id)
		end
	end
	if equipKey and equipKey ~= "" then
		petEquipKeyByName[name] = equipKey
	end
end

function getPetIdsByName(name)
	if not name then
		return {}
	end
	local ids = petIdsByName[name]
	if ids and #ids > 0 then
		return ids
	end
	local one = petIdByName[name]
	return one and { one } or {}
end

function petNameById(id)
	if not id then
		return nil
	end
	if petIdToName[id] then
		return petIdToName[id]
	end
	for name, pid in pairs(petIdByName) do
		if pid == id then
			return name
		end
	end
end

function scanOwnedPetsFromInventory()
	local seen, count = {}, 0
	local function notePet(name, id, equipKey)
		name = normalizePetName(name)
		if not name then
			return
		end
		if not seen[name] then
			count = count + 1
		end
		seen[name] = true
		rememberPet(name, id, equipKey)
	end

	local function scanStateTable(tbl, depth)
		if type(tbl) ~= "table" or depth > 4 then
			return
		end
		for k, v in pairs(tbl) do
			if type(v) == "table" then
				local id = extractPetId(v) or (looksLikeGuid(k) and k or nil)
				local name = extractPetName(v)
				if not name and type(k) == "string" and not looksLikeGuid(k) then
					name = normalizePetName(k)
				end
				if id and name then
					notePet(name, id, id)
				end
				scanStateTable(v, depth + 1)
			elseif type(v) == "string" then
				local id = looksLikeGuid(k) and k or (looksLikeGuid(v) and v or nil)
				local name = looksLikeGuid(v) and nil or v
				if not name and type(k) == "string" and not looksLikeGuid(k) then
					name = k
				end
				if id and name then
					notePet(name, id, id)
				end
			end
		end
	end

	local ok, state = pcall(function()
		local mod = RS:FindFirstChild("ClientModules") and RS.ClientModules:FindFirstChild("PlayerStateClient")
		if not mod then
			return nil
		end
		local client = require(mod)
		local replica = client.GetLocalReplica and client:GetLocalReplica()
		return replica and replica.Data
	end)
	if ok and type(state) == "table" and type(state.Inventory) == "table" then
		scanStateTable(state.Inventory.Pets, 0)
		if count > 0 then
			return seen, count
		end
	end

	local function scan(container)
		if not container then
			return
		end
		for _, item in container:GetChildren() do
			if item:IsA("Tool") then
				local name = item:GetAttribute("PetName")
					or item:GetAttribute("Pet")
					or item:GetAttribute("PetTool")
					or item.Name
				local id = item:GetAttribute("PetId")
					or item:GetAttribute("PetID")
					or item:GetAttribute("Id")
					or item:GetAttribute("UUID")
				notePet(name, id, id or item.Name)
			end
		end
	end
	scan(LP:FindFirstChildOfClass("Backpack"))
	scan(LP.Character)
	return seen, count
end

function parseEquippedPetsRemote(raw)
	local entries, seen = {}, {}
	local function add(name, id)
		id = type(id) == "string" and id or nil
		name = normalizePetName(name)
		local dedupe = id or name
		if not dedupe or seen[dedupe] then
			return
		end
		seen[dedupe] = true
		if name then
			rememberPet(name, id, id)
		end
		table.insert(entries, { name = name, id = id })
	end

	if type(raw) == "string" then
		if looksLikeGuid(raw) then
			add(petNameById(raw), raw)
		else
			add(raw, nil)
		end
		return entries
	end
	if type(raw) ~= "table" then
		return entries
	end

	-- Probe: GetEquippedPets returns { [guid] = { Equipped=true, Name=... } }, not an array.
	for key, payload in pairs(raw) do
		local id = extractPetId(payload)
		if not id and looksLikeGuid(key) then
			id = key
		end
		if type(payload) == "table" and payload.Equipped == false then
			continue
		end
		local name = extractPetName(payload)
		if not name and id then
			name = petNameById(id)
		end
		if not name and type(key) == "string" and not looksLikeGuid(key) then
			name = normalizePetName(key)
		end
		if name or id then
			add(name, id)
		end
	end
	return entries
end

function getEquippedPetEntries()
	local entries, seen = {}, {}
	local function merge(list)
		for _, entry in ipairs(list) do
			local key = entry.id or entry.name
			if key and not seen[key] then
				seen[key] = true
				table.insert(entries, entry)
			end
		end
	end

	local pn = getPetNet()
	if pn and pn.GetEquippedPets then
		local fn = pn.GetEquippedPets.Invoke or pn.GetEquippedPets.Fire
		local ok, r = pcall(fn, pn.GetEquippedPets)
		if ok then
			merge(parseEquippedPetsRemote(r))
		end
	end

	local refs = workspace:FindFirstChild("PlayerPetReferences")
	if refs then
		local fromRefs = {}
		-- Current game format: Workspace.PlayerPetReferences.<PlayerName>.PetPartN
		-- with attrs PetSpecies/PetId. PetPart itself has no OwnerUserId, so the
		-- old owner-attribute scan never saw equipped/follower pets.
		local ownFolder = refs:FindFirstChild(LP.Name)
		if ownFolder then
			for _, ref in ownFolder:GetChildren() do
				local name = ref:GetAttribute("PetSpecies") or ref:GetAttribute("PetName") or ref:GetAttribute("Name")
				local id = ref:GetAttribute("PetId")
					or ref:GetAttribute("PetID")
					or ref:GetAttribute("Id")
					or ref:GetAttribute("UUID")
				if looksLikeGuid(ref.Name) and not id then
					id = ref.Name
				end
				local norm = normalizePetName(name) or (id and petNameById(id))
				if norm or id then
					table.insert(fromRefs, { name = norm, id = id })
				end
			end
		end
		for _, ref in refs:GetDescendants() do
			local owner = ref:GetAttribute("OwnerUserId") or ref:GetAttribute("UserId")
			if owner == LP.UserId then
				local name = ref:GetAttribute("PetSpecies") or ref:GetAttribute("PetName") or ref:GetAttribute("Name")
				local id = ref:GetAttribute("PetId")
					or ref:GetAttribute("PetID")
					or ref:GetAttribute("Id")
					or ref:GetAttribute("UUID")
				if looksLikeGuid(ref.Name) and not id then
					id = ref.Name
				end
				local norm = normalizePetName(name) or (id and petNameById(id))
				if norm or id then
					table.insert(fromRefs, { name = norm, id = id })
				end
			end
		end
		merge(fromRefs)
	end
	return entries
end

function getEquippedPetNamesFromReplica()
	local set = {}
	local inv = getPlayerInventory()
	if not (inv and type(inv.Pets) == "table") then
		return set
	end
	for k, v in pairs(inv.Pets) do
		local id = extractPetId(v) or (looksLikeGuid(k) and k or nil)
		local name = normalizePetName(extractPetName(v)) or (id and petNameById(id))
		if type(v) == "table" and v.Equipped == true then
			if name then
				set[name] = true
			end
		elseif type(v) == "table" then
			if name and id then
				rememberPet(name, id, id)
			end
		end
	end
	return set
end

function getEquippedPetNamesFromTools()
	local set = {}
	local function scan(parent)
		if not parent then
			return
		end
		for _, tool in parent:GetChildren() do
			if tool:IsA("Tool") then
				local raw = tool:GetAttribute("PetName") or tool:GetAttribute("Pet") or tool:GetAttribute("PetTool")
				local name = normalizePetName(raw)
				if name then
					set[name] = true
					rememberPet(
						name,
						tool:GetAttribute("PetId")
							or tool:GetAttribute("PetID")
							or tool:GetAttribute("Id")
							or tool:GetAttribute("UUID"),
						tool.Name
					)
				end
			end
		end
	end
	-- Only held Character tools can be considered active. Backpack pet tools
	-- are merely inventory; follower/equipped state is PlayerPetReferences.
	scan(LP.Character)
	return set
end

function getEquippedPetNameSet()
	local set = {}
	for _, entry in ipairs(getEquippedPetEntries()) do
		if entry.name then
			set[entry.name] = true
		end
	end
	for name in pairs(getEquippedPetNamesFromReplica()) do
		set[name] = true
	end
	for name in pairs(getEquippedPetNamesFromTools()) do
		set[name] = true
	end
	return set
end

function isPetEquipped(name)
	if not name then
		return false
	end
	if getEquippedPetNameSet()[name] then
		return true
	end
	local id = petIdByName[name]
	if not id then
		return false
	end
	for _, entry in ipairs(getEquippedPetEntries()) do
		if entry.id == id then
			return true
		end
	end
	return false
end

function tryEquipPetRemote(pn, name)
	-- PetEquipController fires RequestEquipByName(u13) where u13 is the pet display name,
	-- but the server only equips when Inventory.Pets[name] (folder count) is > 0.
	if not pn or type(name) ~= "string" or name == "" then
		return false
	end
	if os.clock() < (petEquipFailUntil[name] or 0) then
		return false
	end
	local folder = getEquipablePetFolderCount(name)
	local equipped = countEquippedByName(name)
	if folder <= equipped then
		if CFG.verboseLogs and os.clock() - lastPetEquipFailLog > 10 then
			lastPetEquipFailLog = os.clock()
			wr(
				string.format(
					"[PET] skip equip %s: folder=%d equipped=%d (need folder count > 0)",
					name,
					folder,
					equipped
				)
			)
		end
		return false
	end
	local remote = pn.RequestEquipByName or pn.RequestEquip
	if not remote or not remote.Fire then
		return false
	end
	local ok, err = pcall(remote.Fire, remote, name)
	if not ok then
		if CFG.verboseLogs then
			wr(string.format("[PET] equip fire error %s: %s", name, tostring(err)))
		end
		return false
	end
	if isFailMessage(err) then
		if CFG.verboseLogs and os.clock() - lastPetEquipFailLog > 8 then
			lastPetEquipFailLog = os.clock()
			wr(string.format("[PET] equip rejected %s: %s", name, tostring(err)))
		end
		return false
	end
	return true
end

-- Authoritative equipped-count for a pet name, from GetEquippedPets() ({Name,Id} array).
function countEquippedByName(name)
	if not name then
		return 0
	end
	local n = 0
	for _, e in ipairs(getEquippedPetEntries()) do
		if e.name == name then
			n = n + 1
		end
	end
	return n
end

function findPetToolByName(name)
	name = normalizePetName(name) or name
	local function scan(parent)
		if not parent then
			return nil
		end
		for _, tool in parent:GetChildren() do
			if tool:IsA("Tool") then
				local raw = tool:GetAttribute("Pet")
					or tool:GetAttribute("PetName")
					or tool:GetAttribute("PetTool")
					or tool.Name
				local tn = normalizePetName(raw) or raw
				local id = tool:GetAttribute("PetId")
					or tool:GetAttribute("PetID")
					or tool:GetAttribute("Id")
					or tool:GetAttribute("UUID")
				if tn == name and type(id) == "string" and id ~= "" then
					return tool, id
				end
			end
		end
	end
	return scan(LP:FindFirstChildOfClass("Backpack")) or scan(LP.Character)
end

function togglePetFollowerByTool(name)
	local pn = getPetNet()
	if not (pn and pn.RequestToggleFollower) then
		return false
	end
	local tool, id = findPetToolByName(name)
	if not id then
		return false
	end
	local before = countEquippedByName(name)
	local ok, err = pcall(pn.RequestToggleFollower.Fire, pn.RequestToggleFollower, id)
	if not ok then
		if CFG.verboseLogs then
			wr("[PET] follower toggle error " .. tostring(name) .. ": " .. tostring(err))
		end
		return false
	end
	task.wait(0.6)
	if countEquippedByName(name) > before then
		wr("[PET] follower enabled: " .. tostring(name))
		return true
	end
	-- If it was already enabled, count won't rise; treat as success when present.
	return countEquippedByName(name) > 0
end

-- Equip ONE more copy of `name`; returns true only if the equipped count rises.
function equipPetOne(name)
	if not name or not petInventoryReady() then
		return false
	end
	local pn = getPetNet()
	if not pn then
		return false
	end
	name = normalizePetName(name) or name
	-- Modern GUID pet tools use RequestToggleFollower(PetId). RequestEquipByName
	-- only works for legacy count/folder pets.
	if togglePetFollowerByTool(name) then
		return true
	end
	if not (pn.RequestEquipByName or pn.RequestEquip) then
		return false
	end
	if getEquipablePetFolderCount(name) <= countEquippedByName(name) then
		return false
	end
	local before = countEquippedByName(name)
	for attempt = 1, 3 do
		if tryEquipPetRemote(pn, name) then
			task.wait(attempt == 1 and 0.35 or 0.45)
			if countEquippedByName(name) > before then
				return true
			end
		end
		task.wait(0.15)
	end
	if countEquippedByName(name) <= before then
		petEquipFailUntil[name] = os.clock() + 20
		if CFG.verboseLogs and os.clock() - lastPetEquipFailLog > 8 then
			lastPetEquipFailLog = os.clock()
			wr(
				string.format(
					"[PET] equip failed %s: folder=%d before=%d after=%d",
					name,
					getEquipablePetFolderCount(name),
					before,
					countEquippedByName(name)
				)
			)
		end
	end
	return countEquippedByName(name) > before
end

-- Back-compat helper: ensure at least one of `name` is equipped.
function equipPet(name)
	if not name then
		return false
	end
	if countEquippedByName(name) > 0 then
		return true
	end
	return equipPetOne(name)
end

function unequipPet(pet)
	local pn = getPetNet()
	if not pn then
		return false
	end
	local name = type(pet) == "table" and pet.name or pet
	local id = type(pet) == "table" and pet.id or petIdByName[name]
	if id and pn.RequestUnequip then
		local ok = callRemote(pn.RequestUnequip, id)
		if ok then
			return true
		end
	end
	if name and pn.RequestUnequipByName then
		return callRemote(pn.RequestUnequipByName, name)
	elseif name and pn.RequestUnequip then
		return callRemote(pn.RequestUnequip, name)
	end
	return false
end

local lastPetTargetKey = ""
local lastPetManageDiagLog = 0

function farmPetStatusString(owned)
	local parts = {}
	for _, raw in ipairs((CFG.pets and CFG.pets.farm) or {}) do
		local name = normalizePetName(raw) or raw
		if type(name) == "string" and name ~= "" then
			table.insert(
				parts,
				string.format(
					"%s folder=%d owned=%d equipped=%d",
					name,
					getEquipablePetFolderCount(name),
					owned and (owned[name] or 0) or 0,
					countEquippedByName(name)
				)
			)
		end
	end
	return #parts > 0 and table.concat(parts, "; ") or "(no farm pets configured)"
end

-- Equip the configured FARM pets (Deer) for the grow-speed bonus; unequip
-- everything else (rares are mailed to main, commons are useless for farming).
function managePets()
	if not CFG.enabled.pets then
		return 0
	end
	if not petInventoryReady() then
		if CFG.verboseLogs and os.clock() - lastPetManageDiagLog > 20 then
			lastPetManageDiagLog = os.clock()
			wr("[PET] manager: inventory replica not ready")
		end
		return 0
	end
	if shouldDeferForTutorial() then
		return 0
	end

	scanOwnedPetsFromInventory() -- warm id/name caches
	local maxSlots = LP:GetAttribute("MaxEquippedPets") or 3
	local owned = countOwnedPetsByName()

	-- Desired equip/follower multiset = farm pets, in config order, capped by slots + ownership.
	-- Modern GUID pet tools are follower-toggled by PetId; legacy count pets use RequestEquipByName.
	local desiredByName, desiredTotal = {}, 0
	for _, raw in ipairs((CFG.pets and CFG.pets.farm) or {}) do
		if desiredTotal >= maxSlots then
			break
		end
		local nm = normalizePetName(raw) or raw
		local ownedCount = owned[nm] or getEquipablePetFolderCount(nm)
		local want = math.min(ownedCount or 0, maxSlots - desiredTotal)
		if want > 0 then
			desiredByName[nm] = (desiredByName[nm] or 0) + want
			desiredTotal = desiredTotal + want
		end
	end
	if desiredTotal == 0 and CFG.verboseLogs and os.clock() - lastPetManageDiagLog > 20 then
		lastPetManageDiagLog = os.clock()
		wr("[PET] farm target missing: " .. farmPetStatusString(owned))
	end

	local equipped = getEquippedPetEntries()
	local remaining = {}
	for nm, c in pairs(desiredByName) do
		remaining[nm] = c
	end

	-- Unequip undesired (rares queued for mail, useless commons, extra copies).
	local changed = 0
	for _, e in ipairs(equipped) do
		local nm = e.name
		if nm and (remaining[nm] or 0) > 0 then
			remaining[nm] = remaining[nm] - 1
		else
			if unequipPet(e) then
				changed = changed + 1
			end
			task.wait(0.08)
		end
	end

	-- Equip the shortfall of farm pets.
	for nm, need in pairs(remaining) do
		for _ = 1, need do
			if equipPetOne(nm) then
				changed = changed + 1
			end
			task.wait(0.1)
		end
	end

	local actual = {}
	for _, e in ipairs(getEquippedPetEntries()) do
		if e.name then
			actual[#actual + 1] = e.name
		end
	end
	table.sort(actual)
	lastEquippedTarget = actual
	local key = table.concat(actual, ",")
	if key ~= lastPetTargetKey then
		lastPetTargetKey = key
		if desiredTotal == 0 and next(owned) then
			wr("[PET] no farm pet (Deer) owned yet — taming priority/farm wild pets")
		else
			wr("[PET] equipped: " .. (key ~= "" and key or "(none)"))
		end
	end
	return changed
end

function getWildPetRefs()
	local map = workspace:FindFirstChild("Map")
	local folder = map and map:FindFirstChild("WildPetRef")
	if not folder then
		return {}
	end
	local refs = {}
	for _, inst in folder:GetChildren() do
		if inst:IsA("BasePart") and inst.Parent then
			local ownerId = inst:GetAttribute("OwnerUserId")
			if ownerId == nil or ownerId == 0 then
				table.insert(refs, inst)
			end
		end
	end
	table.sort(refs, function(a, b)
		local pa = getPetPriority(a:GetAttribute("PetName") or "")
		local pb = getPetPriority(b:GetAttribute("PetName") or "")
		return pa > pb
	end)
	return refs
end

function isRushWildPet(petName)
	local pri = getPetPriority(petName)
	return pri >= (CFG.smartPets.rushPriority or 70)
end

function getWildPetTopPriority()
	local top = 0
	for _, ref in ipairs(getWildPetRefs()) do
		local p = getPetPriority(ref:GetAttribute("PetName") or "")
		if p > top then
			top = p
		end
	end
	return top
end

function wildPetShouldBuy(petName, price, rarity)
	petName = normalizePetName(petName) or petName
	-- Only ever tame pets named in CFG.pets (priority rares + farm Deer). Everything
	-- else (Bunny/Owl/Frog/...) is useless for farming and is ignored.
	if not isWantedPet(petName) then
		return false
	end
	if type(price) ~= "number" or price <= 0 then
		return false
	end

	-- Farm pets (Deer): only buy enough to fill the equip slots.
	if isFarmPet(petName) and not isPriorityPet(petName) then
		local maxSlots = LP:GetAttribute("MaxEquippedPets") or 3
		if (countOwnedPetsByName()[petName] or 0) >= maxSlots then
			return false
		end
	end
	-- Priority rares are never capped: we want as many as possible to mail to main.

	local money = getMoney()
	if isRushWildPet(petName) then
		local reserve = CFG.minMoneyKeep or 500
		local maxFrac = CFG.smartPets.rushMaxSpendFraction or 0.65
		return money >= price + reserve and price <= money * maxFrac
	end

	local reserve = math.max(CFG.minMoneyKeep, CFG.smartPets.reserveFlat, money * CFG.smartPets.reserveFraction)
	if money - price < reserve then
		return false
	end
	if price > money * CFG.smartPets.maxSpendFraction then
		return false
	end
	return true
end

local recentlyTamed = {}
local rushPetLock = false

function tryTameWildPet(ref, pn, forceRush)
	if recentlyTamed[ref] then
		return false
	end
	local petName = ref:GetAttribute("PetName") or "?"
	local price = ref:GetAttribute("Price")
	local rarity = ref:GetAttribute("Rarity")
	if not wildPetShouldBuy(petName, price, rarity) then
		return false
	end

	local rush = forceRush or isRushWildPet(petName)
	if rush then
		rushPetLock = true
		getgenv().GAG2_RUSH_PET = true
		getgenv().GAG2_RUSH_PET_AT = os.clock()
	end

	local hrp = getHRP()
	if hrp then
		hrp.CFrame = CFrame.new(ref.Position + Vector3.new(0, CFG.teleportHeight, 0))
	end
	fpsBurstBegin()
	_RunSvc.Heartbeat:Wait()
	local moneyBefore = getMoney()
	local attempts = rush and (CFG.wildPetRushAttempts or CFG.smartPets.rushAttempts or 10)
		or CFG.wildPetMaxTameAttempts
	local retryWait = rush and 0.02 or 0.1
	local confirmWait = rush and 0.04 or 0.18

	for i = 1, attempts do
		if not ref.Parent then
			break
		end
		local ok, err = callRemote(pn.WildPetTame, ref)
		if ok then
			task.wait(confirmWait)
			if getMoney() < moneyBefore then
				recentlyTamed[ref] = true
				ref.Destroying:Once(function()
					recentlyTamed[ref] = nil
				end)
				markPetOwned(petName)
				reportPetAcquired(petName, nil, "wild")
				if rush then
					wr(string.format("[PET RUSH] got %s for $%.0f (%.2fs)", petName, price, i * retryWait))
				end
				if rush then
					rushPetLock = false
					getgenv().GAG2_RUSH_PET = false
					getgenv().GAG2_RUSH_PET_AT = nil
				end
				fpsBurstEnd()
				return true, petName, price, moneyBefore - getMoney()
			end
		elseif err and isFailMessage(err) then
			break
		end
		task.wait(retryWait)
	end

	if rush then
		rushPetLock = false
		getgenv().GAG2_RUSH_PET = false
		getgenv().GAG2_RUSH_PET_AT = nil
	end
	fpsBurstEnd()
	return false
end

function tameWildPets(opts)
	opts = opts or {}
	if not CFG.enabled.wildPets then
		return 0
	end
	local pn = getPetNet()
	if not pn or not pn.WildPetTame then
		return 0
	end
	local refs = getWildPetRefs()
	if #refs == 0 then
		return 0
	end

	local rushTamed, normalTamed = 0, 0
	local rushLimit = opts.rushOnly and (CFG.smartPets.rushMaxPerCycle or 3) or (CFG.smartPets.rushMaxPerCycle or 3)
	local normalLimit = opts.rushOnly and 0 or (CFG.smartPets.maxPerCycle or 1)

	for _, ref in ipairs(refs) do
		if not ref.Parent then
			continue
		end
		local petName = ref:GetAttribute("PetName") or "?"
		local rush = isRushWildPet(petName)
		if opts.rushOnly and not rush then
			continue
		end
		if rush and rushTamed >= rushLimit then
			if normalLimit == 0 then
				break
			end
			continue
		end
		if not rush and normalTamed >= normalLimit then
			break
		end

		local ok, name, price, spent = tryTameWildPet(ref, pn, rush)
		if ok then
			if rush then
				rushTamed = rushTamed + 1
			else
				normalTamed = normalTamed + 1
			end
			wr(string.format("[PET] Bought %s for $%.0f (spent $%.0f)%s", name, price, spent, rush and " RUSH" or ""))
			task.spawn(function()
				if waitForPetFolder(name, 10) then
					managePets()
				else
					wr("[PET] waiting for " .. tostring(name) .. " inventory folder (walk-to-garden)")
				end
			end)
		end
	end
	return rushTamed + normalTamed
end

function hookWildPetSpawns()
	if not CFG.wildPetInstantListen then
		return
	end
	getgenv().GAG2_HOOKS = getgenv().GAG2_HOOKS or {}
	if getgenv().GAG2_HOOKS.wildSpawns then
		return
	end
	getgenv().GAG2_HOOKS.wildSpawns = true
	task.spawn(function()
		local map = workspace:WaitForChild("Map", 120)
		if not map then
			return
		end
		local folder = map:WaitForChild("WildPetRef", 120)
		if not folder then
			return
		end

		local function onWildRef(ref)
			local st = getFarmState()
			if not st or not st.wild or not CFG.enabled.wildPets then
				return
			end
			if not ref:IsA("BasePart") then
				return
			end
			safeDefer("wildPetRush", function()
				task.wait()
				if not ref.Parent then
					return
				end
				local ownerId = ref:GetAttribute("OwnerUserId")
				if ownerId and ownerId ~= 0 then
					return
				end
				local name = ref:GetAttribute("PetName") or "?"
				if not isRushWildPet(name) then
					return
				end
				if not wildPetShouldBuy(name, ref:GetAttribute("Price"), ref:GetAttribute("Rarity")) then
					return
				end
				local pn = getPetNet()
				if not pn then
					return
				end
				wr("[PET RUSH] spawn detected: " .. name)
				tryTameWildPet(ref, pn, true)
				-- managePets runs after waitForPetFolder inside tryTameWildPet success path
			end)
		end

		folder.ChildAdded:Connect(onWildRef)
		for _, child in ipairs(folder:GetChildren()) do
			if child:IsA("BasePart") then
				local name = child:GetAttribute("PetName") or ""
				if
					isRushWildPet(name)
					and wildPetShouldBuy(name, child:GetAttribute("Price"), child:GetAttribute("Rarity"))
				then
					task.defer(function()
						onWildRef(child)
					end)
				end
			end
		end
	end)
end

local mailState = {
	last = 0,
	targetUserId = nil,
	targetName = nil,
	lookupLast = 0,
	lookupFail = nil,
	tutorialBlock = false,
	tutorialPassRunning = false,
	tutorialCleared = false,
	tutorialPassLastAt = 0,
	selfTargetWarned = false,
}
local mailClaimState = { last = 0 }
local lastMailActivity = 0

function isMailboxReceiverAccount()
	if not (CFG.mail and CFG.mail.autoClaim) then
		return false
	end
	local target = CFG.mail.targetUsername or ""
	if target ~= "" then
		if LP.Name:lower() == target:lower() then
			return true
		end
		if mailState.targetUserId and mailState.targetUserId == LP.UserId then
			return true
		end
		local resolved = lookupMailTarget and lookupMailTarget()
		if resolved and resolved == LP.UserId then
			return true
		end
	end
	-- alt-only config: autoClaim without targetUsername still collects mail
	return target == ""
end

function parseMailboxTable(box)
	local gifts = {}
	if type(box) ~= "table" then
		return gifts
	end
	local n = 0
	for k, v in pairs(box) do
		n = n + 1
		if type(v) == "table" then
			local gid = v.Id or v.id or v.GiftId or v.GiftID or tostring(k)
			gifts[#gifts + 1] = { id = tostring(gid), gift = v }
		elseif type(k) == "string" or type(k) == "number" then
			gifts[#gifts + 1] = { id = tostring(k), gift = {} }
		end
	end
	if n == 0 and #box > 0 then
		for i, v in ipairs(box) do
			if type(v) == "table" then
				local gid = v.Id or v.id or v.GiftId or v.GiftID or tostring(i)
				gifts[#gifts + 1] = { id = tostring(gid), gift = v }
			end
		end
	end
	return gifts
end

function fetchMailboxGifts()
	local mb = getMailNet()
	if not mb then
		return {}
	end
	local gifts = {}
	if mb.OpenInbox then
		local ok, resp = callRemote(mb.OpenInbox)
		if ok and type(resp) == "table" then
			gifts = parseMailboxTable(resp.Mailbox or resp)
		end
	end
	if #gifts == 0 and mb.List then
		local ok, resp = callRemote(mb.List)
		if ok and type(resp) == "table" then
			gifts = parseMailboxTable(resp.Mailbox or resp)
		end
	end
	return gifts
end

function formatGiftItems(gift)
	gift = gift or {}
	local parts = {}
	local items = gift.Items
	if type(items) == "table" then
		if #items > 0 then
			for _, it in ipairs(items) do
				local cat = it.Category or "?"
				local name = it.ItemName or it.ItemKey or it.Name or "?"
				local cnt = it.Count or 1
				parts[#parts + 1] = cat .. ":" .. tostring(name) .. " x" .. tostring(cnt)
			end
		else
			for k, v in pairs(items) do
				if type(v) == "table" then
					local name = v.ItemName or v.ItemKey or v.Name or tostring(k)
					parts[#parts + 1] = tostring(name) .. " x" .. tostring(v.Count or 1)
				end
			end
		end
	end
	local from = gift.FromName or (gift.From and ("id:" .. tostring(gift.From))) or "?"
	return from, (#parts > 0 and table.concat(parts, ", ") or "gift")
end

function autoClaimMailbox()
	if not isMailboxReceiverAccount() then
		return 0
	end
	local mb = getMailNet()
	if not (mb and mb.Claim) then
		return 0
	end
	if os.clock() - mailClaimState.last < (CFG.mail.claimCooldown or 20) then
		return 0
	end

	local gifts = fetchMailboxGifts()
	if #gifts == 0 then
		return 0
	end

	local claimed, summaries = 0, {}
	local maxClaims = CFG.mail.maxClaimsPerCycle or 8

	for _, entry in ipairs(gifts) do
		if claimed >= maxClaims then
			break
		end
		local giftId = entry.id
		if giftId and giftId ~= "" then
			local ok, success, errMsg = callRemote(mb.Claim, giftId)
			if ok and success == true then
				claimed = claimed + 1
				lastMailActivity = os.clock()
				local from, items = formatGiftItems(entry.gift)
				summaries[#summaries + 1] = items .. " [" .. tostring(from) .. "]"
			else
				wr("[MAIL] claim failed id=" .. giftId .. " err=" .. tostring(errMsg or success))
			end
			task.wait(0.12)
		end
	end

	if claimed > 0 then
		mailClaimState.last = os.clock()
		wr("[MAIL] claimed " .. claimed .. ": " .. table.concat(summaries, " | "))
	end
	return claimed
end

function buildPetWhitelist(list)
	local set, active = {}, false
	if type(list) ~= "table" then
		return set, false
	end
	for _, raw in ipairs(list) do
		local name = normalizePetName(raw) or raw
		if type(name) == "string" and name ~= "" then
			set[name] = true
			active = true
		end
	end
	return set, active
end

function isPetMailTarget(name)
	if not (CFG.mail and CFG.mail.enabled) then
		return false
	end
	name = normalizePetName(name) or name
	if type(name) ~= "string" or name == "" then
		return false
	end
	local petWhitelist, usePetWhitelist = buildPetWhitelist(CFG.mail.pets)
	-- Whitelist OR priority: rare variants like "GoldenDragonfly" keep their own
	-- PET_PRIORITY entry (so normalizePetName won't fold them into "Dragonfly"),
	-- which means a plain {"Dragonfly"} whitelist would miss them. Mailing by
	-- priority threshold auto-covers every valuable pet (incl. gold/variant forms).
	if usePetWhitelist then
		return petWhitelist[name] == true or getPetPriority(name) >= (CFG.mail.minPetPriority or 70)
	end
	if CFG.mail.pets == nil then
		return getPetPriority(name) >= (CFG.mail.minPetPriority or 70)
	end
	return false
end

function buildSeedWhitelist(list)
	local set, active = {}, false
	if type(list) ~= "table" then
		return set, false
	end
	for _, raw in ipairs(list) do
		local name = normalizeSeedName(raw) or raw
		if type(name) == "string" and name ~= "" then
			set[name] = true
			active = true
		end
	end
	return set, active
end

function getPlayerInventory()
	local ok, inv = pcall(function()
		local mod = RS:FindFirstChild("ClientModules") and RS.ClientModules:FindFirstChild("PlayerStateClient")
		if not mod then
			return nil
		end
		local client = require(mod)
		local replica
		if client.WaitForLocalReplica then
			replica = client:WaitForLocalReplica(8)
		end
		if not replica and client.GetLocalReplica then
			replica = client:GetLocalReplica()
		end
		return replica and replica.Data and replica.Data.Inventory
	end)
	if ok and type(inv) == "table" then
		return inv
	end
end

function getEquippedPetIdSet()
	local set = {}
	for _, entry in ipairs(getEquippedPetEntries()) do
		if entry.id then
			set[entry.id] = true
		end
		if entry.name then
			local key = petEquipKeyByName[entry.name] or petIdByName[entry.name]
			if key then
				set[key] = true
			end
		end
	end
	return set
end

function collectReplicaSeedCounts()
	local counts = {}
	local inv = getPlayerInventory()
	if not (inv and type(inv.Seeds) == "table") then
		return counts
	end
	for key, value in pairs(inv.Seeds) do
		local name = normalizeSeedName(key) or key
		local n = 0
		if type(value) == "number" then
			n = value
		elseif type(value) == "table" then
			n = value.Count or value.Amount or value.Quantity or value.Qty or 0
		end
		n = tonumber(n) or 0
		if type(name) == "string" and name ~= "" and n > 0 then
			counts[name] = n
		end
	end
	return counts
end

function collectOwnedSeedCounts()
	-- Replica is authoritative for mail (probe: ItemKey "Rainbow"/"Gold", cat=Seeds).
	-- Tool scan double-counted stacks already mirrored in inv.Seeds -> "don't have that item".
	local counts = collectReplicaSeedCounts()
	if next(counts) ~= nil then
		return counts
	end

	local function add(name, amount)
		name = normalizeSeedName(name) or name
		local n = tonumber(amount) or 0
		if type(name) == "string" and name ~= "" and n > 0 then
			counts[name] = (counts[name] or 0) + n
		end
	end
	local function scanTools(parent)
		if not parent then
			return
		end
		for _, tool in ipairs(parent:GetChildren()) do
			if tool:IsA("Tool") then
				local isSeed = tool:GetAttribute("SeedTool")
					or tool:GetAttribute("RainbowSeed")
					or tool:GetAttribute("GoldSeed")
				if isSeed then
					local name = tool:GetAttribute("SeedTool") or tool.Name
					if tool:GetAttribute("RainbowSeed") then
						name = "Rainbow"
					end
					if tool:GetAttribute("GoldSeed") then
						name = "Gold"
					end
					local qty = tool:GetAttribute("Quantity")
						or tool:GetAttribute("Amount")
						or tool:GetAttribute("Count")
						or tool:GetAttribute("Stack")
					add(name, qty or 1)
				end
			end
		end
	end
	scanTools(LP:FindFirstChildOfClass("Backpack"))
	scanTools(LP.Character)
	return counts
end

-- Event/skip seeds (the ones we never plant, e.g. Rainbow/Gold) + their live inventory
-- counts. Used for the dashboard line ("Rainbow Seed: 23") and the web-cabinet snapshot.
function getEventSeedCounts()
	local want, order = {}, {}
	local function addList(list)
		if type(list) ~= "table" then
			return
		end
		for _, raw in ipairs(list) do
			local n = normalizeSeedName(raw) or raw
			if type(n) == "string" and n ~= "" and not want[n] then
				want[n] = true
				order[#order + 1] = n
			end
		end
	end
	addList(CFG.skipSeeds)
	addList(CFG.eventOnlySeeds)
	if CFG.mail then
		addList(CFG.mail.seeds)
	end

	local owned = collectOwnedSeedCounts()
	local rows = {}
	for _, name in ipairs(order) do
		rows[#rows + 1] = { name = name, count = owned[name] or 0 }
	end
	table.sort(rows, function(a, b)
		if a.count ~= b.count then
			return a.count > b.count
		end
		return a.name < b.name
	end)
	return rows
end

function formatEventSeedLine(rows)
	rows = rows or getEventSeedCounts()
	local parts = {}
	for _, r in ipairs(rows) do
		local label = r.name:lower():find("seed") and r.name or (r.name .. " Seed")
		parts[#parts + 1] = string.format("%s: %d", label, r.count)
	end
	return #parts > 0 and table.concat(parts, "   ") or "-"
end

function collectMailPetCandidates(equippedIds, petWhitelist, usePetWhitelist, usePetPriority)
	local tools, seen = {}, {}
	local function add(name, key)
		name = normalizePetName(name) or name
		key = key and tostring(key) or nil
		if type(name) ~= "string" or name == "" or not key or seen[key] or equippedIds[key] then
			return
		end
		local allowed = false
		if usePetWhitelist then
			-- whitelist OR priority (covers GoldenDragonfly/BlackDragon/etc.)
			allowed = petWhitelist[name] == true or getPetPriority(name) >= (CFG.mail.minPetPriority or 70)
		elseif usePetPriority then
			allowed = getPetPriority(name) >= (CFG.mail.minPetPriority or 70)
		end
		if not allowed then
			return
		end
		seen[key] = true
		table.insert(tools, { name = name, key = key, pri = getPetPriority(name) })
	end

	local inv = getPlayerInventory()
	if inv and type(inv.Pets) == "table" then
		for k, v in pairs(inv.Pets) do
			local key = looksLikeGuid(k) and k or nil
			if type(v) == "table" then
				add(extractPetName(v), extractPetId(v) or key or k)
			elseif type(v) == "string" then
				add(v, key or k)
			elseif key then
				add(k, key)
			end
		end
	end

	local backpack = LP:FindFirstChildOfClass("Backpack")
	if backpack then
		for _, tool in backpack:GetChildren() do
			if tool:IsA("Tool") then
				local name = tool:GetAttribute("PetName")
					or tool:GetAttribute("Pet")
					or tool:GetAttribute("PetTool")
					or tool.Name
				add(name, petToolMailKey(tool))
			end
		end
	end

	return tools
end

function lookupMailTarget(force)
	if not CFG.mail.enabled then
		return nil
	end
	local username = normalizeMailUsername(CFG.mail.targetUsername or "")
	if username == "" then
		return nil
	end
	if mailState.targetUserId and not force then
		return mailState.targetUserId
	end
	if not force and mailState.lookupFail and (os.clock() - mailState.lookupLast) < 45 then
		return nil
	end

	local mb = getMailNet()
	if mb and mb.LookupPlayer then
		local ok, userId, resolvedName = callRemote(mb.LookupPlayer, username)
		if ok and type(userId) == "number" and userId > 0 then
			mailState.targetUserId = userId
			mailState.targetName = resolvedName or username
			mailState.lookupFail = nil
			wr(string.format("[MAIL] target resolved: %s (%d)", tostring(mailState.targetName), userId))
			if userId == LP.UserId and not mailState.selfTargetWarned then
				mailState.selfTargetWarned = true
				wr(
					"[MAIL] target is this account — SendBatch skipped, autoClaim only (set targetUsername to MAIN on farm account)"
				)
			end
			return userId
		end
	end

	local ok2, uid = pcall(function()
		return game:GetService("Players"):GetUserIdFromNameAsync(username)
	end)
	if ok2 and type(uid) == "number" and uid > 0 then
		mailState.targetUserId = uid
		mailState.targetName = username
		mailState.lookupFail = nil
		wr(string.format("[MAIL] target resolved (Players): %s (%d)", username, uid))
		if uid == LP.UserId and not mailState.selfTargetWarned then
			mailState.selfTargetWarned = true
			wr(
				"[MAIL] target is this account — SendBatch skipped, autoClaim only (set targetUsername to MAIN on farm account)"
			)
		end
		return uid
	end

	mailState.lookupLast = os.clock()
	mailState.lookupFail = username
	STATS.mailStatus = "lookup failed: " .. username
	wr("[MAIL] target lookup failed: " .. username)
	reportTelemetry({
		level = "error",
		message = "[MAIL] target lookup failed: " .. username,
		context = { phase = "mail", target = username },
	})
	return nil
end

function petToolMailKey(tool)
	return tool:GetAttribute("PetId")
		or tool:GetAttribute("PetID")
		or tool:GetAttribute("Id")
		or tool:GetAttribute("UUID")
		or tool.Name
end

function autoMailPets()
	if not CFG.mail.enabled then
		return 0
	end
	if not isTutorialMarkedComplete() then
		STATS.mailStatus = "waiting tutorial completion"
		if not mailState.tutorialPassRunning then
			noteMailTutorialBlock("tutorial not marked complete")
		end
		return 0
	end
	if mailState.tutorialBlock then
		STATS.mailStatus = "tutorial in progress"
		return 0
	end
	if os.clock() - mailState.last < (CFG.mail.cooldown or 60) then
		STATS.mailStatus = string.format("cooldown %.0fs", (CFG.mail.cooldown or 60) - (os.clock() - mailState.last))
		return 0
	end
	local mb = getMailNet()
	if not (mb and mb.SendBatch) then
		STATS.mailStatus = "no mailbox remote"
		return 0
	end
	local targetUserId = lookupMailTarget()
	if not targetUserId then
		return 0
	end
	if targetUserId == LP.UserId then
		return autoClaimMailbox()
	end

	local batch, sentNames = {}, {}
	local maxBatch = 20
	local petWhitelist, usePetWhitelist = buildPetWhitelist(CFG.mail.pets)
	local usePetPriority = CFG.mail.pets == nil
	local petSlotsUsed = 0

	for _, entry in ipairs(getEquippedPetEntries()) do
		if entry.name and isPetMailTarget(entry.name) then
			unequipPet(entry)
			task.wait(0.1)
		end
	end

	local equippedIds = getEquippedPetIdSet()

	-- === ПЕТЫ ===
	if usePetWhitelist or usePetPriority then
		local tools = collectMailPetCandidates(equippedIds, petWhitelist, usePetWhitelist, usePetPriority)
		if #tools > 0 then
			table.sort(tools, function(a, b)
				return a.pri > b.pri
			end)
			local keepBest = CFG.mail.keepBestPetCount
			if keepBest == nil then
				keepBest = 0
			end
			for i, entry in ipairs(tools) do
				if i > keepBest and #batch < maxBatch and petSlotsUsed < (CFG.mail.maxPetsPerCycle or 1) then
					table.insert(batch, { Category = "Pets", ItemKey = entry.key, Count = 1 })
					table.insert(sentNames, entry.name .. ":" .. tostring(entry.key))
					petSlotsUsed = petSlotsUsed + 1
				end
			end
		end
	end

	-- === SEEDS === ItemKey is the SeedData SeedName ("Rainbow"/"Gold") — verified in Studio.
	local sentSeeds, seedBefore = {}, nil
	local seedWhitelist, useSeedWhitelist = buildSeedWhitelist(CFG.mail.seeds)
	if useSeedWhitelist then
		local owned = collectReplicaSeedCounts()
		if not next(owned) then
			owned = collectOwnedSeedCounts()
		end
		seedBefore = owned
		local keepMin = CFG.mail.keepSeedMinCount or 0
		local maxPerSeed = CFG.mail.maxPerSeed or 50
		-- A gift holds at most ~20 items total; pets already consumed petSlotsUsed.
		local itemBudget = math.max(0, 20 - petSlotsUsed)
		local maxSeeds = math.min(CFG.mail.maxSeedsPerCycle or 10, itemBudget)
		local seedSent = 0

		local seedNames = {}
		for name in pairs(owned) do
			if seedWhitelist[name] then
				table.insert(seedNames, name)
			end
		end
		table.sort(seedNames, function(a, b)
			return getSeedScore(a) > getSeedScore(b)
		end)

		for _, name in ipairs(seedNames) do
			if seedSent >= maxSeeds then
				break
			end
			local count = owned[name] or 0
			local canSend = math.min(math.max(0, count - keepMin), maxPerSeed, maxSeeds - seedSent)
			if canSend > 0 then
				table.insert(batch, { Category = "Seeds", ItemKey = name, Count = canSend })
				table.insert(sentNames, name .. " x" .. canSend)
				sentSeeds[name] = (sentSeeds[name] or 0) + canSend
				seedSent = seedSent + canSend
			end
		end
	end

	if #batch == 0 then
		STATS.mailStatus = "waiting (no mail items ready)"
		return 0
	end

	local ok, resp, err = callRemote(mb.SendBatch, targetUserId, batch, CFG.mail.message or "GAG2 auto mail")
	if ok then
		mailState.last = os.clock()
		lastMailActivity = os.clock()
		mailState.tutorialCleared = true
		-- Verify the seeds actually left our inventory. The remote can report success
		-- yet drop the items server-side; without this the seeds would silently vanish
		-- instead of reaching main.
		local delivered = true
		if next(sentSeeds) and seedBefore then
			task.wait(0.3)
			local after = collectReplicaSeedCounts()
			if not next(after) then
				after = collectOwnedSeedCounts()
			end
			for name, sent in pairs(sentSeeds) do
				if ((seedBefore[name] or 0) - (after[name] or 0)) < math.min(sent, 1) then
					delivered = false
				end
			end
		end
		if delivered then
			STATS.mailSent = (STATS.mailSent or 0) + #batch
			STATS.mailStatus = "sent " .. table.concat(sentNames, ", ")
			wr(
				"[MAIL] sent to "
					.. tostring(mailState.targetName or targetUserId)
					.. ": "
					.. table.concat(sentNames, ", ")
			)
		else
			STATS.mailStatus = "send reported ok but items not removed"
			wr("[MAIL] WARN: SendBatch ok but inventory unchanged: " .. table.concat(sentNames, ", "))
			reportTelemetry({
				level = "error",
				message = "[MAIL] SendBatch ok but items not removed from inventory",
				context = { phase = "mail", batch = table.concat(sentNames, ", ") },
			})
		end
		return #batch
	end
	local errText = tostring(err or resp or "")
	STATS.mailStatus = "send failed: " .. errText
	wr("[MAIL] send failed: " .. errText .. " batch=" .. table.concat(sentNames, ", "))
	if errText:lower():find("wait") then
		mailState.last = os.clock()
	end
	if errText:lower():find("tutorial") then
		noteMailTutorialBlock(errText)
	elseif not errText:lower():find("wait") then
		reportTelemetry({
			level = "error",
			message = "[MAIL] send failed: " .. errText,
			context = { phase = "mail", batch = table.concat(sentNames, ", ") },
		})
	end
	return 0
end

function learnPetFromPayload(payload)
	rememberPet(extractPetName(payload), extractPetId(payload))
end

function refreshEquippedPetsFromRemote()
	local pn = getPetNet()
	if not pn or not pn.GetEquippedPets then
		return
	end
	local fn = pn.GetEquippedPets.Invoke or pn.GetEquippedPets.Fire
	local ok, r = pcall(fn, pn.GetEquippedPets)
	if not ok then
		return
	end
	for _, entry in ipairs(parseEquippedPetsRemote(r)) do
		if entry.name or entry.id then
			rememberPet(entry.name or petNameById(entry.id), entry.id, entry.id)
		end
	end
end

-- ==========================================================================
--  Natural pet acquisition -> webhook (URLs live ONLY on the license server)
-- ==========================================================================
local lastPetReport = {}
local petGuidBaseline = nil

function reportPetAcquired(name, id, source)
	name = normalizePetName(name) or name
	if type(name) ~= "string" or name == "" then
		return
	end
	if not (CFG.webhook and CFG.webhook.reportPets) then
		return
	end
	local now = os.clock()
	if not isPetMailTarget(name) then
		local skipKey = "skip:" .. name
		if CFG.verboseLogs and (not lastPetReport[skipKey] or (now - lastPetReport[skipKey]) > 60) then
			lastPetReport[skipKey] = now
			wr(string.format("[PET] acquired %s (%s) ignored by policy", name, tostring(source)))
		end
		return
	end
	if lastPetReport[name] and (now - lastPetReport[name]) < 20 then
		return
	end
	lastPetReport[name] = now
	wr(string.format("[PET] acquired %s (%s) -> webhook", name, tostring(source)))
	local fn = getgenv().GAG2_REPORT_EVENT
	if type(fn) == "function" then
		pcall(fn, {
			type = "pet",
			name = name,
			id = id,
			source = source or "natural",
			priority = getPetPriority(name),
			userId = LP.UserId,
			user = LP.Name,
			ts = os.time(),
		})
	end
end

function hookMailboxActivity()
	local mb = getMailNet()
	if not mb then
		return
	end
	getgenv().GAG2_HOOKS = getgenv().GAG2_HOOKS or {}
	if getgenv().GAG2_HOOKS.mailbox then
		return
	end
	getgenv().GAG2_HOOKS.mailbox = true
	pcall(function()
		local upd = mb.Updated or mb.Claim
		if upd and upd.OnClientEvent then
			upd.OnClientEvent:Connect(function()
				lastMailActivity = os.clock()
			end)
		end
	end)
end

function collectOwnedPetGuids()
	local map = {}
	pcall(function()
		local mod = RS:FindFirstChild("ClientModules") and RS.ClientModules:FindFirstChild("PlayerStateClient")
		if not mod then
			return
		end
		local client = require(mod)
		local replica = client.GetLocalReplica and client:GetLocalReplica()
		local data = replica and replica.Data
		local pets = data and data.Inventory and data.Inventory.Pets
		if type(pets) ~= "table" then
			return
		end
		for k, v in pairs(pets) do
			local id = looksLikeGuid(k) and k or extractPetId(v)
			local name = extractPetName(v) or (type(v) == "string" and v) or nil
			name = normalizePetName(name) or name
			if id and type(name) == "string" then
				map[tostring(id)] = name
			end
		end
	end)
	local function scanTools(container)
		if not container then
			return
		end
		for _, item in ipairs(container:GetChildren()) do
			if item:IsA("Tool") then
				local id = item:GetAttribute("PetId")
					or item:GetAttribute("PetID")
					or item:GetAttribute("UUID")
					or item:GetAttribute("Id")
				local name = normalizePetName(
					item:GetAttribute("PetName") or item:GetAttribute("Pet") or item:GetAttribute("PetTool")
				)
				if id and name then
					map[tostring(id)] = name
				end
			end
		end
	end
	scanTools(LP:FindFirstChildOfClass("Backpack"))
	scanTools(LP.Character)
	return map
end

function syncOwnedPetCacheFromLive()
	local guidMap = collectOwnedPetGuids()
	local fresh = {}
	for id, rawName in pairs(guidMap) do
		local name = normalizePetName(rawName)
		if name and isWantedPet(name) then
			fresh[name] = true
			rememberPet(name, id, id)
		end
	end
	for name in pairs(ownedPetCache) do
		if not fresh[name] then
			ownedPetCache[name] = nil
		end
	end
	for name in pairs(fresh) do
		ownedPetCache[name] = true
	end
	saveOwnedPets(true)
	local guidCount = 0
	for _ in pairs(guidMap) do
		guidCount = guidCount + 1
	end
	return guidCount, fresh
end

function liveOwnedPetSummary(maxNames)
	maxNames = maxNames or 5
	local guidMap = collectOwnedPetGuids()
	local byName = {}
	for _, name in pairs(guidMap) do
		name = normalizePetName(name)
		if name then
			byName[name] = (byName[name] or 0) + 1
		end
	end
	local arr = {}
	for name, count in pairs(byName) do
		table.insert(arr, { name = name, pri = getPetPriority(name), count = count })
	end
	table.sort(arr, function(a, b)
		return a.pri > b.pri
	end)
	local best, guidCount = {}, 0
	for _ in pairs(guidMap) do
		guidCount = guidCount + 1
	end
	for i = 1, math.min(maxNames, #arr) do
		local entry = arr[i]
		local label = entry.count > 1 and string.format("%s(%d)x%d", entry.name, entry.pri, entry.count)
			or string.format("%s(%d)", entry.name, entry.pri)
		table.insert(best, label)
	end
	return best, guidCount, byName
end

-- Detect brand-new pet GUIDs (covers natural sources beyond wild taming, e.g. egg
-- hatch). Anything that appears right after mailbox activity is treated as mail.
function detectNewPets()
	if not (CFG.webhook and CFG.webhook.detectNewPets) then
		return
	end
	petDetectTick = petDetectTick + 1
	local every = math.max(tonumber(CFG.wildPetDetectEvery) or 1, 1)
	if petDetectTick % every ~= 0 then
		return
	end
	local cur = collectOwnedPetGuids()
	if petGuidBaseline == nil then
		petGuidBaseline = cur
		return
	end
	for id, name in pairs(cur) do
		if not petGuidBaseline[id] then
			petGuidBaseline[id] = name
			if (os.clock() - lastMailActivity) < (CFG.webhook.mailSuppressSeconds or 60) then
				wr("[PET] new " .. tostring(name) .. " skipped (recent mail activity)")
			else
				reportPetAcquired(name, id, "natural")
			end
		end
	end
end

function hookPetEvents()
	local pn = getPetNet()
	if not pn then
		return
	end
	getgenv().GAG2_HOOKS = getgenv().GAG2_HOOKS or {}
	if getgenv().GAG2_HOOKS.pets then
		return
	end
	getgenv().GAG2_HOOKS.pets = true
	if pn.WildPetCollected and pn.WildPetCollected.OnClientEvent then
		pn.WildPetCollected.OnClientEvent:Connect(function(_, petName)
			local name = normalizePetName(petName) or petName
			if not isWantedPet(name) then
				wr("[PET] ignored wild " .. tostring(petName) .. " (not in policy)")
				return
			end
			markPetOwned(name)
			wr("[PET] Owned: " .. tostring(name))
			reportPetAcquired(name, nil, "wild")
			petEquipFailUntil[name] = nil
			task.delay(0.5, managePets)
		end)
	end
	if pn.PetEquipped and pn.PetEquipped.OnClientEvent then
		pn.PetEquipped.OnClientEvent:Connect(function(a, b)
			learnPetFromPayload(b or a)
		end)
	end
	task.defer(refreshEquippedPetsFromRemote)
end

local lastAntiAfk = 0
local lastRecoverAt = 0
local recoveringFarm = false
local guardJobId = game.JobId

function touchFarmHeartbeat()
	getgenv().GAG2_FARM_HEARTBEAT = os.clock()
end

function farmLoopsAlive()
	local hb = getgenv().GAG2_FARM_HEARTBEAT
	if type(hb) ~= "number" then
		return false
	end
	local stale = (CFG.serverGuard and CFG.serverGuard.staleHeartbeatSec) or 30
	return os.clock() - hb < stale
end

function installAntiKick()
	local ak = CFG.antiKick
	if ak and ak.enabled == false then
		return
	end
	if not CFG.enabled.antiAfk then
		return
	end
	if getgenv().GAG2_ANTIKICK_GEN == FARM_GEN then
		return
	end
	getgenv().GAG2_ANTIKICK_GEN = FARM_GEN
	local kickSec = tonumber(ak and ak.idleKickSec) or 600
	pcall(function()
		LP.Idled:Connect(function(idleTime)
			if idleTime < kickSec then
				return
			end
			pcall(function()
				local vu = game:GetService("VirtualUser")
				vu:CaptureController()
				vu:ClickButton2(Vector2.new())
			end)
			wr("[GUARD] anti-kick: VirtualUser idle reset")
		end)
	end)
end

function restartFarmLoops(reason)
	if not farmGenActive() then
		return false
	end
	wr("[GUARD] restarting farm loops (" .. tostring(reason) .. ")")
	FARM_STATE.running = true
	FARM_STATE.events = true
	FARM_STATE.wild = true
	FARM_STATE.maintenance = true
	FARM_STATE.petsMgr = true
	FARM_STATE.harvest = CFG.fastFarm ~= false
	touchFarmHeartbeat()
	task.spawn(farmLoop)
	if FARM_STATE.harvest then
		task.spawn(harvestLoop)
	end
	task.spawn(eventCollectorLoop)
	task.spawn(wildPetScannerLoop)
	task.spawn(petManagerLoop)
	task.spawn(maintenanceLoop)
	task.spawn(mailLoop)
	task.spawn(telemetryStatusLoop)
	pcall(function()
		Dashboard.startLive()
	end)
	return true
end

function recoverFarmSession(reason)
	if not farmGenActive() then
		return false
	end
	local sg = CFG.serverGuard
	if sg and sg.enabled == false then
		return false
	end
	if recoveringFarm then
		return false
	end
	local cooldown = (sg and sg.recoverCooldown) or 8
	if os.clock() - lastRecoverAt < cooldown then
		return false
	end
	recoveringFarm = true
	lastRecoverAt = os.clock()
	wr("[GUARD] recovering farm session (" .. tostring(reason) .. ")...")
	guardJobId = game.JobId

	SharedModules, Gardens, NET = waitForCoreAssets(75)
	NET_OK = NET ~= nil
	if SharedModules then
		loadPrices()
		reprice()
	end
	ownedGear = {}
	gearCacheExpiry = 0
	clearSeedBuyBlocks()
	getgenv().GAG2_HOOKS = {}
	pcall(hookSeedShopEvents)
	pcall(hookPetEvents)
	pcall(hookEventDropListener)
	pcall(hookWildPetSpawns)
	pcall(refreshOwnedGear)
	waitForGameReady(45)

	local plot = findMyPlot()
	if not NET then
		wr("[GUARD] recover failed: NET still missing")
		STATS.lastStatus = "recover: NET missing"
		recoveringFarm = false
		return false
	end
	if not plot then
		wr("[GUARD] recover: plot not ready yet (will retry)")
	end

	if not FARM_STATE.running or not farmLoopsAlive() then
		restartFarmLoops(reason)
	else
		touchFarmHeartbeat()
	end

	STATS.lastStatus = "recovered (" .. tostring(reason) .. ")"
	recoveringFarm = false
	wr("[GUARD] recover complete job=" .. tostring(game.JobId):sub(1, 8))
	return true
end

function installServerGuard()
	local sg = CFG.serverGuard
	if sg and sg.enabled == false then
		return
	end
	if getgenv().GAG2_SERVER_GUARD_GEN == FARM_GEN then
		return
	end
	getgenv().GAG2_SERVER_GUARD_GEN = FARM_GEN
	guardJobId = game.JobId

	pcall(function()
		LP.CharacterAdded:Connect(function()
			task.wait(2.5)
			if farmGenActive() then
				recoverFarmSession("respawn")
			end
		end)
	end)

	pcall(function()
		local ts = game:GetService("TeleportService")
		if ts.LocalPlayerArrivedFromTeleport then
			ts.LocalPlayerArrivedFromTeleport:Connect(function()
				task.defer(function()
					task.wait(2)
					if farmGenActive() then
						recoverFarmSession("teleport")
					end
				end)
			end)
		end
	end)

	task.spawn(function()
		local interval = (sg and sg.watchInterval) or 4
		while farmGenActive() do
			task.wait(interval)
			if sg and sg.enabled == false then
				continue
			end
			if game.JobId ~= guardJobId then
				recoverFarmSession("jobId:" .. tostring(guardJobId):sub(1, 8) .. "->" .. tostring(game.JobId):sub(1, 8))
			elseif FARM_STATE.running and not NET then
				recoverFarmSession("net-lost")
			elseif FARM_STATE.running and not findMyPlot() then
				recoverFarmSession("plot-lost")
			elseif FARM_STATE.running and not farmLoopsAlive() then
				recoverFarmSession("stale-loops")
			end
		end
	end)
end

function doAntiAfk()
	if not CFG.enabled.antiAfk then
		return
	end
	local ak = CFG.antiKick or {}
	if ak.enabled == false then
		return
	end
	local now = os.clock()
	local interval = tonumber(ak.nudgeInterval) or CFG.antiAfkInterval or 55
	if now - lastAntiAfk < interval then
		return
	end
	lastAntiAfk = now
	local hrp = getHRP()
	if hrp then
		hrp.CFrame = hrp.CFrame * CFrame.Angles(0, 0.5, 0)
	end
	if ak.virtualUser ~= false then
		pcall(function()
			local vu = game:GetService("VirtualUser")
			vu:CaptureController()
			vu:ClickButton2(Vector2.new())
		end)
	end
end

local optimizeOnceDone = false
local render3dDisabled = false

function setRender3dEnabled(enabled)
	local rs = game:GetService("RunService")
	pcall(function()
		rs:Set3dRenderingEnabled(enabled)
	end)
	render3dDisabled = not enabled
end

function tryDisable3DRender()
	if not CFG.disable3DRender or render3dDisabled then
		return
	end
	if not isTutorialMarkedComplete() then
		return
	end
	setRender3dEnabled(false)
	if not optLowPowerLogged then
		optLowPowerLogged = true
		wr("[OPT] 3D rendering disabled (low-power mode)")
	end
end

local tutorialNpcFpsRestore = nil

function beginTutorialNpcMode()
	if typeof(setfpscap) == "function" then
		tutorialNpcFpsRestore = CFG.fpsCap or 8
		pcall(setfpscap, 45)
		wr("[TUTORIAL] FPS boosted to 45 for NPC interaction")
	end
	if render3dDisabled or CFG.disable3DRender then
		wr("[TUTORIAL] enabling 3D render for NPC dialogue")
		setRender3dEnabled(true)
	end
	pcall(function()
		settings().Physics.PhysicsEnvironmentalThrottle = Enum.EnviromentalPhysicsThrottle.DefaultAuto
	end)
	pcall(function()
		LP:SetAttribute("DisableDialogue", nil)
	end)
end

function endTutorialNpcMode()
	if tutorialNpcFpsRestore and typeof(setfpscap) == "function" then
		pcall(setfpscap, tutorialNpcFpsRestore)
		tutorialNpcFpsRestore = nil
	end
	if CFG.disable3DRender and isTutorialMarkedComplete() then
		tryDisable3DRender()
	end
end

function withRenderForTutorial(fn)
	beginTutorialNpcMode()
	task.wait(0.8)
	local ok, result = pcall(fn)
	endTutorialNpcMode()
	if ok then
		return result
	end
	return false
end

function runTutorialTimed(label, timeoutSec, fn)
	local finished, result = false, false
	task.spawn(function()
		local ok, res = pcall(fn)
		result = ok and res or false
		finished = true
	end)
	local deadline = os.clock() + (timeoutSec or 20)
	local lastLog = os.clock()
	while not finished and os.clock() < deadline do
		if os.clock() - lastLog >= 5 then
			wr("[TUTORIAL] " .. label .. " still running...")
			lastLog = os.clock()
		end
		task.wait(0.2)
	end
	if not finished then
		wr("[TUTORIAL] " .. label .. " timed out after " .. tostring(timeoutSec) .. "s")
		return false
	end
	return result
end
local optLowPowerLogged = false
local petDetectTick = 0

function muteClientAudio()
	if not CFG.muteAudio then
		return
	end
	pcall(function()
		local ss = game:GetService("SoundService")
		ss.Volume = 0
		ss.AmbientReverb = Enum.ReverbType.NoReverb
	end)
	pcall(function()
		local ug = UserSettings():GetService("UserGameSettings")
		ug.MasterVolume = 0
		ug.MusicVolume = 0
		ug.SavedQualityLevel = Enum.SavedQualitySetting.QualityLevel1
	end)
end

function trimCharacterVisuals(char)
	if not char then
		return
	end
	pcall(function()
		local hum = char:FindFirstChildOfClass("Humanoid")
		if hum then
			hum.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
			local animator = hum:FindFirstChildOfClass("Animator")
			if animator then
				for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
					track:Stop(0)
				end
			end
		end
		for _, d in ipairs(char:GetDescendants()) do
			if d:IsA("BasePart") then
				d.CastShadow = false
				d.Material = Enum.Material.SmoothPlastic
			elseif d:IsA("ParticleEmitter") or d:IsA("Trail") or d:IsA("Beam") then
				d.Enabled = false
			end
		end
	end)
end

function deepOptimizeOnce()
	if optimizeOnceDone then
		return
	end
	optimizeOnceDone = true

	local targetFps = CFG.fpsCap and CFG.fpsCap > 0 and CFG.fpsCap or 8
	if CFG.lowPower then
		targetFps = math.min(targetFps, 8)
	end
	if type(setfpscap) == "function" then
		pcall(setfpscap, targetFps)
	end

	if CFG.disable3DRender then
		if isTutorialMarkedComplete() then
			tryDisable3DRender()
		else
			wr("[OPT] deferring 3D disable until tutorial complete")
		end
	end

	muteClientAudio()

	pcall(function()
		local gs = settings().Rendering
		gs.QualityLevel = Enum.QualityLevel.Level01
		gs.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level04
		gs.EagerBulkExecution = false
	end)

	pcall(function()
		Lighting.GlobalShadows = false
		Lighting.FogEnd = 1e9
		Lighting.Technology = Enum.Technology.Legacy
		for _, obj in Lighting:GetChildren() do
			if obj:IsA("PostEffect") then
				obj.Enabled = false
			end
		end
	end)

	pcall(function()
		if type(sethiddenproperty) == "function" then
			sethiddenproperty(LP, "SimulationRadius", math.huge)
			if workspace.StreamingEnabled then
				sethiddenproperty(workspace, "StreamingMinRadius", 64)
				sethiddenproperty(workspace, "StreamingTargetRadius", 96)
			end
		end
	end)

	pcall(function()
		settings().Physics.AllowSleep = true
		settings().Physics.PhysicsEnvironmentalThrottle = Enum.EnviromentalPhysicsThrottle.Skip
	end)

	trimCharacterVisuals(LP.Character)
	LP.CharacterAdded:Connect(trimCharacterVisuals)

	pcall(collectgarbage, "collect")
end

task.defer(deepOptimizeOnce)

local lastOptimize = 0
function optimizeClient()
	if not CFG.optimizeClient then
		return
	end
	deepOptimizeOnce()
	local now = os.clock()
	if now - lastOptimize < CFG.optimizeInterval then
		return
	end
	lastOptimize = now

	pcall(function()
		Lighting.GlobalShadows = false
		Lighting.Brightness = 1
		Lighting.FogEnd = 1e9
		for _, obj in Lighting:GetChildren() do
			if obj:IsA("PostEffect") then
				obj.Enabled = false
			end
		end
	end)

	pcall(function()
		local gs = settings().Rendering
		gs.QualityLevel = Enum.QualityLevel.Level01
	end)

	-- Если 3D-рендер выключен — нет смысла обходить визуалы каждые N сек.
	if render3dDisabled then
		if not optLowPowerLogged then
			optLowPowerLogged = true
			wr("[OPT] 3D rendering disabled (low-power mode)")
		end
		return
	end

	local fxFolders = {
		"RainDrops",
		"StormRainDrops",
		"RainSplashes",
		"StormSplashes",
		"LightningEffects",
		"BlizzardBeams",
		"GnomeVisuals",
		"BirdVisuals",
	}
	for _, name in ipairs(fxFolders) do
		local folder = workspace:FindFirstChild(name)
		if folder then
			for _, child in folder:GetChildren() do
				pcall(function()
					child:Destroy()
				end)
			end
		end
	end

	local touched = 0
	local maxTouch = CFG.lowPower and 800 or 2500
	for _, obj in workspace:GetDescendants() do
		if touched > maxTouch then
			break
		end
		if obj:IsA("BasePart") then
			obj.CastShadow = false
			touched = touched + 1
		elseif
			obj:IsA("ParticleEmitter")
			or obj:IsA("Trail")
			or obj:IsA("Beam")
			or obj:IsA("Smoke")
			or obj:IsA("Fire")
			or obj:IsA("Sparkles")
		then
			obj.Enabled = false
			touched = touched + 1
		end
	end
	wr("[OPT] client visuals reduced")
end

-- ==========================================================================
--  ЧЁРНЫЙ ЭКРАН-ДАШБОРД + статистика прогресса
-- ==========================================================================
local lastSnapshotAt = 0
-- Publishes a JSON-friendly snapshot to getgenv().GAG2_STATS so the loader can
-- forward it to the license server (web cabinet / admin live view).
function publishStatsSnapshot(force)
	if not (CFG.statsSnapshot and CFG.statsSnapshot.enabled) then
		return
	end
	local now = os.clock()
	if not force and (now - lastSnapshotAt) < (CFG.statsSnapshot.interval or 4) then
		return
	end
	lastSnapshotAt = now

	local ok = pcall(function()
		STATS.money = getMoney()
		STATS.inv = getInventoryFruitCount()
		STATS.eventSeeds = getEventSeedCounts()
		STATS.eventSeedsLine = formatEventSeedLine(STATS.eventSeeds)

		local runSec = os.clock() - STATS.startClock
		local gained = STATS.startMoney and (STATS.money - STATS.startMoney) or 0
		local perMin = runSec > 3 and (gained / (runSec / 60)) or 0

		local _, petsLiveCount, liveByName = liveOwnedPetSummary(40)
		local ownedPets = {}
		for name in pairs(liveByName or {}) do
			ownedPets[#ownedPets + 1] = { name = name, pri = getPetPriority(name), count = liveByName[name] }
		end
		table.sort(ownedPets, function(a, b)
			return a.pri > b.pri
		end)
		while #ownedPets > 40 do
			table.remove(ownedPets)
		end

		getgenv().GAG2_STATS = {
			v = CFG.scriptVersion,
			user = LP.Name,
			displayName = LP.DisplayName,
			userId = LP.UserId,
			ts = os.time(),
			uptimeSec = math.floor(runSec),
			cycles = STATS.cycles,
			money = math.floor(STATS.money or 0),
			gained = math.floor(gained),
			perMin = math.floor(perMin),
			inv = STATS.inv,
			invLimit = STATS.invLimit,
			harvested = STATS.harvested,
			sold = STATS.soldCount,
			soldValue = math.floor(STATS.soldValue or 0),
			bought = STATS.bought,
			planted = STATS.planted,
			weather = STATS.weather ~= "" and STATS.weather or "clear",
			petsEquipped = STATS.petsEquipped or {},
			petsOwned = ownedPets,
			petsCount = petsLiveCount or 0,
			eventSeeds = STATS.eventSeeds,
			mailStatus = STATS.mailStatus,
		}
	end)
	return ok
end

local Dashboard = {}
do
	local gui, frame, title, body, hidden = nil, nil, nil, nil, false

	local function getParent()
		local ok, hui = pcall(function()
			return gethui and gethui()
		end)
		if ok and hui then
			return hui
		end
		local ok2, cg = pcall(function()
			return game:GetService("CoreGui")
		end)
		if ok2 and cg then
			return cg
		end
		return LP:FindFirstChildOfClass("PlayerGui") or LP:WaitForChild("PlayerGui", 10)
	end

	function Dashboard.init()
		if not CFG.dashboard.enabled or gui then
			return
		end
		local ok = pcall(function()
			gui = Instance.new("ScreenGui")
			gui.Name = "GAG2_Dashboard"
			gui.ResetOnSpawn = false
			gui.IgnoreGuiInset = true
			gui.DisplayOrder = 2147483647
			gui.ZIndexBehavior = Enum.ZIndexBehavior.Global
			gui.Parent = getParent()

			frame = Instance.new("Frame")
			frame.Size = UDim2.fromScale(1, 1)
			frame.BackgroundColor3 = Color3.new(0, 0, 0)
			frame.BackgroundTransparency = 1 - (CFG.dashboard.opacity or 1)
			frame.BorderSizePixel = 0
			frame.Parent = gui

			title = Instance.new("TextLabel")
			title.Size = UDim2.new(1, -40, 0, 60)
			title.Position = UDim2.fromOffset(28, 24)
			title.BackgroundTransparency = 1
			title.Font = Enum.Font.GothamBold
			title.TextSize = 30
			title.TextColor3 = Color3.fromRGB(80, 230, 120)
			title.TextXAlignment = Enum.TextXAlignment.Left
			title.Text = "GAG2 FARM v" .. tostring(CFG.scriptVersion or "10.5.3")
			title.Parent = frame

			body = Instance.new("TextLabel")
			body.Size = UDim2.new(1, -56, 1, -110)
			body.Position = UDim2.fromOffset(28, 92)
			body.BackgroundTransparency = 1
			body.Font = Enum.Font.Code
			body.TextSize = 20
			body.LineHeight = 1.25
			body.TextColor3 = Color3.fromRGB(225, 225, 225)
			body.TextXAlignment = Enum.TextXAlignment.Left
			body.TextYAlignment = Enum.TextYAlignment.Top
			body.RichText = true
			body.Text = "loading..."
			body.Parent = frame
		end)
		if not ok then
			gui = nil
			return
		end

		-- Клавиша скрыть/показать чёрный экран
		pcall(function()
			local UIS = game:GetService("UserInputService")
			local keyName = CFG.dashboard.toggleKey or "RightShift"
			local key = Enum.KeyCode[keyName]
			if key then
				UIS.InputBegan:Connect(function(input, gp)
					if gp then
						return
					end
					if input.KeyCode == key and frame then
						hidden = not hidden
						-- pcall: toggling a CoreGui descendant from an input
						-- callback can raise "lacking capability Plugin" on some
						-- executors; suppress so it doesn't spam the console.
						pcall(function()
							frame.Visible = not hidden
						end)
					end
				end)
			end
		end)
	end

	local function fmtMoney(n)
		n = math.floor(n or 0)
		local s = tostring(n)
		local out = s:reverse():gsub("(%d%d%d)", "%1,"):reverse()
		return (out:gsub("^,", ""))
	end

	-- Пересчитываем лучших питомцев нечасто (раз в цикл), кэшируем строку
	function Dashboard.refreshBestPets()
		local best = liveOwnedPetSummary(5)
		STATS.bestPets = #best > 0 and table.concat(best, ", ") or "-"
	end

	-- Лёгкое обновление: читает деньги/инвентарь/время вживую, без сортировок
	function Dashboard.update()
		if not gui or not body or hidden then
			return
		end
		STATS.money = getMoney()
		STATS.inv = getInventoryFruitCount()
		local runSec = os.clock() - STATS.startClock
		local mins = runSec / 60
		local gained = STATS.startMoney and (STATS.money - STATS.startMoney) or 0
		local perMin = mins > 0.05 and (gained / mins) or 0

		local h = math.floor(runSec / 3600)
		local m = math.floor((runSec % 3600) / 60)
		local s = math.floor(runSec % 60)

		local equipped = (STATS.petsEquipped and #STATS.petsEquipped > 0) and table.concat(STATS.petsEquipped, ", ")
			or "-"
		local weatherLine = STATS.weather ~= "" and STATS.weather or "clear"

		local lines = {
			string.format(
				"<font color='#99ffee'>Uptime</font>      %02d:%02d:%02d   cycles: %d",
				h,
				m,
				s,
				STATS.cycles
			),
			"",
			string.format("<font color='#77ee88'>Money</font>       $%s", fmtMoney(STATS.money)),
			string.format(
				"<font color='#77ee88'>Gained</font>      $%s   (%s$/min)",
				fmtMoney(gained),
				fmtMoney(perMin)
			),
			string.format("<font color='#99ffee'>Inventory</font>   %d / %d", STATS.inv, STATS.invLimit),
			"",
			string.format("<font color='#ffdd77'>Harvested</font>   %d", STATS.harvested),
			string.format(
				"<font color='#ffdd77'>Sold</font>        %d  ($%s)",
				STATS.soldCount,
				fmtMoney(STATS.soldValue)
			),
			string.format("<font color='#ffdd77'>Seeds buy</font>   %d   Planted %d", STATS.bought, STATS.planted),
			string.format("<font color='#ff99dd'>Event seeds</font> %s", STATS.eventSeedsLine or "-"),
			"",
			string.format("<font color='#ddaaff'>Mail</font>       %s", STATS.mailStatus or "-"),
			"",
			string.format("<font color='#bbddff'>Equipped</font>    %s", equipped),
			string.format("<font color='#bbddff'>Best pets</font>   %s", STATS.bestPets or "-"),
			string.format("<font color='#88ccff'>Weather</font>     %s", weatherLine),
			"",
			string.format("<font color='#888888'>%s</font>", STATS.lastStatus),
			"",
			string.format(
				"<font color='#555555'>render3D off: %s   |   toggle: %s</font>",
				tostring(render3dDisabled),
				tostring(CFG.dashboard.toggleKey)
			),
		}
		pcall(function()
			body.Text = table.concat(lines, "\n")
		end)
	end

	-- Живой фоновый цикл обновления чёрного экрана
	function Dashboard.startLive()
		local st = getgenv().GAG2_FARM_STATE
		if type(st) ~= "table" then
			st = { live = false }
			getgenv().GAG2_FARM_STATE = st
		end
		if Dashboard._liveRunning or st.live then
			return
		end
		Dashboard._liveRunning = true
		st.live = true
		task.spawn(function()
			local interval = CFG.dashboard.liveInterval or 0.5
			local snapEvery = CFG.lowPower and 3 or 2
			local tick = 0
			while Dashboard._liveRunning and st.live and farmGenActive() do
				Dashboard.update()
				tick = tick + 1
				if tick % snapEvery == 0 then
					pcall(publishStatsSnapshot)
				end
				task.wait(interval)
			end
			Dashboard._liveRunning = false
			st.live = false
		end)
	end

	function Dashboard.stopLive()
		local st = getgenv().GAG2_FARM_STATE
		Dashboard._liveRunning = false
		if type(st) == "table" then
			st.live = false
		end
	end
end

FARM_STATE.running = false
FARM_STATE.events = false
FARM_STATE.wild = false
FARM_STATE.live = false
FARM_STATE.maintenance = false
FARM_STATE.petsMgr = false
getgenv().GAG2_FARM_STATE = FARM_STATE

getgenv().GAG2_FARM_STOP = function()
	FARM_STATE.running = false
	FARM_STATE.events = false
	FARM_STATE.wild = false
	FARM_STATE.live = false
	FARM_STATE.maintenance = false
	FARM_STATE.petsMgr = false
	FARM_STATE.harvest = false
	pcall(function()
		Dashboard.stopLive()
	end)
	wr("[FARM] Stopped (license reload or manual stop)")
end
getgenv().GAG2_VERSION = CFG.scriptVersion

function wildPetScannerLoop()
	while FARM_STATE.wild and farmGenActive() do
		if CFG.enabled.wildPets and not shouldDeferForTutorial() then
			local ok, err = pcall(tameWildPets)
			if not ok then
				wr("[WILDPET] loop error (continuing): " .. tostring(err))
				reportTelemetry({
					level = "error",
					message = "wildPetScannerLoop error",
					stack = tostring(err),
					context = { phase = "wildPets" },
				})
			end
		end
		local topPri = 0
		pcall(function()
			topPri = getWildPetTopPriority()
		end)
		local rush = topPri >= (CFG.smartPets.rushPriority or 70)
		local waitT = rush and (CFG.wildPetRushInterval or 0.1) or (CFG.wildPetScanInterval or 0.35)
		task.wait(waitT)
	end
end

function petManagerLoop()
	while FARM_STATE.petsMgr and farmGenActive() do
		if FARM_STATE.running then
			pcall(managePets)
			pcall(detectNewPets)
			pcall(Dashboard.refreshBestPets)
		end
		task.wait(CFG.petManagerInterval or 12)
	end
end

function mailLoop()
	wr("[MAIL] loop started (enabled=" .. tostring(CFG.mail and CFG.mail.enabled) .. ")")
	while FARM_STATE.maintenance and farmGenActive() do
		if CFG.mail and CFG.mail.enabled then
			if not FARM_STATE.running then
				STATS.mailStatus = "waiting for farm boot"
			else
				pcall(function()
					local sent = autoMailPets()
					wr(string.format("[MAIL] tick sent=%d status=%s", sent, tostring(STATS.mailStatus)))
					if CFG.mail.autoClaim then
						local cl = autoClaimMailbox()
						if cl > 0 then
							wr(string.format("[MAIL] claimed %d gift(s)", cl))
						end
					end
				end)
			end
		end
		task.wait(CFG.mail.loopInterval or 18)
	end
end

function telemetryStatusLoop()
	while FARM_STATE.running and farmGenActive() do
		local interval = CFG.telemetryStatusInterval or 45
		task.wait(interval)
		if not (CFG.telemetryVerbose or CFG.verboseLogs) then
			continue
		end
		pcall(function()
			reportTelemetry({
				level = "info",
				message = string.format(
					"status c=%d h=%d mail=%s $=%.0f inv=%d ev=%s",
					STATS.cycles or 0,
					STATS.harvested or 0,
					tostring(STATS.mailStatus or "-"),
					STATS.money or 0,
					STATS.inv or 0,
					STATS.eventSeedsLine or "-"
				),
				context = {
					phase = "status",
					cycles = STATS.cycles,
					mailStatus = STATS.mailStatus,
					lastStatus = STATS.lastStatus,
					farmRunning = FARM_STATE.running,
					netOk = NET_OK,
				},
			})
		end)
	end
end

function maintenanceLoop()
	local tick = 0
	while FARM_STATE.maintenance and farmGenActive() do
		tick = tick + 1
		if FARM_STATE.running and NET and not shouldDeferForTutorial() then
			local plot = findMyPlot()
			if plot then
				pcall(function()
					local rm, wa, sp, gb, cr, ex, ml, cl = 0, 0, 0, 0, 0, false, 0, 0
					if getMoney() >= CFG.buyGearWhenMoneyAbove and tick % 2 == 0 then
						gb = autoBuyGear()
					end
					if CFG.enabled.gear and tick % 2 == 0 then
						for _, name in ipairs(CFG.wateringCans) do
							if hasGear(name) then
								equipGear(name)
								break
							end
						end
					end
					if tick % 2 == 0 then
						rm = removeLowValuePlants(plot)
					end
					if tick % 3 == 0 then
						sp = placeSprinklers(plot)
					end
					if tick % 2 == 0 then
						ex = buyGardenExpansion()
					end
					if tick % 4 == 0 then
						cr = autoOpenCrates()
					end
					if CFG.enabled.water and not weatherState.rain then
						lastWaterSweep = os.clock()
						wa = waterAll(plot)
					end
					if tick % 3 == 0 then
						ml = autoMailPets()
					end
					if CFG.mail and CFG.mail.autoClaim and tick % 2 == 0 then
						cl = autoClaimMailbox()
					end
					optimizeClient()
					local work = rm + wa + sp + gb + cr + (ex and 1 or 0) + ml + cl
					if work > 0 then
						wr(
							string.format(
								"[MAINT] rm=%d w=%d sp=%d g=%d c=%d ex=%s mail=%d claim=%d",
								rm,
								wa,
								sp,
								gb,
								cr,
								tostring(ex),
								ml,
								cl
							)
						)
					end
				end)
			end
		end
		task.wait(CFG.maintenanceInterval or 14)
	end
end

function eventCollectorLoop()
	while FARM_STATE.events and farmGenActive() do
		-- Protect the whole body: a transient error must NOT kill the loop, or
		-- overnight Rainbow/Gold collection would silently stop until reload.
		local ok, err = pcall(function()
			checkWeather()
			local rush = hasRushSeedsVisible()
			eventPriorityActive = isEventWeatherActive() or rush
			if not shouldDeferForTutorial() then
				collectEventDrops()
			end
		end)
		if not ok then
			wr("[EVENT] loop error (continuing): " .. tostring(err))
			reportTelemetry({
				level = "error",
				message = "eventCollectorLoop error",
				stack = tostring(err),
				context = { phase = "events" },
			})
		end
		task.wait(eventPriorityActive and (CFG.eventRushInterval or 0.06) or (CFG.eventCollectInterval or 0.35))
	end
	eventPriorityActive = false
end

function hookEventDropListener()
	if not CFG.eventInstantListen then
		return
	end
	getgenv().GAG2_HOOKS = getgenv().GAG2_HOOKS or {}
	if getgenv().GAG2_HOOKS.eventDrops then
		return
	end
	getgenv().GAG2_HOOKS.eventDrops = true
	task.spawn(function()
		local drops = workspace:WaitForChild("DroppedItems", 120)
		if drops then
			drops.ChildAdded:Connect(onEventDropAdded)
			for _, item in drops:GetChildren() do
				if isRushSeedDrop(item) then
					task.defer(function()
						onEventDropAdded(item)
					end)
				end
			end
		end
		local map = workspace:WaitForChild("Map", 120)
		if map and CFG.collectSeedPacks then
			for _, fname in ipairs({ "SeedPackSpawnClient", "SeedPackSpawnServerLocations" }) do
				local folder = map:FindFirstChild(fname)
				if folder then
					folder.ChildAdded:Connect(onEventDropAdded)
				end
			end
		end
	end)
end

function weatherSummary()
	local parts = {}
	if weatherState.rainbow then
		table.insert(parts, "Rainbow")
	end
	if weatherState.starfall then
		table.insert(parts, "Starfall")
	end
	if weatherState.rain then
		table.insert(parts, "Rain")
	end
	return #parts > 0 and table.concat(parts, "+") or "clear"
end

function runMoneyPipeline(plot)
	clearRushFlagsIfStale(4)
	if not isTutorialMarkedComplete() then
		ensureTutorialWorkerRunning()
		STATS.lastStatus = "tutorial (farming)"
	end
	local rushActive = getgenv().GAG2_RUSH_PET or rushPetLock or getgenv().GAG2_RUSH_SEED
	doAntiAfk()
	checkWeather()
	eventPriorityActive = isEventWeatherActive()
	STATS.weather = weatherSummary()
	if STATS.startMoney == nil then
		STATS.startMoney = getMoney()
	end
	STATS.money = getMoney()

	local h, sc, sv, bo, pl, wa, dr = 0, 0, 0, 0, 0, 0, 0

	if eventPriorityActive and shouldDeferFarmTeleport() then
		collectEventBurst()
		dr = eventDropsSinceStatus
		eventDropsSinceStatus = 0
		if dr > 0 then
			STATS.cycles = STATS.cycles + 1
			STATS.lastStatus = string.format("event priority ev=%d", dr)
			wr(string.format("[PIPE] event burst ev=%d", dr))
			return dr
		end
	end

	if not rushActive then
		if CFG.enabled.sell then
			sc, sv = sellAll()
		end
		local hs, hv = 0, 0
		if CFG.enabled.harvest and CFG.fastFarm == false then
			local passes = math.max(tonumber(CFG.harvestPassesPerCycle) or 1, 1)
			for pass = 1, passes do
				local h1, hs1, hv1 = collectFruits(plot)
				h = h + h1
				hs = hs + hs1
				hv = hv + hv1
				if h1 == 0 then
					break
				end
			end
		end
		sc, sv = sc + hs, sv + hv
		if CFG.enabled.sell and getInventoryFruitCount() >= CFG.inventorySellAt then
			local s2, v2 = sellAll()
			sc, sv = sc + s2, sv + v2
		end
		if CFG.enabled.plant then
			pl = plantAll(plot)
		end
		if CFG.enabled.buy then
			bo = autoBuySeeds()
		end
		if CFG.enabled.plant and bo > 0 then
			pl = pl + plantAll(plot)
		end
		if shouldWaterThisCycle(pl) then
			lastWaterSweep = os.clock()
			wa = waterAll(plot)
		end
	else
		STATS.lastStatus = string.format(
			"rush defer h/s/b/p (seed=%s pet=%s)",
			tostring(getgenv().GAG2_RUSH_SEED),
			tostring(getgenv().GAG2_RUSH_PET or rushPetLock)
		)
	end
	collectEventBurst()
	dr = eventDropsSinceStatus
	eventDropsSinceStatus = 0

	local ml, cl = 0, 0
	if CFG.mail and CFG.mail.enabled then
		ml = autoMailPets()
	end
	if CFG.mail and CFG.mail.autoClaim then
		cl = autoClaimMailbox()
	end

	local money = getMoney()
	local work = h + sc + pl + bo + wa + dr + ml + cl
	STATS.cycles = STATS.cycles + 1
	STATS.lastStatus = string.format(
		"h=%d sold=%d planted=%d water=%d buy=%d mail=%d claim=%d rush=%s",
		h,
		sc,
		pl,
		wa,
		bo,
		ml,
		cl,
		tostring(rushActive)
	)
	if work > 0 or STATS.cycles % 4 == 0 or CFG.verboseLogs then
		wr(
			string.format(
				"[PIPE] $%.0f inv=%d/%d h=%d s=%d($%.0f) b=%d p=%d w=%d ev=%d mail=%d claim=%d c=%d rush=%s",
				money,
				getInventoryFruitCount(),
				CFG.inventoryLimit,
				h,
				sc,
				sv,
				bo,
				pl,
				wa,
				dr,
				ml,
				cl,
				STATS.cycles,
				tostring(rushActive)
			)
		)
	end

	STATS.money = money
	STATS.inv = getInventoryFruitCount()
	STATS.invLimit = CFG.inventoryLimit
	STATS.harvested = STATS.harvested + h
	STATS.soldCount = STATS.soldCount + sc
	STATS.soldValue = STATS.soldValue + sv
	STATS.bought = STATS.bought + bo
	STATS.planted = STATS.planted + pl
	STATS.petsEquipped = lastEquippedTarget
	if not Dashboard._liveRunning then
		Dashboard.update()
	end
	flushLogs(work > 0 or CFG.verboseLogs)

	return work
end

function farmCycle(plot)
	local n = STATS.cycles
	local function everyN(k)
		return n % k == 0
	end

	doAntiAfk()
	optimizeClient()
	checkWeather()
	eventPriorityActive = isEventWeatherActive()
	STATS.weather = weatherSummary()
	STATS.lastStatus = "cycle running..."
	if STATS.startMoney == nil then
		STATS.startMoney = getMoney()
	end
	STATS.money = getMoney()
	if not Dashboard._liveRunning then
		Dashboard.update()
	end

	local h, sc, sv, bo, pl, wa, gb, sp, cr, ex, dr, pe, rm, ml = 0, 0, 0, 0, 0, 0, 0, 0, 0, false, 0, 0, 0, 0

	if eventPriorityActive and shouldDeferFarmTeleport() then
		collectEventBurst()
		dr = eventDropsSinceStatus
		eventDropsSinceStatus = 0
		if dr > 0 then
			STATS.cycles = STATS.cycles + 1
			STATS.lastStatus = string.format("event priority ev=%d", dr)
			if not Dashboard._liveRunning then
				Dashboard.update()
			end
			wr(string.format("[FARM v10] event priority ev=%d -- farm deferred", dr))
			flushLogs(true)
			return dr
		end
	end

	if CFG.enabled.sell then
		sc, sv = sellAll()
	end
	local hs, hv = 0, 0
	if CFG.enabled.harvest then
		h, hs, hv = collectFruits(plot)
	end
	sc, sv = sc + hs, sv + hv
	if CFG.enabled.sell and getInventoryFruitCount() >= CFG.inventorySellAt then
		local s2, v2 = sellAll()
		sc, sv = sc + s2, sv + v2
	end
	if CFG.enabled.plant then
		pl = plantAll(plot)
	end
	if CFG.enabled.buy then
		bo = autoBuySeeds()
	end
	if CFG.enabled.plant and bo > 0 then
		pl = pl + plantAll(plot)
	end
	collectEventBurst()

	if getMoney() >= CFG.buyGearWhenMoneyAbove and everyN(2) then
		gb = autoBuyGear()
	end
	if CFG.enabled.gear and everyN(2) then
		for _, name in ipairs(CFG.wateringCans) do
			if hasGear(name) then
				equipGear(name)
				break
			end
		end
	end
	if everyN(2) then
		rm = removeLowValuePlants(plot)
	end
	if everyN(4) then
		sp = placeSprinklers(plot)
	end
	if everyN(2) then
		ex = buyGardenExpansion()
	end
	if everyN(5) then
		cr = autoOpenCrates()
	end
	if CFG.enabled.water and not weatherState.rain then
		wa = waterAll(plot)
	end
	if everyN(5) then
		ml = autoMailPets()
	end
	pe = managePets()
	local cl = 0
	if CFG.mail and CFG.mail.autoClaim and everyN(2) then
		cl = autoClaimMailbox()
	end

	dr = eventDropsSinceStatus
	eventDropsSinceStatus = 0

	Dashboard.refreshBestPets()
	flushLogs(true)
	local money = getMoney()
	wr(
		string.format(
			"[FARM v10] $%.0f | inv=%d/%d h=%d s=%d($%.0f) b=%d p=%d rm=%d w=%d sp=%d g=%d c=%d ex=%s ev=%d pet=%d mail=%d claim=%d",
			money,
			getInventoryFruitCount(),
			CFG.inventoryLimit,
			h,
			sc,
			sv,
			bo,
			pl,
			rm,
			wa,
			sp,
			gb,
			cr,
			tostring(ex),
			dr,
			pe,
			ml,
			cl
		)
	)

	if STATS.startMoney == nil then
		STATS.startMoney = money
	end
	STATS.money = money
	STATS.inv = getInventoryFruitCount()
	STATS.invLimit = CFG.inventoryLimit
	STATS.harvested = STATS.harvested + h
	STATS.soldCount = STATS.soldCount + sc
	STATS.soldValue = STATS.soldValue + sv
	STATS.bought = STATS.bought + bo
	STATS.planted = STATS.planted + pl
	STATS.petsEquipped = lastEquippedTarget
	STATS.cycles = STATS.cycles + 1
	STATS.lastStatus = string.format("h=%d sold=%d planted=%d water=%d buy=%d", h, sc, pl, wa, bo)
	if not Dashboard._liveRunning then
		Dashboard.update()
	end

	return h + sc + pl + wa + sp + bo + dr
end

function harvestLoop()
	while FARM_STATE.harvest and farmGenActive() do
		if FARM_STATE.running and NET and CFG.enabled.harvest then
			local rushActive = getgenv().GAG2_RUSH_PET or rushPetLock or getgenv().GAG2_RUSH_SEED
			if not rushActive then
				local plot = findMyPlot()
				if plot then
					pcall(function()
						local h, hs, hv = collectFruits(plot)
						if h > 0 then
							STATS.harvested = STATS.harvested + h
							STATS.soldCount = STATS.soldCount + (hs or 0)
							STATS.soldValue = STATS.soldValue + (hv or 0)
						end
					end)
				end
			end
		end
		task.wait(CFG.harvestLoopInterval or 0.05)
	end
end

function farmLoop()
	while FARM_STATE.running and farmGenActive() do
		touchFarmHeartbeat()
		if type(getgenv().GAG2_REQUIRE_LICENSE) == "function" then
			if not getgenv().GAG2_REQUIRE_LICENSE(false) then
				local g = getgenv()
				local freshFn = g.GAG2_HEARTBEAT_FRESH
				local staleOnly = type(freshFn) == "function"
					and not freshFn()
					and g.GAG2_LICENSE_OK
					and g.GAG2_DELIVERY_OK
					and g.GAG2_SESSION_TOKEN
				if staleOnly then
					STATS.lastStatus = "paused — heartbeat resync"
					task.wait(20)
					continue
				end
				getgenv().GAG2_REQUIRE_LICENSE(true)
				break
			end
		end
		if not NET then
			wr("[FARM] NET unavailable — waiting")
			task.wait(5)
			continue
		end
		local plot = findMyPlot()
		if not plot then
			task.wait(5)
			continue
		end
		local ok, result = xpcall(function()
			if CFG.pipelineMode ~= false then
				return runMoneyPipeline(plot)
			end
			return farmCycle(plot)
		end, function(e)
			return traceErr(e, 2)
		end)
		if not ok then
			wr("[FARM] Error: " .. tostring(result))
			STATS.lastStatus = "error: " .. tostring(result):sub(1, 80)
			reportTelemetry({
				level = "fatal",
				message = "farmLoop crash",
				stack = tostring(result),
				context = { phase = "farmLoop" },
			})
			task.wait(1)
		else
			local work = tonumber(result) or 0
			local pause
			if CFG.pipelineMode ~= false then
				pause = work > 0 and (CFG.farmActivePause or 0.2) or (CFG.farmIdlePause or 0.75)
			else
				pause = CFG.cycleInterval or 2
			end
			task.wait(pause)
		end
	end
end

function waitForGameReady(timeoutSec)
	timeoutSec = timeoutSec or 60
	local deadline = os.clock() + timeoutSec
	wr("[BOOT] Waiting for plot & leaderstats...")
	skipLoadingScreen()

	if not NET and SharedModules then
		local netMod = SharedModules:FindFirstChild("Networking")
		if netMod then
			local ok, result = pcall(require, netMod)
			if ok then
				NET = result
				NET_OK = true
			end
		end
	end
	if not Gardens then
		Gardens = workspace:FindFirstChild("Gardens") or workspace:WaitForChild("Gardens", 10)
	end

	repeat
		skipLoadingScreen()
		local char = LP.Character
		local hrp = char and char:FindFirstChild("HumanoidRootPart")
		local ls = LP:FindFirstChild("leaderstats")
		local plotReady = LP:GetAttribute("PlotId") or findMyPlot()
		if NET and hrp and ls and plotReady then
			task.wait(CFG.lowPower and 0.8 or 0.5)
			wr("[BOOT] Game ready (plot=" .. tostring(plotReady) .. ")")
			return true
		end
		task.wait(CFG.lowPower and 1 or 0.5)
	until os.clock() >= deadline
	wr("[BOOT] Plot wait timeout — continuing anyway")
	skipLoadingScreen()
	return false
end

function replicaSaysTutorialComplete(data, depth)
	if depth > 6 or type(data) ~= "table" then
		return false
	end
	for k, v in pairs(data) do
		if type(k) == "string" then
			local kl = k:lower()
			if kl:find("tutorial") and (kl:find("complete") or kl:find("done") or kl:find("finished")) then
				if v == true then
					return true
				end
			end
			if kl == "intutorial" and v == false then
				return true
			end
		end
		if replicaSaysTutorialComplete(v, depth + 1) then
			return true
		end
	end
	return false
end

function dismissStuckTutorialUi()
	pcall(function()
		local gui = LP:FindFirstChild("PlayerGui")
		local tut = gui and gui:FindFirstChild("TutorialUI")
		if tut and tut:IsA("ScreenGui") and tut.Enabled then
			tut.Enabled = false
			local ptr = tut:FindFirstChild("Pointer")
			if ptr then
				ptr.Visible = false
			end
			wr("[TUTORIAL] disabled stuck TutorialUI overlay")
		end
	end)
end

-- TutorialComplete attr/replica are often nil on veteran accounts while TutorialUI
-- stays Enabled. Use gameplay signals + absence of active InTutorial state.
function recognizeTutorialAlreadyDone()
	local d = getTutorialDebugInfo()
	local data = getPlayerReplicaData()

	if d.attr == true then
		return true, "attr"
	end
	if type(data) == "table" then
		if data.TutorialComplete == true or data.CompletedTutorial == true then
			return true, "replica"
		end
		if data.InTutorial == false then
			return true, "replica InTutorial=false"
		end
		if replicaSaysTutorialComplete(data, 0) then
			return true, "replica scan"
		end
	end

	if d.wsTag or d.lpTag then
		return false
	end
	if type(data) == "table" and data.InTutorial == true then
		return false
	end
	if LP:GetAttribute("TutorialComplete") == false then
		return false
	end
	if d.inTutorial == true then
		return false
	end

	local money = getMoney()
	local plot = findMyPlot()
	local plants = plot and countPlants(plot) or 0

	if money >= 50000 then
		return true, string.format("veteran money $%d", money)
	end
	if money >= 5000 and plot and plants > 0 then
		return true, string.format("established farm ($%d, %d plants)", money, plants)
	end
	if d.uiEnabled and money >= 1000 and not d.wsTag and not d.lpTag then
		return true, string.format("stuck TutorialUI only ($%d)", money)
	end

	return false
end

function isTutorialMarkedComplete()
	if mailState.tutorialCleared then
		return true
	end
	if LP:GetAttribute("TutorialComplete") == true then
		return true
	end
	local data = getPlayerReplicaData()
	if type(data) == "table" then
		if data.TutorialComplete == true or data.CompletedTutorial == true then
			return true
		end
		if data.InTutorial == false then
			return true
		end
		if replicaSaysTutorialComplete(data, 0) then
			return true
		end
	end
	local done, reason = recognizeTutorialAlreadyDone()
	if done then
		return true
	end
	return false
end

function markTutorialCleared(reason)
	mailState.tutorialCleared = true
	mailState.tutorialBlock = false
	FARM_STATE.tutorialAssist = false
	dismissStuckTutorialUi()
	tryDisable3DRender()
	wr("[TUTORIAL] treated as complete: " .. tostring(reason or "detected"))
end

function ensureTutorialStateResolved()
	if isTutorialMarkedComplete() then
		if not mailState.tutorialCleared then
			local _, reason = recognizeTutorialAlreadyDone()
			markTutorialCleared(reason or "marked complete")
		end
		return true
	end
	return false
end

function shouldDeferForTutorial()
	-- Farm pipeline never blocks on tutorial (v10.7.10). Mail checks isTutorialMarkedComplete().
	return false
end

local tutorialWorkerActive = false

function ensureTutorialWorkerRunning()
	if tutorialWorkerActive or isTutorialMarkedComplete() then
		return
	end
	tutorialWorkerActive = true
	task.spawn(function()
		wr("[TUTORIAL] background worker started — farm keeps running")
		beginTutorialNpcMode()
		fireTutorialRemote("Ready")
		kickstartTutorialRunnerIfStuck()
		waitForGameTutorialReady(20)

		local deadline = os.clock() + 600
		local lastMoney = getMoney()
		local stevenAttempts = 0

		while os.clock() < deadline and not isTutorialMarkedComplete() do
			local money = getMoney()
			local plot = findMyPlot()

			if plot and not hasPlantableSeedTool() and money >= 1 then
				for _, seedName in ipairs({ "Carrot", "Strawberry", "Tomato", "Blueberry", "Apple" }) do
					if purchaseSeedVerified(seedName, true, true) then
						wr("[TUTORIAL] worker bought " .. seedName)
						break
					end
				end
			end
			if plot and hasPlantableSeedTool() and countPlantsOnPlot(plot) == 0 then
				plantAll(plot)
			end
			if plot and hasRipeFruitOnPlot(plot) then
				collectFruits(plot)
			end

			local soldSomething = false
			if hasSellableInventory() or getInventoryFruitCount() > 0 then
				local sc = sellAll()
				soldSomething = sc > 0
			end

			local sellStep = isTutorialPointerVisible()
				or CollectionService:HasTag(workspace, "InTutorial")
				or CollectionService:HasTag(LP, "InTutorial")
			if (soldSomething or hasSellableInventory()) and sellStep and stevenAttempts < 8 then
				stevenAttempts = stevenAttempts + 1
				local moneyBefore = money
				withRenderForTutorial(function()
					runTutorialTimed("Steven dialogue", 20, attemptStevenDialogueSale)
					if not isTutorialMarkedComplete() then
						runTutorialTimed("sellAll", 12, performTutorialSellWithCompleteHook)
					end
				end)
				finalizeTutorialAfterSell(moneyBefore)
			end

			if money > lastMoney or soldSomething or money > 50 then
				fireTutorialRemote("Complete")
			end
			if isTutorialMarkedComplete() then
				markTutorialCleared("background worker")
				break
			end

			lastMoney = money
			task.wait(2)
		end

		if not isTutorialMarkedComplete() then
			fireTutorialRemote("Complete")
			task.wait(1)
			if isTutorialMarkedComplete() or not isInTutorial() then
				markTutorialCleared("worker Complete remote")
			end
		end

		mailState.tutorialBlock = false
		mailState.tutorialPassRunning = false
		FARM_STATE.tutorialAssist = false
		if isTutorialMarkedComplete() then
			STATS.mailStatus = "ready"
		else
			STATS.mailStatus = "tutorial incomplete"
		end
		endTutorialNpcMode()
		tutorialWorkerActive = false
		wr("[TUTORIAL] background worker finished | " .. formatTutorialState())
	end)
end

function getTutorialDebugInfo()
	local data = getPlayerReplicaData()
	local gui = LP:FindFirstChild("PlayerGui")
	local tut = gui and gui:FindFirstChild("TutorialUI")
	return {
		attr = LP:GetAttribute("TutorialComplete"),
		replicaComplete = data and data.TutorialComplete,
		inTutorial = data and data.InTutorial,
		wsTag = CollectionService:HasTag(workspace, "InTutorial"),
		lpTag = CollectionService:HasTag(LP, "InTutorial"),
		uiEnabled = tut and tut:IsA("ScreenGui") and tut.Enabled,
	}
end

function formatTutorialState()
	local d = getTutorialDebugInfo()
	return string.format(
		"attr=%s replica=%s ui=%s wsTag=%s lpTag=%s",
		tostring(d.attr),
		tostring(d.replicaComplete),
		tostring(d.uiEnabled),
		tostring(d.wsTag),
		tostring(d.lpTag)
	)
end

function fireTutorialRemote(name)
	if not NET or not NET.Tutorial then
		return false
	end
	local remote = NET.Tutorial[name]
	if not remote then
		return false
	end
	local ok = callRemote(remote)
	wr(string.format("[TUTORIAL] remote %s fired ok=%s", name, tostring(ok)))
	return ok
end

function kickstartTutorialRunnerIfStuck()
	local done, reason = recognizeTutorialAlreadyDone()
	if done then
		markTutorialCleared(reason)
		return
	end
	local d = getTutorialDebugInfo()
	if d.wsTag or d.lpTag then
		return
	end
	if not d.uiEnabled then
		return
	end
	wr("[TUTORIAL] TutorialUI on but InTutorial tag missing — re-firing Ready")
	fireTutorialRemote("Ready")
	task.wait(3)
end

function noteMailTutorialBlock(reason)
	if ensureTutorialStateResolved() then
		return
	end
	if mailState.tutorialPassRunning then
		return
	end
	local now = os.clock()
	if mailState.tutorialPassLastAt > 0 and (now - mailState.tutorialPassLastAt) < 120 then
		return
	end
	mailState.tutorialPassLastAt = now
	mailState.tutorialBlock = true
	STATS.mailStatus = "tutorial blocking mail"
	wr("[TUTORIAL] mail blocked: " .. tostring(reason))
	ensureTutorialWorkerRunning()
end

function isInTutorial()
	if isTutorialMarkedComplete() then
		return false
	end
	if mailState.tutorialBlock then
		return true
	end
	if CollectionService:HasTag(workspace, "InTutorial") then
		return true
	end
	if CollectionService:HasTag(LP, "InTutorial") then
		return true
	end
	local data = getPlayerReplicaData()
	if type(data) == "table" then
		if data.InTutorial == true then
			return true
		end
		if data.TutorialComplete == false then
			return true
		end
	end
	if LP:GetAttribute("TutorialComplete") == false then
		return true
	end
	local ls = LP:FindFirstChild("leaderstats")
	local sheckles = ls and ls:FindFirstChild("Sheckles")
	if sheckles and sheckles.Value <= 50 then
		local plot = findMyPlot()
		if plot and countPlants(plot) == 0 and getTotalOwnedSeedCount() == 0 then
			return true
		end
		if not plot then
			return true
		end
	end
	return false
end

function countPlantsOnPlot(plot)
	return countPlants(plot)
end

function hasHarvestableFruit()
	if hasFruitToolInBackpack() then
		return true
	end
	return hasRipeFruitOnPlot(findMyPlot())
end

function hasRipeFruitOnPlot(plot)
	if not plot then
		return false
	end
	local pl = plot:FindFirstChild("Plants")
	if not pl then
		return false
	end

	local okTagged, tagged = pcall(function()
		return CollectionService:GetTagged("HarvestPrompt")
	end)
	if okTagged and type(tagged) == "table" then
		for _, prompt in ipairs(tagged) do
			if prompt:GetAttribute("Collected") then
				continue
			end
			local model = prompt.Parent and prompt.Parent:FindFirstAncestorWhichIsA("Model")
			if model and model:IsDescendantOf(pl) then
				return true
			end
		end
	end

	for _, plant in ipairs(pl:GetChildren()) do
		if not plant:IsA("Model") then
			continue
		end
		local pid = plant:GetAttribute("PlantId")
		local ff = pid and plant:FindFirstChild("Fruits")
		if not ff then
			continue
		end
		for _, fruit in ipairs(ff:GetDescendants()) do
			if fruit:GetAttribute("FruitId") and isFruitReady(fruit) then
				return true
			end
		end
	end
	return false
end

function hasPlantableSeedTool()
	for _, tool in ipairs(getToolsByAttr("SeedTool")) do
		local st = tool:GetAttribute("SeedTool")
		if st and not tool:GetAttribute("FruitName") and not isNoPlantSeed(st) then
			return true
		end
	end
	return false
end

function completeTutorialRemote()
	return fireTutorialRemote("Complete")
end

function hasFruitToolInBackpack()
	local function scan(container)
		if not container then
			return false
		end
		for _, t in container:GetChildren() do
			if t:IsA("Tool") and t:GetAttribute("FruitName") then
				return true
			end
		end
		return false
	end
	return scan(LP.Character) or scan(LP:FindFirstChildOfClass("Backpack"))
end

function waitForFruitTool(timeoutSec)
	local deadline = os.clock() + (timeoutSec or 12)
	while os.clock() < deadline do
		if hasFruitToolInBackpack() then
			return true
		end
		task.wait(0.25)
	end
	return hasFruitToolInBackpack()
end

function getStevenNpc()
	local npcs = workspace:FindFirstChild("NPCS")
	return npcs and npcs:FindFirstChild("Steven")
end

function getBillboardDialogueObjects()
	local gui = LP:FindFirstChild("PlayerGui")
	local billboard = gui and gui:FindFirstChild("Billboard_UI")
	return billboard and billboard:FindFirstChild("Objects")
end

function ensureCharacterReady(timeoutSec)
	timeoutSec = timeoutSec or 15
	if LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
		return true
	end
	local deadline = os.clock() + timeoutSec
	while os.clock() < deadline do
		if LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
			return true
		end
		task.wait(0.25)
	end
	return LP.Character ~= nil
end

-- Billboard_UI is cloned into PlayerGui by StarterCharacterScripts.Billboard_UI on spawn.
-- TopText.ShowChoices (Steven dialogue) silently fails if this is missing.
function waitForBillboardUi(timeoutSec)
	timeoutSec = timeoutSec or 12
	ensureCharacterReady(timeoutSec)
	local deadline = os.clock() + timeoutSec
	local logged = false
	while os.clock() < deadline do
		local objects = getBillboardDialogueObjects()
		if objects then
			return objects
		end
		if not logged then
			wr("[TUTORIAL] waiting for PlayerGui.Billboard_UI...")
			logged = true
		end
		if not LP.Character then
			ensureCharacterReady(2)
		end
		task.wait(0.25)
	end
	return getBillboardDialogueObjects()
end

function waitForGameTutorialReady(timeoutSec)
	timeoutSec = timeoutSec or 30
	local deadline = os.clock() + timeoutSec
	while os.clock() < deadline do
		if LP:GetAttribute("LoadingScreenDone") == true then
			return true
		end
		local gui = LP:FindFirstChild("PlayerGui")
		local tut = gui and gui:FindFirstChild("TutorialUI")
		if tut and tut:IsA("ScreenGui") and tut.Enabled then
			return true
		end
		if isTutorialMarkedComplete() then
			return true
		end
		task.wait(0.5)
	end
	wr("[TUTORIAL] game tutorial bootstrap timeout")
	return false
end

function listBillboardDialogueOptions()
	local objects = getBillboardDialogueObjects()
	if not objects then
		return {}
	end
	local opts = {}
	for _, child in ipairs(objects:GetChildren()) do
		if child:IsA("GuiObject") then
			local te = child:FindFirstChild("Text_Element", true)
			local text = te and te:GetAttribute("Text")
			if type(text) == "string" then
				table.insert(opts, text:gsub("<[^>]+>", ""))
			end
		end
	end
	return opts
end

function findBillboardDialogueOption(partialText)
	local objects = getBillboardDialogueObjects()
	if not objects then
		return nil, nil
	end
	partialText = string.lower(partialText or "")
	if partialText == "" then
		return nil, nil
	end
	for _, child in ipairs(objects:GetChildren()) do
		if child:IsA("GuiObject") then
			local te = child:FindFirstChild("Text_Element", true)
			local text = te and te:GetAttribute("Text")
			if type(text) == "string" then
				local plain = text:gsub("<[^>]+>", "")
				if string.find(string.lower(plain), partialText, 1, true) then
					return child, plain
				end
			end
		end
	end
	return nil, nil
end

function activateGuiObject(obj)
	if not obj then
		return false
	end
	if typeof(firesignal) == "function" then
		if obj.Activated and pcall(firesignal, obj.Activated) then
			return true
		end
		if obj.MouseButton1Click and pcall(firesignal, obj.MouseButton1Click) then
			return true
		end
	end
	local btn = obj:IsA("GuiButton") and obj or obj:FindFirstChildWhichIsA("GuiButton", true)
	if btn then
		pcall(function()
			if btn.Activate then
				btn:Activate()
			end
		end)
		return true
	end
	return false
end

function clickDialogueOption(partialText)
	partialText = string.lower(partialText or "")
	if partialText == "" then
		return false
	end

	local option, label = findBillboardDialogueOption(partialText)
	if option then
		local frame = option:FindFirstChild("Frame")
		local imgBtn = frame and frame:FindFirstChild("ImageButton")
		if imgBtn then
			if typeof(firesignal) == "function" and imgBtn.MouseButton1Click then
				pcall(firesignal, imgBtn.MouseButton1Click)
			else
				pcall(function()
					if imgBtn.Activate then
						imgBtn:Activate()
					end
				end)
			end
			wr("[TUTORIAL] dialogue click: " .. tostring(label))
			return true
		end
		if activateGuiObject(option) then
			wr("[TUTORIAL] dialogue click: " .. tostring(label))
			return true
		end
	end

	local gui = LP:FindFirstChild("PlayerGui")
	if not gui then
		return false
	end
	for _, d in ipairs(gui:GetDescendants()) do
		local text = d:GetAttribute("Text")
		if not text and d:IsA("TextLabel") then
			text = d.Text
		end
		if type(text) == "string" then
			local plain = text:gsub("<[^>]+>", "")
			if string.find(string.lower(plain), partialText, 1, true) then
				local frame = d:FindFirstAncestorWhichIsA("GuiObject")
				if frame and activateGuiObject(frame) then
					wr("[TUTORIAL] dialogue click (fallback): " .. plain)
					return true
				end
			end
		end
	end
	return false
end

function equipFruitToolIfAny()
	local char = LP.Character
	local hum = char and char:FindFirstChildOfClass("Humanoid")
	if not hum then
		return false
	end
	for _, container in ipairs({ char, LP:FindFirstChildOfClass("Backpack") }) do
		if container then
			for _, t in ipairs(container:GetChildren()) do
				if t:IsA("Tool") and t:GetAttribute("FruitName") then
					if t.Parent ~= char then
						pcall(function()
							hum:EquipTool(t)
						end)
						task.wait(0.15)
					end
					return true
				end
			end
		end
	end
	return false
end

-- NOTE: The game's own NPCController is already started at client boot, so
-- Steven's ProximityPrompt.Triggered connection already exists. We must NOT
-- call NPCController.Start() again from the tutorial coroutine — its sub
-- controllers run yielding GetAttributeAsync calls that can block the pass for
-- a long time. We only fire the existing prompt connection instead.

function teleportToStevenForDialogue(hrp)
	local myHrp = getHRP()
	if not (myHrp and hrp) then
		return false
	end
	local npcPos = hrp.Position
	local flat = Vector3.new(myHrp.Position.X - npcPos.X, 0, myHrp.Position.Z - npcPos.Z)
	if flat.Magnitude < 0.5 then
		flat = Vector3.new(1, 0, 0)
	end
	local stand = npcPos + flat.Unit * 5 + Vector3.new(0, 1.5, 0)
	myHrp.CFrame = CFrame.new(stand, Vector3.new(npcPos.X, stand.Y, npcPos.Z))
	task.wait(0.4)
	local d = distTo(npcPos)
	wr(string.format("[TUTORIAL] Steven stand dist=%.1f", d))
	return d <= 11
end

function triggerProximityPrompt(prompt)
	if not prompt then
		return
	end
	if typeof(fireproximityprompt) == "function" then
		pcall(fireproximityprompt, prompt, 0)
	end
	pcall(function()
		prompt:InputHoldBegin()
		task.wait(math.max(prompt.HoldDuration or 0, 0.08) + 0.1)
		prompt:InputHoldEnd()
	end)
end

function getStevenProximityPrompt()
	local steven = getStevenNpc()
	local hrp = steven and steven:FindFirstChild("HumanoidRootPart")
	return steven, hrp, hrp and hrp:FindFirstChildWhichIsA("ProximityPrompt", true)
end

function prepareStevenPrompt(prompt, steven)
	if not prompt then
		return
	end
	prompt.Enabled = true
	prompt.MaxActivationDistance = math.max(prompt.MaxActivationDistance or 10, 14)
	pcall(function()
		prompt.RequiresLineOfSight = false
	end)
	pcall(function()
		prompt.ClickablePrompt = true
	end)
	pcall(function()
		prompt.Exclusivity = Enum.ProximityPromptExclusivity.OnePerButton
	end)
	if steven then
		pcall(function()
			steven:SetAttribute("DisableDialogue", nil)
		end)
	end
	pcall(function()
		LP:SetAttribute("DisableDialogue", nil)
	end)
end

function countPromptConnections(prompt)
	if not prompt or typeof(getconnections) ~= "function" then
		return 0
	end
	local ok, conns = pcall(getconnections, prompt.Triggered)
	return ok and type(conns) == "table" and #conns or 0
end

function invokeStevenPromptHandlers(prompt)
	if not prompt then
		return false
	end
	local n = countPromptConnections(prompt)
	wr("[TUTORIAL] Steven prompt Triggered connections: " .. tostring(n))
	if n == 0 then
		return false
	end
	if typeof(getconnections) ~= "function" then
		return false
	end
	local ok, conns = pcall(getconnections, prompt.Triggered)
	if not ok or type(conns) ~= "table" then
		return false
	end
	for _, conn in ipairs(conns) do
		task.spawn(function()
			pcall(function()
				if conn.Function then
					conn.Function(LP)
				elseif conn.Fire then
					conn:Fire(LP)
				end
			end)
		end)
	end
	task.wait(2)
	return #listBillboardDialogueOptions() > 0
end

function openStevenDialogueViaTopText()
	local cm = RS:FindFirstChild("ClientModules")
	local mod = cm and cm:FindFirstChild("TopText")
	if not mod then
		return false
	end
	local ok, topText = pcall(require, mod)
	if not ok or type(topText) ~= "table" or not topText.ShowChoices then
		return false
	end
	local choices = { "Sell Inventory!", "Sell This!", "How much is this worth?", "Nevermind" }
	local opened = false
	pcall(function()
		topText.ShowChoices(LP, choices)
		opened = true
	end)
	if not opened then
		local steven = getStevenNpc()
		if steven then
			pcall(function()
				topText.ShowChoices(steven, choices)
				opened = true
			end)
		end
	end
	task.wait(0.5)
	return opened and #listBillboardDialogueOptions() > 0
end

function openStevenDialogueUi()
	local _, _, prompt = getStevenProximityPrompt()
	prepareStevenPrompt(prompt, getStevenNpc())
	if invokeStevenPromptHandlers(prompt) then
		return true
	end
	for i = 1, 4 do
		triggerProximityPrompt(prompt)
		task.wait(1)
		if #listBillboardDialogueOptions() > 0 then
			return true
		end
	end
	if openStevenDialogueViaTopText() then
		wr("[TUTORIAL] Steven dialogue opened via TopText fallback")
		return true
	end
	return false
end

function performTutorialSellWithCompleteHook()
	local moneyBefore = getMoney()
	local ls = LP:FindFirstChild("leaderstats")
	local sheckles = ls and ls:FindFirstChild("Sheckles")
	local conn
	if sheckles then
		conn = sheckles.Changed:Connect(function()
			if getMoney() > moneyBefore then
				fireTutorialRemote("Complete")
			end
		end)
	end
	local sold = performStevenSellDirect()
	task.wait(1)
	if conn then
		conn:Disconnect()
	end
	if sold and getMoney() > moneyBefore then
		fireTutorialRemote("Complete")
	end
	return sold
end

function waitForBillboardDialogue(timeoutSec)
	local deadline = os.clock() + (timeoutSec or 12)
	while os.clock() < deadline do
		local opts = listBillboardDialogueOptions()
		if #opts > 0 then
			return opts
		end
		task.wait(0.2)
	end
	return listBillboardDialogueOptions()
end

function waitForStevenSale(moneyBefore, timeoutSec)
	local deadline = os.clock() + (timeoutSec or 10)
	while os.clock() < deadline do
		if getMoney() > moneyBefore then
			return true
		end
		if isTutorialMarkedComplete() then
			return true
		end
		if getInventoryFruitCount() == 0 and not hasFruitToolInBackpack() then
			task.wait(0.5)
			if getMoney() > moneyBefore or isTutorialMarkedComplete() then
				return true
			end
		end
		task.wait(0.25)
	end
	return getMoney() > moneyBefore
end

function performStevenSellDirect()
	if not NET or not NET.NPCS then
		return false
	end
	local moneyBefore = getMoney()
	local count = getInventoryFruitCount()
	if count == 0 and not hasFruitToolInBackpack() then
		return false
	end
	local prevFn = NET.NPCS.PreviewSellAll and (NET.NPCS.PreviewSellAll.Invoke or NET.NPCS.PreviewSellAll.Fire)
	local sellFn = NET.NPCS.SellAll and (NET.NPCS.SellAll.Invoke or NET.NPCS.SellAll.Fire)
	if prevFn and sellFn then
		local ok, prev = pcall(prevFn, NET.NPCS.PreviewSellAll)
		local fruitCount = ok and type(prev) == "table" and (prev.FruitCount or 0) or count
		if fruitCount > 0 or hasFruitToolInBackpack() then
			task.wait(0.25)
			local ok2, resp = pcall(sellFn, NET.NPCS.SellAll)
			local success = ok2 and type(resp) == "table" and resp.Success
			wr(
				string.format(
					"[TUTORIAL] Steven SellAll remote: ok=%s success=%s money %d->%d",
					tostring(ok2),
					tostring(success),
					moneyBefore,
					getMoney()
				)
			)
			if waitForStevenSale(moneyBefore, 8) then
				return true
			end
		end
	end
	local sold, val = sellAll()
	wr(
		string.format(
			"[TUTORIAL] sellAll fallback: %d items $%d (money %d->%d)",
			tonumber(sold) or 0,
			tonumber(val) or 0,
			moneyBefore,
			getMoney()
		)
	)
	return getMoney() > moneyBefore
end

function hasSellableInventory()
	return hasFruitToolInBackpack() or getInventoryFruitCount() > 0
end

function waitForSellableInventory(timeoutSec)
	local deadline = os.clock() + (timeoutSec or 14)
	while os.clock() < deadline do
		if hasSellableInventory() then
			return true
		end
		task.wait(0.35)
	end
	return hasSellableInventory()
end

function isTutorialUiActive()
	local gui = LP:FindFirstChild("PlayerGui")
	local tut = gui and gui:FindFirstChild("TutorialUI")
	return tut and tut:IsA("ScreenGui") and tut.Enabled
end

function isTutorialPointerVisible()
	local gui = LP:FindFirstChild("PlayerGui")
	local tut = gui and gui:FindFirstChild("TutorialUI")
	local ptr = tut and tut:FindFirstChild("Pointer")
	return ptr and ptr.Visible
end

-- TutorialRunner step 9 connects Sheckles.Changed only after reaching the sell step.
function waitForTutorialSellReady(timeoutSec)
	timeoutSec = timeoutSec or 70
	local deadline = os.clock() + timeoutSec
	local minReady = os.clock() + 25
	local _, hrp = getStevenProximityPrompt()
	wr("[TUTORIAL] waiting for TutorialRunner sell step (pointer or InTutorial)...")
	while os.clock() < deadline do
		if isTutorialMarkedComplete() then
			return true
		end
		local d = getTutorialDebugInfo()
		if hrp and distTo(hrp.Position) > 14 then
			teleportToStevenForDialogue(hrp)
		end
		if os.clock() >= minReady then
			if isTutorialPointerVisible() then
				wr("[TUTORIAL] sell step: tutorial pointer active")
				return true
			end
			if d.wsTag or d.lpTag then
				wr("[TUTORIAL] sell step: InTutorial tag active")
				return true
			end
		end
		task.wait(0.75)
	end
	wr("[TUTORIAL] sell step wait timeout")
	return false
end

function finalizeTutorialAfterSell(moneyBefore)
	moneyBefore = moneyBefore or getMoney()
	for i = 1, 18 do
		if isTutorialMarkedComplete() then
			mailState.tutorialBlock = false
			mailState.tutorialCleared = true
			tryDisable3DRender()
			wr("[TUTORIAL] server marked complete (after sell, +" .. i .. "s)")
			return true
		end
		if getMoney() > moneyBefore then
			fireTutorialRemote("Complete")
		end
		local dbg = getTutorialDebugInfo()
		if not dbg.uiEnabled then
			mailState.tutorialCleared = true
			mailState.tutorialBlock = false
			wr("[TUTORIAL] TutorialUI gone after sell — unblocking mail")
			tryDisable3DRender()
			return true
		end
		task.wait(1)
	end
	return isTutorialMarkedComplete()
end

function attemptStevenDialogueSale()
	if not waitForBillboardUi(10) then
		wr("[TUTORIAL] Billboard_UI missing — dialogue unavailable")
		return false
	end
	local steven, hrp, prompt = getStevenProximityPrompt()
	if not (hrp and prompt) then
		wr("[TUTORIAL] Steven NPC not found")
		return false
	end
	wr("[TUTORIAL] Steven dialogue: teleporting (dist=" .. string.format("%.0f", distTo(hrp.Position)) .. ")")
	equipFruitToolIfAny()
	teleportToStevenForDialogue(hrp)
	prepareStevenPrompt(prompt, steven)
	local moneyBefore = getMoney()
	local promptShown = false
	local conn = prompt.PromptShown:Connect(function()
		promptShown = true
	end)
	local opened = openStevenDialogueUi()
	if not opened then
		for i = 1, 6 do
			wr("[TUTORIAL] Steven dialogue: prompt attempt " .. i)
			invokeStevenPromptHandlers(prompt)
			triggerProximityPrompt(prompt)
			task.wait(1)
			if #listBillboardDialogueOptions() > 0 then
				opened = true
				break
			end
		end
	end
	conn:Disconnect()
	local opts = opened and listBillboardDialogueOptions() or waitForBillboardDialogue(6)
	if #opts == 0 then
		wr(
			string.format(
				"[TUTORIAL] Steven dialogue did not open (3d=%s promptShown=%s dist=%.1f)",
				tostring(not render3dDisabled),
				tostring(promptShown),
				distTo(hrp.Position)
			)
		)
		return false
	end
	wr("[TUTORIAL] Steven options: [" .. table.concat(opts, ", ") .. "]")
	for _ = 1, 16 do
		if clickDialogueOption("sell inventory") then
			if waitForStevenSale(moneyBefore, 8) then
				wr("[TUTORIAL] Steven sale confirmed (+$" .. tostring(getMoney() - moneyBefore) .. ")")
				return true
			end
		end
		task.wait(0.3)
	end
	wr("[TUTORIAL] Sell Inventory option not clicked")
	return false
end

function sellViaStevenDialogue()
	if getInventoryFruitCount() == 0 and not hasFruitToolInBackpack() then
		return false
	end
	return attemptStevenDialogueSale()
end

function harvestOneRipeNoSell(plot)
	if not NET or not NET.Garden then
		return 0
	end
	local pl = plot and plot:FindFirstChild("Plants")
	if not pl then
		return 0
	end

	local function tryCollect(apid, afid, pos)
		if pos then
			teleportNear(pos + Vector3.new(0, CFG.teleportHeight or 4, 0), 999)
		end
		return callRemote(NET.Garden.CollectFruit, apid, afid or "")
	end

	local okTagged, tagged = pcall(function()
		return CollectionService:GetTagged("HarvestPrompt")
	end)
	if okTagged and type(tagged) == "table" then
		for _, prompt in ipairs(tagged) do
			if prompt:GetAttribute("Collected") then
				continue
			end
			local model = prompt.Parent and prompt.Parent:FindFirstAncestorWhichIsA("Model")
			if not model or not model:IsDescendantOf(pl) then
				continue
			end
			local apid = model:GetAttribute("PlantId")
			if not apid then
				continue
			end
			local pos = getInstancePos(prompt) or getInstancePos(model) or getPlantPos(model)
			if tryCollect(apid, model:GetAttribute("FruitId") or "", pos) then
				wr("[TUTORIAL] harvested tutorial plant")
				return 1
			end
		end
	end

	for _, plant in ipairs(pl:GetChildren()) do
		if not plant:IsA("Model") then
			continue
		end
		local pid = plant:GetAttribute("PlantId")
		local ff = pid and plant:FindFirstChild("Fruits")
		if not ff then
			continue
		end
		for _, fruit in ipairs(ff:GetDescendants()) do
			local fid = fruit:GetAttribute("FruitId")
			if fid and isFruitReady(fruit) then
				local pos = getInstancePos(fruit) or getPlantPos(plant)
				if tryCollect(pid, fid, pos) then
					return 1
				end
			end
		end
	end
	return 0
end

function runTutorialCompletionPass()
	if ensureTutorialStateResolved() then
		return true
	end
	if isTutorialMarkedComplete() then
		return true
	end
	wr("[TUTORIAL] completion pass | " .. formatTutorialState())
	ensureCharacterReady(20)
	waitForGameTutorialReady(30)
	kickstartTutorialRunnerIfStuck()

	local graceDeadline = os.clock() + 22
	while os.clock() < graceDeadline do
		if isTutorialMarkedComplete() then
			FARM_STATE.tutorialAssist = false
			wr("[TUTORIAL] complete (game handled it)")
			return true
		end
		task.wait(1)
	end

	local attempts, maxAttempts = 0, 6
	local deadline = os.clock() + 120
	local plot = findMyPlot()
	local sellReadyOnce = false

	while os.clock() < deadline and attempts < maxAttempts do
		if isTutorialMarkedComplete() then
			FARM_STATE.tutorialAssist = false
			wr("[TUTORIAL] server marked complete")
			return true
		end
		attempts = attempts + 1
		skipLoadingScreen()
		plot = plot or findMyPlot()
		if not plot then
			task.wait(1)
			continue
		end

		if not hasSellableInventory() then
			if hasRipeFruitOnPlot(plot) then
				wr("[TUTORIAL] ripe fruit on plot — harvesting one")
				harvestOneRipeNoSell(plot)
				task.wait(1)
				if not waitForSellableInventory(12) then
					wr("[TUTORIAL] harvest sent, waiting inventory sync...")
					task.wait(2)
				end
				if not hasSellableInventory() then
					continue
				end
			else
				wr("[TUTORIAL] no ripe fruit on plot — waiting...")
				task.wait(4)
				continue
			end
		end

		if not sellReadyOnce then
			sellReadyOnce = waitForTutorialSellReady(70)
		end
		local allowSell = sellReadyOnce or attempts >= 3
		if not allowSell then
			wr("[TUTORIAL] sell step not ready yet — waiting for TutorialRunner")
			task.wait(3)
			continue
		end

		if hasSellableInventory() then
			local moneyBefore = getMoney()
			wr("[TUTORIAL] Steven dialogue sell (attempt " .. attempts .. ")")
			local sold = withRenderForTutorial(function()
				return runTutorialTimed("Steven dialogue", 32, attemptStevenDialogueSale)
			end)
			if sold and finalizeTutorialAfterSell(moneyBefore) then
				FARM_STATE.tutorialAssist = false
				wr("[TUTORIAL] complete after Steven dialogue sell")
				return true
			end

			if not isTutorialMarkedComplete() and not mailState.tutorialCleared then
				wr("[TUTORIAL] direct sellAll after dialogue (attempt " .. attempts .. ")")
				local directSold = withRenderForTutorial(function()
					return runTutorialTimed("sellAll", 16, performTutorialSellWithCompleteHook)
				end)
				if directSold and finalizeTutorialAfterSell(moneyBefore) then
					FARM_STATE.tutorialAssist = false
					wr("[TUTORIAL] complete after direct sell")
					return true
				end
			end
			task.wait(1.5)
		end

		task.wait(2)
	end

	fireTutorialRemote("Complete")
	FARM_STATE.tutorialAssist = false
	wr("[TUTORIAL] pass finished | " .. formatTutorialState())
	return isTutorialMarkedComplete()
end

function runTutorialAutomation()
	if runTutorialCompletionPass() then
		return true
	end
	wr("[TUTORIAL] Auto-pass starting...")
	local deadline = os.clock() + 420
	local startMoney = getMoney()
	local soldOnce = false

	while os.clock() < deadline do
		if not isInTutorial() then
			wr("[TUTORIAL] Already complete")
			return true
		end

		skipLoadingScreen()
		local plot = findMyPlot()
		if not plot then
			task.wait(1)
			continue
		end

		refreshSeedShopState()

		if not hasPlantableSeedTool() then
			local bought = false
			for _, seedName in ipairs({ "Carrot", "Strawberry", "Tomato", "Blueberry", "Apple" }) do
				if purchaseSeedVerified(seedName, true, true) then
					bought = true
					wr("[TUTORIAL] Bought " .. seedName)
					break
				end
			end
			if not bought then
				autoBuySeeds()
			end
		end

		if hasPlantableSeedTool() and countPlantsOnPlot(plot) == 0 then
			plantAll(plot)
		end

		if plot then
			collectFruits(plot)
		end

		if hasHarvestableFruit() or getInventoryFruitCount() > 0 then
			local sc = sellAll()
			if sc > 0 then
				soldOnce = true
			end
		end

		if soldOnce and getMoney() > startMoney then
			completeTutorialRemote()
			task.wait(2)
			if not isInTutorial() then
				wr("[TUTORIAL] Completed after sell")
				return true
			end
		end

		if hasPlantableSeedTool() and countPlantsOnPlot(plot) > 0 and not hasHarvestableFruit() then
			wr("[TUTORIAL] Waiting for crop growth...")
			task.wait(3)
		else
			task.wait(1)
		end
	end

	completeTutorialRemote()
	wr("[TUTORIAL] Timeout — fired Complete")
	return false
end

function bootAndStart()
	if type(getgenv().GAG2_REQUIRE_LICENSE) == "function" and not getgenv().GAG2_REQUIRE_LICENSE(true) then
		return
	end
	if not SharedModules or not NET then
		wr("[BOOT] Retrying core assets...")
		SharedModules, Gardens, NET = waitForCoreAssets(90)
		NET_OK = NET ~= nil
		if SharedModules then
			loadPrices()
			reprice()
		end
	end
	if not NET then
		wr("[FARM] Disabled: Networking unavailable after boot")
		STATS.lastStatus = "NET missing"
		STATS.mailStatus = "NET missing"
		reportTelemetry({ level = "fatal", message = "boot failed: NET missing", context = { phase = "boot" } })
		return
	end
	hookPetEvents()
	hookSeedShopEvents()
	hookMailboxActivity()
	waitForGameReady(60)
	local livePetCount = syncOwnedPetCacheFromLive()
	wr(string.format("[PET] live inventory sync: %d guid(s), cache=%d name(s)", livePetCount or 0, countKnownPets()))
	if not isTutorialMarkedComplete() then
		if ensureTutorialStateResolved() then
			wr("[TUTORIAL] veteran account — skipping assist")
		else
			wr("[TUTORIAL] fresh account — farm + tutorial worker in parallel")
			ensureTutorialWorkerRunning()
		end
	elseif isInTutorial() then
		ensureTutorialWorkerRunning()
	end
	task.wait(0.5)
	FARM_STATE.running = true
	FARM_STATE.events = true
	FARM_STATE.wild = true
	FARM_STATE.maintenance = true
	FARM_STATE.petsMgr = true
	FARM_STATE.harvest = CFG.fastFarm ~= false
	installGlobalErrorReporter()
	installAntiKick()
	installServerGuard()
	touchFarmHeartbeat()
	getgenv().GAG2_ENSURE_FARM = function()
		if not farmGenActive() then
			return false
		end
		if FARM_STATE.running and farmLoopsAlive() and NET and findMyPlot() then
			return true
		end
		return recoverFarmSession("ensure")
	end
	hookEventDropListener()
	hookWildPetSpawns()
	Dashboard.refreshBestPets()
	Dashboard.startLive()
	task.spawn(farmLoop)
	if FARM_STATE.harvest then
		task.spawn(harvestLoop)
		wr(
			"[FARM] fast harvest loop ON (interval="
				.. tostring(CFG.harvestLoopInterval)
				.. "s batch="
				.. tostring(CFG.harvestMaxPerCycle)
				.. ")"
		)
	end
	task.spawn(eventCollectorLoop)
	task.spawn(wildPetScannerLoop)
	task.spawn(petManagerLoop)
	task.spawn(maintenanceLoop)
	task.spawn(mailLoop)
	task.spawn(telemetryStatusLoop)
	reportTelemetry({
		level = "info",
		message = "farm boot complete",
		context = {
			phase = "boot",
			netOk = NET_OK == true,
			mailTarget = CFG.mail and CFG.mail.targetUsername or nil,
			verboseLogs = CFG.verboseLogs == true,
		},
	})
	optimizeClient()
	if CFG.lowPower and (tonumber(CFG.memoryTrimInterval) or 0) > 0 then
		task.spawn(function()
			while FARM_STATE.running and farmGenActive() do
				task.wait(CFG.memoryTrimInterval)
				pcall(function()
					if #pendingLog > 40 then
						local keep = {}
						for i = math.max(1, #pendingLog - 40), #pendingLog do
							keep[#keep + 1] = pendingLog[i]
						end
						pendingLog = keep
					end
					if #fullLogCache > 50000 then
						fullLogCache = fullLogCache:sub(-20000)
					end
					collectgarbage("collect")
				end)
			end
		end)
	end
	wr(
		"[FARM] v"
			.. tostring(CFG.scriptVersion or "?")
			.. " pipeline | low-power="
			.. tostring(CFG.lowPower)
			.. " verbose="
			.. tostring(CFG.verboseLogs)
			.. " log="
			.. tostring(logPath)
	)
end

pcall(Dashboard.init)
Dashboard.update()

if CFG.autoStart then
	task.spawn(bootAndStart)
else
	wr("[FARM] autoStart=false — idle")
end

do
	local parts = {}
	for i = 1, math.min(8, #seedPriority) do
		local name = seedPriority[i]
		local d = SEED_DATA[name]
		if d then
			local avg = (d.yield[1] + d.yield[2]) / 2
			table.insert(parts, string.format("%s(y%.0f@$%d)", name, avg, d.price))
		end
	end
	wr("[CFG] Seeds: " .. table.concat(parts, " "))
	local petCount = 0
	for _ in pairs(ownedPetCache) do
		petCount = petCount + 1
	end
	wr(string.format("[CFG] Known pets: %d (cache %s, log %s)", petCount, petCachePath, logPath))
	flushLogs(true)
end
