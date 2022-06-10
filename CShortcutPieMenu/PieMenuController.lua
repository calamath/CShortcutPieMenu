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


-- ---------------------------------------------------------------------------------------
-- Pie Menu Class
-- ---------------------------------------------------------------------------------------
-- NOTE : Since this add-on emphasizes interface consistency with the QuickSlot system with Utility Wheel, the pie menu class inherits from the ZO_RadialMenu class. 
--        There are some overridden methods for functional extensions and differences, so some of them may contain some of the original code of ZO_RadialMenu by ZOS.
--
local CSPM_PieMenu = ZO_RadialMenu:Subclass()
function CSPM_PieMenu:Initialize(control, entryTemplate, animationTemplate, entryAnimationTemplate, actionLayerName, directionInputs, enableMouse, selectIfCentered)
	ZO_RadialMenu.Initialize(self, control, entryTemplate, animationTemplate, entryAnimationTemplate, actionLayerName, directionInputs, enableMouse, selectIfCentered)
	self.presetLabel = control:GetNamedChild("PresetName")
	self.track = control:GetNamedChild("Track")
	self.underlay = control:GetNamedChild("Underlay")
	self.overlay = control:GetNamedChild("Overlay")
	if self.overlay then
		self.overlay:SetHandler("OnMouseDown", function(control, button, ...)
			if self.onKeyDownCallback then
				self.onKeyDownCallback(ConvertMouseButtonToKeyCode(button), ...)
			end
		end)
		self.overlay:SetHandler("OnMouseUp", function(control, button, ...)
			if self.onKeyUpCallback then
				self.onKeyUpCallback(ConvertMouseButtonToKeyCode(button), ...)
			end
		end)
		self.overlay:SetHandler("OnMouseWheel", function(control, delta, ...)
			local key = (delta > 0) and KEY_MOUSEWHEEL_UP or KEY_MOUSEWHEEL_DOWN
			if self.onKeyDownCallback then
				self.onKeyDownCallback(key, ...)
			end
			if self.onKeyUpCallback then
				self.onKeyUpCallback(key, ...)
			end
		end)
		self.overlay:SetHandler("OnKeyDown", function(control, ...)
			if self.onKeyDownCallback then
				self.onKeyDownCallback(...)
			end
		end)
		self.overlay:SetHandler("OnKeyUp", function(control, ...)
			if self.onKeyUpCallback then
				self.onKeyUpCallback(...)
			end
		end)
	end
	self.mouseDeltaScaleFactor = 1
end

function CSPM_PieMenu:SetOnKeyDownCallback(callback)
    self.onKeyDownCallback = callback
end

function CSPM_PieMenu:SetOnKeyUpCallback(callback)
    self.onKeyUpCallback = callback
end

function CSPM_PieMenu:SetMouseDeltaScaleFactor(scaleFactor)
	self.mouseDeltaScaleFactor = scaleFactor
end

function CSPM_PieMenu:SetVirtualMousePosition(virtualMouseX, virtualMouseY)
	if self.enableMouse then
		if virtualMouseX then
			self.virtualMouseX = virtualMouseX
		end
		if virtualMouseY then
			self.virtualMouseY = virtualMouseY
		end
		self:ShouldUpdateSelection()	-- normalize both virtualMouseX and virtualMouseY if needed.
	end
end

function CSPM_PieMenu:SelectCurrentEntryAndFinalize(...)
-- The original SelectCurrentEntry method always terminates the radial menu interaction after the entry callback execution.
	self:SelectCurrentEntry(...)
end

function CSPM_PieMenu:SelectCurrentEntryAndContinueIfNeeded()
-- The new SelectCurrentEntry method terminates only the radial menu interaction if the entry callback return true after the execution.
-- NOTE: The radial menu interaction continuation should only be performed when there is still a way to end the interaction.
--       It is also recommended to implement a failsafe in case the radial menu interaction cannot be terminated.
--       Example use case: clearing and updating the menu entry with the menu still displayed.
	local result = false
	if self:IsShown() and self.selectedEntry and self.selectedEntry.callback and (not self.animation or not self.animation:IsPlayingBackward()) then
		result = self.selectedEntry.callback(self)
		if result ~= true then	-- If the callback returns true it means that the callback requested continuous processing, and the whole interaction doesn't need ending.
			self:Clear(true)
		end
	else
		self:Clear()
	end
	return result
