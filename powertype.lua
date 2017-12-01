
function power_load()
  stringLength = 6
  maxTime = 6 --seconds
  
  midPowerType = false
  elapsedTime = 0
  randomString = ""
  typedIndex = 1
end

function power_update(dt)
  if midPowerType then
    elapsedTime = elapsedTime + dt
    if elapsedTime >= maxTime then
      midPowerType = false
      elapsedTime = 0
    end
  end
  
  if love.keyboard.isDown("space") then
    if not midPowerType then
      midPowerType = true
      s = ""
      for i = 1, stringLength do
        s = s .. string.char(math.random(97, 122))
      end
      randomString = s
      typedIndex = 1
    end
  end
end

function power_keypressed(key)
  if key == string.sub(randomString, typedIndex, typedIndex) then
    typedIndex = typedIndex + 1
  else
    midPowerType = false
    elapsedTime = 0
  end
end

function power_draw()
  if midPowerType then
    love.graphics.setColor(255, 255, 255)
    love.graphics.print(randomString, love.graphics.getWidth()/2-50, love.graphics.getHeight()/2-10)
    love.graphics.print("score: " .. typedIndex-1, 100, 10)
  end
end



