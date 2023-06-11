local sensorInfo = {
	name = "GetFormation",
	desc = "Returns a list of Vec3(0,0,0) of the length corresponding to the length of the given group.",
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

-- @description returns a list of Vec3(0,0,0) of the length corresponding to the length of the given group.
return function(units)
	local formation = {}

	for index, _ in ipairs(units) do
		formation[index] = Vec3(0,0,0)
	end

	return formation
end