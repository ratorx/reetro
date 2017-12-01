local M = {}

local WIDTH, HEIGHT = love.graphics.getWidth(), love.graphics.getHeight()
local SPAWN_CHANCE = 0.03
local CHARS = {"a", "i", "d", "e", "n"}

local particles = {}

local function update(dt)
  for i = #particles, 1, -1 do
    local particle = particles[i]
    if particle.x > love.graphics.getWidth() then
      table.remove(particles, i)
    end
  end
  
  for i = #particles, 1, -1 do
    local particle = particles[i]
    particle.x = particle.x + particle.velocity
    particle.rotation = particle.rotation + particle.rotation_velocity * dt
  end
  
  if math.random() < SPAWN_CHANCE then
    local particle = {}
    particle.x = 0
    particle.y = math.random(HEIGHT)
    particle.alpha = math.random(100, 250)
    particle.rotation = math.random(math.pi)
    particle.char = CHARS[math.random(#CHARS)]
    particle.velocity = math.random(5, 15)
    particle.rotation_velocity = math.random(math.pi/16, math.pi)
    table.insert(particles, particle)
  end
end
M.update = update

local function draw()
  for i = #particles, 1, -1 do
    local particle = particles[i]
    love.graphics.setColor(255, 255, 255, particle.alpha)
    love.graphics.push()
    love.graphics.translate(particle.x, particle.y)
	  love.graphics.rotate(particle.rotation)
    love.graphics.print(particle.char, 0, 0)
    love.graphics.pop()
  end
end
M.draw = draw

return M