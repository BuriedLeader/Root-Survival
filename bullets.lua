Bullets = {}

-- bullets from player on mouse direction

function Bullets:new(pX,pY,mouseX,mouseY,pLen)
    local bullets = {}
    bullets.x = pX + 2*pLen*math.cos(math.atan2(mouseY - pY, mouseX - pX))
    bullets.y = pY + 2*pLen*math.sin(math.atan2(mouseY - pY, mouseX - pX))

    local angle = math.atan2(mouseY - pY, mouseX - pX)
    bullets.speed = 500
    bullets.vx = math.cos(angle) * bullets.speed
    bullets.vy = math.sin(angle) * bullets.speed

    bullets.body = love.physics.newBody(world, bullets.x, bullets.y, "dynamic")
    bullets.shape = love.physics.newCircleShape(5)
    bullets.fixture = love.physics.newFixture(bullets.body, bullets.shape, 1)
    bullets.fixture:setUserData("bullet")

    bullets.body:setLinearVelocity(bullets.vx, bullets.vy)

    table.insert(self, bullets)
end

function Bullets:update(dt,player)
    for i=#self,1,-1 do
        local destruir = false
        local v = self[i]
        v.x, v.y = v.body:getPosition()
        -- if colider on bullet then remove bullet
        contacts = v.body:getContacts( )
        if contacts then
            for j,contact in ipairs(contacts) do
                if contact:getFixtures():getUserData() == "colider" or contact:getFixtures():getUserData() == "chest" then
                    destruir = true
                    break
                end
                if contact:getFixtures():getUserData() == "enemy" then
                    local x,y = contact:getFixtures():getBody():getPosition()
                    for i,enemy in ipairs(active_enemies) do
                        local ex,ey = enemy.body:getPosition()
                        if ex == x and ey == y then
                            -- delete body
                            enemy.hp = enemy.hp - player.current_damage
                            if enemy.hp <= 0 then
                                enemy.body:destroy()
                                love.audio.play(Sounds.enemy)
                                table.remove(active_enemies, i)
                                player.score = player.score + scores[enemy.type]
                                destruir = true
                                break
                            end
                        end
                    end
                end
            end
        end
        if destruir then
            v.body:destroy()
            table.remove(self, i)
        end

    end
end

function Bullets:draw()
    for i,v in ipairs(self) do
        love.graphics.circle("fill", v.x+15, v.y, v.shape:getRadius())
    end
end