end

-- Overridden some methods of the original ZO_RadialMenu class.
function CSPM_PieMenu:OnUpdate()
	if self:UpdateVirtualMousePosition() then
		self:UpdateSelectedEntryFromVirtualMousePosition()
	end
end

function CSPM_PieMenu:UpdateVirtualMousePosition()
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

function CSPM_PieMenu:Refresh(suppressSound)
	self:ClearSelection()
	if self.actionLabel then
		self.actionLabel:SetHidden(true)
	end
	if not suppressSound then
		PlaySound(SOUNDS.RADIAL_MENU_OPEN)
	end
	if self.animation then
		self.animation:PlayForward()
	end
	self:PerformLayout()
end

-- ---------------------------------------------------------------------------------------
-- Pie Menu Controller Class
-- ---------------------------------------------------------------------------------------
-- NOTE : The Pie Menu Controller class is a proprietary controller that inherits the same interface as ZO_RadialMenuController by ZOS.
--        It is not involved in the input interactions related to the activation of the pie menu. But it manages the pie menu at all after activation.
--        It requires the control passed in to have a child pie menu named "Menu".
--
local ROTATION_OFFSET = 3 * math.pi / 2
local BLANK_TEXTURE = "Esoui/Art/Icons/heraldrycrests_misc_blank_01.dds"
local PIE_MENU_STYLE = {
	["quickslot"] = {
		selected = "EsoUI/Art/HUD/radialMenu_bg.dds", 
		unselected = "EsoUI/Art/HUD/radialMenu_bg_unselected.dds", 
		track = "EsoUI/Art/Quickslots/quickslot_mapping_bg.dds", 
		size = {
			[300] = 493, 
			[350] = 575, 
			[400] = 657, 
			[500] = 825, 
		}, 
	}, 
	["gamepad"] = {
		selected = "EsoUI/Art/HUD/Gamepad/gp_radialmenu_thumb.dds", 
		unselected = nil, 
		track = "EsoUI/Art/HUD/Gamepad/gp_radialMenu_track.dds", 
		size = {
			[300] = 608, 
			[350] = 700, 
			[400] = 810, 
			[500] = 1010, 
		}, 
	}, 
}
local CSPM_PieMenuController = ZO_InitializingObject:Subclass()
function CSPM_PieMenuController:Initialize(control, entryTemplate, animationTemplate, entryAnimationTemplate, attrib)
	self.name = "CSPM_PieMenuController"
	self.attrib = {
		actionLayerNames = "RadialMenu", 
		directionInputs = { ZO_DI_LEFT_STICK, ZO_DI_RIGHT_STICK, }, 
		enableMouse = true, 
		selectIfCentered = true, 

		mouseDeltaScaleFactorInUIMode = 1, 
		mouseDeltaScaleFactorInHUDMode = 1, 
		allowActivateInUIMode = true, 
		allowClickable = true, 
		centeringAtMouseCursor = false, 
		timeToHoldKey = 250, 
	}
	self.overriddenAttrib = attrib or {}
	self.menuControl = control:GetNamedChild("Menu")
	self.menu = CSPM_PieMenu:New(self.menuControl, entryTemplate, animationTemplate, entryAnimationTemplate, self:GetAttribute("actionLayerNames"), self:GetAttribute("directionInputs"), self:GetAttribute("enableMouse"), self:GetAttribute("selectIfCentered"))
	self.menu:SetCustomControlSetUpFunction(function(entryControl, data)
		self:SetupEntryControl(entryControl, data)
	end)
	self.menu:SetOnSelectionChangedCallback(function(selectedEntry)
		self:OnSelectionChangedCallback(selectedEntry)
	end)
	self.rotationRaw = ROTATION_OFFSET
	self.menu:SetOnUpdateRotationFunction(function(...)
		self:OnUpdateRotationCallback(...)
	end)
	self.menu:SetOnClearCallback(function(...)
		self:OnClear(...)
	end)
	self.interaction = LibCInteraction:RegisterInteraction("CSPM_PIE_MENU_BUTTON", {
		type = "press", 
		enabled = true, 
		keyDownCallback = function(interaction, ...)
			self:OnGlobalKeyDown(...)
		end, 
	})
	self.menu:SetOnKeyDownCallback(function(...)
		LibCInteraction:HandleKeybindDown("CSPM_PIE_MENU_BUTTON", ...)
	end)
	self.menu:SetOnKeyUpCallback(function(...)
		LibCInteraction:HandleKeybindUp("CSPM_PIE_MENU_BUTTON", ...)
	end)
	self.menuControl:RegisterForEvent(EVENT_LUA_ERROR, function()
		self:ForceExitInteraction()
	end)
	self.isTopmost = false
	self.bindings = {}
	self.selectedEntry = nil
	self.previousSelectedEntry = nil
