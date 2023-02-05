Sounds = {
    hit = love.audio.newSource("assets/effects/dano1.wav", "static"),
    open = love.audio.newSource("assets/effects/door.wav","static"),
    botao = love.audio.newSource("assets/effects/botao.wav","static"),
    time = love.audio.newSource("assets/effects/time.wav","static"),
    enemy = love.audio.newSource("assets/effects/jump1.wav","static"),
}


for k,v in pairs(Sounds) do
    v:setVolume(0.9)
    -- set reapet to false
    v:setLooping(false)
end