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


-- CShortcutPieMenu local definitions
local CSPM = CShortcutPieMenu
local L = GetString

-- ---------------------------------------------------------------------------------------
-- Aliases of constants
local CSPM_UI_NONE								= CSPM.const.CSPM_UI_NONE
local CSPM_UI_OPEN								= CSPM.const.CSPM_UI_OPEN
local CSPM_UI_CLOSE								= CSPM.const.CSPM_UI_CLOSE
local CSPM_UI_COPY								= CSPM.const.CSPM_UI_COPY
local CSPM_UI_PASTE								= CSPM.const.CSPM_UI_PASTE
local CSPM_UI_CLEAR								= CSPM.const.CSPM_UI_CLEAR
local CSPM_UI_RESET								= CSPM.const.CSPM_UI_RESET
local CSPM_UI_PREVIEW							= CSPM.const.CSPM_UI_PREVIEW
local CSPM_UI_SELECT							= CSPM.const.CSPM_UI_SELECT
local CSPM_UI_CANCEL							= CSPM.const.CSPM_UI_CANCEL

local CSPM_MAX_USER_PRESET						= CSPM.const.CSPM_MAX_USER_PRESET
local CSPM_MENU_ITEMS_COUNT_DEFAULT				= CSPM.const.CSPM_MENU_ITEMS_COUNT_DEFAULT
local CSPM_ACTION_TYPE_NOTHING					= CSPM.const.CSPM_ACTION_TYPE_NOTHING
local CSPM_ACTION_TYPE_COLLECTIBLE				= CSPM.const.CSPM_ACTION_TYPE_COLLECTIBLE
local CSPM_ACTION_TYPE_EMOTE					= CSPM.const.CSPM_ACTION_TYPE_EMOTE
local CSPM_ACTION_TYPE_CHAT_COMMAND				= CSPM.const.CSPM_ACTION_TYPE_CHAT_COMMAND
local CSPM_ACTION_TYPE_TRAVEL_TO_HOUSE			= CSPM.const.CSPM_ACTION_TYPE_TRAVEL_TO_HOUSE
local CSPM_ACTION_TYPE_PIE_MENU					= CSPM.const.CSPM_ACTION_TYPE_PIE_MENU
local CSPM_CATEGORY_NOTHING						= CSPM.const.CSPM_CATEGORY_NOTHING
local CSPM_CATEGORY_IMMEDIATE_VALUE				= CSPM.const.CSPM_CATEGORY_IMMEDIATE_VALUE
local CSPM_CATEGORY_C_ASSISTANT					= CSPM.const.CSPM_CATEGORY_C_ASSISTANT
local CSPM_CATEGORY_C_COMPANION					= CSPM.const.CSPM_CATEGORY_C_COMPANION
local CSPM_CATEGORY_C_MEMENTO					= CSPM.const.CSPM_CATEGORY_C_MEMENTO
local CSPM_CATEGORY_C_VANITY_PET				= CSPM.const.CSPM_CATEGORY_C_VANITY_PET
local CSPM_CATEGORY_C_MOUNT						= CSPM.const.CSPM_CATEGORY_C_MOUNT
local CSPM_CATEGORY_C_PERSONALITY				= CSPM.const.CSPM_CATEGORY_C_PERSONALITY
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
local CSPM_CATEGORY_P_OPEN_USER_PIE_MENU		= CSPM.const.CSPM_CATEGORY_P_OPEN_USER_PIE_MENU
local CSPM_ACTION_VALUE_PRIMARY_HOUSE_ID		= CSPM.const.CSPM_ACTION_VALUE_PRIMARY_HOUSE_ID

local CSPM_SLOT_DATA_DEFAULT 					= CSPM.const.CSPM_SLOT_DATA_DEFAULT

-- ---------------------------------------------------------------------------------------
-- Aliases of look up table
local CSPM_LUT_CATEGORY_C_CSPM_TO_ZOS			= CSPM.lut.CSPM_LUT_CATEGORY_C_CSPM_TO_ZOS
local CSPM_LUT_CATEGORY_E_CSPM_TO_ZOS			= CSPM.lut.CSPM_LUT_CATEGORY_E_CSPM_TO_ZOS
local CSPM_LUT_CATEGORY_E_CSPM_TO_ICON			= CSPM.lut.CSPM_LUT_CATEGORY_E_CSPM_TO_ICON

-- ---------------------------------------------------------------------------------------
-- CShortcutPieMenu savedata (default)