end

function CSPM_PieMenuController:GetAttribute(key)
	if self.overriddenAttrib[key] ~= nil then
		return self.overriddenAttrib[key]
	else
		return self.attrib[key]
	end
end

function CSPM_PieMenuController:SetAttribute(key, value)
	if self.overriddenAttrib[key] ~= nil then
		self.overriddenAttrib[key] = value
	else
		self.attrib[key] = value
	end
end

function CSPM_PieMenuController:SetOnSelectionChangedCallback(callback)
	self.onSelectionChangedCallback = callback
end

function CSPM_PieMenuController:SetOnUpdateRotationFunction(callback)
	self.onUpdateRotationFunc = callback
end

function CSPM_PieMenuController:SetOnClearCallback(callback)
	self.onClearCallback = callback
end

function CSPM_PieMenuController:SetPopulateMenuCallback(callback)
	self.populateMenuCallback = callback
end

function CSPM_PieMenuController:OnGlobalKeyDown(key, ctrl, alt, shift, command)
	if self.bindings[key] then
		self.bindings[key](self, key, ctrl, alt, shift, command)
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
	self:SetAttribute("mouseDeltaScaleFactorInUIMode", scaleFactor)
end

function CSPM_PieMenuController:SetAllowActivateInUIMode(allowActivateInUIMode)
	self:SetAttribute("allowActivateInUIMode", allowActivateInUIMode)
end

function CSPM_PieMenuController:SetAllowClickable(allowClickable)
	self:SetAttribute("allowClickable", allowClickable)
end

function CSPM_PieMenuController:SetCenteringAtMouseCursor(centeringAtMouseCursor)
	self:SetAttribute("centeringAtMouseCursor", centeringAtMouseCursor)
end

function CSPM_PieMenuController:SetVirtualMousePositionToMousePosition()
	local centerX, centerY = GuiRoot:GetCenter()
	local x, y = GetUIMousePosition()
	self.menu:SetVirtualMousePosition(x - centerX, y - centerY)
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

function CSPM_PieMenuController:SetupPieMenuVisual(styleName, pieSize)
	local styleName = styleName or "quickslot"
	local pieStyle = PIE_MENU_STYLE[styleName] or PIE_MENU_STYLE["quickslot"]
	local pieSize = pieSize or 350
	if not pieStyle.size[pieSize] then pieSize = 350 end
	self.menuControl:SetDimensions(pieSize, pieSize)
	local textureSize = pieStyle.size[pieSize]
	if self.menu.selectedBackground then
		self.menu.selectedBackground:SetTexture(pieStyle.selected or BLANK_TEXTURE)
		self.menu.selectedBackground:SetDimensions(textureSize, textureSize)
	end
	if self.menu.unselectedBackground then
		self.menu.unselectedBackground:SetTexture(pieStyle.unselected or BLANK_TEXTURE)
		self.menu.unselectedBackground:SetDimensions(textureSize, textureSize)
	end
	if self.menu.track then
		self.menu.track:SetTexture(pieStyle.track or BLANK_TEXTURE)
		self.menu.track:SetDimensions(textureSize, textureSize)
	end
end

function CSPM_PieMenuController:SetupPieMenuPresetName(presetName, showPresetName)
	local presetName = presetName or ""
	self.menu.presetLabel:SetText(presetName)
	if showPresetName then
		self.menu.presetLabel:SetHidden(false)
	else
		self.menu.presetLabel:SetHidden(true)
	end
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

function CSPM_PieMenuController:IsInteracting()
	return self.isInteracting
end

function CSPM_PieMenuController:StartInteraction()
	if not self.isInteracting then
		if self:PrepareForInteraction() then
			self:ShowMenu()
			return true
		end
	end
end

