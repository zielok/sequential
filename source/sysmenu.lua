import "CoreLibs/ui"

local gfx = playdate.graphics

function removeSysMenu()
    local menu = playdate.getSystemMenu()

    menu:removeAllMenuItems()
end

function sysMenuGame()
    local menu = playdate.getSystemMenu()

    local menuItem, error = menu:addMenuItem("Restart", function()
        startLevel()
    end)

    local checkmarkMenuItem, error = menu:addMenuItem("Menu", function(value)
        gfx.sprite.removeAll()
        removeSysMenu()
        gameState = 0
        TitleScreen:menuInit()
    end)
end

function sysMenuMenu()
    local menu = playdate.getSystemMenu()

    local menuItem, error = menu:addMenuItem("Reset save", function()
        level = 1
        hlevel = 1
        saveGameData()
    end)

    if (hlevel>1) then
        opcje ={}
        for i=1,hlevel do
            opcje[i]=i
        end
        local menuItem2 error = menu:addOptionsMenuItem("Level:", opcje, level, function(value)
            level = tonumber(value)
        end)
    end
end