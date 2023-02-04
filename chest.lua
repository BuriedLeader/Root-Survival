chest = {img = love.graphics.newImage("assets/chest/teste.jpg")}

require("items")

active_chests = {}

function chest.create(x,y,item)

    new_chest = {
        x = x,
        y = y,
        item = item
    }

    new_chest.body = love.physics.newBody(world,new_chest.x,new_chest.y,'kinematic')
    new_chest.shape = love.physics.newCircleShape(radius)
    new_chest.fixture = love.physics.newFixture(new_chest.body,new_chest.shape,1)
    new_chest.fixture:setFriction(0)
    new_chest.fixture:setUserData("chest")
    new_chest.body:setFixedRotation(true)

    table.insert(active_chests,new_chest)


end

function chest.load()
    
end

function chest.draw()
    
end

function chest.beginContact(a,b,collision)
    
end

return chest