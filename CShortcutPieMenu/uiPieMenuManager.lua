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
local CSPM_UI_EXECUTE							= CSPM.const.CSPM_UI_EXECUTE

local CSPM_MAX_USER_PRESET						= CSPM.const.CSPM_MAX_USER_PRESET
local CSPM_MENU_ITEMS_COUNT_DEFAULT				= CSPM.const.CSPM_MENU_ITEMS_COUNT_DEFAULT
local CSPM_ACTION_TYPE_NOTHING					= CSPM.const.CSPM_ACTION_TYPE_NOTHING
local CSPM_ACTION_TYPE_COLLECTIBLE				= CSPM.const.CSPM_ACTION_TYPE_COLLECTIBLE
local CSPM_ACTION_TYPE_EMOTE					= CSPM.const.CSPM_ACTION_TYPE_EMOTE
local CSPM_ACTION_TYPE_CHAT_COMMAND				= CSPM.const.CSPM_ACTION_TYPE_CHAT_COMMAND
local CSPM_ACTION_TYPE_TRAVEL_TO_HOUSE			= CSPM.const.CSPM_ACTION_TYPE_TRAVEL_TO_HOUSE
local CSPM_ACTION_TYPE_PIE_MENU					= CSPM.const.CSPM_ACTION_TYPE_PIE_MENU
local CSPM_ACTION_TYPE_SHORTCUT					= CSPM.const.CSPM_ACTION_TYPE_SHORTCUT
local CSPM_ACTION_TYPE_COLLECTIBLE_APPEARANCE	= CSPM.const.CSPM_ACTION_TYPE_COLLECTIBLE_APPEARANCE

local CSPM_CATEGORY_NOTHING						= CSPM.const.CSPM_CATEGORY_NOTHING
local CSPM_CATEGORY_IMMEDIATE_VALUE				= CSPM.const.CSPM_CATEGORY_IMMEDIATE_VALUE
local CSPM_CATEGORY_C_ASSISTANT					= CSPM.const.CSPM_CATEGORY_C_ASSISTANT
local CSPM_CATEGORY_C_COMPANION					= CSPM.const.CSPM_CATEGORY_C_COMPANION
local CSPM_CATEGORY_C_MEMENTO					= CSPM.const.CSPM_CATEGORY_C_MEMENTO
local CSPM_CATEGORY_C_VANITY_PET				= CSPM.const.CSPM_CATEGORY_C_VANITY_PET
local CSPM_CATEGORY_C_MOUNT						= CSPM.const.CSPM_CATEGORY_C_MOUNT
local CSPM_CATEGORY_C_PERSONALITY				= CSPM.const.CSPM_CATEGORY_C_PERSONALITY
local CSPM_CATEGORY_C_ABILITY_SKIN				= CSPM.const.CSPM_CATEGORY_C_ABILITY_SKIN
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
local CSPM_CATEGORY_P_OPEN_EXTERNAL_PIE_MENU	= CSPM.const.CSPM_CATEGORY_P_OPEN_EXTERNAL_PIE_MENU
local CSPM_CATEGORY_S_PIE_MENU_ADDON			= CSPM.const.CSPM_CATEGORY_S_PIE_MENU_ADDON
local CSPM_CATEGORY_S_MAIN_MENU					= CSPM.const.CSPM_CATEGORY_S_MAIN_MENU
local CSPM_CATEGORY_S_SYSTEM_MENU				= CSPM.const.CSPM_CATEGORY_S_SYSTEM_MENU
local CSPM_CATEGORY_S_USEFUL_SHORTCUT			= CSPM.const.CSPM_CATEGORY_S_USEFUL_SHORTCUT
local CSPM_CATEGORY_C_HAT						= CSPM.const.CSPM_CATEGORY_C_HAT
local CSPM_CATEGORY_C_HAIR						= CSPM.const.CSPM_CATEGORY_C_HAIR
local CSPM_CATEGORY_C_HEAD_MARKING				= CSPM.const.CSPM_CATEGORY_C_HEAD_MARKING
local CSPM_CATEGORY_C_FACIAL_HAIR_HORNS			= CSPM.const.CSPM_CATEGORY_C_FACIAL_HAIR_HORNS
local CSPM_CATEGORY_C_FACIAL_ACCESSORY			= CSPM.const.CSPM_CATEGORY_C_FACIAL_ACCESSORY
local CSPM_CATEGORY_C_PIERCING_JEWELRY			= CSPM.const.CSPM_CATEGORY_C_PIERCING_JEWELRY
local CSPM_CATEGORY_C_COSTUME					= CSPM.const.CSPM_CATEGORY_C_COSTUME
local CSPM_CATEGORY_C_BODY_MARKING				= CSPM.const.CSPM_CATEGORY_C_BODY_MARKING
local CSPM_CATEGORY_C_SKIN						= CSPM.const.CSPM_CATEGORY_C_SKIN
local CSPM_CATEGORY_C_POLYMORPH					= CSPM.const.CSPM_CATEGORY_C_POLYMORPH
local CSPM_ACTION_VALUE_PRIMARY_HOUSE_ID		= CSPM.const.CSPM_ACTION_VALUE_PRIMARY_HOUSE_ID

