import 'globals.lua'

whiteImg = MyGfxImage2('img/white')

--playdate.setCollectsGarbage(false)

TitleScreen:menuInit()
--playdate.display.setRefreshRate(0)

--playdate.display.setMosaic(1, 0)

function playdate.update()
    if (gameState==0) then 
        TitleScreen:menuDraw();
    elseif (gameState==1) then 
        gameM()
    elseif (gameState==2) then 
        GameoverScreen:drawM()
    elseif (gameState==3) then 
        HelpScreen:drawM()
    end
    --playdate.drawFPS()
end

function playdate.BButtonHeld()
    --globalPrint()
end

function playdate.cranked()
    
end

function playdate.gameWillTerminate()
    saveGameData()
end

function playdate.deviceWillSleep()
    saveGameData()
end

function playdate.gameWillPause()
    saveGameData()
end

function playdate.keyPressed(key)

end

function locals()
  local variables = {}
  local idx = 1
  while true do
    local ln, lv = debug.getlocal(2, idx)
    if ln ~= nil then
      variables[ln] = lv
    else
      break
    end
    idx = 1 + idx
  end
  return variables
end

function globalPrint()
    for k,v in pairs(_G) do
        print("Global key", k, "value", v)
    end
end


function saveGameData()
    local gameData = {
        currentLevel = hlevel,
    }
    playdate.datastore.write(gameData)
end
