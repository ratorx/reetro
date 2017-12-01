require "collision"

function love.load()
  player = {}
  player.image = love.graphics.newImage("assets/images/main_character.png")
  player.x = 0
  player.y = 0
  player.w = 10
  player.h = 200
  
  font = love.graphics.newFont("assets/fonts/UbuntuMono-R.ttf", 36)
end

function love.update(dt)
  local x = player.x
  local y = player.y
  
  -- Player
  if love.keyboard.isDown("right") then
    player.x = player.x + 5
  elseif love.keyboard.isDown("down") then
    player.y = player.y + 5
  elseif love.keyboard.isDown("left") then
    player.x = player.x - 5
  elseif love.keyboard.isDown("up") then
    player.y = player.y - 5
  end
  
  --Collision Detection
  if AABB(player.x, player.y, player.w, player.h, 0, love.graphics.getHeight(), love.graphics.getWidth(), 0) then
    player.x = x
    player.y = y
  end
end

function love.draw()
  love.graphics.draw(player.image, player.x, player.y)
end