local CSPM_SLOT_DATA_DEFAULT 					= CSPM.const.CSPM_SLOT_DATA_DEFAULT

-- ---------------------------------------------------------------------------------------
-- Aliases of look up table
local CSPM_LUT_CATEGORY_C_CSPM_TO_ZOS			= CSPM.lut.CSPM_LUT_CATEGORY_C_CSPM_TO_ZOS
local CSPM_LUT_CATEGORY_E_CSPM_TO_ZOS			= CSPM.lut.CSPM_LUT_CATEGORY_E_CSPM_TO_ZOS
local CSPM_LUT_CATEGORY_E_CSPM_TO_ICON			= CSPM.lut.CSPM_LUT_CATEGORY_E_CSPM_TO_ICON
local CSPM_LUT_ACTION_TYPE_API_STRINGS			= CSPM.lut.CSPM_LUT_ACTION_TYPE_API_STRINGS
local CSPM_LUT_ACTION_TYPE_ALIAS				= CSPM.lut.CSPM_LUT_ACTION_TYPE_ALIAS
local CSPM_LUT_UI_COLOR							= CSPM.lut.CSPM_LUT_UI_COLOR


-- Library
local LAM = LibAddonMenu2
if not LAM then d("[CSPM] Error : 'LibAddonMenu' not found.") return end


-- UI section locals
local ui = ui or {}

local function DoSetupDefault(slotId)
end

local function GetTableKeyForValue(luaTable, value)
	for k, v in pairs(luaTable) do
		if v == value then 
			return k
		end
	end
	return
end

local function GetPresetDisplayNameByPresetId(presetId)
	local name
	local pieMenuName = CSPM:GetPieMenuInfo(presetId)
	if CSPM:IsUserPieMenu(presetId) then
		if CSPM:DoesPieMenuDataExist(presetId) then
			if pieMenuName ~= "" then
				name = zo_strformat(L(SI_CSPM_PRESET_NAME_FORMATTER), presetId, pieMenuName)
			else
				name = ZO_CachedStrFormat(L(SI_CSPM_PRESET_NO_NAME_FORMATTER), presetId)
			end
		else
			name = ZO_CachedStrFormat(L(SI_CSPM_PRESET_NAME_FORMATTER), presetId, L(SI_CSPM_COMMON_UNREGISTERED))
		end
	else
		name = pieMenuName
	end
	return name
end

local function RefreshPanel_OnPieMenuInfoUpdated(presetId)
-- This function assumes that the preset attribute information in the user pie menu has just changed.
	CSPM.LDL:Debug("RefreshManagerPanel-OnPieMenuInfoUpdated : ", presetId)

	-- NOTE : the preset selection choices will also be updated here.
	if CSPM:IsUserPieMenu(presetId) then
		ui.presetChoices[presetId] = GetPresetDisplayNameByPresetId(presetId)
	else
		local key = GetTableKeyForValue(ui.presetChoicesValues, presetId)
		if not key then return end
		ui.presetChoices[key] = GetPresetDisplayNameByPresetId(presetId)
	end
	if ui.panelInitialized then
		CSPM_UI_MAN_PresetSelectMenuKeybinds1:UpdateChoices(ui.presetChoices, ui.presetChoicesValues, ui.presetChoicesTooltips)
		CSPM_UI_MAN_PresetSelectMenuKeybinds1:UpdateValue()		-- Note : When called with no arguments, getFunc will be called, and setFunc will NOT be called.
		CSPM_UI_MAN_PresetSelectMenuKeybinds2:UpdateChoices(ui.presetChoices, ui.presetChoicesValues, ui.presetChoicesTooltips)
		CSPM_UI_MAN_PresetSelectMenuKeybinds2:UpdateValue()
		CSPM_UI_MAN_PresetSelectMenuKeybinds3:UpdateChoices(ui.presetChoices, ui.presetChoicesValues, ui.presetChoicesTooltips)
		CSPM_UI_MAN_PresetSelectMenuKeybinds3:UpdateValue()
		CSPM_UI_MAN_PresetSelectMenuKeybinds4:UpdateChoices(ui.presetChoices, ui.presetChoicesValues, ui.presetChoicesTooltips)
		CSPM_UI_MAN_PresetSelectMenuKeybinds4:UpdateValue()
		CSPM_UI_MAN_PresetSelectMenuKeybinds5:UpdateChoices(ui.presetChoices, ui.presetChoicesValues, ui.presetChoicesTooltips)
		CSPM_UI_MAN_PresetSelectMenuKeybinds5:UpdateValue()
	end
