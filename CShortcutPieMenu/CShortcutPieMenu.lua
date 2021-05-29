--
-- Calamath's Shortcut Pie Menu [CSPM]
--
-- Copyright (c) 2021 Calamath
--
-- This software is released under the Artistic License 2.0
-- https://opensource.org/licenses/Artistic-2.0
--
-- Note :
-- This addon works that uses the library LibAddonMenu-2.0 by sirinsidiator, Seerah, released under the Artistic License 2.0
-- You will need to obtain the above libraries separately.
--


-- CShortcutPieMenu global definitions
CShortcutPieMenu = CShortcutPieMenu or {}

-- CShortcutPieMenu local definitions
local CSPM = CShortcutPieMenu
CSPM.name = "CShortcutPieMenu"
CSPM.version = "0.1.0"
CSPM.author = "Calamath"
CSPM.savedVars = "CShortcutPieMenuDB"
CSPM.savedVarsVersion = 1
CSPM.authority = {2973583419,210970542} 

CSPM.const = {
	CSPM_MENU_ITEMS_COUNT_DEFAULT				= 2, 
	CSPM_ACTION_TYPE_NOTHING					= 0, 
	CSPM_ACTION_TYPE_COLLECTIBLE				= 1, 
	CSPM_CATEGORY_NOTHING						= 0, 
	CSPM_CATEGORY_C_ASSISTANT					= 11, 
	CSPM_CATEGORY_C_COMPANION					= 12, 
	CSPM_CATEGORY_C_MEMENTO						= 13, 
	CSPM_CATEGORY_C_VANITY_PET					= 14, 
	CSPM_SLOT_DATA_DEFAULT = {
		type = 0, 
		category = 0, 
		value = 0, 
	}, 
}
-- ---------------------------------------------------------------------------------------
-- Aliases of constants
local CSPM_MENU_ITEMS_COUNT_DEFAULT				= CSPM.const.CSPM_MENU_ITEMS_COUNT_DEFAULT
local CSPM_ACTION_TYPE_NOTHING					= CSPM.const.CSPM_ACTION_TYPE_NOTHING
local CSPM_ACTION_TYPE_COLLECTIBLE				= CSPM.const.CSPM_ACTION_TYPE_COLLECTIBLE
local CSPM_CATEGORY_NOTHING						= CSPM.const.CSPM_CATEGORY_NOTHING
local CSPM_CATEGORY_C_ASSISTANT					= CSPM.const.CSPM_CATEGORY_C_ASSISTANT
local CSPM_CATEGORY_C_COMPANION					= CSPM.const.CSPM_CATEGORY_C_COMPANION
local CSPM_CATEGORY_C_MEMENTO					= CSPM.const.CSPM_CATEGORY_C_MEMENTO
local CSPM_CATEGORY_C_VANITY_PET				= CSPM.const.CSPM_CATEGORY_C_VANITY_PET
local CSPM_SLOT_DATA_DEFAULT 					= CSPM.const.CSPM_SLOT_DATA_DEFAULT

-- CShortcutPieMenu savedata (default)
local CSPM_DB_DEFAULT = {
	preset = {
		[1] = {
			menuItemsCount = CSPM_MENU_ITEMS_COUNT_DEFAULT, 
			slot = {
				[1] = ZO_ShallowTableCopy(CSPM_SLOT_DATA_DEFAULT), 
				[2] = ZO_ShallowTableCopy(CSPM_SLOT_DATA_DEFAULT), 
			}, 
--[[
			slot = {
				[1] = {
					id = 1, 
					type = CSPM_ACTION_TYPE_COLLECTIBLE, 
					category = CSPM_CATEGORY_C_ASSISTANT, 
					value = 267, 
				}, 
				[2] = {
					id = 2, 
					type = CSPM_ACTION_TYPE_COLLECTIBLE, 
					category = CSPM_CATEGORY_C_ASSISTANT, 
					value = 301, 
				}, 
			}, 
]]
		}, 
	}, 
}

