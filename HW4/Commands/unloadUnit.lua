function getInfo()
	return {
		onNoUnits = SUCCESS, -- instant success
		tooltip = "Unload given unit",
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
	local safeArea = Sensors.core.MissionInfo()


	if not Spring.ValidUnitID(unit) or not Spring.ValidUnitID(transporter) then
		return FAILURE
	end

	if Spring.GetUnitTransporter(unit) == nil then
		return SUCCESS
	end

	if not self.init then
		Spring.GiveOrderToUnit(transporter, CMD.UNLOAD_UNITS,
				{safeArea.safeArea.center.x, safeArea.safeArea.center.y, safeArea.safeArea.center.z,
				 safeArea.safeArea.radius}, {"shift"})
		self.init = true
	end

	return RUNNING
end

function Reset(self)
	self.init = false
end

