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
local CSPM, C, LUT = {}, {}, {}
local L = GetString

-- ---------------------------------------------------------------------------------------
-- Library
-- ---------------------------------------------------------------------------------------
local LAM = LibAddonMenu2
if not LAM then d("[CSPM] Error : 'LibAddonMenu' not found.") return end

-- ---------------------------------------------------------------------------------------
-- Helper Functions
-- ---------------------------------------------------------------------------------------
local function ClearTable(luaTable)
	luaTable = luaTable or {}
	ZO_ClearTable(luaTable)
end

local function GetTableKeyForValue(luaTable, value)
	for k, v in pairs(luaTable) do
		if v == value then 
			return k
		end
	end
	return
end

-- ---------------------------------------------------------------------------------------
-- PieMenuManager Panel Class
-- ---------------------------------------------------------------------------------------
local CSPM_PieMenuManagerPanel = ZO_InitializingObject:Subclass()
function CSPM_PieMenuManagerPanel:Initialize(parent, currentSavedVars, accountWideSavedVars, defaults)
	if CSPM then
		CSPM = parent
		if C then C = CSPM.const end
		if LUT then LUT = CSPM.lut end
	end
	self.name = "CSPM-ManagerPanel"
	self.svCurrent = currentSavedVars or {}
	self.svAccount = accountWideSavedVars or {}
	self.SV_DEFAULT = defaults or {}
	self.panelInitialized = false
	self.panelOpened = false
	self:RebuildPresetSelectionChoices()	-- 	presetChoices
	CALLBACK_MANAGER:RegisterCallback("CSPM-UserPieMenuInfoUpdated", function(presetId)
		self:OnUserPieMenuInfoUpdated(presetId)
	end)
	CALLBACK_MANAGER:RegisterCallback("CSPM-PieMenuRegistered", function(presetId)
		self.presetSelectionIsDirty = true
	end)
end

function CSPM_PieMenuManagerPanel:GetPresetDisplayNameByPresetId(presetId)
	local name
	local pieMenuName = CSPM.util.GetPieMenuInfo(presetId)
	if CSPM.util.IsUserPieMenu(presetId) then
		if CSPM.util.DoesPieMenuDataExist(presetId) then
			if pieMenuName ~= "" then
				name = zo_strformat(L(SI_CSPM_PRESET_NAME_FORMATTER), presetId, pieMenuName)
			else
				name = zo_strformat(L(SI_CSPM_PRESET_NO_NAME_FORMATTER), presetId)
			end
		else
			name = zo_strformat(L(SI_CSPM_PRESET_NAME_FORMATTER), presetId, L(SI_CSPM_COMMON_UNREGISTERED))
		end
	else
		name = pieMenuName
	end
	return name
end

function CSPM_PieMenuManagerPanel:OnUserPieMenuInfoUpdated(presetId)
-- This function assumes that the preset attribute information in the user pie menu has just changed.
	CSPM.LDL:Debug("OnUserPieMenuInfoUpdated : ", presetId)

	-- NOTE : the preset selection choices will also be updated here.
	if CSPM.util.IsUserPieMenu(presetId) then
		self.presetChoices[presetId] = self:GetPresetDisplayNameByPresetId(presetId)
	else
		local key = GetTableKeyForValue(self.presetChoicesValues, presetId)
		if not key then return end
		self.presetChoices[key] = self:GetPresetDisplayNameByPresetId(presetId)
	end
	if self.panelInitialized then
		CSPM_UI_MAN_PresetSelectMenuKeybinds1:UpdateChoices(self.presetChoices, self.presetChoicesValues, self.presetChoicesTooltips)
		CSPM_UI_MAN_PresetSelectMenuKeybinds1:UpdateValue()		-- Note : When called with no arguments, getFunc will be called, and setFunc will NOT be called.
		CSPM_UI_MAN_PresetSelectMenuKeybinds2:UpdateChoices(self.presetChoices, self.presetChoicesValues, self.presetChoicesTooltips)
		CSPM_UI_MAN_PresetSelectMenuKeybinds2:UpdateValue()
		CSPM_UI_MAN_PresetSelectMenuKeybinds3:UpdateChoices(self.presetChoices, self.presetChoicesValues, self.presetChoicesTooltips)
		CSPM_UI_MAN_PresetSelectMenuKeybinds3:UpdateValue()
		CSPM_UI_MAN_PresetSelectMenuKeybinds4:UpdateChoices(self.presetChoices, self.presetChoicesValues, self.presetChoicesTooltips)
		CSPM_UI_MAN_PresetSelectMenuKeybinds4:UpdateValue()
		CSPM_UI_MAN_PresetSelectMenuKeybinds5:UpdateChoices(self.presetChoices, self.presetChoicesValues, self.presetChoicesTooltips)
		CSPM_UI_MAN_PresetSelectMenuKeybinds5:UpdateValue()
	end
