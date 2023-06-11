local sensorInfo = {
	name = "InitUnitReservationList",
	desc = "Initializes a list indexed by unit IDs.",
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

-- @description returns an initialized reservation list indexed by UnitIDs
return function(units)
	local unitsReservation = {}

	for _, unit in ipairs(units) do
		unitsReservation[unit] = "waiting"
	end

	return unitsReservation
end