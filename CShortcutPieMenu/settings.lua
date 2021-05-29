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

-- Library
local LAM = LibAddonMenu2
if not LAM then d("[CSPM] Error : 'LibAddonMenu' not found.") return end

local L = GetString
local strings = {
	SI_CSPM_UI_PANEL_HEADER1_TEXT =		"This add-on provides a pie menu for shortcuts to various UI operations.", 
	SI_CSPM_UI_SLOT_SELECT_MENU_NAME =	"Select slot", 
	SI_CSPM_UI_SLOT_SELECT_MENU_TIPS =	"First, please select the slot number you want to configure.", 
	SI_CSPM_UI_ACTION_TYPE_MENU_NAME =	"Action Type", 
	SI_CSPM_UI_ACTION_TYPE_MENU_TIPS =	"Select the type of operation for this slot.", 
	SI_CSPM_UI_CATEGORY_MENU_NAME =		"Category", 
	SI_CSPM_UI_CATEGORY_MENU_TIPS =		"<Category menu tips>", 
	SI_CSPM_UI_ACTION_VALUE_MENU_NAME =	"Value", 
	SI_CSPM_UI_ACTION_VALUE_MENU_TIPS =	"<Action Value tips>"
}
for stringId, stringToAdd in pairs(strings) do
   ZO_CreateStringId(stringId, stringToAdd)
   SafeAddVersion(stringId, 1)
end

-- UI section locals
local ui = ui or {}
local uiPresetId = 1
local uiSlotId = 1

local function DoSetupDefault(slotId)
end


local function RebuildSlotSelectionChoices(menuItemsCount)
	local choices = {}
	local choicesValues = {}
	for i = 1, menuItemsCount do
		choices[i] = table.concat({"Slot ", i})
		choicesValues[i] = i
	end
	return choices, choicesValues
end