-- ------------------------------------------------

ZO_CreateStringId("SI_BINDING_NAME_CSPM_PIE_MENU_INTERACTION", "PieMenu Interaction") 

-- Library
local LAM = LibAddonMenu2
if not LAM then d("[CSPM] Error : 'LibAddonMenu-2.0' not found.") return end

-- ------------------------------------------------

-- Class
local CSPM_PieMenu = ZO_InteractiveRadialMenuController:Subclass()

function CSPM_PieMenu:New(...)
    return ZO_InteractiveRadialMenuController.New(self, ...)
end

-- Overridden from base class
function CSPM_PieMenu:PrepareForInteraction()
	CSPM.LDL:Debug("PrepareForInteraction()")
    if not SCENE_MANAGER:IsInUIMode() then
	    return true
	end
    return false
end

function CSPM_PieMenu:SetupEntryControl(entryControl, data)
	if not data then return end
--	CSPM.LDL:Debug("SetupEntryControl(_, %s)", tostring(data.name))
	local selected = true
	local itemCount = data.id
	-- function ZO_SetupSelectableItemRadialMenuEntryTemplate(template, selected, itemCount)
	ZO_SetupSelectableItemRadialMenuEntryTemplate(entryControl, selected, itemCount)
end

function CSPM_PieMenu:OnSelectionChangedCallback(selectedEntry)
	if not selectedEntry then return end
	CSPM.LDL:Debug("OnSelectionChangedCallback : %s", selectedEntry.name)
end

function CSPM_PieMenu:PopulateMenu()
	CSPM.LDL:Debug("PopulateMenu()")
	self.selectedSlotNum = 0

	local presetData = CSPM:GetMenuPresetData()
--	for i, data in ipairs(presetData.slot) do
	for i = 1, presetData.menuItemsCount do
		local data = presetData.slot[i] or {}
        local found = false
		local actionType = data.type
		local actionValue = data.value or 0
		local name, inactiveIcon, activeIcon
		if actionType == CSPM_ACTION_TYPE_COLLECTIBLE then
			if actionValue > 0 then
				name = GetCollectibleName(actionValue)
				activeIcon = GetCollectibleIcon(actionValue)
				inactiveIcon = activeIcon
				found = name ~= ""
			end
		end
		if found then
--			function ZO_RadialMenu:AddEntry(name, inactiveIcon, activeIcon, callback, data)
			self.menu:AddEntry(name, inactiveIcon, activeIcon, function() CSPM:OnSelectionExecutionCallback(data) end, data)
		else
			self.menu:AddEntry(GetString(SI_QUICKSLOTS_EMPTY), "EsoUI/Art/Quickslots/quickslot_emptySlot.dds", "EsoUI/Art/Quickslots/quickslot_emptySlot.dds", nil, data)
		end
	end
	self.menu:AddEntry(GetString(SI_RADIAL_MENU_CANCEL_BUTTON), "EsoUI/Art/HUD/Gamepad/gp_radialIcon_cancel_down.dds", "EsoUI/Art/HUD/Gamepad/gp_radialIcon_cancel_down.dds", nil, {})
end

-- ------------------------------------------------

function CSPM:OnSelectionExecutionCallback(slotData)
	local actionType = slotData.type
	local actionValue = slotData.value or 0
	if actionType == CSPM_ACTION_TYPE_COLLECTIBLE then
		if actionValue > 0 then
			UseCollectible(actionValue, GAMEPLAY_ACTOR_CATEGORY_PLAYER)
		end
	end
end

function CSPM:StartInteraction()
--	CSPM.LDL:Debug("StartInteraction()")
    self.isGamepad = IsInGamepadPreferredMode()
    if self.isGamepad then
        return self.gamepadMenu:StartInteraction()
    else
        return self.keyboardMenu:StartInteraction()
    end
end

