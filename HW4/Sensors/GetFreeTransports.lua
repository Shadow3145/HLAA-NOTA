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
return function(transports)
	local freeTransports = {}
	for transport, state in pairs(transports) do
		if state == "free" then
			table.insert(freeTransports, transport)
		end
	end

	return freeTransports
end