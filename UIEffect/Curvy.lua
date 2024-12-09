--[=[
	@class Curvy
--]=]
local Curvy = {}
Curvy.__index = Curvy

-- Da Dubious Dynasty

-- This is unfinished

local TweenService = game:GetService("TweenService")

type image = ImageLabel | ImageButton
type object = GuiObject

local function createCurve(object: any, info: TweenInfo, property: string, target: any): Tween
	return TweenService:Create(object, info, { [property] = target })
end

function Curvy.new()
	local self = setmetatable({}, Curvy)

	self.Objects = {}
	self.Curves = {}

	return self
end

function Curvy:Curve(object, info, property, target): Tween
	if not info then
		info = TweenInfo.new(0.5)
	end
	local tween = createCurve(object, info, property, target)
	tween:Play()
	return tween
end

function Curvy.TweenInfo(seconds, style, direction, repeatCount, reverses, delayTime)
	return TweenInfo.new(
		seconds,
		Enum.EasingStyle[style],
		Enum.EasingDirection[direction],
		repeatCount,
		reverses,
		delayTime
	)
end

return Curvy
