local bullet_handler = require "bullet"
require "collision"
local mathFunc = require "mathFunc"
local physics = require "physics"
local dust_handler = require "dust"
local power_handler = require "powertype"

function love.load()
  WIDTH, HEIGHT = love.graphics.getWidth(), love.graphics.getHeight()
  
  love.graphics.setFont(love.graphics.newFont("assets/fonts/DejaVuSansMono.ttf", 36))
  
  level = {}
  level.char = "z"
  level.text = love.graphics.newText(love.graphics.getFont(), level.char)
  level.base = HEIGHT - love.graphics.getFont():getHeight(level.char) * 1.5
  level.grav = love.graphics.getFont():getHeight(level.char) * 30 --one sec to fall

  player = {}
  player.char = "("
  player.text = love.graphics.newText(love.graphics.getFont(), player.char)
  player.x = 0
  player.y = HEIGHT-100
  player.w = love.graphics.getFont():getWidth(player.char)
  player.h = love.graphics.getFont():getHeight(player.char)

  player.vx = 0
  player.vy = 0

  player.speed = 20
end

function love.update(dt)
  local x = player.x
  local y = player.y

  -- Player
  player.x = physics.updatePos(dt, player.vx, player.x)
  player.y = physics.updatePos(dt, player.vy, player.y)

  player.vy = physics.updateVel(dt, level.grav, player.vy)
  
  --Collision Detection
  if AABB(player.x, player.y, player.w, player.h, 0, level.base, WIDTH, 0) then
    -- player.x = x
    player.y = y
  end
  
  power_handler.update(dt)
  bullet_handler.update(dt)
  dust_handler.update(dt)
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
  
  power_handler.keypressed(key)
  bullet_handler.keypressed(key)
end

function love.keyreleased(key)
  if key == "left" or key == "right" then
    player.vx = 0
  end
  bullet_handler.keyreleased(key)
end

function love.draw()
  dust_handler.draw()
  
  love.graphics.setColor(255, 255, 255)
  love.graphics.draw(player.text, player.x, player.y)
  for i = 0, WIDTH, love.graphics.getFont():getWidth(level.char) do
    love.graphics.draw(level.text, i, level.base)
  end
  
  power_handler.draw()
  bullet_handler.draw()
end
