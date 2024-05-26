import "CoreLibs/graphics"
import "CoreLibs/sprites"

local gfx = playdate.graphics


class('MyGfxImage2').extends()
function MyGfxImage2:init(images)
    --print ('create')
    self.Image2 = playdate.graphics.image.new(images)
    self.fade = 1
    self.finish = 0
    self.fadeType = 0
    self.ditherMet = gfx.image.kDitherTypeDiagonalLine
end

function MyGfxImage2:draw(x,y)
    self.Image2:draw(x,y)
end

function MyGfxImage2:drawFaded(x,y,alpha)
    if (self.ditherMet==NIL) then
       --print(self)
       --globalPrint()
       --self.ditherMet = gfx.image.kDitherTypeDiagonalLine
    end
    --self.Image2:drawFaded(x,y,alpha,self.ditherMet)
    self.Image2:scaledImage(alpha):drawCentered(200,120)
end

function MyGfxImage2:startFadeIn()
    --print('Start in')
    self.fadeType = 0
    self.fade = 1
    self.finish = 0
    self.ditherMet = ditherMethod[math.random(1,10)]
end

function MyGfxImage2:startFadeOut()
    --print('Start out')
    self.fadeType = 1
    self.fade = 0
    self.finish = 0
    self.ditherMet = ditherMethod[math.random(1,10)]
end

function MyGfxImage2:updateFade()
    if (self.finish==0) then
        --print('fade')
        if (self.fadeType==0) then self:updateFadeIn()
        elseif (self.fadeType==1) then self:updateFadeOut()   
        end
    end
end

function MyGfxImage2:updateFadeIn()
    --print('in')
    if (self.fade>0) then
        self.fade = self.fade-(1/10)
        self:drawFaded(0,0,self.fade)
    else
        self.finish = 1
    end
end

function MyGfxImage2:updateFadeOut()
    --print(self.ditherMet)
    if (self.fade<1) then
        self.fade = self.fade+(1/10)
        self:drawFaded(0,0,self.fade)
    else
        self:drawFaded(0,0,1)
        self.finish = 1
    end
end

function MyGfxImage2:complete()
    return self.finish
end