function CSPM_PieMenuController:PrepareForInteraction()
--	LDL:Debug("PrepareForInteraction()")
	local currentScene = SCENE_MANAGER:GetCurrentScene()
	if not currentScene or currentScene:IsRemoteScene() then
		return false
	end
	if IsGameCameraActive() and IsGameCameraUIModeActive() and not self:GetAttribute("allowActivateInUIMode") then
		return false
	end
	return true
end

function CSPM_PieMenuController:ShowMenu(suppressSound)
	if self.menu:IsShown() then
		self.menu:Clear()
	end
	
	self.menu:ResetData()
	self.selectedEntry = nil
	self.previousSelectedEntry = nil

	local isUIMode = IsGameCameraActive() and IsGameCameraUIModeActive() or IsInteracting()
	if isUIMode then
		if self:GetAttribute("allowClickable") then
			self:SetActionLayer("CSPM_UI_Interceptor")
			self:ShowOverlay()
		else
			self:SetActionLayer("CSPM_Interceptor")
			self:HideOverlay()
		end
		self:ShowUnderlay()
	else
		if self:GetAttribute("allowClickable") then
			self:SetActionLayer("CSPM_HUD_Interceptor")
			self:ShowOverlay()
		else
			self:SetActionLayer("CSPM_Interceptor")
			self:HideOverlay()
		end
	end
	self:SetTopmost(true)

	self:PopulateMenu()
	self.menu:Show(suppressSound)

	if isUIMode then
		self.menu:SetMouseDeltaScaleFactor(self:GetAttribute("mouseDeltaScaleFactorInUIMode"))
		if self:GetAttribute("centeringAtMouseCursor") then
			self:SetAnchorToMousePosition()
		else
			self:SetAnchorToCenterPosition()
			self:SetVirtualMousePositionToMousePosition()
		end
	else
		self.menu:SetMouseDeltaScaleFactor(self:GetAttribute("mouseDeltaScaleFactorInHUDMode"))
		self:SetAnchorToCenterPosition()
	end

	self.isInteracting = true
	LockCameraRotation(true)
	RETICLE:RequestHidden(true)
end

function CSPM_PieMenuController:RefreshMenu(suppressSound)
	if not self.isInteracting then return end

	self.menu:ResetData()
	self.selectedEntry = nil
	self.previousSelectedEntry = nil

	local isUIMode = IsGameCameraActive() and IsGameCameraUIModeActive() or IsInteracting()

	self:PopulateMenu()
	self.menu:Refresh(suppressSound)

	if isUIMode then
		if self:GetAttribute("centeringAtMouseCursor") then
			self:SetAnchorToMousePosition()
		else
			self:SetVirtualMousePositionToMousePosition()
		end
	end
end

function CSPM_PieMenuController:PopulateMenu()
--	LDL:Debug("PopulateMenu()")
	if self.populateMenuCallback then
		self.populateMenuCallback(self)
	end
end

function CSPM_PieMenuController:StopInteraction(clearSelection)
	LDL:Debug("StopInteraction:")
	local wasShowing = self.isInteracting
	if self.isInteracting then
		self:HideUnderlay()
		self:ShowOverlay()
		self:SetTopmost(false)

		self.isInteracting = false
		LockCameraRotation(false)
		RETICLE:RequestHidden(false)
		if clearSelection then
			self.menu:ClearSelection()
		end
		self.menu:SelectCurrentEntryAndFinalize()
	end
	return wasShowing
end

function CSPM_PieMenuController:CancelInteraction()
	return self:StopInteraction(true)	-- true: clearSelection
end

function CSPM_PieMenuController:SelectCurrentEntry()
	local result = false
	if self.isInteracting then
		result = self.menu:SelectCurrentEntryAndContinueIfNeeded()
		if result ~= true then
			self:ForceExitInteraction()
		end
	end
end


function CSPM_PieMenuController:SetupEntryControl(entryControl, data)
	if not data then return end
