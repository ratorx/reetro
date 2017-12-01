local bullet_handler = require "bullet"
require "collision"
local mathFunc = require "mathFunc"
local physics = require "physics"

function love.load()
  love.graphics.setFont(love.graphics.newFont("assets/fonts/DejaVuSansMono.ttf", 36))
  
  level = {}
  level.char = "z"
  level.text = love.graphics.newText(love.graphics.getFont(), level.char)
  level.base = love.graphics.getHeight() - love.graphics.getFont():getHeight(level.char) * 1.5
  level.grav = love.graphics.getFont():getHeight(level.char) * 30 --one sec to fall

  player = {}
  player.char = "("
  player.text = love.graphics.newText(love.graphics.getFont(), player.char)
  player.x = 0
  player.y = 0
  player.w = love.graphics.getFont():getWidth(player.char)
  player.h = love.graphics.getFont():getHeight(player.char)

  player.vx = 0
  player.vy = 0

  player.speed = 20
end

function love.update(dt)
  local x = player.x
  local y = player.y
  
  -- if love.keyboard.isDown("right") then
  --   player.x = player.x + 5
  -- elseif love.keyboard.isDown("down") then
  --   player.y = player.y + 5
  -- elseif love.keyboard.isDown("left") then
  --   player.x = player.x - 5
  -- elseif love.keyboard.isDown("up") then
  --   player.y = player.y - 5
  -- end

  -- Player
  player.x = physics.updatePos(dt, player.vx, player.x)
  player.y = physics.updatePos(dt, player.vy, player.y)

  player.vy = physics.updateVel(dt, level.grav, player.vy)
  
  --Collision Detection
  if AABB(player.x, player.y, player.w, player.h, 0, level.base, love.graphics.getWidth(), 0) then
    -- player.x = x
    player.y = y
  end
  
  bullet_handler.update(dt)
end

function love.keypressed(key)
  if key == "right" then
    player.vx = player.w * player.speed
  elseif key == "left" then
    player.vx = - player.w * player.speed
  end

  if key == "up" then
    player.vy = -player.h * 10
  end

  bullet_handler.keypressed(key)
end

function love.keyreleased(key)
  if key == "left" or key == "right" then
    player.vx = 0
  end
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
