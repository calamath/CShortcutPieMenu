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


-- Library
local LAM = LibAddonMenu2
if not LAM then d("[CSPM] Error : 'LibAddonMenu' not found.") return end


-- UI section locals
local ui = ui or {}

local function DoSetupDefault(slotId)
end

local function GetPresetDisplayNameByPresetId(presetId)
	local presetName = table.concat({ L(SI_CSPM_COMMON_PRESET), " ", presetId, })
	local presetInfo = CSPM:GetPresetInfo(presetId)
	if presetInfo then
		if presetInfo.name ~= "" then
			presetName = table.concat({ presetName, " : ", presetInfo.name, })
		end
	else
		presetName = table.concat({ presetName, " : ", L(SI_CSPM_COMMON_UNREGISTERED), })
	end
	return presetName
end

local function RefreshPanelDueToPresetInfoChange(presetId)
-- This function assumes that the presetInfo table has just changed.
	CSPM.LDL:Debug("RefreshManagerPanelDueToPresetInfoChange : ", presetId)

	-- NOTE : Since the preset info table has been changed, the preset selection choices will also be updated here.
	local presetInfo = CSPM:GetPresetInfo(presetId)
	if presetInfo then
		ui.presetChoices[presetId] = GetPresetDisplayNameByPresetId(presetId)
		ui.presetChoicesTooltips[presetId] = presetInfo.tooltip or ""
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
	local choicesTooltips = {}
	for i = 1, CSPM_MAX_USER_PRESET do
		choices[i] = GetPresetDisplayNameByPresetId(i)
		choicesValues[i] = i
		presetInfo = CSPM:GetPresetInfo(i)
		if presetInfo then
			choicesTooltips[i] = presetInfo.tooltip or ""
		else
			choicesTooltips[i] = ""
		end
	end
	return choices, choicesValues, choicesTooltips
end

local function DoTestButton()
end

local function OnLAMPanelControlsCreated(panel)
	if (panel ~= ui.panel) then return end
	CALLBACK_MANAGER:UnregisterCallback("LAM-PanelControlsCreated", OnLAMPanelControlsCreated)

	ui.panelInitialized = true
end

function CSPM:InitializeManagerUI()
	ui.panelInitialized = false
	ui.presetChoices, ui.presetChoicesValues, ui.presetChoicesTooltips = RebuildPresetSelectionChoices()
	CALLBACK_MANAGER:RegisterCallback("CSPM-UserPresetInfoUpdated", RefreshPanelDueToPresetInfoChange)
end

function CSPM:CreateManagerPanel()
	local panelData = {
		type = "panel", 
		name = "Shortcut PieManager", 
		displayName = "Calamath's Shortcut Pie Menu (Manager)", 
		author = CSPM.author, 
		version = CSPM.version, 
		website = "https://www.esoui.com/downloads/info3088-CalamathsShortcutPieMenu.html", 
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
		name = "Use Account Wide Settings", 
		getFunc = function() return CSPM.svAccount.accountWide end, 
		setFunc = function(newValue) CSPM.svAccount.accountWide = newValue end, 
		tooltip = "When the account wide setting is OFF, then each character can have different configuration options set below.", 
		width = "full", 
		requiresReload = true, 
		default = true, 
	}
	optionsData[#optionsData + 1] = {
		type = "header", 
		name = "Key Bindings and Presets", 
		helpUrl = "For each shortcut key, you can assign your favorite pie menu. Of course, you need to configure addon keybinds in the CONTROLS settings.", 
	}
	optionsData[#optionsData + 1] = {
		type = "dropdown", 
		name = L(SI_BINDING_NAME_CSPM_PIE_MENU_INTERACTION), 
		tooltip = "This is the 'primary interaction' key bindings that must be assigned to this add-on. Basically, you should assign the most frequently used pie menu presets, but the add-on may occasionally switch pie menu presets automatically due to the event triggers described below.", 
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
		name = "Behavior Options (Advanced)", 
		helpUrl = "These are optional settings that normally do not need to be changed, such as prototype features that are still under development. Option settings that are being tweaked will be marked as beta, and positive feedback on future tweaks will be welcomed. (For advanced users)", 
	}
	optionsData[#optionsData + 1] = {
		type = "slider", 
		name = "Time to hold key until activation (milliseconds)", 
		tooltip = "You can adjust the key hold time for pie menu activation. The smaller the number, the faster it is.", 
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
		name = "Activate Pie Menu in UI mode", 
		getFunc = function() return CSPM.svCurrent.allowActivateInUIMode end, 
		setFunc = function(newValue) CSPM.svCurrent.allowActivateInUIMode = newValue end, 
		tooltip = "Allow you to activate pie menu in most UI mode (cursor mode) scenes.", 
		width = "full", 
		default = true, 
	}
	optionsData[#optionsData + 1] = {
		type = "checkbox",
		name = "Selecting and canceling with click", 
		getFunc = function() return CSPM.svCurrent.allowClickable end, 
		setFunc = function(newValue) CSPM.svCurrent.allowClickable = newValue end, 
		tooltip = "By turning on this setting, you can use mouse buttons or gamepad buttons to quickly select or cancel pie menus.\n\nSelecting : Mouse Left Button, GamePad A Button\nCanceling : Mouse Right Button, GamePad B Button and ESC", 
		width = "full", 
		default = true, 
	}
	optionsData[#optionsData + 1] = {
		type = "checkbox",
		name = "Centering Pie Menu at mouse cursor in UI mode", 
		getFunc = function() return CSPM.svCurrent.centeringAtMouseCursor end, 
		setFunc = function(newValue) CSPM.svCurrent.centeringAtMouseCursor = newValue end, 
		tooltip = "By turning on this setting, the pie menu will be displayed at the current mouse cursor position instead of the center of the screen in UI mode.", 
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
