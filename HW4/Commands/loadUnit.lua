function getInfo()
	return {
		onNoUnits = SUCCESS, -- instant success
		tooltip = "Load given unit",
		parameterDefs = {
			{ 
				name = "transporter",
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
	local transporter = parameter.transporter -- UnitID
	local unit = parameter.unit -- UnitID


	if not Spring.ValidUnitID(unit) or not Spring.ValidUnitID(transporter) then
		return FAILURE
	end

	if Spring.GetUnitTransporter(unit) ~= nil then
		return SUCCESS
	end

	if not self.init then
		Spring.GiveOrderToUnit(transporter, CMD.LOAD_UNITS, {unit}, {"shift"})
		self.init = true
	end

	return RUNNING
end

function Reset(self)
	self.init = false
end

