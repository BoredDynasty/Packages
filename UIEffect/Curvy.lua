--[=[
	@class Curvy
--]=]
local Curvy = {}
Curvy.__index = Curvy

-- Da Dubious Dynasty

-- This is unfinished

local TweenService = game:GetService("TweenService")

export type properties = {
	[string]: any,
}

function Curvy.new()
	local self = setmetatable({}, Curvy)

	self.Objects = {}
	self.Curves = {} :: { Tween }
	self.Properties = {} :: properties

	return self
end

local function createCurve(object: any, info: TweenInfo, property: string, target: any): Tween
	return TweenService:Create(object, info, { [property] = target })
end

function Curvy:Curve(object: Instance, info, property, target): Tween
	local curve: Tween = nil
	if not self.Curves[1] then
		if not info then
			info = TweenInfo.new(0.5)
		end
		curve = task.defer(createCurve, object, info, property, target) :: Tween
		for key, value in pairs(object) do
			self.Properties[key] = value
		end
		curve:Play()
		table.insert(self.Curves, 1, curve)
	end
	return curve
end

function Curvy:Reverse(object: Instance): properties
	for property, propertyValue in self.Properties do
		if object[property] then
			object[property] = propertyValue
		end
	end
	return self.Properties
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
