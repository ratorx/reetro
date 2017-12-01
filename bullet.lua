local M = {}

local VELOCITY = 5
local CHAR = "♆"

local bullets = {}
local isShooting = false

local function update(dt)
  for i = #bullets, 1, -1 do
    local bullet = bullets[i]
    bullet.x = bullet.x + VELOCITY
  end
end
M.update = update

local function keypressed(key)  
  if key == "space" then
    if not isShooting then
      local bullet = {}
      bullet.x = 0
      bullet.y = 0
      table.insert(bullets, bullet)
    end
    isShooting = true
  end
end
M.keypressed = keypressed

local function keyreleased(key)
  if key == "space" then
    isShooting = false
  end
end
M.keyreleased = keyreleased

local function draw()
  love.graphics.setColor(255, 255, 255)
  for i = #bullets, 1, -1 do
    local bullet = bullets[i]
    love.graphics.print(CHAR, bullet.x, bullet.y)
  end
end
M.draw = draw

return M