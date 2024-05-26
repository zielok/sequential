import "CoreLibs/sprites"
import "CoreLibs/graphics"

class('SpriteBackground').extends(playdate.graphics.sprite)
function SpriteBackground:init(x, y,image)
    SpriteBackground.super.init(self) -- this is critical
    self:setImage(image)
    self:moveTo(x, y)
    self:setZIndex(0)
    self:add()
    --local w,h = self:getSize()
    --print (self:getCenter())
end