local function RebuildCollectibleSelectionChoicesByCategoryType(categoryId, unlockedOnly)
	local choices = {}
	local choicesValues = {}
	unlockedOnly = unlockedOnly or false
	if categoryId then
		for index = 1, GetTotalCollectiblesByCategoryType(categoryId) do
			local collectibleId = GetCollectibleIdFromType(categoryId, index)
			if not unlockedOnly or IsCollectibleUnlocked(collectibleId) then
				choices[#choices + 1] = ZO_CachedStrFormat("<<1>>", GetCollectibleName(collectibleId))
				choicesValues[#choicesValues + 1] = collectibleId
			end
		end
	end
	return choices, choicesValues
end


local function ChangePanelSlotState(slotId)
	CSPM.LDL:Debug("ChangePanelSlotState : %s", slotId)
	-- Here, we need to call the setFunc callback of CSPM_UI_SlotSelectMenu.
	CSPM_UI_SlotSelectMenu:UpdateValue(false, slotId)	-- Note : When called with arguments, setFunc will be called.
end

local function ChangePanelPresetState(presetId)
	CSPM.LDL:Debug("ChangePanelPresetState : %s", presetId)
	if not CSPM:DoesMenuPresetDataExist(presetId) then
		d("[CSPM] fatal error : preset data not found")
		return
	end
	uiPresetId = presetId
	CSPM_UI_MenuItemsCountSlider:UpdateValue(false, CSPM.db.preset[uiPresetId].menuItemsCount)
	ChangePanelSlotState(1)
end

local function OnMenuItemCountChanged(newMenuItemsCount)
	CSPM.LDL:Debug("OnMenuItemCountChanged : %s", newMenuItemsCount)
	CSPM.db.preset[uiPresetId].menuItemsCount = newMenuItemsCount
	ui.slotChoices, ui.slotChoicesValues = RebuildSlotSelectionChoices(newMenuItemsCount)
	CSPM_UI_SlotSelectMenu:UpdateChoices(ui.slotChoices, ui.slotChoicesValues)
	CSPM_UI_SlotSelectMenu:UpdateValue()

	if uiSlotId > newMenuItemsCount then
		ChangePanelSlotState(newMenuItemsCount)
	end
end

local function OnSlotIdSelectionChanged(newSlotId)
	CSPM.LDL:Debug("OnSlotIdSelectionChanged : %s", newSlotId)

	if not CSPM:DoesMenuSlotDataExist(uiPresetId, newSlotId) then
--		d("[CSPM] fatal error : slot data not found, so extend !")
		CSPM:ExtendMenuSlotDataSet(uiPresetId, newSlotId)
	end
	local savedSlotData = CSPM:GetMenuSlotData(uiPresetId, newSlotId)
	if not savedSlotData then d("[CSPM] fatal error : slot data not found") return end

	-- update slot tab
	uiSlotId = newSlotId
	-- Since the only purpose here is to reflect the saved data to the panel(slot tab), we will make sure NOT to call setFunc for each widget.
	local uiActionTypeId = savedSlotData.type or CSPM_ACTION_TYPE_NOTHING
	local uiCategoryId = savedSlotData.category or CSPM_CATEGORY_NOTHING
--	local uiActionValue = savedSlotData.value or 0

	CSPM_UI_TabHeader.data.name = ui.slotChoices[uiSlotId] .. " :", 
	CSPM_UI_TabHeader:UpdateValue()		-- Note : When called with no arguments, getFunc will be called, and setFunc will NOT be called..

	CSPM_UI_ActionTypeMenu:UpdateValue()
	CSPM_UI_CategoryMenu:UpdateChoices(ui.categoryChoices[uiActionTypeId], ui.categoryChoicesValues[uiActionTypeId])
	CSPM_UI_CategoryMenu:UpdateValue()
	CSPM_UI_ActionValueMenu:UpdateChoices(ui.actionValueChoices[uiCategoryId], ui.actionValueChoicesValues[uiCategoryId])
	CSPM_UI_ActionValueMenu:UpdateValue()
end

local function OnActionTypeSelectionChanged(newActionTypeId)
	CSPM.LDL:Debug("OnActionTypeSelectionChanged : %s", newActionTypeId)
	CSPM.db.preset[uiPresetId].slot[uiSlotId].type = newActionTypeId

	CSPM_UI_CategoryMenu:UpdateChoices(ui.categoryChoices[newActionTypeId], ui.categoryChoicesValues[newActionTypeId])

	-- The meaning of ActionValue is different for each ActionType, and they are not mutually compatible.
	-- Therefore, when a user changes the ActionType selection, the category id and ActionValue should be initialized．
	CSPM_UI_CategoryMenu:UpdateValue(true)
	CSPM_UI_ActionValueMenu:UpdateValue(true)
end

local function OnCategorySelectionChanged(newCategoryId)
	CSPM.LDL:Debug("OnCategorySelectionChanged : %s", newCategoryId)
	CSPM.db.preset[uiPresetId].slot[uiSlotId].category = newCategoryId
	CSPM_UI_ActionValueMenu:UpdateChoices(ui.actionValueChoices[newCategoryId], ui.actionValueChoicesValues[newCategoryId])
	CSPM_UI_ActionValueMenu:UpdateValue()
end

local function OnActionValueSelectionChanged(newActionValue)
	CSPM.LDL:Debug("OnActionValueSelectionChanged : %s", newActionValue)
	CSPM.db.preset[uiPresetId].slot[uiSlotId].value = newActionValue
end

local function DoTestButton()
	ChangePanelPresetState(1)
end

local function OnLAMPanelControlsCreated(panel)
	if (panel ~= ui.panel) then return end
	CALLBACK_MANAGER:UnregisterCallback("LAM-PanelControlsCreated", OnLAMPanelControlsCreated)

	ChangePanelPresetState(1)
	ui.panelInitialized = true
end

function CSPM:InitializeUI()
	ui.panelInitialized = false

	ui.slotChoices, ui.slotChoicesValues = RebuildSlotSelectionChoices(CSPM_MENU_ITEMS_COUNT_DEFAULT)

	ui.actionTypeChoices = { "Nothing", "Collectible", } 
	ui.actionTypeChoicesValues = { CSPM_ACTION_TYPE_NOTHING, CSPM_ACTION_TYPE_COLLECTIBLE, }

	ui.categoryChoices = {}
	ui.categoryChoicesValues = {}
	ui.categoryChoices[CSPM_ACTION_TYPE_NOTHING], ui.categoryChoicesValues[CSPM_ACTION_TYPE_NOTHING] = {}, {}
	ui.categoryChoices[CSPM_ACTION_TYPE_COLLECTIBLE] = {
		"Nothing", 
		"Assistant", 
		"Companion", 
		"Memento", 
		"Non-combat-pet", 
	}
	ui.categoryChoicesValues[CSPM_ACTION_TYPE_COLLECTIBLE] = {
		CSPM_CATEGORY_NOTHING, 
		CSPM_CATEGORY_C_ASSISTANT, 
		CSPM_CATEGORY_C_COMPANION, 
		CSPM_CATEGORY_C_MEMENTO, 
		CSPM_CATEGORY_C_VANITY_PET
	}

	ui.actionValueChoices = {}
	ui.actionValueChoicesValues = {}
	ui.actionValueChoices[CSPM_CATEGORY_NOTHING], ui.actionValueChoicesValues[CSPM_CATEGORY_NOTHING] = {}, {}
	ui.actionValueChoices[CSPM_CATEGORY_C_ASSISTANT], ui.actionValueChoicesValues[CSPM_CATEGORY_C_ASSISTANT] = RebuildCollectibleSelectionChoicesByCategoryType(COLLECTIBLE_CATEGORY_TYPE_ASSISTANT, true)
	ui.actionValueChoices[CSPM_CATEGORY_C_COMPANION], ui.actionValueChoicesValues[CSPM_CATEGORY_C_COMPANION] = RebuildCollectibleSelectionChoicesByCategoryType(COLLECTIBLE_CATEGORY_TYPE_COMPANION, true)
	ui.actionValueChoices[CSPM_CATEGORY_C_MEMENTO], ui.actionValueChoicesValues[CSPM_CATEGORY_C_MEMENTO] = RebuildCollectibleSelectionChoicesByCategoryType(COLLECTIBLE_CATEGORY_TYPE_MEMENTO, true)
	ui.actionValueChoices[CSPM_CATEGORY_C_VANITY_PET], ui.actionValueChoicesValues[CSPM_CATEGORY_C_VANITY_PET] = RebuildCollectibleSelectionChoicesByCategoryType(COLLECTIBLE_CATEGORY_TYPE_VANITY_PET, true)
end

function CSPM:CreateSettingsWindow()
	local panelData = {
		type = "panel", 
		name = "Shortcut PieMenu", 
		displayName = "Calamath's Shortcut Pie Menu", 
		author = CSPM.author, 
		version = CSPM.version, 
		website = "", 
		slashCommand = "/cspm.settings", 
		registerForRefresh = true, 
--		registerForDefaults = true, 
--		resetFunc = nil, 
	}
	ui.panel = LAM:RegisterAddonPanel("CSPM_OptionsMenu", panelData)

	local optionsData = {}
	optionsData[#optionsData + 1] = {
			type = "description", 
			title = "", 
			text = L(SI_CSPM_UI_PANEL_HEADER1_TEXT), 
	}
	optionsData[#optionsData + 1] = {
			type = "slider", 
			name = "Menu items count", 
			min = 2,
			max = 11,
			step = 1, 
			getFunc = function() return CSPM.db.preset[uiPresetId].menuItemsCount end, 
			setFunc = OnMenuItemCountChanged,
			clampInput = false, 
			default = CSPM_MENU_ITEMS_COUNT_DEFAULT, 
			reference = "CSPM_UI_MenuItemsCountSlider", 
	}
	optionsData[#optionsData + 1] = {
			type = "dropdown", 
			name = L(SI_CSPM_UI_SLOT_SELECT_MENU_NAME), 
			tooltip = L(SI_CSPM_UI_SLOT_SELECT_MENU_TIPS), 
			choices = ui.slotChoices, 	-- If choicesValue is defined, choices table is only used for UI display!
			choicesValues = ui.slotChoicesValues, 
--			choicesTooltips = ui.slotChoicesTooltips, 
			getFunc = function() return uiSlotId end, 
			setFunc = OnSlotIdSelectionChanged, 
--			sort = "name-up", --or "name-down", "numeric-up", "numeric-down", "value-up", "value-down", "numericvalue-up", "numericvalue-down" 
			width = "half", 
--			scrollable = true, 
			default = 1, 
			reference = "CSPM_UI_SlotSelectMenu", 
	}
	optionsData[#optionsData + 1] = {
			type = "description", 
			title = " ", 
			text = " ", 
			width = "half", 
	}
	optionsData[#optionsData + 1] = {
			type = "header", 
			name = "Slot " .. uiSlotId .. " :", 
			reference = "CSPM_UI_TabHeader", 
	}
	optionsData[#optionsData + 1] = {
			type = "dropdown", 
			name = L(SI_CSPM_UI_ACTION_TYPE_MENU_NAME), 
			tooltip = L(SI_CSPM_UI_ACTION_TYPE_MENU_TIPS), 
			choices = ui.actionTypeChoices, 	-- If choicesValue is defined, choices table is only used for UI display!
			choicesValues = ui.actionTypeChoicesValues, 
--			choicesTooltips = ui.actionTypeChoicesTooltips, 
			getFunc = function() return CSPM.db.preset[uiPresetId].slot[uiSlotId].type end, 
			setFunc = OnActionTypeSelectionChanged, 
--			sort = "name-up", --or "name-down", "numeric-up", "numeric-down", "value-up", "value-down", "numericvalue-up", "numericvalue-down" 
--			width = "half", 
--			scrollable = true, 
			default = CSPM_ACTION_TYPE_NOTHING, 
			reference = "CSPM_UI_ActionTypeMenu", 
	}
	optionsData[#optionsData + 1] = {
			type = "dropdown", 
			name = L(SI_CSPM_UI_CATEGORY_MENU_NAME), 
--			tooltip = L(SI_CSPM_UI_CATEGORY_MENU_TIPS), 
			choices = ui.categoryChoices[CSPM.db.preset[uiPresetId].slot[uiSlotId].type], 	-- If choicesValue is defined, choices table is only used for UI display!
			choicesValues = ui.categoryChoicesValues[CSPM.db.preset[uiPresetId].slot[uiSlotId].type], 
--			choicesTooltips = ui.categoryChoicesTooltips[CSPM.db.preset[uiPresetId].slot[uiSlotId].type], 
			getFunc = function() return CSPM.db.preset[uiPresetId].slot[uiSlotId].category end, 
			setFunc = OnCategorySelectionChanged, 
--			sort = "name-up", --or "name-down", "numeric-up", "numeric-down", "value-up", "value-down", "numericvalue-up", "numericvalue-down" 
--			width = "half", 
--			scrollable = true, 
			default = CSPM_CATEGORY_NOTHING, 
			reference = "CSPM_UI_CategoryMenu", 
	}
	optionsData[#optionsData + 1] = {
			type = "dropdown", 
			name = L(SI_CSPM_UI_ACTION_VALUE_MENU_NAME), 
--			tooltip = L(SI_CSPM_UI_ACTION_VALUE_MENU_TIPS), 
			choices = ui.actionValueChoices[CSPM.db.preset[uiPresetId].slot[uiSlotId].category], 	-- If choicesValue is defined, choices table is only used for UI display!
			choicesValues = ui.actionValueChoicesValues[CSPM.db.preset[uiPresetId].slot[uiSlotId].category], 
--			choicesTooltips = ui.actionValueChoicesTooltips[CSPM.db.preset[uiPresetId].slot[uiSlotId].category], 
			getFunc = function() return CSPM.db.preset[uiPresetId].slot[uiSlotId].value end, 
			setFunc = OnActionValueSelectionChanged, 
--			sort = "name-up", --or "name-down", "numeric-up", "numeric-down", "value-up", "value-down", "numericvalue-up", "numericvalue-down" 
--			width = "half", 
			scrollable = 15, 
			default = 0, 
			reference = "CSPM_UI_ActionValueMenu", 
	}
--[[
	optionsData[#optionsData + 1] = {
			type = "button", 
			name = "Test", 
			func = DoTestButton, 
--			width = "half", 
	}
]]
	LAM:RegisterOptionControls("CSPM_OptionsMenu", optionsData)
	CALLBACK_MANAGER:RegisterCallback("LAM-PanelControlsCreated", OnLAMPanelControlsCreated)
end
