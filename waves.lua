Waves{
    {onions=1,pumpkin=2,lettuce=3},
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

local timer = 0
WavesCount = {{Count = 50,time=100,timerMin=0.5,timerMax=1}}

function WavesCount:Sapwn(waveNumber,Enemy,Map,dt)
    if self[waveNumber].Count > 0 and timer <= self[waveNumber].timerMin then
        local coords = Map:spawns()
        local x = love.math.random(coords.x, coords.x + coords.w)
        local y = love.math.random(coords.y, coords.y + coords.h)
        Enemy.create(x,y,waveNumber)
        Count = Count - 1
        timer = timerMax
    end

    timer = timer - dt
end