end

function CSPM_PieMenuManagerPanel:GetPresetSelectionChoices()
	local choices = {}
	local choicesValues = {}
	for i = 1, C.MAX_USER_PRESET do
		choices[i] = self:GetPresetDisplayNameByPresetId(i)
		choicesValues[i] = i
	end

	local externalPieMenuPresetIdList = CSPM.pieMenuManager:GetExternalPieMenuPresetIdList()
	for _, presetId in pairs(externalPieMenuPresetIdList) do
		table.insert(choices, self:GetPresetDisplayNameByPresetId(presetId))
		table.insert(choicesValues, presetId)
	end
	-- In overridden custom tooltip functions, the choicesTooltips table uses the presetId value instead of a string.
	return choices, choicesValues, choicesValues
end
function CSPM_PieMenuManagerPanel:RebuildPresetSelectionChoices()
	ClearTable(self.presetChoices)
	ClearTable(self.presetChoicesValues)
	ClearTable(self.presetChoicesTooltips)
	self.presetChoices, self.presetChoicesValues, self.presetChoicesTooltips = self:GetPresetSelectionChoices()
	self.presetSelectionIsDirty = false
end

function CSPM_PieMenuManagerPanel:DoTestButton()
end

function CSPM_PieMenuManagerPanel:OnLAMPanelOpened(panel)
	if (panel ~= self.panel) then return end
	self.panelOpened = true
--	CSPM.LDL:Debug("OnLAMPanelOpened")
	-- update preset selection choices if needed.
	-- NOTE : If an external pie menu is added by an external add-on after the previous construction of the choice, the pie menu preset choice should be rebuilt.
	if self.presetSelectionIsDirty then
		CSPM.LDL:Debug("PresetSelectionChoices Updated:")
		self:RebuildPresetSelectionChoices()	-- 	presetChoices

		CSPM_UI_MAN_PresetSelectMenuKeybinds1:UpdateChoices(self.presetChoices, self.presetChoicesValues, self.presetChoicesTooltips)
		CSPM_UI_MAN_PresetSelectMenuKeybinds1:UpdateValue()		-- Note : When called with no arguments, getFunc will be called, and setFunc will NOT be called.
		CSPM_UI_MAN_PresetSelectMenuKeybinds2:UpdateChoices(self.presetChoices, self.presetChoicesValues, self.presetChoicesTooltips)
		CSPM_UI_MAN_PresetSelectMenuKeybinds2:UpdateValue()
		CSPM_UI_MAN_PresetSelectMenuKeybinds3:UpdateChoices(self.presetChoices, self.presetChoicesValues, self.presetChoicesTooltips)
		CSPM_UI_MAN_PresetSelectMenuKeybinds3:UpdateValue()
		CSPM_UI_MAN_PresetSelectMenuKeybinds4:UpdateChoices(self.presetChoices, self.presetChoicesValues, self.presetChoicesTooltips)
		CSPM_UI_MAN_PresetSelectMenuKeybinds4:UpdateValue()
		CSPM_UI_MAN_PresetSelectMenuKeybinds5:UpdateChoices(self.presetChoices, self.presetChoicesValues, self.presetChoicesTooltips)
		CSPM_UI_MAN_PresetSelectMenuKeybinds5:UpdateValue()
	end
