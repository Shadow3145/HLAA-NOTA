local sensorInfo = {
	name = "UpdateTransportList",
	desc = "Updates states of transports in the list indexed by UnitIDs",
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


function isDead(transport)
	return not Spring.GetUnitIsDead(transport) == false
end

function isOccupied(transport, transports)
	return transports[transport] == "occupied"
end

-- @description returns updated reservation list of transports
return function(transports)
	local transportReservation = {}
	for transport, state in pairs(transports) do
		if isDead(transport) == true then
			transportReservation[transport] = "dead"
		elseif isOccupied(transport, transports) == true then
			transportReservation[transport] = "occupied"
		else
			transportReservation[transport] = "free"
		end
	end

	return transportReservation
end