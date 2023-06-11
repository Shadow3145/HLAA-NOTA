local sensorInfo = {
	name = "UpdateUnitList",
	desc = "Updates states of units in the list indexed by UnitIDs",
	author = "Kahlan",
	date = "2021-08-03",
	license = "none",
}

local EVAL_PERIOD_DEFAULT = 0 -- acutal, no caching

function getInfo()
	return {
		period = EVAL_PERIOD_DEFAULT 
	}
end


function isDead(unit)
	return not Spring.GetUnitIsDead(unit) == false
end

function isSaved(unit)
	local x, y, z = Spring.GetUnitPosition(unit)
	local safeArea = Sensors.core.MissionInfo()
	local center = safeArea.safeArea.center
	local radius = safeArea.safeArea.radius

	return math.abs(x - center.x) < radius and math.abs(z - center.z) < radius
end

function isBeingRescued(unit, units)
	return units[unit] == "beingRescued"
end

-- @description returns updated reservation list of units
return function(units)
	local unitsReservation = {}
	for unit, state in pairs(units) do
		if isDead(unit) == true then
			unitsReservation[unit] = "dead"
		elseif isSaved(unit) == true then
			unitsReservation[unit] = "saved"
		elseif isBeingRescued(unit, units) == true then
			unitsReservation[unit] = "beingRescued"
		else
			unitsReservation[unit] = "waiting"
		end
	end

	return unitsReservation
end