end

function CSPM_PieMenuManagerPanel:OnLAMPanelClosed(panel)
	if (panel ~= self.panel) then return end
	self.panelOpened = false
--	CSPM.LDL:Debug("OnLAMPanelClosed")
end

function CSPM_PieMenuManagerPanel:CreateOptionsPanel()
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
	self.panel = LAM:RegisterAddonPanel("CSPM_lamOptionsManager", panelData)

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
		getFunc = function() return self.svAccount.accountWide end, 
		setFunc = function(newValue) self.svAccount.accountWide = newValue end, 
		tooltip = L(SI_CSPM_UI_ACCOUNT_WIDE_OP_TIPS), 
		width = "full", 
		requiresReload = true, 
		default = self.SV_DEFAULT.accountWide, 
	}
	optionsData[#optionsData + 1] = {
		type = "header", 
		name = L(SI_CSPM_UI_BINDINGS_HEADER1_TEXT), 
		tooltip = L(SI_CSPM_UI_BINDINGS_HEADER1_TIPS), 
	}
	optionsData[#optionsData + 1] = {
		type = "dropdown", 
		name = L(SI_BINDING_NAME_CSPM_PIE_MENU_INTERACTION), 
		tooltip = L(SI_CSPM_UI_BINDINGS_INTERACTION1_TIPS), 
		choices = self.presetChoices, 	-- If choicesValue is defined, choices table is only used for UI display!
		choicesValues = self.presetChoicesValues, 
		choicesTooltips = self.presetChoicesTooltips, 
		getFunc = function() return self.svCurrent.keybinds[1] end, 
		setFunc = function(newPreset) self.svCurrent.keybinds[1] = newPreset end, 
		width = "full", 
		scrollable = true, 
		default = self.SV_DEFAULT.keybinds[1], 
		reference = "CSPM_UI_MAN_PresetSelectMenuKeybinds1", 
	}
	optionsData[#optionsData + 1] = {
		type = "dropdown", 
		name = L(SI_BINDING_NAME_CSPM_PIE_MENU_SECONDARY), 
--		tooltip = "", 
		choices = self.presetChoices, 	-- If choicesValue is defined, choices table is only used for UI display!
		choicesValues = self.presetChoicesValues, 
		choicesTooltips = self.presetChoicesTooltips, 
		getFunc = function() return self.svCurrent.keybinds[2] end, 
		setFunc = function(newPreset) self.svCurrent.keybinds[2] = newPreset end, 
		width = "full", 
		scrollable = true, 
		default = self.SV_DEFAULT.keybinds[2], 
		reference = "CSPM_UI_MAN_PresetSelectMenuKeybinds2", 
	}
	optionsData[#optionsData + 1] = {
		type = "dropdown", 
		name = L(SI_BINDING_NAME_CSPM_PIE_MENU_TERTIARY), 
--		tooltip = "", 
		choices = self.presetChoices, 	-- If choicesValue is defined, choices table is only used for UI display!
		choicesValues = self.presetChoicesValues, 
		choicesTooltips = self.presetChoicesTooltips, 
		getFunc = function() return self.svCurrent.keybinds[3] end, 
		setFunc = function(newPreset) self.svCurrent.keybinds[3] = newPreset end, 
		width = "full", 
		scrollable = true, 
		default = self.SV_DEFAULT.keybinds[3], 
		reference = "CSPM_UI_MAN_PresetSelectMenuKeybinds3", 
	}
	optionsData[#optionsData + 1] = {
		type = "dropdown", 
		name = L(SI_BINDING_NAME_CSPM_PIE_MENU_QUATERNARY), 
--		tooltip = "", 
		choices = self.presetChoices, 	-- If choicesValue is defined, choices table is only used for UI display!
		choicesValues = self.presetChoicesValues, 
		choicesTooltips = self.presetChoicesTooltips, 
		getFunc = function() return self.svCurrent.keybinds[4] end, 
		setFunc = function(newPreset) self.svCurrent.keybinds[4] = newPreset end, 
		width = "full", 
		scrollable = true, 
		default = self.SV_DEFAULT.keybinds[4], 
		reference = "CSPM_UI_MAN_PresetSelectMenuKeybinds4", 
	}
	optionsData[#optionsData + 1] = {
		type = "dropdown", 
		name = L(SI_BINDING_NAME_CSPM_PIE_MENU_QUINARY), 
--		tooltip = "", 
		choices = self.presetChoices, 	-- If choicesValue is defined, choices table is only used for UI display!
		choicesValues = self.presetChoicesValues, 
		choicesTooltips = self.presetChoicesTooltips, 
		getFunc = function() return self.svCurrent.keybinds[5] end, 
		setFunc = function(newPreset) self.svCurrent.keybinds[5] = newPreset end, 
		width = "full", 
		scrollable = true, 
		default = self.SV_DEFAULT.keybinds[5], 
		reference = "CSPM_UI_MAN_PresetSelectMenuKeybinds5", 
	}
	optionsData[#optionsData + 1] = {
		type = "header", 
		name = L(SI_CSPM_UI_BEHAVIOR_HEADER1_TEXT), 
		tooltip = L(SI_CSPM_UI_BEHAVIOR_HEADER1_TIPS), 
	}
	optionsData[#optionsData + 1] = {
		type = "slider", 
		name = L(SI_CSPM_UI_BEHAVIOR_TIME_TO_HOLD_KEY_OP_NAME), 
		tooltip = L(SI_CSPM_UI_BEHAVIOR_TIME_TO_HOLD_KEY_OP_TIPS), 
		min = 0,
		max = 300,
		step = 1, 
		getFunc = function() return self.svCurrent.menuAttributes.timeToHoldKey end, 
		setFunc = function(newValue) self.svCurrent.menuAttributes.timeToHoldKey = newValue end, 
		clampInput = false, 
		default = self.SV_DEFAULT.menuAttributes.timeToHoldKey, 
	}
	optionsData[#optionsData + 1] = {
		type = "checkbox",
		name = L(SI_CSPM_UI_BEHAVIOR_ACTIVATE_IN_UI_OP_NAME), 
		getFunc = function() return self.svCurrent.menuAttributes.allowActivateInUIMode end, 
		setFunc = function(newValue) self.svCurrent.menuAttributes.allowActivateInUIMode = newValue end, 
		tooltip = L(SI_CSPM_UI_BEHAVIOR_ACTIVATE_IN_UI_OP_TIPS), 
		width = "full", 
		default = self.SV_DEFAULT.menuAttributes.allowActivateInUIMode, 
	}
	optionsData[#optionsData + 1] = {
		type = "checkbox",
		name = L(SI_CSPM_UI_BEHAVIOR_CLICKABLE_OP_NAME), 
		getFunc = function() return self.svCurrent.menuAttributes.allowClickable end, 
		setFunc = function(newValue) self.svCurrent.menuAttributes.allowClickable = newValue end, 
		tooltip = zo_strformat(L(SI_CSPM_UI_BEHAVIOR_CLICKABLE_OP_TIPS), ZO_Keybindings_GenerateIconKeyMarkup(KEY_MOUSE_LEFT, 125), ZO_Keybindings_GenerateIconKeyMarkup(KEY_GAMEPAD_BUTTON_1, 125), "", ZO_Keybindings_GenerateIconKeyMarkup(KEY_MOUSE_RIGHT, 125), ZO_Keybindings_GenerateIconKeyMarkup(KEY_GAMEPAD_BUTTON_2, 125), ZO_Keybindings_GenerateTextKeyMarkup("ESC")), 
		width = "full", 
		default = self.SV_DEFAULT.menuAttributes.allowClickable, 
	}
	optionsData[#optionsData + 1] = {
		type = "checkbox",
		name = L(SI_CSPM_UI_BEHAVIOR_CENTER_AT_MOUSE_OP_NAME), 
		getFunc = function() return self.svCurrent.menuAttributes.centeringAtMouseCursor end, 
		setFunc = function(newValue) self.svCurrent.menuAttributes.centeringAtMouseCursor = newValue end, 
		tooltip = L(SI_CSPM_UI_BEHAVIOR_CENTER_AT_MOUSE_OP_TIPS), 
		width = "full", 
		default = self.SV_DEFAULT.menuAttributes.centeringAtMouseCursor, 
	}
	optionsData[#optionsData + 1] = {
		type = "dropdown", 
		name = L(SI_CSPM_UI_BEHAVIOR_MOUSE_SENSITIVITY_OP_NAME), 
		tooltip = L(SI_CSPM_UI_BEHAVIOR_MOUSE_SENSITIVITY_OP_TIPS), 
		choices = {
			L(SI_CSPM_COMMON_LOW), 
			L(SI_CSPM_COMMON_DEFAULT), 
			L(SI_CSPM_COMMON_MEDIUM), 
			L(SI_CSPM_COMMON_HIGH), 
			L(SI_CSPM_COMMON_ULTRA), 
		}, 
		choicesValues = {
			0.5, 
			1, 
			5, 
			12, 
			20, 
		}, 
		getFunc = function() return self.svCurrent.menuAttributes.mouseDeltaScaleFactorInUIMode end, 
		setFunc = function(newValue) self.svCurrent.menuAttributes.mouseDeltaScaleFactorInUIMode = newValue end, 
		width = "full", 
		scrollable = true, 
		default = self.SV_DEFAULT.menuAttributes.mouseDeltaScaleFactorInUIMode, 
	}

