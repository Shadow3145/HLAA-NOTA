function getInfo()
	return {
		onNoUnits = SUCCESS, -- instant success
		tooltip = "Move unit to defined position",
		parameterDefs = {
			{ 
				name = "position",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "",
			},
			{ 
				name = "unit",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "",
			},
			{
				name = "radius",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = 20,
			}
		}
	}
end

function Run(self, units, parameter)
	local position = parameter.position -- Vec3
	local unit = parameter.unit -- UnitID
	local radius = parameter.radius


	if not Spring.ValidUnitID(unit) then
		return FAILURE
	end

	local x,y,z = Spring.GetUnitPosition(unit)

	if math.abs(position.x - x) < radius and math.abs(position.z - z) < radius then
		return SUCCESS
	end

	if not self.init then
		Spring.GiveOrderToUnit(unit, CMD.MOVE, {position.x, position.y, position.z}, {"shift"})
		self.init = true
	end

	return RUNNING
end

function Reset(self)
	self.init = false
end

