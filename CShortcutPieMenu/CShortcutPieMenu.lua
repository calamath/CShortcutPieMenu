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


-- CShortcutPieMenu namespace
CShortcutPieMenu = CShortcutPieMenu or {}

local CSPM = CShortcutPieMenu
CSPM.name = "CShortcutPieMenu"
CSPM.version = "0.4.1"
CSPM.author = "Calamath"
CSPM.savedVars = "CShortcutPieMenuDB"
CSPM.savedVarsVersion = 1
CSPM.authority = {2973583419,210970542} 

-- ---------------------------------------------------------------------------------------
-- constants
CSPM.const = {
	CSPM_MENU_ITEMS_COUNT_DEFAULT				= 2, 
	CSPM_ACTION_TYPE_NOTHING					= 0, 
	CSPM_ACTION_TYPE_COLLECTIBLE				= 1, 
	CSPM_ACTION_TYPE_EMOTE						= 2, 
	CSPM_ACTION_TYPE_CHAT_COMMAND				= 3, 
	CSPM_ACTION_TYPE_TRAVEL_TO_HOUSE			= 4, 
	CSPM_CATEGORY_NOTHING						= 0, 
	CSPM_CATEGORY_IMMEDIATE_VALUE				= 1, 
	CSPM_CATEGORY_C_ASSISTANT					= 11, 
	CSPM_CATEGORY_C_COMPANION					= 12, 
	CSPM_CATEGORY_C_MEMENTO						= 13, 
	CSPM_CATEGORY_C_VANITY_PET					= 14, 
	CSPM_CATEGORY_C_MOUNT						= 15, 
	CSPM_CATEGORY_E_CEREMONIAL					= 31, 
	CSPM_CATEGORY_E_CHEERS_AND_JEERS			= 32, 
	CSPM_CATEGORY_E_EMOTION						= 33, 
	CSPM_CATEGORY_E_ENTERTAINMENT				= 34, 
	CSPM_CATEGORY_E_FOOD_AND_DRINK				= 35, 
	CSPM_CATEGORY_E_GIVE_DIRECTIONS				= 36, 
	CSPM_CATEGORY_E_PHYSICAL					= 37, 
	CSPM_CATEGORY_E_POSES_AND_FIDGETS			= 38, 
	CSPM_CATEGORY_E_PROP						= 39, 
	CSPM_CATEGORY_E_SOCIAL						= 40, 
	CSPM_CATEGORY_E_COLLECTED					= 41, 
	CSPM_CATEGORY_H_UNLOCKED_HOUSE_INSIDE		= 51, 
	CSPM_CATEGORY_H_UNLOCKED_HOUSE_OUTSIDE		= 52, 
	CSPM_ACTION_VALUE_PRIMARY_HOUSE_ID			= -1, 
}
-- ---------------------------------------------------------------------------------------
-- Aliases of constants
local CSPM_MENU_ITEMS_COUNT_DEFAULT				= CSPM.const.CSPM_MENU_ITEMS_COUNT_DEFAULT
local CSPM_ACTION_TYPE_NOTHING					= CSPM.const.CSPM_ACTION_TYPE_NOTHING
local CSPM_ACTION_TYPE_COLLECTIBLE				= CSPM.const.CSPM_ACTION_TYPE_COLLECTIBLE
local CSPM_ACTION_TYPE_EMOTE					= CSPM.const.CSPM_ACTION_TYPE_EMOTE
local CSPM_ACTION_TYPE_CHAT_COMMAND				= CSPM.const.CSPM_ACTION_TYPE_CHAT_COMMAND
local CSPM_ACTION_TYPE_TRAVEL_TO_HOUSE			= CSPM.const.CSPM_ACTION_TYPE_TRAVEL_TO_HOUSE
local CSPM_CATEGORY_NOTHING						= CSPM.const.CSPM_CATEGORY_NOTHING
local CSPM_CATEGORY_IMMEDIATE_VALUE				= CSPM.const.CSPM_CATEGORY_IMMEDIATE_VALUE
local CSPM_CATEGORY_C_ASSISTANT					= CSPM.const.CSPM_CATEGORY_C_ASSISTANT
local CSPM_CATEGORY_C_COMPANION					= CSPM.const.CSPM_CATEGORY_C_COMPANION
local CSPM_CATEGORY_C_MEMENTO					= CSPM.const.CSPM_CATEGORY_C_MEMENTO
local CSPM_CATEGORY_C_VANITY_PET				= CSPM.const.CSPM_CATEGORY_C_VANITY_PET
local CSPM_CATEGORY_C_MOUNT						= CSPM.const.CSPM_CATEGORY_C_MOUNT
local CSPM_CATEGORY_E_CEREMONIAL				= CSPM.const.CSPM_CATEGORY_E_CEREMONIAL
local CSPM_CATEGORY_E_CHEERS_AND_JEERS			= CSPM.const.CSPM_CATEGORY_E_CHEERS_AND_JEERS
local CSPM_CATEGORY_E_EMOTION					= CSPM.const.CSPM_CATEGORY_E_EMOTION
local CSPM_CATEGORY_E_ENTERTAINMENT				= CSPM.const.CSPM_CATEGORY_E_ENTERTAINMENT
local CSPM_CATEGORY_E_FOOD_AND_DRINK			= CSPM.const.CSPM_CATEGORY_E_FOOD_AND_DRINK
local CSPM_CATEGORY_E_GIVE_DIRECTIONS			= CSPM.const.CSPM_CATEGORY_E_GIVE_DIRECTIONS
local CSPM_CATEGORY_E_PHYSICAL					= CSPM.const.CSPM_CATEGORY_E_PHYSICAL
local CSPM_CATEGORY_E_POSES_AND_FIDGETS			= CSPM.const.CSPM_CATEGORY_E_POSES_AND_FIDGETS
local CSPM_CATEGORY_E_PROP						= CSPM.const.CSPM_CATEGORY_E_PROP
local CSPM_CATEGORY_E_SOCIAL					= CSPM.const.CSPM_CATEGORY_E_SOCIAL
local CSPM_CATEGORY_E_COLLECTED					= CSPM.const.CSPM_CATEGORY_E_COLLECTED
local CSPM_CATEGORY_H_UNLOCKED_HOUSE_INSIDE		= CSPM.const.CSPM_CATEGORY_H_UNLOCKED_HOUSE_INSIDE
local CSPM_CATEGORY_H_UNLOCKED_HOUSE_OUTSIDE	= CSPM.const.CSPM_CATEGORY_H_UNLOCKED_HOUSE_OUTSIDE
local CSPM_ACTION_VALUE_PRIMARY_HOUSE_ID		= CSPM.const.CSPM_ACTION_VALUE_PRIMARY_HOUSE_ID