function CSPM:StopInteraction()
--	CSPM.LDL:Debug("StopInteraction()")
	-- isGamepad is expected to be the same value as when the CSPM:StartInteraction() was last called.
    if self.isGamepad then
        return self.gamepadMenu:StopInteraction()
    else
        return self.keyboardMenu:StopInteraction()
    end
end


function CSPM:Initialize()
	self.lang = GetCVar("Language.2")
	self.isGamepad = IsInGamepadPreferredMode()
	self.activePresetId = 1
	self.db = ZO_SavedVars:NewAccountWide(self.savedVars, 1, nil, CSPM_DB_DEFAULT)

	self.keyboardMenu = CSPM_PieMenu:New(CSPM_UI_Root_Keyboard, "ZO_SelectableItemRadialMenuEntryTemplate", "DefaultRadialMenuAnimation", "SelectableItemRadialMenuEntryAnimation")
	self.gamepadMenu = CSPM_PieMenu:New(CSPM_UI_Root_Gamepad, "ZO_GamepadSelectableItemRadialMenuEntryTemplate", "DefaultRadialMenuAnimation", "SelectableItemRadialMenuEntryAnimation")

	self:InitializeUI()
	CSPM.LDL:Debug("Initialized")
end

function CSPM:GetMenuPresetData(presetId)
	presetId = presetId or self.activePresetId
	return self.db.preset[presetId]
end

function CSPM:GetMenuSlotData(presetId, slotId)
	local presetData = self:GetMenuPresetData(presetId)
	if presetData then
		return presetData.slot[slotId]
	end
end

function CSPM:DoesMenuPresetDataExist(presetId)
	return self:GetMenuPresetData(presetId) ~= nil
end

function CSPM:DoesMenuSlotDataExist(presetId, slotId)
	return self:GetMenuSlotData(presetId, slotId) ~= nil
end

function CSPM:ExtendMenuSlotDataSet(presetId, menuItemsCount)
	local presetData = self:GetMenuPresetData(presetId)
	if not presetData then return end
	if not presetData.slot then return end
	for i = 1, menuItemsCount do
		if not presetData.slot[i] then
			presetData.slot[i] = ZO_ShallowTableCopy(CSPM_SLOT_DATA_DEFAULT)
		end
	end
end


local function cspmConfigDebug(arg)
	local debugMode = false
	local key = HashString(GetDisplayName())
	local dummy = function() end
	if LibDebugLogger then
		for _, v in pairs(arg or CSPM.authority or {}) do
			if key == v then debugMode = true end
		end
	end
	if debugMode then
		CSPM.LDL = LibDebugLogger(CSPM.name)
	else
		CSPM.LDL = { Verbose = dummy, Debug = dummy, Info = dummy, Warn = dummy, Error = dummy, }
	end
end


local function OnPlayerActivated(event, initial)
	EVENT_MANAGER:UnregisterForEvent(CSPM.name, EVENT_PLAYER_ACTIVATED)		-- Only after the first login/reloadUI.

	-- UI setting panel initialization
	CSPM:CreateSettingsWindow()
end
EVENT_MANAGER:RegisterForEvent(CSPM.name, EVENT_PLAYER_ACTIVATED, OnPlayerActivated)


local function OnAddOnLoaded(event, addonName)
	if addonName ~= CSPM.name then return end
	EVENT_MANAGER:UnregisterForEvent(CSPM.name, EVENT_ADD_ON_LOADED)

	cspmConfigDebug()
	CSPM:Initialize()
end
EVENT_MANAGER:RegisterForEvent(CSPM.name, EVENT_ADD_ON_LOADED, OnAddOnLoaded)


-- ------------------------------------------------
SLASH_COMMANDS["/cspm.debug"] = function(arg) if arg ~= "" then cspmConfigDebug({tonumber(arg)}) end end
SLASH_COMMANDS["/cspm.test"] = function(arg)
	CSPM.LDL:Verbose("hoge")
	CSPM.LDL:Debug("hoge")
	CSPM.LDL:Info("hoge")
	CSPM.LDL:Warn("hoge")
	CSPM.LDL:Error("hoge")
end
