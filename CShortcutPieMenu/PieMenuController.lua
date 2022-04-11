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

local LDL
--local debugMode = true
if debugMode and LibDebugLogger then
	LDL = LibDebugLogger("CSPM-class")
else
	LDL = { Verbose = function() end, Debug = function() end, Info = function() end, Warn = function() end, Error = function() end, }
end

-- Template
-- NOTE : This template is based on ZO_SelectableItemRadialMenuEntryTemplate by ZOS, with its own extensions and size adjustment to fit the UI design of the CShortcutPieMenu add-on.
function CSPM_SelectableItemRadialMenuEntryTemplate_OnInitialized(self)
	self.glow = self:GetNamedChild("Glow")
	self.icon = self:GetNamedChild("Icon")
	self.count = self:GetNamedChild("CountText")
	self.cooldown = self:GetNamedChild("Cooldown")
	self.inCooldown = false
	self.frame = self:GetNamedChild("Frame")
	self.label = self:GetNamedChild("Label")
	if self.label then
		self.label:SetDimensionConstraints(0, 0, 360, 64)
	end
	self.padding = self:GetNamedChild("Padding")
	if self.padding then
		self.padding:SetDimensions(64 / 2 + 10, 64 / 2 + 5)		-- trueEntryTemplateWidth / 2 + offsetX , trueEntryTemplateHeight / 2 + offsetY
	end
	self.status = self:GetNamedChild("Status")
end

function CSPM_SelectableItemRadialMenuEntryTemplate_UpdateStatus(template, statusIcon)
	if template.status then
		template.status:ClearIcons()
		if statusIcon then
			if type(statusIcon) == "table" then
				for k, v in ipairs(statusIcon) do
					template.status:AddIcon(v)
				end
			else
				template.status:AddIcon(statusIcon)
			end
			template.status:Show()
		end
	end
end

function CSPM_SelectableItemRadialMenuEntryTemplate_UpdateIconAttributes(template, attributes)
-- NOTE: The argument attributes is also compatible with the argument for ZO_SetIconAttributes().
	if type(attributes) ~= "table" then return end
	if attributes.iconColor then
		if attributes.iconColor.UnpackRGBA and attributes.iconColor.Colorize then	-- checking ZO_ColorDef object
			template.icon:SetColor(attributes.iconColor:UnpackRGBA())
		else
			template.icon:SetColor(attributes.iconColor[1] or 1, attributes.iconColor[2] or 1, attributes.iconColor[3] or 1, attributes.iconColor[4] or 1)
		end
	end
	if attributes.iconDesaturation then
		template.icon:SetDesaturation(attributes.iconDesaturation)
	end
	if attributes.iconSamplingTable then
		for sampleProcessingType, weight in pairs(attributes.iconSamplingTable) do
			template.icon:SetTextureSampleProcessingWeight(sampleProcessingType, weight)
		end
	end
end

function CSPM_SelectableItemRadialMenuEntryTemplate_UpdateSlotLabel(template, slotLabel)
	slotLabel = slotLabel or ""
	if type(slotLabel) == "table" then
		template.label:SetText(slotLabel[1])
		template.label:SetColor(slotLabel[2][1] or 1, slotLabel[2][2] or 1, slotLabel[2][3] or 1, 1)
	else
		template.label:SetText(slotLabel)
		template.label:SetColor(1, 1, 1, 1)
	end
end

function CSPM_SelectableItemRadialMenuEntryTemplate_UpdateCooldown(template, remaining, duration, displayType, timeType, drawLeadingEdge)
	template.inCooldown = remaining > 0 and duration > 0
	if template.inCooldown then
		displayType = displayType or CD_TYPE_RADIAL
		timeType = timeType or CD_TIME_TYPE_TIME_UNTIL
		drawLeadingEdge = drawLeadingEdge or false		-- nil should be false (no draw leading edge for radial type.)
		template.cooldown:SetVerticalCooldownLeadingEdgeHeight(12)
		template.cooldown:StartCooldown(remaining, duration, displayType, timeType, drawLeadingEdge)
	else
		template.cooldown:ResetCooldown()
	end
	template.cooldown:SetHidden(not template.inCooldown)
end

