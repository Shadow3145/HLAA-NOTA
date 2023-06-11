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
			}
		}
	}
end

function Run(self, units, parameter)
	local position = parameter.position -- Vec3
	local unit = parameter.unit -- UnitID


	if not Spring.ValidUnitID(parameter.unit) then
		return FAILURE
	end


	local x,y,z = Spring.GetUnitPosition(unit)
	local error = 20

	if math.abs(position.x - x) < error and math.abs(position.z - z) < error and position.y == y then
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

