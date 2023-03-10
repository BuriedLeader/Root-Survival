require 'chest'
--require 'buffs'
Waves = {
    {lettuce=1},
    {onions=1},
    {lettuce=1,onions=2},
    {lettuce=5,onions=5,pumpkin=1},
    {onions=1,lettuce=1,pumpkin=1},
    {lettuce=5,pumpkin=1},
    {onions=5,pumpkin=1},
    {lettuce=5,onions=5,pumpkin=1},
    {lettuce=1,onions=1,pumpkin=5},
}
function waveProp(wave)
    local prob = {}
    local sum = 0
    for key, value in pairs(wave) do
        sum = sum +value 
        prob[key] =  sum
    end

    for key, value in pairs(prob) do
        prob[key] = prob[key] / sum
    end
    return prob
end
storeTimer = 1
stroeTImerStandart = 1
difficult = 1

WavesCount = {
    {Count = 5,time=100,timerMin=0.001,timerMax=0.9,timer = 0},
    {Count = 5,time=100,timerMin=0.001,timerMax=0.9,timer = 0},
    {Count = 10,time=100,timerMin=0.001,timerMax=0.9,timer = 0},
    {Count = 10,time=100,timerMin=0.001,timerMax=0.8,timer = 0},
    {Count = 10,time=100,timerMin=0.001,timerMax=0.8,timer = 0},
    {Count = 20,time=100,timerMin=0.001,timerMax=0.8,timer = 0},
    {Count = 20,time=100,timerMin=0.001,timerMax=0.7,timer = 0},
    {Count = 30,time=100,timerMin=0.001,timerMax=0.7,timer = 0},
    {Count = 30,time=100,timerMin=0.001,timerMax=0.7,timer = 0},
}

for i = 1, #WavesCount do
    WavesCount[i].Reset = WavesCount[i].Count
end

waveNumber = 1

function WavesCount:Spawn(Enemy,Map,dt)
    if self[waveNumber].Count > 0 and self[waveNumber].timer <= self[waveNumber].timerMin then
        local coords = Map:spawns()
        local x = love.math.random(coords.x, coords.x + coords.w)
        local y = love.math.random(coords.y, coords.y + coords.h)

        probs = waveProp(Waves[waveNumber])

        n = love.math.random()
        local type
    
        local old_prob = 0
        for key, values in pairs(probs) do
            if old_prob < n and n < values then
                type = key
                break
            end
            old_prob = values
        end
        Enemy.create(x,y,waveNumber,type)
        self[waveNumber].Count = self[waveNumber].Count - 1
        self[waveNumber].timer = self[waveNumber].timerMax

    elseif self[waveNumber].Count <= 0 and #active_enemies == 0 then
        if love.keyboard.isDown("space") then
            waveTimer = waveTimer - 0.25
        end
        if storeTimer > 0 then
            if storeTimer == stroeTImerStandart then
                chest.new()
            end
            storeTimer = storeTimer - dt
        else
            --Enemy.create(0,0,y,waveNumber,'lettuce')
            waveNumber = waveNumber + 1
            storeTimer = stroeTImerStandart
            love.audio.play(Sounds.time)
            if waveNumber > #WavesCount then
                waveNumber = 1
                for i = 1, #WavesCount do
                    WavesCount[i].Count = WavesCount[i].Reset*(2+math.log(difficult,2) + math.log(2+i%(#WavesCount),2))
                    WavesCount[i].timerMax = WavesCount[i].timerMax - difficult*0.01
                end
                for i,speed in pairs(speeds) do
                    speeds[i] = speed + difficult*10
                end
                difficult = difficult + 1
            end
            return waveNumber
        end

    end

    self[waveNumber].timer = self[waveNumber].timer - dt

end

