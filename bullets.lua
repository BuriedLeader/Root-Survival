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

function Bullets:update(dt)
    for i=#self,1,-1 do
        local v = self[i]
        v.x, v.y = v.body:getPosition()
        -- if colider on bullet then remove bullet
        contacts = v.body:getContacts( )
        if contacts then
            for i,contact in ipairs(contacts) do
                if contact:getFixtures():getUserData() == "colider" then
                    table.remove(self, i)
                end
            end
        end

    end
end

function Bullets:draw()
    for i,v in ipairs(self) do
        love.graphics.circle("fill", v.x, v.y, v.shape:getRadius())
    end
end