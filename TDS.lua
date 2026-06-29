if not game:IsLoaded() then
	game.Loaded:Wait()
end

-------------------------------------- Services ------------------------------------------

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local MarketplaceService = game:GetService("MarketplaceService")
local PathfindingService = game:GetService("PathfindingService")

-------------------------------------- Variables ------------------------------------------

local LP = Players.LocalPlayer
local PlayerGui = LP.PlayerGui
local RF = ReplicatedStorage:WaitForChild("RemoteFunction")
local RE = ReplicatedStorage:WaitForChild("RemoteEvent")

-------------------------------------- Script Variables ------------------------------------------

local GameState = nil
local ItemNames = {
	["17447507910"] = "Timescale Ticket(s)",
	["17438486690"] = "Range Flag(s)",
	["17438486138"] = "Damage Flag(s)",
	["17438487774"] = "Cooldown Flag(s)",
	["17429537022"] = "Blizzard(s)",
	["17448596749"] = "Napalm Strike(s)",
	["18493073533"] = "Spin Ticket(s)",
	["17429548305"] = "Supply Drop(s)",
	["18443277308"] = "Low Grade Consumable Crate(s)",
	["136180382135048"] = "Santa Radio(s)",
	["18443277106"] = "Mid Grade Consumable Crate(s)",
	["18443277591"] = "High Grade Consumable Crate(s)",
	["132155797622156"] = "Christmas Tree(s)",
	["124065875200929"] = "Fruit Cake(s)",
	["17429541513"] = "Barricade(s)",
	["110415073436604"] = "Holy Hand Grenade(s)",
	["17429533728"] = "Frag Grenade(s)",
	["17437703262"] = "Molotov(s)",
	["139414922355803"] = "Present Clusters(s)",
}

local StartCoins, CurrentTotalCoins, StartGems, CurrentTotalGems = 0, 0, 0, 0
if GameState == "GAME" then
	pcall(function()
		repeat
			task.wait(1)
		until LP:FindFirstChild("Coins")
		StartCoins = LP.Coins.Value
		CurrentTotalCoins = StartCoins
		StartGems = LP.Gems.Value
		CurrentTotalGems = StartGems
	end)
end

-------------------------------------- Functions ------------------------------------------

local function IsVoidCharm(obj)
	return math.abs(obj.Position.Y) > 999999
end

local function GetRoot()
	local char = LP.Character
	return char and char:FindFirstChild("HumanoidRootPart")
end

local function IdentifyGameState()
	if PlayerGui:FindFirstChild("ReactLobbyHud") then
		return "LOBBY"
	elseif PlayerGui:FindFirstChild("ReactUniversalHotbar") then
		return "GAME"
	end
end

local function CheckResult(Data: any)
	if Data == true then
		return true
	end

	if type(Data) == "table" and Data.Success == true then
		return true
	end

	local success, IsModel = pcall(function()
		return Data and Data:IsA("Model")
	end)

	if success and IsModel then
		return true
	end
	if type(Data) == "userdata" then
		return true
	end

	return false
end

local function CastMapVote(MapId, PosVec)
	local TargetMap = MapId or "Simplicity"
	local TargetPos = PosVec or Vector3.new(0, 0, 0)
	RE:FireServer("LobbyVoting", "Vote", TargetMap, TargetPos)
	print("Cast map vote: " .. TargetMap)
end

local function LobbyReadyUp()
	pcall(function()
		RE:FireServer("LobbyVoting", "Ready")
		print("Lobby ready up sent")
	end)
end

