function love.load()
  player = {}
  player.image = love.graphics.newImage("assets/images/main_character.png")
  player.x = 0
  player.y = 0
  
  font = love.graphics.newFont("assets/fonts/UbuntuMono-R.ttf", 36)
end

function love.update(dt)
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
end

function love.draw()
  love.graphics.draw(player.image, player.x, player.y)
end
