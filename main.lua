local bullet_handler = require "bullet"
require "collision"
local mathFunc = require "mathFunc"
local physics = require "physics"
local dust_handler = require "dust"
require "mathlib"

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
  player.x = 1
  player.y = 1
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
  
  -- --Collision Detection
  -- if AABB(player.x, player.y, player.w, player.h, 0, level.base, love.graphics.getWidth(), 0) then
  --   -- player.x = x
  --   player.y = y
  -- end

  if math.doLinesIntersect({x=x, y=y}, {x=player.x, y=player.y}, {x=0, y=level.base}, {x=love.graphics.getWidth(), y=level.base}) then
    player.y = y
  end

  if math.doLinesIntersect(point(x,y), point(player.x, player.y), point(0, 0), point(love.graphics.getWidth(), 0)) then--upper side
    player.y = y
  end

  if math.doLinesIntersect(point(x,y), point(player.x, player.y), point(0, 0), point(0, love.graphics.getHeight())) then --left hand side
    player.x = x
  end

  if math.doLinesIntersect(point(x,y), point(player.x, player.y), point(love.graphics.getWidth(), 0), point(love.graphics.getWidth(), love.graphics.getHeight())) then --left hand side
    player.x = x
  end
  
  bullet_handler.update(dt)
  dust_handler.update(dt)
end

function checkCollisionWithLevel(level, init, curr)
  interHori = false
  interVert = false 
  matrix = level.matrix
  for j=1,level.height do
    for i=1,level.width do
      if not (matrix[i][j] == " " or matrix[i][j] == nil) then
        x = (i-1) * level.charWidth
        y = (j-1) * level.charHeight
        w = level.charWidth
        h = level.charHeight

        intersections = math.polygonLineIntersection(
            {x,y, x+w,y, x+w,y+h, x,y+h, x,y},
            init, curr, false)

        for idx=1, #intersections, 1 do
          if intersections[idx].lineIndex == 1 then
            interHori = true
          elseif intersections[idx] == 2 then 
            interVert = true
          elseif intersections[idx] == 3 then
            interHori = true
          elseif intersections[idx] == 4 then
            interVert = true
          end
        end
      end
    end
  end
  return {x= if interVert then init.x else curr.x, y= if interHori then init.y, else curr.y}

end

function point(x, y)
  return {x=x, y=y}
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
  dust_handler.draw()
  
  love.graphics.setColor(255, 255, 255)
  love.graphics.draw(player.text, player.x, player.y)
  local width = love.graphics.getWidth()
  for i = 0, love.graphics.getWidth(), love.graphics.getFont():getWidth(level.char) do
    love.graphics.draw(level.text, i, level.base)
  end
  
  bullet_handler.draw()
end