--	LDL:Debug("SetupEntryControl(_, %s)", tostring(data.name))
	local iconDesaturation = data.disabled or false

	local slotLabel
	if data.showSlotLabel then
		if data.nameColor and type(data.nameColor) == "table" then
			slotLabel = { data.name, data.nameColor, }
		else
			slotLabel = data.name
		end
	else
		slotLabel = ""
	end

	CSPM_SetupSelectableItemRadialMenuEntryTemplate(entryControl, data.showGlow, data.itemCount, data.showIconFrame, slotLabel, iconDesaturation, data.resizeIconToFitFile)
	CSPM_SelectableItemRadialMenuEntryTemplate_UpdateIconAttributes(entryControl, data.iconAttributes)
	CSPM_SelectableItemRadialMenuEntryTemplate_UpdateStatus(entryControl, data.statusIcon)

	if data.cooldownRemaining and data.cooldownDuration then
		CSPM_SelectableItemRadialMenuEntryTemplate_UpdateCooldown(entryControl, data.cooldownRemaining, data.cooldownDuration)
	end
end

function CSPM_PieMenuController:OnSelectionChangedCallback(selectedEntry)
--	LDL:Debug("OnSelectionChangedCallback() : %s -> %s", self.previousSelectedEntry and self.previousSelectedEntry.data.index or "nil", selectedEntry and selectedEntry.data.index or "nil")
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

function CSPM_PieMenuController:OnClear()
--	LDL:Debug("OnClear() : ")
	if self.onClearCallback then
		self.onClearCallback(self)
	end
end

--Helper functions added to do a fail safe.
function CSPM_PieMenuController:ForceExitInteraction()
	if self.menu:IsShown() then
		self.menu:Clear()
	end
	self:HideUnderlay()
	self:ShowOverlay()
	self:SetTopmost(false)
	self.isInteracting = false
	LockCameraRotation(false)
	RETICLE:RequestHidden(false)

	local actionLayers = { "CSPM_Interceptor", "CSPM_HUD_Interceptor", "CSPM_UI_Interceptor", }
	for _, actionLayer in pairs(actionLayers) do
		if IsActionLayerActiveByName(actionLayer) then
			RemoveActionLayerByName(actionLayer)
		end
	end
end


-- ---------------------------------------------------------------------------------------
-- Pie Menu Action Layer Keybindings
-- ---------------------------------------------------------------------------------------
local ObsoleteActionNames = {
	"CSPM_KEY_MOUSE_LEFT", 
	"CSPM_KEY_MOUSE_LEFTRIGHT", 
	"CSPM_KEY_MOUSE_MIDDLE", 
	"CSPM_KEY_MOUSE_RIGHT", 
	"CSPM_KEY_MOUSEWHEEL_DOWN", 
	"CSPM_KEY_MOUSEWHEEL_UP", 
	"CSPM_KEY_MOUSE_4", 
	"CSPM_KEY_MOUSE_5", 
	"CSPM_KEY_GAMEPAD_BUTTON_1", 
	"CSPM_KEY_GAMEPAD_BUTTON_2", 
	"CSPM_KEY_GAMEPAD_BUTTON_3", 
	"CSPM_KEY_GAMEPAD_BUTTON_4", 
}
local CSPM_HUD_Interceptor_ActionNames = {
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
EVENT_MANAGER:RegisterForEvent("CSPM_PieMenuController", EVENT_ADD_ON_LOADED, function(_, addonName)
	if addonName ~= "CShortcutPieMenu" then return end
	EVENT_MANAGER:UnregisterForEvent("CSPM_PieMenuController", EVENT_ADD_ON_LOADED)

--  In previous versions, we had set key bindings for these actions, so we try to unbind to restore custom keybinds slots.
	for _, actionName in pairs(ObsoleteActionNames) do
		local layer, category, action = GetActionIndicesFromName(actionName)
		if layer and category and action then
			if IsProtectedFunction("UnbindAllKeysFromAction") then
				CallSecureProtected("UnbindAllKeysFromAction", layer, category, action)
			else
				UnbindAllKeysFromAction(layer, category, action)
			end
		end
	end

	for actionName, v in pairs(CSPM_HUD_Interceptor_ActionNames) do
		local layer, category, action = GetActionIndicesFromName(actionName)
		if layer and category and action then
			if IsProtectedFunction("UnbindAllKeysFromAction") then
				CallSecureProtected("UnbindAllKeysFromAction", layer, category, action)
			else
				UnbindAllKeysFromAction(layer, category, action)
			end
			CreateDefaultActionBind(actionName, v[1], v[2], v[3], v[4], v[5])
		end
	end
end)

CShortcutPieMenu:RegisterClassObject("PieMenu", CSPM_PieMenu)
CShortcutPieMenu:RegisterClassObject("PieMenuController", CSPM_PieMenuController)