local CSPM_SLOT_DATA_DEFAULT 					= CSPM.const.CSPM_SLOT_DATA_DEFAULT

-- =======================================================================================
-- CShortcutPieMenu local definitions
local L = GetString

-- look up table
CSPM.lut = {
	CSPM_LUT_CATEGORY_C_CSPM_TO_ZOS = {
		[CSPM_CATEGORY_C_ASSISTANT]				= COLLECTIBLE_CATEGORY_TYPE_ASSISTANT, 
		[CSPM_CATEGORY_C_COMPANION]				= COLLECTIBLE_CATEGORY_TYPE_COMPANION, 
		[CSPM_CATEGORY_C_MEMENTO]				= COLLECTIBLE_CATEGORY_TYPE_MEMENTO, 
		[CSPM_CATEGORY_C_VANITY_PET]			= COLLECTIBLE_CATEGORY_TYPE_VANITY_PET, 
		[CSPM_CATEGORY_C_MOUNT]					= COLLECTIBLE_CATEGORY_TYPE_MOUNT, 
	}, 
	CSPM_LUT_CATEGORY_E_CSPM_TO_ZOS = {
		[CSPM_CATEGORY_E_CEREMONIAL]			= EMOTE_CATEGORY_CEREMONIAL, 
		[CSPM_CATEGORY_E_CHEERS_AND_JEERS]		= EMOTE_CATEGORY_CHEERS_AND_JEERS, 
		[CSPM_CATEGORY_E_EMOTION]				= EMOTE_CATEGORY_EMOTION, 
		[CSPM_CATEGORY_E_ENTERTAINMENT]			= EMOTE_CATEGORY_ENTERTAINMENT, 
		[CSPM_CATEGORY_E_FOOD_AND_DRINK]		= EMOTE_CATEGORY_FOOD_AND_DRINK, 
		[CSPM_CATEGORY_E_GIVE_DIRECTIONS]		= EMOTE_CATEGORY_GIVE_DIRECTIONS, 
		[CSPM_CATEGORY_E_PHYSICAL]				= EMOTE_CATEGORY_PHYSICAL, 
		[CSPM_CATEGORY_E_POSES_AND_FIDGETS]		= EMOTE_CATEGORY_POSES_AND_FIDGETS, 
		[CSPM_CATEGORY_E_PROP]					= EMOTE_CATEGORY_PROP, 
		[CSPM_CATEGORY_E_SOCIAL]				= EMOTE_CATEGORY_SOCIAL, 
		[CSPM_CATEGORY_E_COLLECTED] 			= EMOTE_CATEGORY_COLLECTED, 
	}, 
	CSPM_LUT_CATEGORY_E_CSPM_TO_ICON = {
		[CSPM_CATEGORY_NOTHING]					= "EsoUI/Art/Inventory/inventory_tabIcon_quickslot_up.dds", 
		[CSPM_CATEGORY_IMMEDIATE_VALUE]			= "EsoUI/Art/Help/help_tabIcon_emotes_up.dds", 
		[CSPM_CATEGORY_E_CEREMONIAL]			= "EsoUI/Art/Emotes/emotes_indexIcon_ceremonial_up.dds", 
		[CSPM_CATEGORY_E_CHEERS_AND_JEERS]		= "EsoUI/Art/Emotes/emotes_indexIcon_cheersJeers_up.dds", 
		[CSPM_CATEGORY_E_EMOTION]				= "EsoUI/Art/Emotes/emotes_indexIcon_emotion_up.dds", 
		[CSPM_CATEGORY_E_ENTERTAINMENT]			= "EsoUI/Art/Emotes/emotes_indexIcon_entertain_up.dds", 
		[CSPM_CATEGORY_E_FOOD_AND_DRINK]		= "EsoUI/Art/Emotes/emotes_indexIcon_eatDrink_up.dds", 
		[CSPM_CATEGORY_E_GIVE_DIRECTIONS]		= "EsoUI/Art/Emotes/emotes_indexIcon_directions_up.dds", 
		[CSPM_CATEGORY_E_PHYSICAL]				= "EsoUI/Art/Emotes/emotes_indexIcon_physical_up.dds", 
		[CSPM_CATEGORY_E_POSES_AND_FIDGETS]		= "EsoUI/Art/Emotes/emotes_indexIcon_fidget_up.dds", 
		[CSPM_CATEGORY_E_PROP]					= "EsoUI/Art/Emotes/emotes_indexIcon_prop_up.dds", 
		[CSPM_CATEGORY_E_SOCIAL]				= "EsoUI/Art/Emotes/emotes_indexIcon_social_up.dds", 
		[CSPM_CATEGORY_E_COLLECTED] 			= "EsoUI/Art/Collections/collections_tabIcon_collectibles_up.dds", 
	}, 
}
-- ---------------------------------------------------------------------------------------
-- Aliases of look up table
local CSPM_LUT_CATEGORY_C_CSPM_TO_ZOS			= CSPM.lut.CSPM_LUT_CATEGORY_C_CSPM_TO_ZOS
local CSPM_LUT_CATEGORY_E_CSPM_TO_ZOS			= CSPM.lut.CSPM_LUT_CATEGORY_E_CSPM_TO_ZOS
local CSPM_LUT_CATEGORY_E_CSPM_TO_ICON			= CSPM.lut.CSPM_LUT_CATEGORY_E_CSPM_TO_ICON

