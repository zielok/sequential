import "CoreLibs/sprites"
import "CoreLibs/graphics"

class('MySprite').extends(playdate.graphics.sprite)
function MySprite:init(x, y,image,z)
    MySprite.super.init(self) -- this is critical
    self:setImage(image)
    self:moveTo(x, y)
    self:setZIndex(z)
    self:add()
    self.frame = 1;
    --local w,h = self:getSize()
    --print (self:getCenter())
end

function MySprite:image(imageN)
    --print(imageN)
    self.frame = imageN
    local imageL = self.ImagesTab:getImage(imageN)
    self:setImage(imageL)
end

function MySprite:testDrawImageTable()
    self.ImagesTab:drawImage(1,0,0)
end

function MySprite:setImagesTable(images)
    self.ImagesTab = playdate.graphics.imagetable.new(images)
    --self.ImagesTab:drawImage(1,0,0)
    
end

function MySprite:position(x,y)
    self:moveTo(x, y)
end

function MySprite:playAnimation()
    self.frame=self.frame+1
    if (self.frame>#self.ImagesTab) then
        self.frame = 1
    end
    self:image(self.frame)
end

function MySprite:visible(i)
    self:setVisible(i)
end
