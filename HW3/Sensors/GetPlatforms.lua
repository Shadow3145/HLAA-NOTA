local sensorInfo = {
	name = "GetPlatforms",
	desc = "Returns list of positions (Vec3) of platforms.",
	author = "Kahlan",
	date = "2021-07-21",
	license = "none",
}

local EVAL_PERIOD_DEFAULT = 0 -- acutal, no caching

function getInfo()
	return {
		period = EVAL_PERIOD_DEFAULT 
	}
end

function getHill(coord, areaHeight)
	local height = areaHeight
	local left = getExtreme(coord.x, 0, -1, coord, height)
	local right = getExtreme(coord.x, Game.mapSizeX, 1, coord, height)
	local top = getExtreme(coord.z, 0, -1, coord, height)
	local bottom = getExtreme(coord.z, Game.mapSizeZ, 1, coord, height)

	return {{x = left, z = top}, {x = right, z = bottom}}
end

function getExtreme(start, stop, step, coord, h)
	for i = start, stop, step do
		if coord.x == start then
			if Spring.GetGroundHeight(i, coord.z) ~= h then
				return i - step
			end
		else
			if Spring.GetGroundHeight(coord.x, i) ~= h then
				return i - step
			end
		end
	end
end

-- @description returns platforms with given height
return function(missionInfo)
	local platforms = {}
	local height = missionInfo.areaHeight
	local enemies = missionInfo.enemyPositions
	local step = 10
	local platformBoxes = {}

	-- Find platforms
	for x = 0, Game.mapSizeX, step do
		for z = 0, Game.mapSizeZ, step do
			if height == Spring.GetGroundHeight(x, z) then
				local n = true
				-- Don't calculate box for already found platform
				for _, platform in ipairs(platformBoxes) do
					if x >= platform[1].x and x <= platform[2].x and z >= platform[1].z and z <= platform[2].z then
						n = false
						break
					end
				end

				if n == true then
					local platform = getHill({x = x, z = z}, height)
					table.insert(platformBoxes, platform)
				end
			end
		end
	end

	-- Return middle position of platforms that are safe (no enemies nearby)
	for _, box in ipairs(platformBoxes) do
		x = (box[1].x + box[2].x)/2
		z = (box[1].z + box[2].z)/2

		-- Exclude platforms with enemies nearby
		local safe = true
		local radius = 350

		for _, enemyLoc in ipairs(enemies) do
			if math.abs(x - enemyLoc.x) <= radius and math.abs(z - enemyLoc.z) <= radius then
				safe = false
				break
			end
		end

		if safe == true then
			table.insert(platforms, Vec3(x, height, z))
		end
	end

	return platforms
end