-- ---------------------------------------------------------------------------------------
-- CShortcutPieMenu savedata (default)
local CSPM_SLOT_DATA_DEFAULT = {
	type = 0, 
	category = 0, 
	value = 0, 
} 

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
	local selected = false
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
		local cspmCategoryId = data.category
		local actionValue = data.value or 0
		local name, inactiveIcon, activeIcon
		if actionType == CSPM_ACTION_TYPE_COLLECTIBLE then
			-- actionValue : collectibleId
			if actionValue > 0 then
				name = ZO_CachedStrFormat("<<1>>", GetCollectibleName(actionValue))
				activeIcon = GetCollectibleIcon(actionValue)
				inactiveIcon = activeIcon
				found = name ~= ""
			end
		elseif actionType == CSPM_ACTION_TYPE_EMOTE then
			-- actionValue : emoteId
			local emoteInfo = PLAYER_EMOTE_MANAGER:GetEmoteItemInfo(actionValue)
			if emoteInfo then
				name = ZO_CachedStrFormat("<<1>>", emoteInfo.displayName)
				if emoteInfo.isOverriddenByPersonality then
					name = ZO_PERSONALITY_EMOTES_COLOR:Colorize(name)
				end
				local emoteCollectibleId = GetEmoteCollectibleId(emoteInfo.emoteIndex)
				if emoteCollectibleId then
					activeIcon = GetCollectibleIcon(emoteCollectibleId)
				else
					activeIcon = CSPM_LUT_CATEGORY_E_CSPM_TO_ICON[cspmCategoryId] or CSPM_LUT_CATEGORY_E_CSPM_TO_ICON[CSPM_CATEGORY_NOTHING]
				end
				inactiveIcon = activeIcon
				found = true
			end
		elseif actionType == CSPM_ACTION_TYPE_CHAT_COMMAND then
			-- actionValue : chatCommandString
			name = tostring(actionValue)
			activeIcon = "EsoUI/Art/Icons/crafting_dwemer_shiny_cog.dds"
			inactiveIcon = activeIcon
			found = name ~= ""
		elseif actionType == CSPM_ACTION_TYPE_TRAVEL_TO_HOUSE then
			-- actionValue : houseId
			local houseId = (actionValue == CSPM_ACTION_VALUE_PRIMARY_HOUSE_ID) and GetHousingPrimaryHouse() or actionValue
			if houseId ~= 0 then
				local houseCollectibleId = GetCollectibleIdForHouse(houseId)
				local houseName = GetCollectibleName(houseCollectibleId)
				if actionValue == CSPM_ACTION_VALUE_PRIMARY_HOUSE_ID then
					houseName = ZO_CachedStrFormat(L(SI_HOUSING_BOOK_PRIMARY_RESIDENCE_FORMATTER), houseName)		-- "Primary Residence: |cffffff<<1>>|r"
				end
				if cspmCategoryId == CSPM_CATEGORY_H_UNLOCKED_HOUSE_INSIDE then
					name = ZO_CachedStrFormat(L(SI_GAMEPAD_WORLD_MAP_TRAVEL_TO_HOUSE_INSIDE), houseName)		-- "<<1>> (inside)"
				elseif cspmCategoryId == CSPM_CATEGORY_H_UNLOCKED_HOUSE_OUTSIDE then
					name = ZO_CachedStrFormat(L(SI_GAMEPAD_WORLD_MAP_TRAVEL_TO_HOUSE_OUTSIDE), houseName)		-- "<<1>> (outside)"
				end
				activeIcon = GetCollectibleIcon(houseCollectibleId)
				inactiveIcon = activeIcon
				found = houseName ~= ""
			end
		end
		if found then
			-- override the display name, if slot name data exists
			if type(data.name) == "string" and data.name ~= "" then
				name = data.name
			end

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
		-- actionValue : collectibleId
		if actionValue > 0 then
			UseCollectible(actionValue, GAMEPLAY_ACTOR_CATEGORY_PLAYER)
		end
	elseif actionType == CSPM_ACTION_TYPE_EMOTE then
		-- actionValue : emoteId
		if actionValue > 0 then
			local emoteIndex = GetEmoteIndex(actionValue)
			if emoteIndex then
				PlayEmoteByIndex(emoteIndex)
			end
		end
	elseif actionType == CSPM_ACTION_TYPE_CHAT_COMMAND then
		-- actionValue : chatCommandString
		local command, args = string.match(actionValue, "^(%S+)% *(.*)")
		CSPM.LDL:Debug("chat command : %s, argments : %s", tostring(command), tostring(args))
		if SLASH_COMMANDS[command] then
			SLASH_COMMANDS[command](args)
		else
			CSPM.LDL:Debug("[CSPM] error : slash command '%s' not found", tostring(command))
		end
	elseif actionType == CSPM_ACTION_TYPE_TRAVEL_TO_HOUSE then
		-- actionValue : houseId
		local houseId = actionValue
		local jumpOutside = false
		if actionValue == CSPM_ACTION_VALUE_PRIMARY_HOUSE_ID then
			houseId = GetHousingPrimaryHouse()
		end
		if slotData.category == CSPM_CATEGORY_H_UNLOCKED_HOUSE_OUTSIDE then
			jumpOutside = true
		end
		RequestJumpToHouse(houseId, jumpOutside)
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
