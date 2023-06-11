local sensorInfo = {
	name = "GetUnitPosition",
	desc = "Returns a Vec3 position of given unit.",
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

-- @description returns a Vec3 position of given unit.
return function(unit)
	local x, y, z = Spring.GetUnitPosition(unit)

	return Vec3(x, y, z)
end