do
	local POINT_TO_RELATIVE_POINT = {
		[TOP]			= BOTTOM, 
		[LEFT]			= RIGHT, 
		[BOTTOM]		= TOP, 
		[RIGHT]			= LEFT, 
		[TOPLEFT]		= BOTTOMRIGHT, 
		[BOTTOMLEFT]	= TOPRIGHT, 
		[BOTTOMRIGHT]	= TOPLEFT, 
		[TOPRIGHT]		= BOTTOMLEFT, 
		[CENTER]		= CENTER, 
	}
	function CSPM_SetupSelectableItemRadialMenuEntryTemplate(template, showGlow, itemCount, showIconFrame, slotLabel, iconDesaturation, resizeIconToFitFile)
		if template.frame then
			if showIconFrame then
				template.frame:SetHidden(false)
			else
				template.frame:SetHidden(true)
			end
		end

		if template.icon then
			template.icon:SetColor(1, 1, 1, 1)
			if iconDesaturation == true then
				template.icon:SetDesaturation(1)
			else
				template.icon:SetDesaturation(0)
			end
			template.icon:SetTextureSampleProcessingWeight(TEX_SAMPLE_PROCESSING_RGB, 1)
			template.icon:SetTextureSampleProcessingWeight(TEX_SAMPLE_PROCESSING_ALPHA_AS_RGB, 0)
			if resizeIconToFitFile == true then
				template.icon:SetResizeToFitFile(true)
			else
				template.icon:SetResizeToFitFile(false)
			end
		end

		if template.label then
			if template.padding then
				-- To avoid a bug where the anchor offset calculation is incorrect for the child control without scale inheritance, when animating the parent's scale.
				local isValid, point = template.label:GetAnchor(0)
				if isValid then
					template.padding:ClearAnchors()
					template.padding:SetAnchor(point, nil, CENTER)
					template.label:ClearAnchors()
					template.label:SetAnchor(point, template.padding, POINT_TO_RELATIVE_POINT[point])
				end
			end
			CSPM_SelectableItemRadialMenuEntryTemplate_UpdateSlotLabel(template, slotLabel)
		end

		if template.count then
			if itemCount then
				template.count:SetHidden(false)
				template.count:SetText(itemCount)
			else
				template.count:SetHidden(true)
				template.count:SetText("")
			end
		end

		if showGlow then
			if template.glow then
				template.glow:SetAlpha(1)
			end
			template.animation:GetLastAnimation():SetAnimatedControl(nil)
		else
			if template.glow then
				template.glow:SetAlpha(0)
			end
			template.animation:GetLastAnimation():SetAnimatedControl(template.glow)
		end
	end
end

-- ------------------------------------------------
-- Class

-- NOTE : Since this add-on emphasizes interface consistency with the QuickSlot system and Fishing Manager, 
--        the pie menu control class inherits from ZOS's ZO_InteractiveRadialMenuController class.
--        However, there are some methods that are overridden for functional extensions and differences, 
--        and some of them may contain some of the original code of ZO_RadialMenu and ZO_InteractiveRadialMenuController by ZOS.
--
if CSPM_PieMenuController then return end

