local sensorInfo = {
	name = "InitUnitReservationList",
	desc = "Initializes a list indexed by transporters unit IDs.",
	author = "Kahlan",
	date = "2021-08-02",
	license = "none",
}

local EVAL_PERIOD_DEFAULT = 0 -- acutal, no caching

function getInfo()
	return {
		period = EVAL_PERIOD_DEFAULT 
	}
end

-- @description returns an initialized reservation list indexed by transporters UnitIDs
return function(units)
	local transportReservation = {}

	for _, unit in ipairs(units) do
		transportReservation[unit] = "free"
	end
		
	return transportReservation
end