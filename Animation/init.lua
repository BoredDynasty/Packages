--!nonstrict

-- Animation.lua

--[=[
    @module Animation
    This module is used for animating objects in a appealing way.
--]=]
local Animation = {}

-- // Services
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

-- // Util
local TweenTable = {}
local RunServiceEvents = {}

--[=[
    @function Animation.upgradeRotation
        Makes a nice animation for rotating an object.
--]=]
function Animation.upgradeRotation(object: BasePart, targetRotationSpeed: number, stopRotation: boolean)
	if not object:FindFirstChild("RotationSpeed") then
		local rotationSpeed = Instance.new("NumberValue")
		rotationSpeed.Name = "RotationSpeed"
		rotationSpeed.Value = targetRotationSpeed
		rotationSpeed.Parent = object
	end
	local rotationSpeed = object:FindFirstChild("RotationSpeed")
	if stopRotation then
		if RunServiceEvents[object] then
			RunServiceEvents[object]:Disconnect()
			RunServiceEvents[object] = nil
		end
		if TweenTable[object] then
			TweenTable[object]:Cancel()
			TweenTable[object] = nil
		end
		if rotationSpeed then
			rotationSpeed.Value = 0
		end
	else
		local TInfo = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
		local tween = TweenService:Create(rotationSpeed, TInfo, { Value = targetRotationSpeed })
		TweenTable[object] = tween
		tween:Play()

		local initCFrame = object.CFrame
		local Angles = 0
		local yAxis = 0

		if not RunServiceEvents[object] then
			RunServiceEvents[object] = RunService.RenderStepped:Connect(function()
				if rotationSpeed.Value ~= 0 then
					Angles = Angles + rotationSpeed.Value
					yAxis = yAxis + rotationSpeed.Value
					object.CFrame = initCFrame * CFrame.Angles(0, math.rad(yAxis), 0)
				end
			end)
		end
	end
end

return Animation