local TIME_TO_HOLD_KEY_MS = 250
local ROTATION_OFFSET = 3 * math.pi / 2
local CSPM_INTERCEPTOR = {
	["CSPM_KEY_MOUSE_LEFT"] = { KEY_MOUSE_LEFT, }, 
	["CSPM_KEY_MOUSE_LEFTRIGHT"] = { KEY_MOUSE_LEFTRIGHT, }, 
	["CSPM_KEY_MOUSE_MIDDLE"] = { KEY_MOUSE_MIDDLE, }, 
	["CSPM_KEY_MOUSE_RIGHT"] = { KEY_MOUSE_RIGHT, }, 
	["CSPM_KEY_MOUSEWHEEL_DOWN"] = { KEY_MOUSEWHEEL_DOWN, }, 
	["CSPM_KEY_MOUSEWHEEL_UP"] = { KEY_MOUSEWHEEL_UP, }, 
	["CSPM_KEY_MOUSE_4"] = { KEY_MOUSE_4, }, 
	["CSPM_KEY_MOUSE_5"] = { KEY_MOUSE_5, }, 
	["CSPM_KEY_GAMEPAD_BUTTON_1"] = { KEY_GAMEPAD_BUTTON_1, }, 
	["CSPM_KEY_GAMEPAD_BUTTON_2"] = { KEY_GAMEPAD_BUTTON_2, }, 
	["CSPM_KEY_GAMEPAD_BUTTON_3"] = { KEY_GAMEPAD_BUTTON_3, }, 
	["CSPM_KEY_GAMEPAD_BUTTON_4"] = { KEY_GAMEPAD_BUTTON_4, }, 
	["CSPM_HUD_KEY_MOUSE_LEFT"] = { KEY_MOUSE_LEFT, }, 
	["CSPM_HUD_KEY_MOUSE_LEFTRIGHT"] = { KEY_MOUSE_LEFTRIGHT, }, 
	["CSPM_HUD_KEY_MOUSE_MIDDLE"] = { KEY_MOUSE_MIDDLE, }, 
	["CSPM_HUD_KEY_MOUSE_RIGHT"] = { KEY_MOUSE_RIGHT, }, 
	["CSPM_HUD_KEY_MOUSEWHEEL_DOWN"] = { KEY_MOUSEWHEEL_DOWN, }, 
	["CSPM_HUD_KEY_MOUSEWHEEL_UP"] = { KEY_MOUSEWHEEL_UP, }, 
	["CSPM_HUD_KEY_MOUSE_4"] = { KEY_MOUSE_4, }, 
	["CSPM_HUD_KEY_MOUSE_5"] = { KEY_MOUSE_5, }, 
	["CSPM_HUD_KEY_GAMEPAD_BUTTON_1"] = { KEY_GAMEPAD_BUTTON_1, }, 
	["CSPM_HUD_KEY_GAMEPAD_BUTTON_2"] = { KEY_GAMEPAD_BUTTON_2, }, 
	["CSPM_HUD_KEY_GAMEPAD_BUTTON_3"] = { KEY_GAMEPAD_BUTTON_3, }, 
	["CSPM_HUD_KEY_GAMEPAD_BUTTON_4"] = { KEY_GAMEPAD_BUTTON_4, }, 
}
local pieMenuCount = pieMenuCount or 0

CSPM_PieMenuController = ZO_InteractiveRadialMenuController:Subclass()

function CSPM_PieMenuController:New(...)
    return ZO_InteractiveRadialMenuController.New(self, ...)
end

