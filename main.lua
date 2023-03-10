local menu = require "menu"
local game = require "game"
require "scores"
local tela = menu
require 'loadSounds'

font = love.graphics.newFont("fonts/CompassPro.ttf", 20)
love.graphics.setFont(font)

roxo = {81/255,38/255,107/255}

cinza = {85/255,85/255,85/255}

azul_claro = { 0/255,255/255,223/255}

azul_mar = {89/255,215/255,1}

verde = {89/255,173/255,102/255}

marrom = {129/255,78/255,0/255}

marrom_claro = {214/255,132/255,0/255}

vermelho = {255/255,10/255,5/255}

function verify_region (mx, my, x, y, w, h) 
    return mx >= x and mx <= x + w and my >= y and my <= y + h
end

function drawCenteredText(rectX, rectY, rectWidth, rectHeight, text)
	local font       = love.graphics.getFont()
	local textWidth  = font:getWidth(text)
	local textHeight = font:getHeight()
	love.graphics.print(text, rectX+rectWidth/2, rectY+rectHeight/2, 0, 1, 1, textWidth/2, textHeight/2)
end

function love.load()
  tela = menu
  tela.load()
end  

function love.update(dt)
  if dt > 0.040 then return end
  tela.update(dt)
end

function love.draw() 
  tela.draw()
end

function love.keypressed(key)
  tela.keypressed(key)
end

function love.keyreleased(key)
  tela.keyreleased(key)
end

function love.mousepressed(x,y,button)
  tela.mousepressed(x, y, button)
  if isSaveName then
    if verify_region(x,y,textbox.x,textbox.y,textbox.width,textbox.height) then
        textbox.active = true
    else
      textbox.active = false
    end
  end
end

function love.mousereleased(x,y,button)
  tela.mousereleased(x,y,button)
end

function goToGame()
  game.load()
  tela = game
end

function love.textinput (text)
    if isSaveName then
        if textbox.active then
            textbox.text = textbox.text .. text
        end
    end
end
