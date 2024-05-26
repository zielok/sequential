local gfx = playdate.graphics

class('TitleScreen').extends()
function TitleScreen:menuInit()
    local spriteBack = SpriteBackground(200,120,playdate.graphics.image.new("img/menu"))
    local spriteA = SpriteBackground(200,170,playdate.graphics.image.new("img/playbutton"))
    local spriteB = SpriteBackground(200,220,playdate.graphics.image.new("img/helpbutton"))
    state = 0;
    whiteImg:startFadeIn()
    gfx.setColor(gfx.kColorBlack)
    sysMenuMenu()
end

function TitleScreen:menuDraw()
    gfx.sprite.update()
    if (state==0) then
        whiteImg:updateFade()
        if (whiteImg:complete()==1) then
            state = 1
        end
    elseif (state==1) then
        if (playdate.buttonJustPressed("a")) then
            playSfx:play()
            whiteImg:startFadeOut()
            state = 2
        end
        if (playdate.buttonJustPressed("b")) then
            HelpScreen:init()
        end
    elseif (state==2) then
        whiteImg:updateFade()
        if (whiteImg:complete()==1) then
            startLevel()
        end
    end

end

function startLevel()
    gfx.sprite.removeAll()
    removeSysMenu()
    gameSetUp()
    sysMenuGame()
end