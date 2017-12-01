local M = {}

local function clamp(lower, upper, x)
	if x < lower then 
		return lower
	elseif x > upper then 
		return upper
	else 
		return x
	end
end
M.clamp = clamp

return M