end

local function RebuildPresetSelectionChoices()
	local choices = {}
	local choicesValues = {}
	for i = 1, CSPM_MAX_USER_PRESET do
		choices[i] = GetPresetDisplayNameByPresetId(i)
		choicesValues[i] = i
	end

	local externalPieMenuList = CSPM:GetExternalPieMenuList()
	for _, presetId in pairs(externalPieMenuList) do
		choices[#choices + 1] = GetPresetDisplayNameByPresetId(presetId)
		choicesValues[#choicesValues + 1] = presetId
	end
	-- In overridden custom tooltip functions, the ChoicesTooltips table uses the presetId value instead of a string.
	return choices, choicesValues, choicesValues
end

local function DoTestButton()
end

local function OnLAMPanelControlsCreated(panel)
	if (panel ~= ui.panel) then return end
	CALLBACK_MANAGER:UnregisterCallback("LAM-PanelControlsCreated", OnLAMPanelControlsCreated)

	-- override ScrollableDropdownHelper for CSPM_UI_MAN_PresetSelectMenuKeybindsX to customize dropdown choices tooltips
	for i = 1, 5 do
			_G["CSPM_UI_MAN_PresetSelectMenuKeybinds" .. i].scrollHelper.OnMouseEnter = function(self, control)
				if control.m_data.tooltip then
					CSPM.util.LayoutSlotActionTooltip(CSPM_ACTION_TYPE_PIE_MENU, CSPM_CATEGORY_NOTHING, control.m_data.tooltip, CSPM_UI_NONE)
					CSPM.util.ShowSlotActionTooltip(control, TOPLEFT, 0, 0, BOTTOMRIGHT)
				end
			end
			_G["CSPM_UI_MAN_PresetSelectMenuKeybinds" .. i].scrollHelper.OnMouseExit = function(self, control)
				if control.m_data.tooltip then
					CSPM.util.HideSlotActionTooltip()
				end
			end
		
	end

	ui.panelInitialized = true
end

function CSPM:InitializeManagerUI()
	ui.panelInitialized = false
	ui.presetChoices, ui.presetChoicesValues, ui.presetChoicesTooltips = RebuildPresetSelectionChoices()
	CALLBACK_MANAGER:RegisterCallback("CSPM-UserPieMenuInfoUpdated", RefreshPanel_OnPieMenuInfoUpdated)
end

function CSPM:CreateManagerPanel()
	local panelData = {
		type = "panel", 
		name = "Shortcut PieManager", 
		displayName = "Calamath's Shortcut Pie Menu (Manager)", 
		author = CSPM.author, 
		version = CSPM.version, 
		website = "https://www.esoui.com/downloads/info3088-CalamathsShortcutPieMenu.html", 
		feedback = "https://www.esoui.com/downloads/info3088-CalamathsShortcutPieMenu.html#comments", 
		donation = "https://www.esoui.com/downloads/info3088-CalamathsShortcutPieMenu.html#donate", 
		slashCommand = "/cspm", 
		registerForRefresh = true, 
		registerForDefaults = true, 
--		resetFunc = nil, 
	}
	ui.panel = LAM:RegisterAddonPanel("CSPM_OptionsManager", panelData)
	self.panelManager = ui.panel

	local optionsData = {}
--[[
	optionsData[#optionsData + 1] = {
		type = "divider", 
		width = "full", 
		height = 10, 
		alpha = 0.5, 
	}
]]
	optionsData[#optionsData + 1] = {
		type = "description", 
		title = "", 
		text = L(SI_CSPM_UI_PANEL_HEADER3_TEXT), 
	}
	optionsData[#optionsData + 1] = {
		type = "checkbox",
		name = L(SI_CSPM_UI_ACCOUNT_WIDE_OP_NAME), 
		getFunc = function() return CSPM.svAccount.accountWide end, 
		setFunc = function(newValue) CSPM.svAccount.accountWide = newValue end, 
		tooltip = L(SI_CSPM_UI_ACCOUNT_WIDE_OP_TIPS), 
		width = "full", 
		requiresReload = true, 
		default = true, 
	}
	optionsData[#optionsData + 1] = {
		type = "header", 
		name = L(SI_CSPM_UI_BINDINGS_HEADER1_TEXT), 
		helpUrl = L(SI_CSPM_UI_BINDINGS_HEADER1_TIPS), 
	}
	optionsData[#optionsData + 1] = {
		type = "dropdown", 
		name = L(SI_BINDING_NAME_CSPM_PIE_MENU_INTERACTION), 
		tooltip = L(SI_CSPM_UI_BINDINGS_INTERACTION1_TIPS), 
		choices = ui.presetChoices, 	-- If choicesValue is defined, choices table is only used for UI display!
		choicesValues = ui.presetChoicesValues, 
		choicesTooltips = ui.presetChoicesTooltips, 
		getFunc = function() return CSPM.svCurrent.keybinds[1] end, 
		setFunc = function(newPreset) CSPM.svCurrent.keybinds[1] = newPreset end, 
--		sort = "name-up", --or "name-down", "numeric-up", "numeric-down", "value-up", "value-down", "numericvalue-up", "numericvalue-down" 
		width = "full", 
		scrollable = true, 
		default = 1, 
		reference = "CSPM_UI_MAN_PresetSelectMenuKeybinds1", 
	}
	optionsData[#optionsData + 1] = {
		type = "dropdown", 
		name = L(SI_BINDING_NAME_CSPM_PIE_MENU_SECONDARY), 
--		tooltip = "", 
		choices = ui.presetChoices, 	-- If choicesValue is defined, choices table is only used for UI display!
		choicesValues = ui.presetChoicesValues, 
		choicesTooltips = ui.presetChoicesTooltips, 
		getFunc = function() return CSPM.svCurrent.keybinds[2] end, 
		setFunc = function(newPreset) CSPM.svCurrent.keybinds[2] = newPreset end, 
--		sort = "name-up", --or "name-down", "numeric-up", "numeric-down", "value-up", "value-down", "numericvalue-up", "numericvalue-down" 
		width = "full", 
		scrollable = true, 
		default = 0, 
		reference = "CSPM_UI_MAN_PresetSelectMenuKeybinds2", 
	}
	optionsData[#optionsData + 1] = {
		type = "dropdown", 
		name = L(SI_BINDING_NAME_CSPM_PIE_MENU_TERTIARY), 
--		tooltip = "", 
		choices = ui.presetChoices, 	-- If choicesValue is defined, choices table is only used for UI display!
		choicesValues = ui.presetChoicesValues, 
		choicesTooltips = ui.presetChoicesTooltips, 
		getFunc = function() return CSPM.svCurrent.keybinds[3] end, 
		setFunc = function(newPreset) CSPM.svCurrent.keybinds[3] = newPreset end, 
--		sort = "name-up", --or "name-down", "numeric-up", "numeric-down", "value-up", "value-down", "numericvalue-up", "numericvalue-down" 
		width = "full", 
		scrollable = true, 
		default = 0, 
		reference = "CSPM_UI_MAN_PresetSelectMenuKeybinds3", 
	}
	optionsData[#optionsData + 1] = {
		type = "dropdown", 
		name = L(SI_BINDING_NAME_CSPM_PIE_MENU_QUATERNARY), 
--		tooltip = "", 
		choices = ui.presetChoices, 	-- If choicesValue is defined, choices table is only used for UI display!
		choicesValues = ui.presetChoicesValues, 
		choicesTooltips = ui.presetChoicesTooltips, 
		getFunc = function() return CSPM.svCurrent.keybinds[4] end, 
		setFunc = function(newPreset) CSPM.svCurrent.keybinds[4] = newPreset end, 
--		sort = "name-up", --or "name-down", "numeric-up", "numeric-down", "value-up", "value-down", "numericvalue-up", "numericvalue-down" 
		width = "full", 
		scrollable = true, 
		default = 0, 
		reference = "CSPM_UI_MAN_PresetSelectMenuKeybinds4", 
	}
	optionsData[#optionsData + 1] = {
		type = "dropdown", 
		name = L(SI_BINDING_NAME_CSPM_PIE_MENU_QUINARY), 
--		tooltip = "", 
		choices = ui.presetChoices, 	-- If choicesValue is defined, choices table is only used for UI display!
		choicesValues = ui.presetChoicesValues, 
		choicesTooltips = ui.presetChoicesTooltips, 
		getFunc = function() return CSPM.svCurrent.keybinds[5] end, 
		setFunc = function(newPreset) CSPM.svCurrent.keybinds[5] = newPreset end, 
--		sort = "name-up", --or "name-down", "numeric-up", "numeric-down", "value-up", "value-down", "numericvalue-up", "numericvalue-down" 
		width = "full", 
		scrollable = true, 
		default = 0, 
		reference = "CSPM_UI_MAN_PresetSelectMenuKeybinds5", 
	}
	optionsData[#optionsData + 1] = {
		type = "header", 
		name = L(SI_CSPM_UI_BEHAVIOR_HEADER1_TEXT), 
		helpUrl = L(SI_CSPM_UI_BEHAVIOR_HEADER1_TIPS), 
	}
	optionsData[#optionsData + 1] = {
		type = "slider", 
		name = L(SI_CSPM_UI_BEHAVIOR_TIME_TO_HOLD_KEY_OP_NAME), 
		tooltip = L(SI_CSPM_UI_BEHAVIOR_TIME_TO_HOLD_KEY_OP_TIPS), 
		min = 0,
		max = 300,
		step = 1, 
		getFunc = function() return CSPM.svCurrent.timeToHoldKey end, 
		setFunc = function(newValue) CSPM.svCurrent.timeToHoldKey = newValue end, 
		clampInput = false, 
		default = 250, 
	}
	optionsData[#optionsData + 1] = {
		type = "checkbox",
		name = L(SI_CSPM_UI_BEHAVIOR_ACTIVATE_IN_UI_OP_NAME), 
		getFunc = function() return CSPM.svCurrent.allowActivateInUIMode end, 
		setFunc = function(newValue) CSPM.svCurrent.allowActivateInUIMode = newValue end, 
		tooltip = L(SI_CSPM_UI_BEHAVIOR_ACTIVATE_IN_UI_OP_TIPS), 
		width = "full", 
		default = true, 
	}
	optionsData[#optionsData + 1] = {
		type = "checkbox",
		name = L(SI_CSPM_UI_BEHAVIOR_CLICKABLE_OP_NAME), 
		getFunc = function() return CSPM.svCurrent.allowClickable end, 
		setFunc = function(newValue) CSPM.svCurrent.allowClickable = newValue end, 
		tooltip = ZO_CachedStrFormat(L(SI_CSPM_UI_BEHAVIOR_CLICKABLE_OP_TIPS), ZO_Keybindings_GenerateIconKeyMarkup(KEY_MOUSE_LEFT, 125), ZO_Keybindings_GenerateIconKeyMarkup(KEY_GAMEPAD_BUTTON_1, 125), "", ZO_Keybindings_GenerateIconKeyMarkup(KEY_MOUSE_RIGHT, 125), ZO_Keybindings_GenerateIconKeyMarkup(KEY_GAMEPAD_BUTTON_2, 125), ZO_Keybindings_GenerateTextKeyMarkup("ESC")), 
		width = "full", 
		default = true, 
	}
	optionsData[#optionsData + 1] = {
		type = "checkbox",
		name = L(SI_CSPM_UI_BEHAVIOR_CENTER_AT_MOUSE_OP_NAME), 
		getFunc = function() return CSPM.svCurrent.centeringAtMouseCursor end, 
		setFunc = function(newValue) CSPM.svCurrent.centeringAtMouseCursor = newValue end, 
		tooltip = L(SI_CSPM_UI_BEHAVIOR_CENTER_AT_MOUSE_OP_TIPS), 
		width = "full", 
		default = false, 
	}

--[[
	optionsData[#optionsData + 1] = {
		type = "button", 
		name = "Test", 
		func = DoTestButton, 
--		width = "half", 
	}
]]
	LAM:RegisterOptionControls("CSPM_OptionsManager", optionsData)
	CALLBACK_MANAGER:RegisterCallback("LAM-PanelControlsCreated", OnLAMPanelControlsCreated)
end

function CSPM:OpenManagerPanel()
	if self.panelManager then
		LAM:OpenToPanel(self.panelManager)
	end
end