function CSPM_PieMenuController:Initialize(control, entryTemplate, animationTemplate, entryAnimationTemplate)
	ZO_InteractiveRadialMenuController.Initialize(self, control, entryTemplate, animationTemplate, entryAnimationTemplate)
	pieMenuCount = pieMenuCount + 1
	self.menu.mouseDeltaScaleFactor = 1
	self.menu.presetLabel = self.menuControl:GetNamedChild("PresetName")
	self.menu.trackQuickslot = self.menuControl:GetNamedChild("TrackQuickslot")
	self.menu.trackGamepad = self.menuControl:GetNamedChild("TrackGamepad")
	self.menu.underlay = self.menuControl:GetNamedChild("Underlay")
	self.menu.overlay = self.menuControl:GetNamedChild("Overlay")
	self.menu.overlay:SetHandler("OnMouseDown", function(control, button, ...) self:OnGlobalKeyDown(ConvertMouseButtonToKeyCode(button), ...) end)
	self.menu.overlay:SetHandler("OnMouseWheel", function(control, delta, ...) self:OnGlobalKeyDown((delta > 0) and KEY_MOUSEWHEEL_UP or KEY_MOUSEWHEEL_DOWN, ...) end)
	self.menu.overlay:SetHandler("OnKeyDown", function(control, ...) self:OnGlobalKeyDown(...) end)
	CALLBACK_MANAGER:RegisterCallback("CSPM-KeyDownHUD", function(...) self:OnGlobalKeyDown(...) end)
	self.isTopmost = false
	self.mouseDeltaScaleFactorInUIMode = 1
	self.allowActivateInUIMode = true
	self.allowClickable = true
	self.centeringAtMouseCursor = false
	self.timeToHoldKey = TIME_TO_HOLD_KEY_MS
	self.bindings = {}
	for k, v in pairs(CSPM_INTERCEPTOR) do
		local layer, category, action = GetActionIndicesFromName(k)
		if layer and category and action then
			if IsProtectedFunction("UnbindAllKeysFromAction") then
				CallSecureProtected("UnbindAllKeysFromAction", layer, category, action)
			else
				UnbindAllKeysFromAction(layer, category, action)
			end
			if IsProtectedFunction("BindKeyToAction") then
				CallSecureProtected("BindKeyToAction", layer, category, action, 1, v[1], v[2], v[3], v[4], v[5])
			else
				BindKeyToAction(layer, category, action, 1,  v[1], v[2], v[3], v[4], v[5])
			end
		end
	end
	self.selectedEntry = nil
	self.previousSelectedEntry = nil
	if self.menu.SetOnUpdateRotationFunction then
		self.rotationRaw = ROTATION_OFFSET
		self.menu:SetOnUpdateRotationFunction(function(...) self:OnUpdateRotationCallback(...) end)
	end
	EVENT_MANAGER:RegisterForEvent("CSPM-class_PieMenu" .. pieMenuCount, EVENT_LUA_ERROR, function()
		if self.menu:IsShown() then
			self.menu.ForceActiveMenuClosed()
		end
	end)
	-- Overridden some methods of the original ZO_RadialMenu class by ZOS.
	self.menu.SetMouseDeltaScaleFactor = function(self, scaleFactor)
		self.mouseDeltaScaleFactor = scaleFactor
	end
	self.menu.OnUpdate = function(self)
		if self:UpdateVirtualMousePosition() then
			self:UpdateSelectedEntryFromVirtualMousePosition()
		end
	end
	self.menu.UpdateVirtualMousePosition= function(self)
		if self.enableMouse then
			local deltaX, deltaY = GetUIMouseDeltas()
			if deltaX ~= 0 or deltaY ~= 0 then
				self.virtualMouseX = self.virtualMouseX + deltaX * self.mouseDeltaScaleFactor
				self.virtualMouseY = self.virtualMouseY + deltaY * self.mouseDeltaScaleFactor
				return self:ShouldUpdateSelection()
			end
		end
		return false
	end
end

function CSPM_PieMenuController:SetOnSelectionChangedCallback(callback)
    self.onSelectionChangedCallback = callback
end

function CSPM_PieMenuController:SetOnUpdateRotationFunction(callback)
    self.onUpdateRotationFunc = callback
end

function CSPM_PieMenuController:SetPopulateMenuCallback(callback)
    self.populateMenuCallback = callback
end

function CSPM_PieMenuController:OnGlobalKeyDown(key, ctrl, alt, shift, command)
	if self.bindings[key] then
		self.bindings[key](key, ctrl, alt, shift, command)
	end
end

function CSPM_PieMenuController:SetActionLayer(actionLayerName)
	self.menu.actionLayerName = actionLayerName
end

function CSPM_PieMenuController:SetSelectIfCentered(selectIfCentered)
	self.menu.selectIfCentered = selectIfCentered
end

function CSPM_PieMenuController:IsTopmost()
	return self.isTopmost
end

function CSPM_PieMenuController:SetTopmost(isTopmost)
	self.isTopmost = isTopmost
	self.menuControl:GetParent():SetTopmost(isTopmost)
end

function CSPM_PieMenuController:ShowUnderlay()
	if self.menu.underlay then
		self.menu.underlay:SetHidden(false)
	end
end

function CSPM_PieMenuController:HideUnderlay()
	if self.menu.underlay then
		self.menu.underlay:SetHidden(true)
	end
end

function CSPM_PieMenuController:ShowOverlay()
	if self.menu.overlay then
		self.menu.overlay:SetHidden(false)
	end
end

function CSPM_PieMenuController:HideOverlay()
	if self.menu.overlay then
		self.menu.overlay:SetHidden(true)
	end
end

function CSPM_PieMenuController:SetMouseDeltaScaleFactorInUIMode(scaleFactor)
	self.mouseDeltaScaleFactorInUIMode = scaleFactor
end