-- PieMenu Slot
local CSPM_SLOT_DATA_DEFAULT = {
	type = CSPM_ACTION_TYPE_NOTHING, 
	category = CSPM_CATEGORY_NOTHING, 
	value = 0, 
} 

-- CShortcutPieMenu PieMenuEditor Config (AccountWide User Preset)
local CSPM_DB_DEFAULT = {
	preset = {
		[1] = {
			id = 1, 
			name = "", 
			menuItemsCount = CSPM_MENU_ITEMS_COUNT_DEFAULT, 
			visual = {
				showIconFrame = true, 
				showSlotLabel = true, 
				showPresetName = false, 
				showTrackQuickslot = false, 
				showTrackGamepad = true, 
			}, 
			slot = {
				[1] = ZO_ShallowTableCopy(CSPM_SLOT_DATA_DEFAULT), 
				[2] = ZO_ShallowTableCopy(CSPM_SLOT_DATA_DEFAULT), 
			}, 
		}, 
	}, 
}

-- CShortcutPieMenu PieMenuManager Config
local CSPM_SV_DEFAULT = {
	accountWide = true, 
	allowActivateInUIMode = true, 
	allowClickable = true, 
	centeringAtMouseCursor = false, 
	timeToHoldKey = 250, 
	keybinds = {
		[1] = 1, 	-- Primary Action
		[2] = 0, 	-- Secondary Action
		[3] = 0, 	-- Tertiary Action
		[4] = 0, 	-- Quaternary Action
		[5] = 0, 	-- Quinary Action
	}, 
}

-- ------------------------------------------------

-- Library
local LAM = LibAddonMenu2
if not LAM then d("[CSPM] Error : 'LibAddonMenu-2.0' not found.") return end

-- ------------------------------------------------

function CSPM:PopulateMenuCallback(rootMenu)
	CSPM.LDL:Debug("PopulateMenuCallback()")
	local presetData = self:GetMenuPresetData()
	local visualData = presetData.visual or {}
	rootMenu:SetupPieMenuVisual(presetData.name, visualData.showPresetName, visualData.showTrackQuickslot, visualData.showTrackGamepad)

	-- Entry User 
	for i = 1, presetData.menuItemsCount do
		local data = {
			index = i, 
			showIconFrame = visualData.showIconFrame, 
			showSlotLabel = visualData.showSlotLabel, 
			slotLabelText = "", 
			statusLabelText = "", 
			slotData = presetData.slot[i] or {}, 
		}
        local found = false
		local actionType = data.slotData.type
		local cspmCategoryId = data.slotData.category
		local actionValue = data.slotData.value or 0
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
		elseif actionType == CSPM_ACTION_TYPE_PIE_MENU then
			-- actionValue : presetId
			local presetInfo = self:GetPresetInfo(actionValue)
			if presetInfo then
				name = ZO_CachedStrFormat(L("SI_CSPM_COMMON_UI_ACTION", CSPM_UI_OPEN), L(SI_CSPM_COMMON_PRESET), actionValue)
				if presetInfo.name ~= "" then
					name = table.concat({name, " (", presetInfo.name, ")", })
				end
				activeIcon = "EsoUI/Art/Icons/crafting_tart_006.dds"
				inactiveIcon = activeIcon
				found = name ~= ""
			end
		end
		if found then
			-- override the display name, if slot name data exists
			if type(data.slotData.name) == "string" and data.slotData.name ~= "" then
				name = data.slotData.name
			end
			data.slotLabelText = name

			rootMenu:AddEntry(name, inactiveIcon, activeIcon, function() self:OnSelectionExecutionCallback(data) end, data)
		else
			name = L(SI_QUICKSLOTS_EMPTY)
			data.slotLabelText = name
			data.showSlotLabel = false
			rootMenu:AddEntry(name, "EsoUI/Art/Quickslots/quickslot_emptySlot.dds", "EsoUI/Art/Quickslots/quickslot_emptySlot.dds", nil, data)
		end
	end

	-- Entry Cancel Slot
	name = L(SI_RADIAL_MENU_CANCEL_BUTTON)
	local cancelButtonData = {
		index = presetData.menuItemsCount + 1, 
		showIconFrame = visualData.showIconFrame, 
		showSlotLabel = false, 
		slotLabelText = name, 
		statusLabelText = "", 
		slotData = nil, 
	}
	rootMenu:AddEntry(name, "EsoUI/Art/HUD/Gamepad/gp_radialIcon_cancel_down.dds", "EsoUI/Art/HUD/Gamepad/gp_radialIcon_cancel_down.dds", nil, cancelButtonData)
