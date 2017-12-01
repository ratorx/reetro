require "collision"
local bullet_handler = require "bullet"

function love.load()
  love.graphics.setFont(love.graphics.newFont("assets/fonts/DejaVuSansMono.ttf", 36))
  
  level = {}
  level.char = "z"
  level.text = love.graphics.newText(love.graphics.getFont(), level.char)
  level.base = love.graphics.getHeight() - love.graphics.getFont():getHeight(level.char) * 1.5
  
  player = {}
  player.char = "("
  player.text = love.graphics.newText(love.graphics.getFont(), player.char)
  player.x = 0
  player.y = 0
  player.w = love.graphics.getFont():getWidth(level.char)
  player.h = love.graphics.getFont():getHeight(level.char)
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
  if AABB(player.x, player.y, player.w, player.h, 0, level.base, love.graphics.getWidth(), 0) then
    player.x = x
    player.y = y
  end
  
  bullet_handler.update(dt)
end

function love.keypressed(key)
  bullet_handler.keypressed(key)
end

function love.keyreleased(key)
  bullet_handler.keyreleased(key)
end

function love.draw()
  love.graphics.draw(player.text, player.x, player.y)
  local width = love.graphics.getWidth()
  for i = 0, love.graphics.getWidth(), love.graphics.getFont():getWidth(level.char) do
    love.graphics.draw(level.text, i, level.base)
  end
  
  bullet_handler.draw()
end
