local sensorInfo = {
	name = "GetGroupDefinition",
	desc = "Returns a group definition of given list of units.",
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

-- @description returns a group definition of given list of units
return function(units)
	local groupDefinition = {}

	for index, value in ipairs(units) do
		groupDefinition[value] = index
	end

	return groupDefinition
end