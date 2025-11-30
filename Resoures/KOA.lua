setidentity(4)

-- Servicios
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Módulos
local PlayerWrapper = require(ReplicatedStorage._replicationFolder.PlayerWrapper)
local GuiUtils = require(ReplicatedStorage._replicationFolder.GuiUtils)
local WorldspaceGuiUtils = require(ReplicatedStorage._replicationFolder.WorldspaceGuiUtils)
local Binder = require(ReplicatedStorage._replicationFolder.Binder)
local Maid = require(ReplicatedStorage._replicationFolder.Maid)
local CharacterData = require(ReplicatedStorage._replicationFolder.CharacterData)
local OverheadHealthbar = require(ReplicatedStorage._replicationFolder.OverheadHealthbar)
local safeDestroy = require(ReplicatedStorage._replicationFolder.safeDestroy)
local Constants = require(ReplicatedStorage._replicationFolder.Constants)

-- GUI Template
local OverheadGui = ReplicatedStorage._replicationFolder.KeenObserverOverhead:WaitForChild("OverheadGui")
OverheadGui.MaxDistance = 250

-- Variables locales
local LocalPlayer = Players.LocalPlayer
local PlayerClient = PlayerWrapper.GetClient()
local observerInstances = {}

-- CREAR/OBTENER ESTADO GLOBAL EN REPLICATEDSTORAGE
local function GetGlobalState()
	if not ReplicatedStorage:FindFirstChild("_KeenObserverState") then
		local state = Instance.new("Folder")
		state.Name = "_KeenObserverState"
		state:SetAttribute("IsActive", false)
		state:SetAttribute("BinderRef", nil)
		state.Parent = ReplicatedStorage
	end
	return ReplicatedStorage:FindFirstChild("_KeenObserverState")
end

local GlobalState = GetGlobalState()

-- Clase KeenObserver
local KeenObserver = {}
KeenObserver.__index = KeenObserver

-- Crear nueva instancia de observador para un personaje
function KeenObserver.new(model)
	local observer = setmetatable({}, KeenObserver)
	observer.Maid = Maid.new()
	
	-- No observar al jugador local
	if model == LocalPlayer.Character then
		return observer
	end
	
	observer.Model = model
	observer.Player = Players:FindFirstChild(model.Name)
	observer.IsLocalPlayer = observer.Player == LocalPlayer
	observer.CharacterData = CharacterData.YieldForCharacterData(observer.Model)
	
	if not observer.CharacterData then
		return observer
	end

	observer.Gui = OverheadGui:Clone()
	observer.Gui.Name = observer.Player.Name .. "KeenObserverUI"
	observer.Gui.Enabled = true
	GuiUtils.ParentToWorkspaceGui(observer.Gui)
	observer.Maid:GiveTask(observer.Gui)
	
	observer.Healthbar = OverheadHealthbar.new(observer.Player, observer.Gui.Health)
	observer.Maid:GiveTask(observer.Healthbar)
	
	WorldspaceGuiUtils.AddWorldspaceGui(observer.Gui)
	observer.Gui.Adornee = model
	
	-- Verificar visibilidad
	if not observer:_checkVisibility() then
		return observer
	end
	
	-- Actualizar visibilidad cuando hay cambios de ailments
	if observer.CharacterData and observer.CharacterData.AilmentAddedSignal then
		observer.Maid:GiveTask(observer.CharacterData.AilmentAddedSignal:Connect(function()
			observer:_checkVisibility()
		end))
	end
	
	observerInstances[observer] = true
	return observer
end

-- Verificar si el personaje debe ser visible
function KeenObserver._checkVisibility(observer)
	local model = observer.Model
	if model then
		model = observer.Model:FindFirstChild("Ailments")
	end
	if model then
		model = model:GetAttribute("HideInfo")
	end
	
	if not model then
		return true
	end
	
	task.defer(observer.Destroy, observer)
	return false
end

-- Limpiar todas las instancias
function KeenObserver.ClearAll()
	for observer, _ in pairs(observerInstances) do
		observer:Destroy()
	end
	observerInstances = {}
end

-- Destruir una instancia
function KeenObserver.Destroy(observer)
	observerInstances[observer] = nil
	safeDestroy(observer)
end

-- Manejar cambio de personaje
PlayerClient.CharacterChangedSignal:Connect(function()
	local currentChar = PlayerClient:GetCurrentCharacter()
	if currentChar and GlobalState:GetAttribute("IsActive") then
		if currentChar:Get("KeenObserver") then
			local binder = Binder.new(Constants.CharacterTag, KeenObserver)
			binder:Init()
			PlayerClient.Maid.KeenObserverBinder = binder
		end
	end
end)

-- Función para activar/desactivar KeenObserver
local function ToggleKeenObserver(Value)
	local currentChar = PlayerClient:GetCurrentCharacter()
	if not currentChar then
		return
	end
	
	if Value then
		-- Activar
		if not GlobalState:GetAttribute("IsActive") then
			local binder = Binder.new(Constants.CharacterTag, KeenObserver)
			binder:Init()
			PlayerClient.Maid.KeenObserverBinder = binder
			GlobalState:SetAttribute("IsActive", true)
		end
	else
		-- Desactivar
		if GlobalState:GetAttribute("IsActive") then
			PlayerClient.Maid.KeenObserverBinder = nil
			KeenObserver.ClearAll()
			GlobalState:SetAttribute("IsActive", false)
		end
	end
end


return ToggleKeenObserver
