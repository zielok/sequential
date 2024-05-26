local gfx = playdate.graphics

class('HelpScreen').extends()
function HelpScreen:init()
    removeSysMenu()
    whiteImg:startFadeIn()
    gameState = 3;
    state = 0;
    gfx.sprite.removeAll()
    self.help1 = gfx.image.new('img/help1')
    self.help2 = gfx.image.new('img/help2')
end


function HelpScreen:drawM()
    gfx.setBackgroundColor(gfx.kColorClear)
    if (state<3) then self.help1:draw(0,0)
    else self.help2:draw(0,0)
    end

    --print(state)
    if (state==0) then
        whiteImg:updateFade()
        if (whiteImg:complete()==1) then
            state = 1
        end
    elseif (state==1) then
        if (playdate.buttonJustPressed("a") or playdate.buttonJustPressed("b")) then
            whiteImg:startFadeOut()
            state = 2
        end
    elseif (state==2) then
        whiteImg:updateFade()
        if (whiteImg:complete()==1) then
            whiteImg:startFadeIn()
            state = 3
        end
    elseif (state==3) then
        whiteImg:updateFade()
        if (whiteImg:complete()==1) then
            state = 4
        end
    elseif (state==4) then
        if (playdate.buttonJustPressed("a") or playdate.buttonJustPressed("b")) then
            whiteImg:startFadeOut()
            state = 5
        end
    elseif (state==5) then
        whiteImg:updateFade()
        if (whiteImg:complete()==1) then
            state = 6
            gameState = 0
            TitleScreen:menuInit()
        end
    end
end



