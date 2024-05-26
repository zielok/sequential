import "CoreLibs/graphics"
import "CoreLibs/sprites"

local gfx = playdate.graphics

class('MyGfxImage').extends()
function MyGfxImage:init(images)
    self.ImagesTab = playdate.graphics.imagetable.new(images)
    
end

function MyGfxImage:draw(x,y,im)
    self.ImagesTab:drawImage(im,x,y)
end