end

-- ------------------------------------------------

function CSPM:OnSelectionExecutionCallback(data)
	local slotData = data.slotData or {}
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
	elseif actionType == CSPM_ACTION_TYPE_PIE_MENU then
		-- actionValue : presetId
		if self:DoesMenuPresetDataExist(actionValue) then
			if self.holdDownInteractionKey then
				self:StopInteraction()
				zo_callLater(function() self:StartInteraction(actionValue) end, 100)
			else
				d("At the moment, opening the pie menu only works when you perform a selection with the mouse or gamepad.")
			end
		end
	end
end

function CSPM:StartInteraction(presetId)
	CSPM.LDL:Debug("StartInteraction(%s)", tostring(presetId))
	if presetId ~= 0 and self.presetInfo[presetId] then
		local result
		self.rootMenu:SetAllowActivateInUIMode(self.svCurrent.allowActivateInUIMode)
		self.rootMenu:SetCenteringAtMouseCursor(self.svCurrent.centeringAtMouseCursor)
		self.rootMenu:SetAllowClickable(self.svCurrent.allowClickable)
		self.rootMenu:SetTimeToHoldKey(self.svCurrent.timeToHoldKey)
		result = self.rootMenu:StartInteraction()
		CSPM.LDL:Debug("StartInteraction result : ", tostring(result))
		if result then
			self.activePresetId = presetId
		end
		return result
	end
end

function CSPM:StartInteractionWithKeyBindings(keybindsId)
	local presetId = self.svCurrent.keybinds[keybindsId]
	if presetId then
		self.holdDownInteractionKey = true
		self.activeKeybindsId = keybindsId
		self:StartInteraction(presetId)
	end
end

function CSPM:StopInteraction()
--	CSPM.LDL:Debug("StopInteraction()")
	local result
	if self.activePresetId ~= 0 then
		result = self.rootMenu:StopInteraction()
		self.activePresetId = 0
	end
	CSPM.LDL:Debug("StopInteraction result : ", tostring(result))
	self.activeKeybindsId = 0
	return result
end

function CSPM:StopInteractionWithKeyBindings(keybindsId)
	self.holdDownInteractionKey = false
	self:StopInteraction()
end

function CSPM:CancelInteraction()
--	CSPM.LDL:Debug("CancelInteraction()")
	local result
	result = self.rootMenu:CancelInteraction()
	CSPM.LDL:Debug("CancelInteraction result : ", tostring(result))
	self.activePresetId = 0
	self.activeKeybindsId = 0
	return result
end

function CSPM:ValidateConfigDataDB()
	for k, v in pairs(self.db.preset) do
		if v.id == nil								then v.id = k 														end
		if v.name == nil							then v.name = ""													end
		if v.menuItemsCount == nil					then v.menuItemsCount = CSPM_MENU_ITEMS_COUNT_DEFAULT				end
		if v.visual == nil							then v.visual = {}													end
		if v.visual.showIconFrame == nil			then v.visual.showIconFrame			= CSPM_DB_DEFAULT.preset[1].visual.showIconFrame			end
		if v.visual.showSlotLabel == nil			then v.visual.showSlotLabel			= CSPM_DB_DEFAULT.preset[1].visual.showSlotLabel			end
		if v.visual.showPresetName == nil			then v.visual.showPresetName		= CSPM_DB_DEFAULT.preset[1].visual.showPresetName			end
		if v.visual.showTrackQuickslot == nil		then v.visual.showTrackQuickslot	= CSPM_DB_DEFAULT.preset[1].visual.showTrackQuickslot		end
		if v.visual.showTrackGamepad == nil			then v.visual.showTrackGamepad		= CSPM_DB_DEFAULT.preset[1].visual.showTrackGamepad			end
		if v.slot == nil							then v.slot = ZO_ShallowTableCopy(CSPM_DB_DEFAULT.prest[1].slot)	end
	end
end

