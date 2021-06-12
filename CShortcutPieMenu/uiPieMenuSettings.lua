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

-- Aliases of look up table
local CSPM_LUT_CATEGORY_C_CSPM_TO_ZOS			= CSPM.lut.CSPM_LUT_CATEGORY_C_CSPM_TO_ZOS
local CSPM_LUT_CATEGORY_E_CSPM_TO_ZOS			= CSPM.lut.CSPM_LUT_CATEGORY_E_CSPM_TO_ZOS
local CSPM_LUT_CATEGORY_E_CSPM_TO_ICON			= CSPM.lut.CSPM_LUT_CATEGORY_E_CSPM_TO_ICON

-- Library
local LAM = LibAddonMenu2
if not LAM then d("[CSPM] Error : 'LibAddonMenu' not found.") return end

local L = GetString
local strings = {
	SI_CSPM_COMMON_SLOT =							"Slot", 
	SI_CSPM_COMMON_UNSELECTED =						"<Unselected>", 
	SI_CSPM_COMMON_UNREGISTERED =					"<Unregistered>", 
	SI_CSPM_COMMON_IMMEDIATE_VALUE =				"(Immediate Value)", 
	SI_CSPM_COMMON_COLLECTIBLE =					"Collectible", 
	SI_CSPM_COMMON_EMOTE =							"Emote", 
	SI_CSPM_COMMON_CHAT_COMMAND =					"Chat Command", 
	SI_CSPM_COMMON_TRAVEL_TO_HOUSE =				"Travel to house", 
	SI_CSPM_COMMON_MY_HOUSE_INSIDE =				"My House (inside)", 
	SI_CSPM_COMMON_MY_HOUSE_OUTSIDE =				"My House (outside)", 
	SI_CSPM_UI_PANEL_HEADER1_TEXT =					"This add-on provides a pie menu for shortcuts to various UI operations.", 
	SI_CSPM_UI_PRESET_SELECT_MENU_NAME =			"Select preset", 
	SI_CSPM_UI_PRESET_SELECT_MENU_TIPS =			"Please select the preset number you want to configure.", 
	SI_CSPM_UI_SLOT_SELECT_MENU_NAME =				"Select slot", 
	SI_CSPM_UI_SLOT_SELECT_MENU_TIPS =				"Please select the slot number you want to configure.", 
	SI_CSPM_UI_ACTION_TYPE_MENU_NAME =				"Action Type", 
	SI_CSPM_UI_ACTION_TYPE_MENU_TIPS =				"Select the type of operation for this slot.", 
	SI_CSPM_UI_ACTION_TYPE_NOTHING_TIPS =			"", 
	SI_CSPM_UI_ACTION_TYPE_COLLECTIBLE_TIPS =		"Use unlocked collectible.", 
	SI_CSPM_UI_ACTION_TYPE_EMOTE_TIPS =				"Play unlocked emote.", 
	SI_CSPM_UI_ACTION_TYPE_CHAT_COMMAND_TIPS =		"Execute the chat command.", 
	SI_CSPM_UI_ACTION_TYPE_TRAVEL_TO_HOUSE_TIPS =	"Jump to your home already unlocked", 
	SI_CSPM_UI_CATEGORY_MENU_NAME =					"Category", 
	SI_CSPM_UI_CATEGORY_MENU_TIPS =					"<Category menu tips>", 
	SI_CSPM_UI_ACTION_VALUE_MENU_NAME =				"Value", 
	SI_CSPM_UI_ACTION_VALUE_MENU_TIPS =				"<Action Value tips>", 
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

local function GetDefaultSlotName(actionTypeId, categoryId, actionValue)
	local slotName = ""
	if actionTypeId == CSPM_ACTION_TYPE_COLLECTIBLE then
		slotName = ZO_CachedStrFormat("<<1>>", GetCollectibleName(actionValue or ""))
	elseif actionTypeId == CSPM_ACTION_TYPE_EMOTE then
		local emoteItemInfo = PLAYER_EMOTE_MANAGER:GetEmoteItemInfo(actionValue)
		slotName = ZO_CachedStrFormat("<<1>>", emoteItemInfo and emoteItemInfo.displayName or "")
	elseif actionTypeId == CSPM_ACTION_TYPE_CHAT_COMMAND then
		slotName = actionValue
	elseif actionTypeId == CSPM_ACTION_TYPE_TRAVEL_TO_HOUSE then
		local houseName
		if actionValue == CSPM_ACTION_VALUE_PRIMARY_HOUSE_ID then
			houseName = L(SI_HOUSING_FURNITURE_SETTINGS_GENERAL_PRIMARY_RESIDENCE_TEXT)		-- "Primary Residence"
		else
			houseName = GetCollectibleName(GetCollectibleIdForHouse(actionValue))
		end
		if actionValue ~= 0 then
			if categoryId == CSPM_CATEGORY_H_UNLOCKED_HOUSE_INSIDE then
				slotName = ZO_CachedStrFormat(L(SI_GAMEPAD_WORLD_MAP_TRAVEL_TO_HOUSE_INSIDE), houseName)		-- "<<1>> (inside)"
			elseif categoryId == CSPM_CATEGORY_H_UNLOCKED_HOUSE_OUTSIDE then
				slotName = ZO_CachedStrFormat(L(SI_GAMEPAD_WORLD_MAP_TRAVEL_TO_HOUSE_OUTSIDE), houseName)		-- "<<1>> (outside)"
			end
		end
	end
--	CSPM.LDL:Debug("SlotName : ", tostring(slotName))
	return slotName
end

local function GetSlotDisplayNameBySlotId(slotId)
	local slotName = ""
	local savedSlotData = CSPM:GetMenuSlotData(uiPresetId, slotId)
	if savedSlotData then
		if type(savedSlotData.name) == "string" and savedSlotData.name ~= "" then
			slotName = savedSlotData.name
		else
			slotName = GetDefaultSlotName(savedSlotData.type, savedSlotData.category, savedSlotData.value)
		end
	end
	if slotName == "" then
		slotName = L(SI_CSPM_COMMON_UNREGISTERED)
	end
	return slotName
end

local function RefreshPanelDueToSlotDisplayNameChange()
-- This function assumes that the slot display name of the currently open preset and slot has just changed.
	CSPM.LDL:Debug("RefreshPanelDueToSlotDisplayNameChange : ")
	
	-- NOTE : Since the slot display name has been changed, the slot selection choices and the slot name tab header will also be updated here.
	ui.slotChoices[uiSlotId] = table.concat({ L(SI_CSPM_COMMON_SLOT), " ", uiSlotId, " : ", ui.slotDisplayName[uiSlotId] or L(SI_CSPM_COMMON_UNREGISTERED), })
	CSPM_UI_SlotSelectMenu:UpdateChoices(ui.slotChoices, ui.slotChoicesValues)
	CSPM_UI_SlotSelectMenu:UpdateValue()		-- Note : When called with no arguments, getFunc will be called, and setFunc will NOT be called.

	CSPM_UI_TabHeader.data.name = ui.slotChoices[uiSlotId]
	CSPM_UI_TabHeader:UpdateValue()
end

local function UpdateSlotDisplayNameTableForSpecificSlot(slotId)
	ui.slotDisplayName[slotId] = GetSlotDisplayNameBySlotId(slotId)
	if slotId == uiSlotId then
		RefreshPanelDueToSlotDisplayNameChange()
	end
end

local function RebuildSlotDisplayNameTable(presetId)
	presetId = presetId or uiPresetId
	local displayNameTable = {}
	local savedPresetData = CSPM:GetMenuPresetData(presetId)
	if not savedPresetData then return end
	for i = 1, savedPresetData.menuItemsCount do
		displayNameTable[i] = GetSlotDisplayNameBySlotId(i)
	end
	return displayNameTable
end

local function RebuildSlotSelectionChoices(menuItemsCount)
	local choices = {}
	local choicesValues = {}
	for i = 1, menuItemsCount do
		choices[i] = table.concat({ L(SI_CSPM_COMMON_SLOT), " ", i, " : ", ui.slotDisplayName[i] or L(SI_CSPM_COMMON_UNREGISTERED), })
		choicesValues[i] = i
	end
	return choices, choicesValues
end

local function RebuildCollectibleSelectionChoicesByCategoryType(categoryId, unlockedOnly)
--	unlockedOnly : return only the unlocked ones or the whole set
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
	-- In overridden custom tooltip functions, the ChoicesTooltips table uses the collectibleId value instead of a string.
	return choices, choicesValues, choicesValues
end

local function RebuildEmoteSelectionChoicesByEmoteCategory(emoteCategory)
	local choices = {}
	local choicesValues = PLAYER_EMOTE_MANAGER:GetEmoteListForType(emoteCategory) or {}
	for k, emoteId in pairs(choicesValues) do
		choices[#choices + 1] = ZO_CachedStrFormat("<<1>>", PLAYER_EMOTE_MANAGER:GetEmoteItemInfo(emoteId).displayName)
	end
	-- In overridden custom tooltip functions, the ChoicesTooltips table uses the emoteId value instead of a string.
	return choices, choicesValues, choicesValues
end

local function RebuildHouseSelectionChoices(unlockedOnly)
--	unlockedOnly : return only the unlocked ones or the whole set
	local choices = {}
	local choicesValues = {}
	local currentPrimaryHouseId = GetHousingPrimaryHouse()
	unlockedOnly = unlockedOnly or false
	if currentPrimaryHouseId ~= 0 then
		choices[#choices + 1] = 		L(SI_HOUSING_FURNITURE_SETTINGS_GENERAL_PRIMARY_RESIDENCE_TEXT) -- Primary Residence
		choicesValues[#choicesValues + 1] = CSPM_ACTION_VALUE_PRIMARY_HOUSE_ID
	end
	for index = 1, GetTotalCollectiblesByCategoryType(COLLECTIBLE_CATEGORY_TYPE_HOUSE) do
		local collectibleId = GetCollectibleIdFromType(COLLECTIBLE_CATEGORY_TYPE_HOUSE, index)
		if not unlockedOnly or IsCollectibleUnlocked(collectibleId) then
			choices[#choices + 1] = ZO_CachedStrFormat("<<1>>", GetCollectibleName(collectibleId))
			choicesValues[#choicesValues + 1] = GetCollectibleReferenceId(collectibleId)
		end
	end
	-- In overridden custom tooltip functions, the ChoicesTooltips table uses the houseId value instead of a string.
	return choices, choicesValues, choicesValues
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
	ui.slotDisplayName = RebuildSlotDisplayNameTable(uiPresetId)
	CSPM_UI_MenuItemsCountSlider:UpdateValue(false, CSPM.db.preset[uiPresetId].menuItemsCount)
	ChangePanelSlotState(1)
end

local function OnMenuItemCountChanged(newMenuItemsCount)
	CSPM.LDL:Debug("OnMenuItemCountChanged : %s", newMenuItemsCount)
	CSPM.db.preset[uiPresetId].menuItemsCount = newMenuItemsCount
	ui.slotChoices, ui.slotChoicesValues = RebuildSlotSelectionChoices(newMenuItemsCount)
	CSPM_UI_SlotSelectMenu:UpdateChoices(ui.slotChoices, ui.slotChoicesValues)
	CSPM_UI_SlotSelectMenu:UpdateValue()		-- Note : When called with no arguments, getFunc will be called, and setFunc will NOT be called.

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

	CSPM_UI_TabHeader.data.name = ui.slotChoices[uiSlotId]
	CSPM_UI_TabHeader:UpdateValue()		-- Note : When called with no arguments, getFunc will be called, and setFunc will NOT be called.

	CSPM_UI_ActionTypeMenu:UpdateValue()
	CSPM_UI_CategoryMenu:UpdateChoices(ui.categoryChoices[uiActionTypeId], ui.categoryChoicesValues[uiActionTypeId])
	CSPM_UI_CategoryMenu:UpdateValue()
	CSPM_UI_ActionValueMenu:UpdateChoices(ui.actionValueChoices[uiCategoryId], ui.actionValueChoicesValues[uiCategoryId], ui.actionValueChoicesTooltips[uiCategoryId])
	CSPM_UI_ActionValueMenu:UpdateValue()
	CSPM_UI_ActionValueEditbox:UpdateValue()
	CSPM_UI_ActionValueEditbox:UpdateDisabled()
	CSPM_UI_SlotNameEditbox:UpdateValue()
end

local function OnActionTypeSelectionChanged(newActionTypeId)
	CSPM.LDL:Debug("OnActionTypeSelectionChanged : %s", newActionTypeId)
	CSPM.db.preset[uiPresetId].slot[uiSlotId].type = newActionTypeId

	CSPM_UI_CategoryMenu:UpdateChoices(ui.categoryChoices[newActionTypeId], ui.categoryChoicesValues[newActionTypeId])

	-- The meaning of ActionValue is different for each ActionType, and they are not mutually compatible.
	-- Therefore, when a user changes the ActionType selection, the category id and ActionValue should be initialized．
	CSPM_UI_CategoryMenu:UpdateValue(true)
	CSPM_UI_ActionValueMenu:UpdateValue(true)
	-- According to the design policy, the slot name override setting is also initialized.
	CSPM_UI_SlotNameEditbox:UpdateValue(true)
end

local function OnCategorySelectionChanged(newCategoryId)
	CSPM.LDL:Debug("OnCategorySelectionChanged : %s", newCategoryId)
	CSPM.db.preset[uiPresetId].slot[uiSlotId].category = newCategoryId
	CSPM_UI_ActionValueMenu:UpdateChoices(ui.actionValueChoices[newCategoryId], ui.actionValueChoicesValues[newCategoryId], ui.actionValueChoicesTooltips[newCategoryId])

	-- To prevent a mismatch between the category id and the ActionValue,
	-- the ActionValue should be initialized when the user changes the category selection.
	CSPM_UI_ActionValueMenu:UpdateValue(true)
	-- According to the design policy, the slot name override setting is also initialized.
	CSPM_UI_SlotNameEditbox:UpdateValue(true)
end

local function OnActionValueSelectionChanged(newActionValue)
	CSPM.LDL:Debug("OnActionValueSelectionChanged : %s", newActionValue)
	CSPM.db.preset[uiPresetId].slot[uiSlotId].value = newActionValue
	-- According to the design policy, the slot name override setting is initialized.
	CSPM_UI_SlotNameEditbox:UpdateValue(true)
end

local function OnActionValueEditboxChanged(newActionValueString)
	CSPM.LDL:Debug("OnActionValueEditboxChanged : %s", newActionValueString)
	local uiActionTypeId = CSPM.db.preset[uiPresetId].slot[uiSlotId].type
	-- NOTE : the meaning of ActionValue is different for each ActionType, and they are not mutually compatible.
	if uiActionTypeId == CSPM_ACTION_TYPE_CHAT_COMMAND then 
		CSPM.db.preset[uiPresetId].slot[uiSlotId].value = newActionValueString
	else
		CSPM.db.preset[uiPresetId].slot[uiSlotId].value = tonumber(newActionValueString)
	end

	-- The slot display name will be changed and the UI panel will be updated here.
	-- When the ActionValue selection is changed, this edit box will be initialized, so the slot display name will be updated here as well.
	UpdateSlotDisplayNameTableForSpecificSlot(uiSlotId)
end

local function OnSlotNameEditboxChanged(newSlotName)
	CSPM.LDL:Debug("OnSlotNameEditboxChanged : %s", newSlotName)
	if newSlotName == "" then
		CSPM.db.preset[uiPresetId].slot[uiSlotId].name = nil
	else
		CSPM.db.preset[uiPresetId].slot[uiSlotId].name = newSlotName
	end

	UpdateSlotDisplayNameTableForSpecificSlot(uiSlotId)
end

local function DoTestButton()
	ChangePanelPresetState(1)
end

local function OnLAMPanelControlsCreated(panel)
	if (panel ~= ui.panel) then return end
	CALLBACK_MANAGER:UnregisterCallback("LAM-PanelControlsCreated", OnLAMPanelControlsCreated)

	-- override ScrollableDropdownHelper for CSPM_UI_ActionValueMenu to customize dropdown choices tooltips
	if CSPM_UI_ActionValueMenu.scrollHelper and CSPM_UI_ActionValueMenu.scrollHelper.OnMouseEnter and CSPM_UI_ActionValueMenu.scrollHelper.OnMouseExit then
		CSPM_UI_ActionValueMenu.scrollHelper.OnMouseEnter = function(self, control)
--			CSPM.LDL:Debug("ActionValueMenu:OnMouseEnter")
			if control.m_data.tooltip then
				local uiActionTypeId = CSPM.db.preset[uiPresetId].slot[uiSlotId].type
				if uiActionTypeId == CSPM_ACTION_TYPE_COLLECTIBLE then
					InitializeTooltip(ItemTooltip, control, TOPLEFT, 0, 0, BOTTOMRIGHT)
			        ItemTooltip:SetCollectible(control.m_data.tooltip, SHOW_NICKNAME, SHOW_PURCHASABLE_HINT, SHOW_BLOCK_REASON, GAMEPLAY_ACTOR_CATEGORY_PLAYER)
					ItemTooltipTopLevel:BringWindowToTop()
				elseif uiActionTypeId == CSPM_ACTION_TYPE_EMOTE then
					
				elseif uiActionTypeId == CSPM_ACTION_TYPE_TRAVEL_TO_HOUSE then
					InitializeTooltip(ItemTooltip, control, TOPLEFT, 0, 0, BOTTOMRIGHT)
			        ItemTooltip:SetCollectible(GetCollectibleIdForHouse(control.m_data.tooltip), SHOW_NICKNAME, SHOW_PURCHASABLE_HINT, SHOW_BLOCK_REASON, GAMEPLAY_ACTOR_CATEGORY_PLAYER)
					ItemTooltipTopLevel:BringWindowToTop()
				else
					InitializeTooltip(InformationTooltip, control, TOPLEFT, 0, 0, BOTTOMRIGHT)
					SetTooltipText(InformationTooltip, LAM.util.GetStringFromValue(control.m_data.tooltip))
					InformationTooltipTopLevel:BringWindowToTop()
				end
			end
		end
		CSPM_UI_ActionValueMenu.scrollHelper.OnMouseExit = function(self, control)
--			CSPM.LDL:Debug("ActionValueMenu:OnMouseExit")
			if control.m_data.tooltip then
				local uiActionTypeId = CSPM.db.preset[uiPresetId].slot[uiSlotId].type
				if uiActionTypeId == CSPM_ACTION_TYPE_COLLECTIBLE then
					ClearTooltip(ItemTooltip)
				elseif uiActionTypeId == CSPM_ACTION_TYPE_EMOTE then
					
				elseif uiActionTypeId == CSPM_ACTION_TYPE_TRAVEL_TO_HOUSE then
					ClearTooltip(ItemTooltip)
				else
					ClearTooltip(InformationTooltip)
				end
			end
		end
	end

	ChangePanelPresetState(1)
	ui.panelInitialized = true
end

function CSPM:InitializeMenuEditorUI()
	ui.panelInitialized = false
	ui.slotDisplayName = {}
	ui.slotChoices, ui.slotChoicesValues = RebuildSlotSelectionChoices(CSPM_MENU_ITEMS_COUNT_DEFAULT)

	ui.actionTypeChoices = {
		L(SI_CSPM_COMMON_UNSELECTED), 
		L(SI_CSPM_COMMON_COLLECTIBLE), 
		L(SI_CSPM_COMMON_EMOTE), 
		L(SI_CSPM_COMMON_CHAT_COMMAND), 
		L(SI_CSPM_COMMON_TRAVEL_TO_HOUSE), 
	} 
	ui.actionTypeChoicesValues = {
		CSPM_ACTION_TYPE_NOTHING, 
		CSPM_ACTION_TYPE_COLLECTIBLE, 
		CSPM_ACTION_TYPE_EMOTE, 
		CSPM_ACTION_TYPE_CHAT_COMMAND, 
		CSPM_ACTION_TYPE_TRAVEL_TO_HOUSE, 
	}
	ui.actionTypeChoicesTooltips = {
		L(SI_CSPM_UI_ACTION_TYPE_NOTHING_TIPS), 
		L(SI_CSPM_UI_ACTION_TYPE_COLLECTIBLE_TIPS), 
		L(SI_CSPM_UI_ACTION_TYPE_EMOTE_TIPS), 
		L(SI_CSPM_UI_ACTION_TYPE_CHAT_COMMAND_TIPS), 
		L(SI_CSPM_UI_ACTION_TYPE_TRAVEL_TO_HOUSE_TIPS), 
	}

	ui.categoryChoices = {}
	ui.categoryChoicesValues = {}
	ui.categoryChoices[CSPM_ACTION_TYPE_NOTHING], ui.categoryChoicesValues[CSPM_ACTION_TYPE_NOTHING] = {}, {}
	ui.categoryChoices[CSPM_ACTION_TYPE_COLLECTIBLE] = {
		L(SI_CSPM_COMMON_UNSELECTED), 
		L(SI_CSPM_COMMON_IMMEDIATE_VALUE), 
		L(SI_COLLECTIBLECATEGORYTYPE8), 	-- "Assistant", 
		L(SI_COLLECTIBLECATEGORYTYPE27), 	-- "Companion", 
		L(SI_COLLECTIBLECATEGORYTYPE5), 	-- "Memento", 
		L(SI_COLLECTIBLECATEGORYTYPE3), 	-- "Non-combat-pet", 
		L(SI_COLLECTIBLECATEGORYTYPE2), 	-- "Mount", 
	}
	ui.categoryChoicesValues[CSPM_ACTION_TYPE_COLLECTIBLE] = {
		CSPM_CATEGORY_NOTHING, 
		CSPM_CATEGORY_IMMEDIATE_VALUE, 
		CSPM_CATEGORY_C_ASSISTANT, 
		CSPM_CATEGORY_C_COMPANION, 
		CSPM_CATEGORY_C_MEMENTO, 
		CSPM_CATEGORY_C_VANITY_PET, 
		CSPM_CATEGORY_C_MOUNT, 
	}
	ui.categoryChoices[CSPM_ACTION_TYPE_EMOTE] = {
		L(SI_CSPM_COMMON_UNSELECTED), 
		L(SI_CSPM_COMMON_IMMEDIATE_VALUE), 
		L(SI_EMOTECATEGORY1), 	-- "Ceremonial"
		L(SI_EMOTECATEGORY2), 	-- "Cheers and Jeers"
		L(SI_EMOTECATEGORY4), 	-- "Emotion"
		L(SI_EMOTECATEGORY5), 	-- "Entertainment"
		L(SI_EMOTECATEGORY6), 	-- "Food and Drink"
		L(SI_EMOTECATEGORY7), 	-- "Give Directions"
		L(SI_EMOTECATEGORY9), 	-- "Physical"
		L(SI_EMOTECATEGORY10), 	-- "Poses and Fidgets"
		L(SI_EMOTECATEGORY11), 	-- "Prop"
		L(SI_EMOTECATEGORY12), 	-- "Social"
		L(SI_EMOTECATEGORY14), 	-- "Collected"
	}
	ui.categoryChoicesValues[CSPM_ACTION_TYPE_EMOTE] = {
		CSPM_CATEGORY_NOTHING, 
		CSPM_CATEGORY_IMMEDIATE_VALUE, 
		CSPM_CATEGORY_E_CEREMONIAL, 
		CSPM_CATEGORY_E_CHEERS_AND_JEERS, 
		CSPM_CATEGORY_E_EMOTION, 
		CSPM_CATEGORY_E_ENTERTAINMENT, 
		CSPM_CATEGORY_E_FOOD_AND_DRINK, 
		CSPM_CATEGORY_E_GIVE_DIRECTIONS, 
		CSPM_CATEGORY_E_PHYSICAL, 
		CSPM_CATEGORY_E_POSES_AND_FIDGETS, 
		CSPM_CATEGORY_E_PROP, 
		CSPM_CATEGORY_E_SOCIAL, 
		CSPM_CATEGORY_E_COLLECTED, 
	}
	ui.categoryChoices[CSPM_ACTION_TYPE_CHAT_COMMAND] = {
		L(SI_CSPM_COMMON_UNSELECTED), 
		L(SI_CSPM_COMMON_IMMEDIATE_VALUE), 
	}
	ui.categoryChoicesValues[CSPM_ACTION_TYPE_CHAT_COMMAND] = {
		CSPM_CATEGORY_NOTHING, 
		CSPM_CATEGORY_IMMEDIATE_VALUE, 
	}
	ui.categoryChoices[CSPM_ACTION_TYPE_TRAVEL_TO_HOUSE] = {
		L(SI_CSPM_COMMON_UNSELECTED), 
		L(SI_CSPM_COMMON_MY_HOUSE_INSIDE), 
		L(SI_CSPM_COMMON_MY_HOUSE_OUTSIDE), 
	}
	ui.categoryChoicesValues[CSPM_ACTION_TYPE_TRAVEL_TO_HOUSE] = {
		CSPM_CATEGORY_NOTHING, 
		CSPM_CATEGORY_H_UNLOCKED_HOUSE_INSIDE, 
		CSPM_CATEGORY_H_UNLOCKED_HOUSE_OUTSIDE, 
	}

	ui.actionValueChoices = {}
	ui.actionValueChoicesValues = {}
	ui.actionValueChoicesTooltips = {}
	ui.actionValueChoices[CSPM_CATEGORY_NOTHING], ui.actionValueChoicesValues[CSPM_CATEGORY_NOTHING], ui.actionValueChoicesTooltips[CSPM_CATEGORY_NOTHING] = {}, {}, {}
	ui.actionValueChoices[CSPM_CATEGORY_IMMEDIATE_VALUE], ui.actionValueChoicesValues[CSPM_CATEGORY_IMMEDIATE_VALUE], ui.actionValueChoicesTooltips[CSPM_CATEGORY_IMMEDIATE_VALUE] = {}, {}, {}
	for cspmCollectibleCategory, zosCollectibleCategory in pairs(CSPM_LUT_CATEGORY_C_CSPM_TO_ZOS) do
		ui.actionValueChoices[cspmCollectibleCategory], ui.actionValueChoicesValues[cspmCollectibleCategory], ui.actionValueChoicesTooltips[cspmCollectibleCategory] = RebuildCollectibleSelectionChoicesByCategoryType(zosCollectibleCategory, true)
	end
	for cspmEmoteCategory, zosEmoteCategory in pairs(CSPM_LUT_CATEGORY_E_CSPM_TO_ZOS) do
		ui.actionValueChoices[cspmEmoteCategory], ui.actionValueChoicesValues[cspmEmoteCategory], ui.actionValueChoicesTooltips[cspmEmoteCategory] = RebuildEmoteSelectionChoicesByEmoteCategory(zosEmoteCategory) 
	end
	ui.actionValueChoices[CSPM_CATEGORY_H_UNLOCKED_HOUSE_INSIDE], ui.actionValueChoicesValues[CSPM_CATEGORY_H_UNLOCKED_HOUSE_INSIDE], ui.actionValueChoicesTooltips[CSPM_CATEGORY_H_UNLOCKED_HOUSE_INSIDE] = RebuildHouseSelectionChoices(true)
	ui.actionValueChoices[CSPM_CATEGORY_H_UNLOCKED_HOUSE_OUTSIDE], ui.actionValueChoicesValues[CSPM_CATEGORY_H_UNLOCKED_HOUSE_OUTSIDE], ui.actionValueChoicesTooltips[CSPM_CATEGORY_H_UNLOCKED_HOUSE_OUTSIDE] = RebuildHouseSelectionChoices(true)
end

function CSPM:CreateMenuEditorPanel()
	local panelData = {
		type = "panel", 
		name = "Shortcut PieMenu", 
		displayName = "Calamath's Shortcut Pie Menu", 
		author = CSPM.author, 
		version = CSPM.version, 
		website = "https://www.esoui.com/downloads/info3088-CalamathsShortcutPieMenu.html", 
		slashCommand = "/cspm.settings", 
		registerForRefresh = true, 
--		registerForDefaults = true, 
--		resetFunc = nil, 
	}
	ui.panel = LAM:RegisterAddonPanel("CSPM_OptionsMenuEditor", panelData)
	self.panelMenuEditor = ui.panel

	local submenuPieVisual = {}
	submenuPieVisual[#submenuPieVisual + 1] = {
		type = "header", 
		name = "Visual Design Options", 
	}
	submenuPieVisual[#submenuPieVisual + 1] = {
		type = "checkbox",
		name = "Quickslot radial menu style", 
		getFunc = function() return CSPM.db.preset[uiPresetId].visual.showTrackQuickslot end, 
		setFunc = function(newValue)
			CSPM.db.preset[uiPresetId].visual.showTrackQuickslot = newValue
			CSPM.db.preset[uiPresetId].visual.showTrackGamepad = not newValue
		end, 
		tooltip = "Apply a background design like a quick slot radial menu.", 
		width = "full", 
		default = false, 
	}
	submenuPieVisual[#submenuPieVisual + 1] = {
		type = "checkbox",
		name = "Gamepad mode radial menu style", 
		getFunc = function() return CSPM.db.preset[uiPresetId].visual.showTrackGamepad end, 
		setFunc = function(newValue)
			CSPM.db.preset[uiPresetId].visual.showTrackGamepad = newValue
			CSPM.db.preset[uiPresetId].visual.showTrackQuickslot = not newValue
		end, 
		tooltip = "Apply a background design like a radial menu in gamepad mode.", 
		width = "full", 
		default = true, 
	}
	submenuPieVisual[#submenuPieVisual + 1] = {
		type = "divider", 
		width = "full", 
		height = 10, 
		alpha = 0.5, 
	}
	submenuPieVisual[#submenuPieVisual + 1] = {
		type = "checkbox",
		name = "Show preset name", 
		getFunc = function() return CSPM.db.preset[uiPresetId].visual.showPresetName end, 
		setFunc = function(newValue) CSPM.db.preset[uiPresetId].visual.showPresetName = newValue end, 
		tooltip = "Whether to show the preset name under the pie menu.", 
		width = "full", 
		default = false, 
	}
	submenuPieVisual[#submenuPieVisual + 1] = {
		type = "checkbox",
		name = "Show slot name", 
		getFunc = function() return CSPM.db.preset[uiPresetId].visual.showSlotLabel end, 
		setFunc = function(newValue) CSPM.db.preset[uiPresetId].visual.showSlotLabel = newValue end, 
		tooltip = "Whether to show the name of each slot around the pie menu.", 
		width = "full", 
		default = false, 
	}
	submenuPieVisual[#submenuPieVisual + 1] = {
		type = "checkbox",
		name = "Show icon frame", 
		getFunc = function() return CSPM.db.preset[uiPresetId].visual.showIconFrame end, 
		setFunc = function(newValue) CSPM.db.preset[uiPresetId].visual.showIconFrame = newValue end, 
		tooltip = "Whether to show the icon frame for each slot in the pie menu.", 
		width = "full", 
		default = true, 
	}

	local optionsData = {}
	optionsData[#optionsData + 1] = {
		type = "description", 
		title = "", 
		text = L(SI_CSPM_UI_PANEL_HEADER1_TEXT), 
	}
	optionsData[#optionsData + 1] = {
		type = "submenu",
		name = "Preset " .. uiPresetId .. " : ", 
--		icon = "path/to/my/icon.dds", -- or function returning a string (optional)
--		iconTextureCoords = {left, right, top, bottom}, -- or function returning a table (optional)
		tooltip = "Adjust the visual design of the pie menu. (optional)", 
--		disabled = function() return db.someBooleanSetting end, -- or boolean (optional)
--		disabledLabel = function() return db.someBooleanSetting end, -- or boolean (optional)
--		reference = "MyAddonSubmenu" ,
		controls = submenuPieVisual, 
	}
	optionsData[#optionsData + 1] = {
		type = "slider", 
		name = "Menu items count", 
		tooltip = "Select the number of slots to be displayed in the pie menu.", 
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
--		choicesTooltips = ui.slotChoicesTooltips, 
		getFunc = function() return uiSlotId end, 
		setFunc = OnSlotIdSelectionChanged, 
--		sort = "name-up", --or "name-down", "numeric-up", "numeric-down", "value-up", "value-down", "numericvalue-up", "numericvalue-down" 
		width = "half", 
--		scrollable = true, 
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
		choicesTooltips = ui.actionTypeChoicesTooltips, 
		getFunc = function() return CSPM.db.preset[uiPresetId].slot[uiSlotId].type end, 
		setFunc = OnActionTypeSelectionChanged, 
--		sort = "name-up", --or "name-down", "numeric-up", "numeric-down", "value-up", "value-down", "numericvalue-up", "numericvalue-down" 
--		width = "half", 
--		scrollable = true, 
		default = CSPM_ACTION_TYPE_NOTHING, 
		reference = "CSPM_UI_ActionTypeMenu", 
	}
	optionsData[#optionsData + 1] = {
		type = "dropdown", 
		name = L(SI_CSPM_UI_CATEGORY_MENU_NAME), 
--		tooltip = L(SI_CSPM_UI_CATEGORY_MENU_TIPS), 
		choices = ui.categoryChoices[CSPM.db.preset[uiPresetId].slot[uiSlotId].type], 	-- If choicesValue is defined, choices table is only used for UI display!
		choicesValues = ui.categoryChoicesValues[CSPM.db.preset[uiPresetId].slot[uiSlotId].type], 
--		choicesTooltips = ui.categoryChoicesTooltips[CSPM.db.preset[uiPresetId].slot[uiSlotId].type], 
		getFunc = function() return CSPM.db.preset[uiPresetId].slot[uiSlotId].category end, 
		setFunc = OnCategorySelectionChanged, 
--		sort = "name-up", --or "name-down", "numeric-up", "numeric-down", "value-up", "value-down", "numericvalue-up", "numericvalue-down" 
--		width = "half", 
--		scrollable = true, 
		default = CSPM_CATEGORY_NOTHING, 
		reference = "CSPM_UI_CategoryMenu", 
	}
	optionsData[#optionsData + 1] = {
		type = "dropdown", 
		name = L(SI_CSPM_UI_ACTION_VALUE_MENU_NAME), 
--		tooltip = L(SI_CSPM_UI_ACTION_VALUE_MENU_TIPS), 
		choices = ui.actionValueChoices[CSPM.db.preset[uiPresetId].slot[uiSlotId].category], 	-- If choicesValue is defined, choices table is only used for UI display!
		choicesValues = ui.actionValueChoicesValues[CSPM.db.preset[uiPresetId].slot[uiSlotId].category], 
		choicesTooltips = ui.actionValueChoicesTooltips[CSPM.db.preset[uiPresetId].slot[uiSlotId].category], 
		getFunc = function() return CSPM.db.preset[uiPresetId].slot[uiSlotId].value end, 
		setFunc = OnActionValueSelectionChanged, 
--		sort = "name-up", --or "name-down", "numeric-up", "numeric-down", "value-up", "value-down", "numericvalue-up", "numericvalue-down" 
		sort = "name-up", 
--		width = "half", 
		scrollable = 15, 
		default = 0, 
		reference = "CSPM_UI_ActionValueMenu", 
	}
	optionsData[#optionsData + 1] = {
		type = "editbox", 
		name = "", 
--		tooltip = nil, 
		getFunc = function() return CSPM.db.preset[uiPresetId].slot[uiSlotId].value end, 
		setFunc = OnActionValueEditboxChanged, 
		isMultiline = false, 
		isExtraWide = false, 
--		maxChars = 3000, 
--		textType = TEXT_TYPE_NUMERIC, -- number (optional) or function returning a number. Valid TextType numbers: TEXT_TYPE_ALL, TEXT_TYPE_ALPHABETIC, TEXT_TYPE_ALPHABETIC_NO_FULLWIDTH_LATIN, TEXT_TYPE_NUMERIC, TEXT_TYPE_NUMERIC_UNSIGNED_INT, TEXT_TYPE_PASSWORD
--		width = "half", 
		disabled = function()
			local uiCategoryId = CSPM.db.preset[uiPresetId].slot[uiSlotId].category
			return uiCategoryId ~= CSPM_CATEGORY_IMMEDIATE_VALUE
		end, 
		default = 0, 
		reference = "CSPM_UI_ActionValueEditbox", 
	}
	optionsData[#optionsData + 1] = {
		type = "divider", 
		width = "full", 
		height = 10, 
		alpha = 0.25, 
	}
	optionsData[#optionsData + 1] = {
		type = "editbox", 
		name = "Slot Name Override", 
--		tooltip = nil, 
		getFunc = function() return CSPM.db.preset[uiPresetId].slot[uiSlotId].name end, 
		setFunc = OnSlotNameEditboxChanged, 
		isMultiline = false, 
		isExtraWide = false, 
--		maxChars = 3000, 
--		textType = TEXT_TYPE_NUMERIC, -- number (optional) or function returning a number. Valid TextType numbers: TEXT_TYPE_ALL, TEXT_TYPE_ALPHABETIC, TEXT_TYPE_ALPHABETIC_NO_FULLWIDTH_LATIN, TEXT_TYPE_NUMERIC, TEXT_TYPE_NUMERIC_UNSIGNED_INT, TEXT_TYPE_PASSWORD
		width = "full", 
--		disabled = true, 
		default = "", 
		reference = "CSPM_UI_SlotNameEditbox", 
	}
	optionsData[#optionsData + 1] = {
		type = "button", 
		name = "Default Name", 
--		tooltip = nil, 
		func = function()
			local actionTypeId = CSPM.db.preset[uiPresetId].slot[uiSlotId].type
			local categoryId = CSPM.db.preset[uiPresetId].slot[uiSlotId].category
			local actionValue = CSPM.db.preset[uiPresetId].slot[uiSlotId].value
			local newSlotName = GetDefaultSlotName(actionTypeId, categoryId, actionValue) 
			CSPM_UI_SlotNameEditbox:UpdateValue(false, newSlotName)
		end, 
		width = "full", 
--		disabled = true, 
		disabled = function()
			local uiActionTypeId = CSPM.db.preset[uiPresetId].slot[uiSlotId].type
			if uiActionTypeId == CSPM_ACTION_TYPE_COLLECTIBLE or uiActionTypeId == CSPM_ACTION_TYPE_EMOTE or CSPM_ACTION_TYPE_TRAVEL_TO_HOUSE then
				return false
			else
				return true
			end
		end, 
--		isDangerous = false, 
--		warning = "Will need to reload the UI.", -- (optional)
--		reference = "CSPM_UI_GetSlotNameButton", 
	}
--[[
	optionsData[#optionsData + 1] = {
		type = "button", 
		name = "Test", 
		func = DoTestButton, 
--		width = "half", 
	}
]]
	LAM:RegisterOptionControls("CSPM_OptionsMenuEditor", optionsData)
	CALLBACK_MANAGER:RegisterCallback("LAM-PanelControlsCreated", OnLAMPanelControlsCreated)
end