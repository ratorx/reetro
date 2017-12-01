function bullet_load()
  bullets = {}
  
  score = 0
end

function bullet_update(dt)
  if love.keyboard.isDown("space") then
    score = score + 1
    local bullet = {}
    bullet.x = 0
    bullet.y = 0
    bullet.v = 5
    table.insert(bullets, bullet)
  end
  
  for i = #bullets, 1, -1 do
    local bullet = bullets[i]
    bullet.x = bullet.x + 5
  end
end

function bullet_draw()
  love.graphics.setColor(255, 255, 255)
  for i = #bullets, 1, -1 do
    local bullet = bullets[i]
    love.graphics.rectangle("fill", bullet.x, bullet.y, 10, 10)
  end
  love.graphics.print("score: " .. score, 10, 10)
end