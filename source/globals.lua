import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/frameTimer"
import "CoreLibs/ui"
import "CoreLibs/easing"
import "CoreLibs/crank"

import 'cursor.lua'
import 'game.lua'
import 'gameover.lua'
import 'gfxImage.lua'
import 'gfxImage2.lua'
import 'help.lua'
import 'menu.lua'
import 'spriteBackground.lua'
import 'sprite.lua'
import 'sysmenu.lua'

local gfx = playdate.graphics
local sfx = playdate.sound.sampleplayer
local msx = playdate.sound.fileplayer

font = gfx.font.new('img/font/whiteglove-stroked')

click = sfx.new('sfx/click.wav')
gameoverSfx = sfx.new('sfx/gameover.wav')
playSfx = sfx.new('sfx/play.wav')
completeSfx = sfx.new('sfx/completelevel.wav')
undoSfx = sfx.new('sfx/undo.wav')

gameState = 0;

level = 1;
hlevel = 1;

local gameData = playdate.datastore.read()
if gameData then
    hlevel = gameData.currentLevel
    level = hlevel
end

levels = { 5,10,20,30,20,30,35,40,35,40,44,48,51,54,57,60,50,55,60,64,66,68,70,72,74,76,78,80,85, 90}
levels2= { 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4 ,4, 4, 4}

movesLeft = 0
blockInputG = false

ditherMethod = {gfx.image.kDitherTypeDiagonalLine,gfx.image.kDitherTypeVerticalLine,gfx.image.kDitherTypeHorizontalLine,
        gfx.image.kDitherTypeScreen,gfx.image.kDitherTypeBayer2x2,gfx.image.kDitherTypeBayer4x4,gfx.image.kDitherTypeBayer8x8,
        gfx.image.kDitherTypeFloydSteinberg,gfx.image.kDitherTypeBurkes,gfx.image.kDitherTypeAtkinson}



screenImage = gfx.image.new(400, 240)

--[[ todo 
wiekszy kursor


Controls: A - action, B or crank -undo, dpad - move cursor
Rules: Your goal is to clear the board of all blocks. 
To remove blocks, select the appropriate squares and press the A button. 
In later rounds, some blocks need to be pressed two, three, or four times. You have a set number of moves to complete the task.


]]--