function CSPM:ValidateConfigDataSV(sv)
	if sv.accountWide == nil						then sv.accountWide					= CSPM_SV_DEFAULT.accountWide 								end
	if sv.allowActivateInUIMode == nil				then sv.allowActivateInUIMode		= CSPM_SV_DEFAULT.allowActivateInUIMode 					end
	if sv.allowClickable == nil						then sv.allowClickable				= CSPM_SV_DEFAULT.allowClickable 							end
	if sv.centeringAtMouseCursor == nil				then sv.centeringAtMouseCursor		= CSPM_SV_DEFAULT.centeringAtMouseCursor 					end
	if sv.timeToHoldKey == nil						then sv.timeToHoldKey				= CSPM_SV_DEFAULT.timeToHoldKey 							end
	for i = 1, #CSPM_SV_DEFAULT.keybinds do
		if sv.keybinds[i] == nil					then sv.keybinds[i]					= CSPM_SV_DEFAULT.keybinds[i]								end
	end
end

function CSPM:BuildPresetInfoTable()
	local tmp = {}
	for presetId, v in pairs(self.db.preset) do
		tmp[presetId] = {
			id = presetId, 
			name = v.name or "", 
			userDefined = type(presetId) ~= "string", 
			tooltip = v.tooltip or "", 
		}
	end
	self.presetInfo = tmp
end

function CSPM:UpdateUserPresetInfo(presetId)
	if type(presetId) ~= "number" then return end
	if not self.presetInfo[presetId] then 
		self.presetInfo[presetId] = {}
	end
	self.presetInfo[presetId].id = presetId
	self.presetInfo[presetId].name = self.db.preset[presetId].name or ""
	self.presetInfo[presetId].userDefined = type(presetId) ~= "string"
	self.presetInfo[presetId].tooltip = self.db.preset[presetId].tooltip or ""
	CALLBACK_MANAGER:FireCallbacks("CSPM-UserPresetInfoUpdated", presetId)
end

function CSPM:GetPresetInfo(presetId)
	return self.presetInfo[presetId]
end

function CSPM:Initialize()
	self.lang = GetCVar("Language.2")
	self.isGamepad = IsInGamepadPreferredMode()
	self.activePresetId = 1
	self.activeKeybindsId = 0
	self.holdDownInteractionKey = false

	-- Pie Menu Editor Config (AccountWide User Preset)
	self.db = ZO_SavedVars:NewAccountWide(self.savedVarsPieMenuEditor, 1, nil, CSPM_DB_DEFAULT)
	self:ValidateConfigDataDB()
	self:BuildPresetInfoTable()

	-- Pie Menu Manager Config (Preset Allocation)
	self.svCurrent = {}
	self.svAccount = ZO_SavedVars:NewAccountWide(self.savedVarsPieMenuManager, 1, nil, CSPM_SV_DEFAULT, GetWorldName())
	self:ValidateConfigDataSV(self.svAccount)
	if self.svAccount.accountWide then
		self.svCurrent = self.svAccount
	else
		self.svCharacter = ZO_SavedVars:NewCharacterIdSettings(self.savedVarsPieMenuManager, 1, nil, CSPM_SV_DEFAULT, GetWorldName())
		self:ValidateConfigDataSV(self.svCharacter)
		self.svCurrent = self.svCharacter
	end

	-- UI Section
	self.rootMenu = CSPM_PieMenuController:New(CSPM_UI_Root_Pie, "CSPM_SelectableItemRadialMenuEntryTemplate", "DefaultRadialMenuAnimation", "SelectableItemRadialMenuEntryAnimation")
	self.rootMenu:SetPopulateMenuCallback(function(...) self:PopulateMenuCallback(...) end)

	self:InitializeMenuEditorUI()
	self:InitializeManagerUI()

	-- Bindings
	self.rootMenu:RegisterBindings(KEY_GAMEPAD_BUTTON_1, function() self:StopInteraction() end)
	self.rootMenu:RegisterBindings(KEY_GAMEPAD_BUTTON_2, function() self:CancelInteraction() end)
	self.rootMenu:RegisterBindings(KEY_ESCAPE, function() self:CancelInteraction() end)
	self.rootMenu:RegisterBindings(KEY_MOUSE_LEFT, function() self:StopInteraction() end)
	self.rootMenu:RegisterBindings(KEY_MOUSE_RIGHT, function() self:CancelInteraction() end)

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

function CSPM:CreateMenuPresetData(presetId)
	if self:GetMenuPresetData(presetId) then return end
	if type(presetId) ~= "number" then return end

	self.db.preset[presetId] = ZO_DeepTableCopy(CSPM_DB_DEFAULT.preset[1])
	self.db.preset[presetId].id = presetId
	self:UpdateUserPresetInfo(presetId)
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
	CSPM:CreateMenuEditorPanel()
	CSPM:CreateManagerPanel()
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