function CSPM_PieMenuController:SetAllowActivateInUIMode(allowActivateInUIMode)
	self.allowActivateInUIMode = allowActivateInUIMode
end

function CSPM_PieMenuController:SetAllowClickable(allowClickable)
	self.allowClickable = allowClickable
end

function CSPM_PieMenuController:SetCenteringAtMouseCursor(centeringAtMouseCursor)
	self.centeringAtMouseCursor = centeringAtMouseCursor
end

function CSPM_PieMenuController:SetTimeToHoldKey(timeToHoldKey)
	self.timeToHoldKey = timeToHoldKey or TIME_TO_HOLD_KEY_MS
end

function CSPM_PieMenuController:SetAnchorOffset(offsetX, offsetY)
	self.menuControl:ClearAnchors()
	self.menuControl:SetAnchor(CENTER, guiRoot, CENTER, offsetX, offsetY)
end

function CSPM_PieMenuController:SetAnchorToMousePosition()
	local centerX, centerY = GuiRoot:GetCenter()
	local x, y = GetUIMousePosition()
	self:SetAnchorOffset(x - centerX, y - centerY)
end

function CSPM_PieMenuController:SetAnchorToCenterPosition()
	self:SetAnchorOffset(0, 0)
end

function CSPM_PieMenuController:RegisterBindings(key, callback)
	if type(callback) == "function" then
		self.bindings[key] = callback
	end
end

function CSPM_PieMenuController:UnregisterBindings(key)
	self.bindings[key] = nil
end

function CSPM_PieMenuController:GetCurrentRotation()
	return self.rotationRaw and (self.rotationRaw - ROTATION_OFFSET) or 0.0
end

function CSPM_PieMenuController:SetupPieMenuVisual(presetName, showPresetName, showQuickslotRadialTrack, showGamepadRadialTrack)
	presetName = presetName or ""
	self.menu.presetLabel:SetText(presetName)

	if showPresetName then
		self.menu.presetLabel:SetHidden(false)
	else
		self.menu.presetLabel:SetHidden(true)
	end

	if type(showQuickslotRadialTrack) == "boolean" then
		showQuickslotRadialTrack = showQuickslotRadialTrack and 1.0 or 0.0
	end
	self.menu.trackQuickslot:SetAlpha(showQuickslotRadialTrack or 0.0)

	if type(showGamepadRadialTrack) == "boolean" then
		showGamepadRadialTrack = showGamepadRadialTrack and 0.8 or 0.0
	end
	self.menu.trackGamepad:SetAlpha(showGamepadRadialTrack or 0.0)
end

function CSPM_PieMenuController:ClearSelection(...)
	self.menu:ClearSelection(...)
end

function CSPM_PieMenuController:GetNumMenuEntries()
	return #self.menu.entries
end

function CSPM_PieMenuController:GetSelectedEntryControl()
	if self.selectedEntry then
		return self.selectedEntry.control
	end
end

function CSPM_PieMenuController:GetPreviousSelectedEntryControl()
	if self.previousSelectedEntry then
		return self.previousSelectedEntry.control
	end
end

function CSPM_PieMenuController:AddMenuEntry(...)
	self.menu:AddEntry(...)
end

function CSPM_PieMenuController:CancelInteraction()
	return(self:StopInteraction(true))	-- true: clearSelection
end

-- Overridden from base class
function CSPM_PieMenuController:StopInteraction(clearSelection)
	if self.isInteracting then
		self:HideUnderlay()
		self:ShowOverlay()
		self:SetTopmost(false)
	end
	return(ZO_InteractiveRadialMenuController.StopInteraction(self, clearSelection))
end

function CSPM_PieMenuController:OnUpdate()
    if self.beginHold and GetFrameTimeMilliseconds() >= self.beginHold + self.timeToHoldKey then
        self.beginHold = nil
        if not self.isInteracting then
            self:ShowMenu()
        end
    end
end

function CSPM_PieMenuController:PrepareForInteraction()
	LDL:Debug("PrepareForInteraction()")
	local currentScene = SCENE_MANAGER:GetCurrentScene()
    if not currentScene or currentScene:IsRemoteScene() then
		return false
	end
    if IsGameCameraActive() and IsGameCameraUIModeActive() and not self.allowActivateInUIMode then
		return false
	end
    return true
