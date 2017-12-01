local M = {}

local STRING_LENGTH = 6
local MAX_TIME = 6 --seconds
  
local mid_power = false
local elapsed_time = 0
local rand_string = ""
local typed_index = 1

function update(dt)
  if mid_power then
    elapsed_time = elapsed_time + dt
    if elapsed_time >= MAX_TIME then
      mid_power = false
      elapsed_time = 0
    end
  end
  
  if love.keyboard.isDown("t") then
    if not mid_power then
      mid_power = true
      s = ""
      for i = 1, STRING_LENGTH do
        s = s .. string.char(math.random(97, 122))
      end
      rand_string = s
      typed_index = 1
    end
  end
end
M.update = update

function keypressed(key)
  if key == string.sub(rand_string, typed_index, typed_index) then
    typed_index = typed_index + 1
  else
    mid_power = false
    elapsed_time = 0
  end
end
M.keypressed = keypressed

function draw()
  if mid_power then
    love.graphics.setColor(255, 255, 255)
    love.graphics.print(rand_string, love.graphics.getWidth()/2-50, love.graphics.getHeight()/2-10)
  end
end
M.draw = draw

return M