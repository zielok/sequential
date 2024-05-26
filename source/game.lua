local gfx = playdate.graphics

local gameCursor = {7,4}
local blockInput = false
local blocky = playdate.frameTimer.new(6)
blocky.repeats = true
local anim = playdate.frameTimer.new(45)
anim.discardOnCompletion = false
local undoX = {}
local undoY = {}
local licznik = 0

function gameSetUp()

    blockInputG = false
    gameState = 1;
    backGroundBoard = gfx.image.new('img/board')
    completeLevel = gfx.image.new('img/levelcomplete.png')
    gameEndImg = gfx.image.new('img/gameend.png')

    puzzleSprite = MyGfxImage('img/puzzle')
    gfxAddSprite = MyGfxImage('img/gameadd')

    myBoard = {}
    for i=0,13,1 do
        myBoard[i] = {}
        for i2=0,8,1 do
            myBoard[i][i2] = 0
        end
    end

    for i=1,levels[level],1 do
        local r = math.random(0,13)
        local r2 = math.random(0,8)
        setOnBoard(r,r2,0)
    end
    movesLeft = levels[level]
    whiteImg:startFadeIn()
    cursorSetUp(gameCursor[1],gameCursor[2])

    nextLevel = 0
    licznik = 0
end

function setOnBoard(x,y,type) 
    setOnBoardOne(x,y,type)
    setOnBoardOne(x+1,y,type)
    setOnBoardOne(x,y+1,type)
    setOnBoardOne(x-1,y,type)
    setOnBoardOne(x,y-1,type)
end

function setOnBoardOne(x,y,type) 
    if (x>=0 and x<14 and y>=0 and y<9) then
        if (type==0) then
            if (myBoard[x][y]==levels2[level]) then
                myBoard[x][y] = 0;
            else 
                myBoard[x][y] = myBoard[x][y]+1;
            end
        else
            if (myBoard[x][y]==0) then
                myBoard[x][y] = levels2[level];
            else 
                myBoard[x][y] = myBoard[x][y]-1;
            end
        end
    end
end

function initBlockInput()
    blockInput = true
    blocky:reset()
    
end

function gameM()
    gfx.setBackgroundColor(gfx.kColorClear)
    playdate.frameTimer.updateTimers()

    if (nextLevel==0) then 
        mainGame()
    elseif (nextLevel==1) then
        gfx.lockFocus(screenImage)
        drawGame()
        gfx.unlockFocus()
        nextLevel = 2
        completeSfx:play()
        anim:reset()
    elseif (nextLevel==2) then
        screenImage:draw(0,0)
        completeLevel:scaledImage(playdate.easingFunctions.outBounce(anim.frame,0,1,45)):drawCentered(200,120)

        if playdate.buttonJustPressed("a") then
            click:play()
            level = level + 1
            if (level>hlevel) then
                hlevel = level
            end
            saveGameData()
            startLevel()
        end
    elseif (nextLevel==10) then
        whiteImg:startFadeOut()
        gfx.sprite.removeAll()
        nextLevel = 11
    elseif (nextLevel==11) then
        whiteImg:updateFade()
        if (whiteImg:complete()==1) then
            nextLevel = 12
            completeSfx:play()
        end
    elseif (nextLevel==12) then
        gameEndImg:draw(0,0)
        if playdate.buttonJustPressed("a") then
            level = 1
            hlevel = 1
            saveGameData()
            gameState = 0
            TitleScreen:menuInit()
        end
    end
end

function mainGame()
    if (blockInputG==false) then
        if playdate.buttonJustPressed("down") then
            initBlockInput()
            gameCursor[2]=gameCursor[2]+1
        end
        if playdate.buttonJustPressed("up") then
            initBlockInput()
            gameCursor[2]=gameCursor[2]-1
        end
        if playdate.buttonJustPressed("right") then
            initBlockInput()
            gameCursor[1]=gameCursor[1]+1
        end
        if playdate.buttonJustPressed("left") then
            initBlockInput()
            gameCursor[1]=gameCursor[1]-1
        end

        if (blocky.frame>5) then 
            blockInput = false
        end
        if (blockInput==false) then
            if playdate.buttonIsPressed("down") then
                initBlockInput()
                gameCursor[2]=gameCursor[2]+1
            end
            if playdate.buttonIsPressed("up") then
                initBlockInput()
                gameCursor[2]=gameCursor[2]-1
            end
            if playdate.buttonIsPressed("right") then
                initBlockInput()
                gameCursor[1]=gameCursor[1]+1
            end
            if playdate.buttonIsPressed("left") then
                initBlockInput()
                gameCursor[1]=gameCursor[1]-1
            end
        end

        if (gameCursor[1]<0) then gameCursor[1]=0 end
        if (gameCursor[2]<0) then gameCursor[2]=0 end
        if (gameCursor[1]>13) then gameCursor[1]=13 end
        if (gameCursor[2]>8) then gameCursor[2]=8 end

        if playdate.buttonJustPressed("a") then
            setOnBoard(gameCursor[1],gameCursor[2],1)
            undoX[licznik] = gameCursor[1]
            undoY[licznik] = gameCursor[2]
            licznik = licznik + 1
            movesLeft = movesLeft - 1
            click:play()
        end
        if playdate.buttonJustPressed("b") then
            undo()
        end

        local crankTicks = playdate.getCrankTicks(6)

        if crankTicks == 1 then
            if (licznik>0) then
                undo()
            end
        elseif crankTicks == -1 then
            --print("Backward tick")
        end

    end

    drawGame()

    if (blockInputG==false) then
        if (checkBoard()==true) then
            if (level==#levels) then
                nextLevel=10
            else    
                nextLevel=1
            end
        elseif (movesLeft==0) then
            blockInputG = true
            whiteImg:startFadeOut()
        end
    else
        if (whiteImg:complete()==1) then
            GameoverScreen:init()
        end
    end
end

function undo()
    if (licznik>0) then
        licznik = licznik - 1
        movesLeft = movesLeft + 1
        setOnBoard(undoX[licznik],undoY[licznik],0)
        undoSfx:play()
    end
end

function drawGame()
    gfx.setColor(gfx.kColorBlack)
    
    backGroundBoard:draw(0,0)
    boardUpdate() 
    gfx.sprite.update()
    
    --gfx.setBackgroundColor(gfx.kColorBlack)
    whiteImg:updateFade()
    cursorUpdate(gameCursor[1],gameCursor[2])
    
    --playdate.drawFPS(0,0)
    gfx.setFont(font)
    --gfx.drawText('sprite: '..#gfx.sprite.getAllSprites(), 2, 20)
    addText = 4
    gfx.drawTextAligned('LEVEL', 364, 16+addText,kTextAlignment.center)
    gfx.drawTextAligned(level, 364, 30+addText,kTextAlignment.center)
    addText = 48
    gfx.drawTextAligned('MOVES', 364, 16+addText,kTextAlignment.center)
    gfx.drawTextAligned(movesLeft, 364, 30+addText,kTextAlignment.center)

    gfxAddSprite:draw(340,100,levels2[level])
    --playdate.ui.crankIndicator:draw(0,0)
end

function boardUpdate() 
     for i=0,13,1 do
        for i2=0,8,1 do
            --puzzleSprite[i][i2]:image(myBoard[i][i2]+1)
            puzzleSprite:draw(13+i*22,22+i2*22,myBoard[i][i2]+1)
        end
    end

end

function checkBoard()
    local complete = true
    for i=0,13,1 do
        for i2=0,8,1 do
            if (myBoard[i][i2]==1) then
                complete = false
            end
        end
    end
    return complete
end




