import "CoreLibs/graphics"
import "CoreLibs/sprites"

import 'sprite.lua'

local gfx = playdate.graphics
cursor = {}

function cursorSetUp(xm,ym)
    
    for i=0,4,1 do
        cursor[i] = MySprite(22+xm*22,31+ym*22,NIL,1)
        cursor[i]:setImagesTable("img/mark")
        cursor[i]:image(1)
    end
    
end

function cursorSetOne(i,x,y)
    if (x<0 or x>=14 or y<0 or y>=9) then
        cursor[i]:visible(false)
    else 
        cursor[i]:visible(true)
    end
    cursor[i]:position(23+x*22,32+y*22)
end


function cursorUpdate(xm,ym)
    for i=0,4,1 do
        cursor[i]:playAnimation()
    end
    cursorSetOne(0,xm,ym)
    cursorSetOne(1,xm+1,ym)
    cursorSetOne(2,xm,ym+1)
    cursorSetOne(3,xm-1,ym)
    cursorSetOne(4,xm,ym-1)
end