end

function CSPM_PieMenuController:SetupEntryControl(entryControl, data)
	if not data then return end
	LDL:Debug("SetupEntryControl(_, %s)", tostring(data.name))
	local showGlow = false
	local itemCount
	local slotLabel
	local iconDesaturation = data.disabled or false
	
	if data.itemCount then
		itemCount = data.itemCount
	else
		itemCount = nil
	end

	if data.showSlotLabel then
		if data.nameColor and type(data.nameColor) == "table" then
			slotLabel = { data.name, data.nameColor, }
		else
			slotLabel = data.name
		end
	else
		slotLabel = ""
	end

	CSPM_SetupSelectableItemRadialMenuEntryTemplate(entryControl, showGlow, itemCount, data.showIconFrame, slotLabel, iconDesaturation, data.resizeIconToFitFile)
	CSPM_SelectableItemRadialMenuEntryTemplate_UpdateIconAttributes(entryControl, data.iconAttributes)
	CSPM_SelectableItemRadialMenuEntryTemplate_UpdateStatus(entryControl, data.statusIcon)

	if data.cooldownRemaining and data.cooldownDuration then
		CSPM_SelectableItemRadialMenuEntryTemplate_UpdateCooldown(entryControl, data.cooldownRemaining, data.cooldownDuration)
	end
end

function CSPM_PieMenuController:OnSelectionChangedCallback(selectedEntry)
	LDL:Debug("OnSelectionChangedCallback() : %s -> %s", self.previousSelectedEntry and self.previousSelectedEntry.data.index or "nil", selectedEntry and selectedEntry.data.index or "nil")
	self.selectedEntry = selectedEntry
	if selectedEntry then
		local previousSelectedEntryControl = self:GetPreviousSelectedEntryControl()
		if previousSelectedEntryControl then
			if previousSelectedEntryControl.entry.data.activeStatusIcon then
				CSPM_SelectableItemRadialMenuEntryTemplate_UpdateStatus(previousSelectedEntryControl, previousSelectedEntryControl.entry.data.statusIcon)
			end
		end
		if selectedEntry.data.activeStatusIcon then
			CSPM_SelectableItemRadialMenuEntryTemplate_UpdateStatus(selectedEntry.control, selectedEntry.data.activeStatusIcon)
		end

		if self.onSelectionChangedCallback then
			self.onSelectionChangedCallback(self, selectedEntry.data.index, selectedEntry.data)
		end
	end
	self.previousSelectedEntry = selectedEntry
end

function CSPM_PieMenuController:OnUpdateRotationCallback(rotationRaw)
--	LDL:Debug("OnUpdateRotationCallback() : rotationRaw = %s", tostring(rotationRaw))
	self.rotationRaw = rotationRaw
	if self.onUpdateRotationFunc then
		self.onUpdateRotationFunc(self, rotationRaw)
	end
end

function CSPM_PieMenuController:PopulateMenu()
	LDL:Debug("PopulateMenu()")
	self.selectedEntry = nil
	self.previousSelectedEntry = nil
	self.selectedSlotNum = 0
	if IsGameCameraActive() and IsGameCameraUIModeActive() or IsInteracting() then
		self.menu:SetMouseDeltaScaleFactor(self.mouseDeltaScaleFactorInUIMode)
		if self.allowClickable then
			self:SetActionLayer("CSPM_UI_Interceptor")
			self:ShowOverlay()
		else
			self:SetActionLayer("CSPM_Interceptor")
			self:HideOverlay()
		end
		if self.centeringAtMouseCursor then
			self:SetAnchorToMousePosition()
		else
			self:SetAnchorToCenterPosition()
		end
		self:ShowUnderlay()
	else
		self.menu:SetMouseDeltaScaleFactor(1)
		if self.allowClickable then
			self:SetActionLayer("CSPM_HUD_Interceptor")
			self:ShowOverlay()
		else
			self:SetActionLayer("CSPM_Interceptor")
			self:HideOverlay()
		end
		self:SetAnchorToCenterPosition()
	end
	self:SetTopmost(true)
	if self.populateMenuCallback then
		self.populateMenuCallback(self)
	end
end
