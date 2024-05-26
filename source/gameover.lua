local gfx = playdate.graphics

class('GameoverScreen').extends()
function GameoverScreen:init()
    gameoverSfx:play()
    whiteImg:startFadeIn()
    gameState = 2;
    state = 0;
    gfx.sprite.removeAll()
    self.backGameOver = gfx.image.new('img/gameover')
    local spriteA = SpriteBackground(200,170,playdate.graphics.image.new("img/restartbutton"))
    local spriteB = SpriteBackground(200,220,playdate.graphics.image.new("img/menubutton"))
end


function GameoverScreen:drawM()
    gfx.setBackgroundColor(gfx.kColorClear)
    --self.backGameOver2 = self.backGameOver:vcrPauseFilterImage()
    --self.backGameOver2:draw(0,0)
    self.backGameOver:draw(0,0)
    gfx.sprite.update()


    if (state==0) then
        whiteImg:updateFade()
        if (whiteImg:complete()==1) then
            state = 1
        end
    elseif (state==1) then
        if (playdate.buttonJustPressed("a")) then
            whiteImg:startFadeOut()
            state = 2
        elseif (playdate.buttonJustPressed("b")) then
            whiteImg:startFadeOut()
            state = 3
        end
    elseif (state==2) then
        whiteImg:updateFade()
        if (whiteImg:complete()==1) then
            startLevel()
        end
    elseif (state==3) then
        whiteImg:updateFade()
        if (whiteImg:complete()==1) then
            gameState = 0
            TitleScreen:menuInit()
        end
    end
end