local function SelectMapOverride(MapId, ...)
	local args = { ... }

	if args[#args] == "vip" then
		RF:InvokeServer("LobbyVoting", "Override", MapId)
	end

	task.wait(3)
	CastMapVote(MapId, Vector3.new(12.59, 10.64, 52.01))
	task.wait(1)
	LobbyReadyUp()
end

local function IsMapAvailable(name)
	for _, g in ipairs(workspace:GetDescendants()) do
		if g:IsA("SurfaceGui") and g.Name == "MapDisplay" then
			local t = g:FindFirstChild("Title")
			if t and t.Text == name then
				return true
			end
		end
	end

	local hasVoted = false

	repeat
		local IntermissionFrame = PlayerGui:WaitForChild("ReactGameIntermission"):WaitForChild("Frame")
		local VetoValue = IntermissionFrame.buttons.veto.value
		local VetoText = VetoValue.Text

		if VetoText ~= "" then
			if not VetoText:find("Veto") then
				return false
			end

			local currentStr, totalStr = VetoText:match("(%d+)/(%d+)")
			local current, total = tonumber(currentStr), tonumber(totalStr)

			if not hasVoted and total and total > 0 and current == 0 then
				RE:FireServer("LobbyVoting", "Veto")
				hasVoted = true
			end
		end

		local found = false
		for _, g in ipairs(workspace:GetDescendants()) do
			if g:IsA("SurfaceGui") and g.Name == "MapDisplay" then
				local t = g:FindFirstChild("Title")
				if t and t.Text == name then
					found = true
					break
				end
			end
		end

		task.wait(1)

		local TotalPlayer = #Players:GetChildren()
		local isFull = VetoText == "Veto (" .. TotalPlayer .. "/" .. TotalPlayer .. ")"

	until found or isFull

	for _, g in ipairs(workspace:GetDescendants()) do
		if g:IsA("SurfaceGui") and g.Name == "MapDisplay" then
			local t = g:FindFirstChild("Title")
			if t and t.Text == name then
				return true
			end
		end
	end

	return false
end

local function CastModifierVote(ModsTable)
	local BulkModifiers =
		ReplicatedStorage:WaitForChild("Network"):WaitForChild("Modifiers"):WaitForChild("RF:BulkVoteModifiers")
	local ModRep = ReplicatedStorage:WaitForChild("StateReplicators"):FindFirstChild("ModifierReplicator")

	local Available = {}
	if ModRep then
		local raw = ModRep:GetAttribute("Available")
		if type(raw) == "string" then
			local clean = raw:match("{.+}")
			if clean then
				pcall(function()
					Available = HttpService:JSONDecode(clean)
				end)
			end
		end
	end

	local SelectedMods = {}
	local missingMods = {}

	if ModsTable then
		for k, v in pairs(ModsTable) do
			local modName = type(k) == "string" and k or v

			if type(modName) == "string" then
				if Available[modName] == true then
					SelectedMods[modName] = true
				else
					table.insert(missingMods, modName)
				end
			end
		end
	end

	if #missingMods > 0 then
		print("Locked (Skipped) modifiers: " .. table.concat(missingMods, ", "))
	end

	if next(SelectedMods) then
		pcall(function()
			BulkModifiers:InvokeServer(SelectedMods)
			print("Successfully casted modifier votes.")
		end)
	end
end

local function DoPlaceTower(TName, TPos, ...)
	local args = { ... }
	print("Placing tower: " .. TName)
	while true do
		local ok, res = pcall(function()
			return RF:InvokeServer("Troops", "Place", {
				Rotation = CFrame.new(),
				Position = TPos,
			}, TName, unpack(args))
		end)

		if ok and CheckResult(res) then
			return true
		end
		task.wait(0.25)
	end
end

local function StartAntiLag()
	if AntiLagRunning then
		return
	end
	AntiLagRunning = true

	local settings = settings().Rendering
	local OriginalQuality = settings.QualityLevel
	settings.QualityLevel = Enum.QualityLevel.Level01

	task.spawn(function()
		while _G.AntiLag do
			local TowersFolder = workspace:FindFirstChild("Towers")
			local ClientUnits = workspace:FindFirstChild("ClientUnits")

			if TowersFolder then
				for _, tower in ipairs(TowersFolder:GetChildren()) do
					local anims = tower:FindFirstChild("Animations")
					local weapon = tower:FindFirstChild("Weapon")
					local projectiles = tower:FindFirstChild("Projectiles")

					if anims then
						anims:Destroy()
					end
					if projectiles then
						projectiles:Destroy()
					end
					if weapon then
						weapon:Destroy()
					end
				end
			end
			if ClientUnits then
				for _, unit in ipairs(ClientUnits:GetChildren()) do
					unit:Destroy()
				end
			end

			task.wait(0.5)
		end
		AntiLagRunning = false
	end)
end

local function DoUpgradeTower(TObj, PathId)
	while true do
		local ok, res = pcall(function()
			return RF:InvokeServer("Troops", "Upgrade", "Set", {
				Troop = TObj,
				Path = PathId,
			})
		end)
		if ok and CheckResult(res) then
			return true
		end
		task.wait(0.25)
	end
end

local function RunVoteSkip()
	while true do
		local success = pcall(function()
			RF:InvokeServer("Voting", "Skip")
		end)
		if success then
			break
		end
		task.wait(0.2)
	end
end

local function StartAutoReady()
	if AutoReadyRunning or GameState ~= "GAME" then
		return
	end
	AutoReadyRunning = true

	task.spawn(function()
		local VR = ReplicatedStorage:WaitForChild("StateReplicators"):WaitForChild("VoteReplicator")

		repeat
			task.wait(0.1)
		until VR:GetAttribute("Enabled") == true and VR:GetAttribute("Title") == "Ready?"

		RunVoteSkip()

		repeat
			task.wait(0.1)
		until VR:GetAttribute("Enabled") == false

		AutoReadyRunning = false
	end)
end

local function RejoinMatch()
	TeleportService:Teleport(3260590327)
end

local function GetAllRewards()
	local results = {
		Coins = 0,
		Gems = 0,
		XP = 0,
		Wave = 0,
		Level = 0,
		Time = "00:00",
		Status = "UNKNOWN",
		Others = {},
	}

	local UiRoot = PlayerGui:FindFirstChild("ReactGameNewRewards")
	local MainFrame = UiRoot and UiRoot:FindFirstChild("Frame")
	local GameOver = MainFrame and MainFrame:FindFirstChild("gameOver")
	local RewardsScreen = GameOver and GameOver:FindFirstChild("RewardsScreen")

	local GameStats = RewardsScreen and RewardsScreen:FindFirstChild("gameStats")
	local StatsList = GameStats and GameStats:FindFirstChild("stats")

	if StatsList then
		for _, frame in ipairs(StatsList:GetChildren()) do
			local l1 = frame:FindFirstChild("textLabel")
			local l2 = frame:FindFirstChild("textLabel2")
			if l1 and l2 and l1.Text:find("Time Completed:") then
				results.Time = l2.Text
				break
			end
		end
	end

	local TopBanner = RewardsScreen and RewardsScreen:FindFirstChild("RewardBanner")
	if TopBanner and TopBanner:FindFirstChild("textLabel") then
		local txt = TopBanner.textLabel.Text:upper()
		results.Status = txt:find("TRIUMPH") and "WIN" or (txt:find("LOST") and "LOSS" or "UNKNOWN")
	end

	local LevelValue = LP.Level
	if LevelValue then
		results.Level = LevelValue.Value or 0
	end

	local label = PlayerGui:WaitForChild("ReactGameTopGameDisplay").Frame.wave.container.value
	local WaveNum = label.Text:match("^(%d+)")

	if WaveNum then
		results.Wave = tonumber(WaveNum) or 0
	end

	local SectionRewards = RewardsScreen and RewardsScreen:FindFirstChild("RewardsSection")
	if SectionRewards then
		for _, item in ipairs(SectionRewards:GetChildren()) do
			if tonumber(item.Name) then
				local IconId = "0"
				local img = item:FindFirstChildWhichIsA("ImageLabel", true)
				if img then
					IconId = img.Image:match("%d+") or "0"
				end

				for _, child in ipairs(item:GetDescendants()) do
					if child:IsA("TextLabel") then
						local text = child.Text
						local amt = tonumber(text:match("(%d+)")) or 0

						if text:find("Coins") then
							results.Coins = amt
						elseif text:find("Gems") then
							results.Gems = amt
						elseif text:find("XP") then
							results.XP = amt
						elseif text:lower():find("x%d+") then
							local displayName = ItemNames[IconId] or "Unknown Item (" .. IconId .. ")"
							table.insert(results.Others, { Amount = text:match("x%d+"), Name = displayName })
						end
					end
				end
			end
		end
	end

	return results
end

local function HandlePostMatch()
	local UiRoot
	repeat
		task.wait(1)

		local root = PlayerGui:FindFirstChild("ReactGameNewRewards")
		local frame = root and root:FindFirstChild("Frame")
		local gameOver = frame and frame:FindFirstChild("gameOver")
		local RewardsScreen = gameOver and gameOver:FindFirstChild("RewardsScreen")
		UiRoot = RewardsScreen and RewardsScreen:FindFirstChild("RewardsSection")
	until UiRoot

	if not UiRoot then
		return RejoinMatch()
	end

	if not _G.SendWebhook then
		RejoinMatch()
		return
	end

	task.wait(1)

	local match = GetAllRewards()

	CurrentTotalCoins += match.Coins
	CurrentTotalGems += match.Gems

	local BonusString = ""
	if #match.Others > 0 then
		for _, res in ipairs(match.Others) do
			BonusString = BonusString .. "🎁 **" .. res.Amount .. " " .. res.Name .. "**\n"
		end
	else
		BonusString = "_No bonus rewards found._"
	end

	local PostData = {
		username = "TDS AutoStrat",
		embeds = {
			{
				title = (match.Status == "WIN" and "🏆 TRIUMPH" or "💀 DEFEAT"),
				color = (match.Status == "WIN" and 0x2ecc71 or 0xe74c3c),
				description = "### 📋 Match Overview\n"
					.. "> **Status:** `"
					.. match.Status
					.. "`\n"
					.. "> **Time:** `"
					.. match.Time
					.. "`\n"
					.. "> **Current Level:** `"
					.. match.Level
					.. "`\n"
					.. "> **Wave:** `"
					.. match.Wave
					.. "`\n",

				fields = {
					{
						name = "✨ Rewards",
						value = "```ansi\n"
							.. "[2;33mCoins:[0m +"
							.. match.Coins
							.. "\n"
							.. "[2;34mGems: [0m +"
							.. match.Gems
							.. "\n"
							.. "[2;32mXP:   [0m +"
							.. match.XP
							.. "```",
						inline = false,
					},
					{
						name = "🎁 Bonus Items",
						value = BonusString,
						inline = true,
					},
					{
						name = "📊 Session Totals",
						value = "```py\n# Total Amount\nCoins: "
							.. CurrentTotalCoins
							.. "\nGems:  "
							.. CurrentTotalGems
							.. "```",
						inline = true,
					},
				},
				footer = { text = "Logged for " .. LP.Name .. " • TDS AutoStrat" },
				timestamp = DateTime.now():ToIsoDate(),
			},
		},
	}

	pcall(function()
		request({
			Url = _G.Webhook,
			Method = "POST",
			Headers = { ["Content-Type"] = "application/json" },
			Body = HttpService:JSONEncode(PostData),
		})
	end)

	task.wait(1.5)

	RejoinMatch()

	task.wait(9e9)
end

local function StartBackToLobby()
	if BackToLobbyRunning then
		return
	end
	BackToLobbyRunning = true

	task.spawn(function()
		while true do
			pcall(function()
				HandlePostMatch()
			end)
			task.wait(5)
		end
		BackToLobbyRunning = false
	end)
end

local function StartAutoPickups()
	if AutoPickupsRunning or not _G.AutoPickups then
		return
	end
	AutoPickupsRunning = true

	task.spawn(function()
		while _G.AutoPickups do
			local folder = workspace:FindFirstChild("Pickups")
			local hrp = GetRoot()

			if folder and hrp then
				local char = hrp.Parent
				local humanoid = char and char:FindFirstChildOfClass("Humanoid")
				local function MoveToPos(TargetPos)
					if not humanoid then
						return false
					end
					local function MoveDirect(pos)
						humanoid:MoveTo(pos)
						local StartT = os.clock()
						while os.clock() - StartT < 2 do
							if not _G.AutoPickups then
								return false
							end
							if (hrp.Position - pos).Magnitude < 4 then
								return true
							end
							task.wait(0.1)
						end
						return (hrp.Position - pos).Magnitude < 4
					end
					local path = PathfindingService:CreatePath({
						AgentRadius = 2,
						AgentHeight = 6,
						AgentCanJump = true,
						AgentJumpHeight = 7,
						AgentMaxSlope = 45,
					})
					local ok = pcall(function()
						path:ComputeAsync(hrp.Position, TargetPos)
					end)
					if ok and path.Status == Enum.PathStatus.Success then
						local waypoints = path:GetWaypoints()
						local BlockedConn = nil
						BlockedConn = path.Blocked:Connect(function()
							if BlockedConn then
								BlockedConn:Disconnect()
							end
							if _G.AutoPickups then
								task.spawn(function()
									MoveToPos(TargetPos)
								end)
							end
						end)
						for _, wp in ipairs(waypoints) do
							if not _G.AutoPickups then
								if BlockedConn then
									BlockedConn:Disconnect()
								end
								return false
							end
							if wp.Action == Enum.PathWaypointAction.Jump then
								humanoid.Jump = true
							end
							if not MoveDirect(wp.Position) then
								if BlockedConn then
									BlockedConn:Disconnect()
								end
								return false
							end
						end
						if BlockedConn then
							BlockedConn:Disconnect()
						end
						return true
					end
					return MoveDirect(TargetPos)
				end

				for _, item in ipairs(folder:GetChildren()) do
					if not _G.AutoPickups then
						break
					end

					if
						item:IsA("MeshPart")
						and (item.Name == "Bunz" or item.Name == "Lorebook" or item.Name == "SnowCharm")
					then
						if not IsVoidCharm(item) then
							local TargetPos = item.Position + Vector3.new(0, 3, 0)
							MoveToPos(TargetPos)
							task.wait(0.2)
							task.wait(0.3)
						end
					end
				end
			end

			task.wait(1)
		end

		AutoPickupsRunning = false
	end)
end

local function StartAutoSkip()
	if AutoSkipRunning or not _G.AutoSkip then
		return
	end
	AutoSkipRunning = true

	task.spawn(function()
		while _G.AutoSkip do
			local SkipVisible = PlayerGui:FindFirstChild("ReactOverridesVote")
				and PlayerGui.ReactOverridesVote:FindFirstChild("Frame")
				and PlayerGui.ReactOverridesVote.Frame:FindFirstChild("votes")
				and PlayerGui.ReactOverridesVote.Frame.votes:FindFirstChild("vote")

			if SkipVisible and SkipVisible.Position == UDim2.new(0.5, 0, 0.5, 0) then
				RunVoteSkip()
			end

			task.wait(0.1)
		end

		AutoSkipRunning = false
	end)
end

GameState = IdentifyGameState()

-------------------------------------- API ------------------------------------------

local TDS = {}

TDS = {
	PlacedTowers = {},
	ActiveStrat = true,
	MatchmakingMap = {
		["PizzaParty"] = "halloween",
		["Badlands"] = "badlands",
		["PollutedWasteland"] = "polluted",
		["DuckyEasy"] = "ducky2025",
		["DuckyHard"] = "ducky2025",
	},
}

function TDS:GameInfo(name, list)
	if GameState ~= "GAME" then
		return false
	end

	local VoteGui = PlayerGui:WaitForChild("ReactGameIntermission", 30)
	if not (VoteGui and VoteGui.Enabled and VoteGui:WaitForChild("Frame", 5)) then
		return
	end

	local modifiers = (list and next(list)) and list

	CastModifierVote(modifiers)

	if
		MarketplaceService:UserOwnsGamePassAsync(LP.UserId, 10518590)
		or ReplicatedStorage.StateReplicators.GameStateReplicator:GetAttribute("IsPrivateServer") == true
	then
		SelectMapOverride(name, "vip")
		print("Selected map: " .. name)
		repeat
			task.wait(1)
		until PlayerGui:FindFirstChild("ReactUniversalHotbar")
		return true
	elseif IsMapAvailable(name) then
		SelectMapOverride(name)
		repeat
			task.wait(1)
		until PlayerGui:FindFirstChild("ReactUniversalHotbar")
		return true
	else
		print("Map '" .. name .. "' not available, rejoining...")
		TeleportService:Teleport(3260590327)
		repeat
			task.wait(9999)
		until false
	end
end

function TDS:Loadout(...)
	if GameState ~= "GAME" then
		return
	end

	local Towers = { ... }
	local StateReplicators = ReplicatedStorage:FindFirstChild("StateReplicators")

	local CurrentlyEquipped = {}

	if StateReplicators then
		for _, Folder in ipairs(StateReplicators:GetChildren()) do
			if Folder.Name == "PlayerReplicator" and Folder:GetAttribute("UserId") == LP.UserId then
				local EquippedAttr = Folder:GetAttribute("EquippedTowers")
				if type(EquippedAttr) == "string" then
					local CleanedJson = EquippedAttr:match("%[.*%]")

					local DecodeSuccess, decoded = pcall(function()
						return HttpService:JSONDecode(CleanedJson)
					end)

					if DecodeSuccess and type(decoded) == "table" then
						CurrentlyEquipped = decoded
					end
				end
			end
		end
	end

	for _, CurrentTower in ipairs(CurrentlyEquipped) do
		if CurrentTower ~= "None" then
			local UnequipDone = false
			repeat
				local ok = pcall(function()
					RE:FireServer("Inventory", "Unequip", "Tower", CurrentTower)
					task.wait(0.3)
				end)
				if ok then
					UnequipDone = true
				else
					task.wait(0.2)
				end
			until UnequipDone
		end
	end

	task.wait(0.5)

	for _, TowerName in ipairs(Towers) do
		if TowerName and TowerName ~= "" then
			local EquipSuccess = false
			repeat
				local ok = pcall(function()
					RE:FireServer("Inventory", "Equip", "Tower", TowerName)
					print("Equipped tower: " .. TowerName)
					task.wait(0.3)
				end)
				if ok then
					EquipSuccess = true
				else
					task.wait(0.2)
				end
			until EquipSuccess
		end
	end

	task.wait(0.5)
	return true
end

function TDS:Mode(Difficulty: string)
	if GameState ~= "LOBBY" then
		return false
	end

	local FSuccess: boolean

	repeat
		local Success, Result = pcall(function()
			local mode = TDS.MatchmakingMap[Difficulty]
			local Payload: table

			if Difficulty == "Hardcore" then
				Payload = {
					mode = "hardcore",
					difficulty = "Easy",
					count = 1,
				}
			elseif Difficulty == "Voidcore" then
				Payload = {
					mode = "hardcore",
					difficulty = "Hard",
					count = 1,
				}
			elseif mode then
				Payload = {
					mode = mode,
					count = 1,
				}
				if Difficulty:match("Ducky") then
					Payload.difficulty = Difficulty:gsub("Ducky", "")
				end
			else
				Payload = {
					difficulty = Difficulty,
					mode = "survival",
					count = 1,
				}
			end

			return RF:InvokeServer("Multiplayer", "v2:start", Payload)
		end)

		if Success and CheckResult(Result) then
			FSuccess = true
		else
			task.wait(0.5)
		end
	until FSuccess
end

function TDS:Place(TName, px, py, pz, ...)
	local args = { ... }

	if GameState ~= "GAME" then
		return false
	end

	local existing = {}
	for _, child in ipairs(workspace.Towers:GetChildren()) do
		for _, SubChild in ipairs(child:GetChildren()) do
			if SubChild.Name == "Owner" and SubChild.Value == LP.UserId then
				existing[child] = true
				break
			end
		end
	end

	DoPlaceTower(TName, Vector3.new(px, py, pz), unpack(args))

	local NewT
	repeat
		for _, child in ipairs(workspace.Towers:GetChildren()) do
			if not existing[child] then
				for _, SubChild in ipairs(child:GetChildren()) do
					if SubChild.Name == "Owner" and SubChild.Value == LP.UserId then
						NewT = child
						break
					end
				end
			end
			if NewT then
				break
			end
		end
		task.wait(0.05)
	until NewT

	table.insert(self.PlacedTowers, NewT)
	return #self.PlacedTowers
end

function TDS:Upgrade(idx, PId)
	local t = self.PlacedTowers[idx]
	if t then
		DoUpgradeTower(t, PId or 1)
		print("Upgrading tower index: " .. idx)
	end
end

task.spawn(function()
	while true do
		if not AutoReadyRunning then
			StartAutoReady()
		end

		if _G.AutoRejoin and not BackToLobbyRunning then
			StartBackToLobby()
		end

		if _G.AutoPickups and not AutoPickupsRunning then
			StartAutoPickups()
		end

		if _G.AutoSkip and not AutoSkipRunning then
			StartAutoSkip()
		end

		if _G.AntiLag and not AntiLagRunning then
			StartAntiLag()
		end

		task.wait(1)
	end
end)

-- [[ CONFIGURATION ]]
_G.ClaimRewards = true -- Claims lobby rewards after matches
_G.AutoPickups = true -- Collects event pickups/tokens in match
_G.AutoSkip = true -- Automatically votes to skip waves
_G.AutoChain = false -- Enables automatic commander chain logic if used by the script
_G.AutoDJ = false -- Automatically manages DJ Booth support
_G.AutoNecro = false -- Automatically uses Necromancer ability
_G.AutoMercenary = false -- Automatically uses Mercenary Base ability
_G.AutoMilitary = false -- Automatically uses Military Base ability
_G.AntiLag = true -- Reduces effects/animations to lower lag
_G.AutoRejoin = true -- Rejoins lobby after match for auto farm loop

-- [[ WEBHOOK SETTINGS ]]
_G.SendWebhook = true -- Sends match result notifications to webhook

TDS:Loadout("Crook Boss", "Pyromancer", "Minigunner", "Turret", "Scout")
TDS:Mode("Hardcore")
TDS:GameInfo("Wretched Front", {})

TDS:Place("Crook Boss", 6.218183517456055, 1.3434163331985474, 22.581954956054688)
TDS:Upgrade(1)

TDS:Place("Pyromancer", -7.329001426696777, 0.9728163480758667, -32.4669189453125)
TDS:Upgrade(2)
TDS:Upgrade(2)

TDS:Place("Crook Boss", -2.0693929195404053, 0.02184617519378662, -8.011201858520508)
TDS:Upgrade(1)
TDS:Upgrade(3)
TDS:Upgrade(2)
TDS:Upgrade(3)
TDS:Upgrade(2)

TDS:Place("Minigunner", 4.4869585037231445, 1.4105360507965088, 29.151418685913086)
TDS:Upgrade(4)

TDS:Place("Minigunner", -5.082139015197754, -0.05503757297992706, -9.930734634399414)
TDS:Upgrade(5)
TDS:Upgrade(4)
TDS:Place("Minigunner", 2.44553279876709, 1.4368822574615479, 32.053016662597656)
TDS:Upgrade(6)

TDS:Place("Scout", 0.356964111328125, 0.9264992475509644, 16.610939025878906)
TDS:Place("Scout", -6.353634834289551, 1.2319080829620361, 44.73686981201172)
TDS:Place("Scout", 23.433452606201172, 0.9576295018196106, 31.1367244720459)
TDS:Place("Scout", 2.4927287101745605, 1.0217328071594238, -31.41207504272461)
TDS:Place("Scout", 12.284514427185059, 0.5448119640350342, -6.019914627075195)
TDS:Place("Scout", -18.197608947753906, -0.4582497179508209, 6.592010498046875)
TDS:Place("Scout", 27.326263427734375, 0.49346378445625305, 13.229872703552246)
