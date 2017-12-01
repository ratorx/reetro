local M = {}
 
local function testFunction()
      print("Test function called")
end
M.testFunction = testFunction

local function updatePos(dt, v, s)
	return s + v * dt
end
M.updatePos = updatePos

local function updateVel(dt, a, v)
	return v + dt * a
end
M.updateVel = updateVel

return M