--[[
	optionsData[#optionsData + 1] = {
		type = "button", 
		name = "Test", 
		func = function()
			self:DoTestButton()
		end, 
--		width = "half", 
	}
]]
	LAM:RegisterOptionControls("CSPM_lamOptionsManager", optionsData)

	local function OnLAMPanelControlsCreated(panel)
		if (panel ~= self.panel) then return end
		CALLBACK_MANAGER:UnregisterCallback("LAM-PanelControlsCreated", OnLAMPanelControlsCreated)

		-- override ScrollableDropdownHelper for CSPM_UI_MAN_PresetSelectMenuKeybindsX to customize dropdown choices tooltips
		for i = 1, 5 do
			_G["CSPM_UI_MAN_PresetSelectMenuKeybinds" .. i].scrollHelper.OnMouseEnter = function(scrollHelper, control)
				if control.m_data.tooltip then
					CSPM.util.LayoutSlotActionTooltip(C.ACTION_TYPE_PIE_MENU, C.CATEGORY_NOTHING, control.m_data.tooltip, C.UI_NONE)
					CSPM.util.ShowSlotActionTooltip(control, TOPLEFT, 0, 0, BOTTOMRIGHT)
				end
			end
			_G["CSPM_UI_MAN_PresetSelectMenuKeybinds" .. i].scrollHelper.OnMouseExit = function(scrollHelper, control)
				if control.m_data.tooltip then
					CSPM.util.HideSlotActionTooltip()
				end
			end
		end
		self.panelInitialized = true
	end
	CALLBACK_MANAGER:RegisterCallback("LAM-PanelControlsCreated", OnLAMPanelControlsCreated)
	CALLBACK_MANAGER:RegisterCallback("LAM-PanelOpened", function(panel)
		self:OnLAMPanelOpened(panel)
	end)
	CALLBACK_MANAGER:RegisterCallback("LAM-PanelClosed", function(panel)
		self:OnLAMPanelClosed(panel)
	end)
end

function CSPM_PieMenuManagerPanel:GetOptionsPanel()
	return self.panel
end

function CSPM_PieMenuManagerPanel:OpenOptionsPanel()
	if self.panel then
		LAM:OpenToPanel(self.panel)
	end
end

CShortcutPieMenu:RegisterClassObject("PieMenuManagerPanel", CSPM_PieMenuManagerPanel)
