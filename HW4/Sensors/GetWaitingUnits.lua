local sensorInfo = {
	name = "GetFreeTransports",
	desc = "Returns a list of free transporters.",
	author = "Kahlan",
	date = "2021-08-05",
	license = "none",
}

local EVAL_PERIOD_DEFAULT = 0 -- acutal, no caching

function getInfo()
	return {
		period = EVAL_PERIOD_DEFAULT 
	}
end

-- @description returns a list of free transporters
return function(orderedUnits, units)
	local waitingUnits = {}
	for _, unit in pairs(orderedUnits) do
		if units[unit] == "waiting" then
			table.insert(waitingUnits, unit)
		end
	end

	return waitingUnits
end