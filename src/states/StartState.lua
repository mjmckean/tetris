StartState = Class{__includes = BaseState}

function StartState:init() 
    startContainer = Container(CONTAINER_DATA['start'])
    difficultyContainer = Container(CONTAINER_DATA['difficulty'])

    levelSelections = {}
    modeSelections = {
        Selection(1, 2, MODES[1]),
        Selection(5.25, 2, MODES[2]),
        Selection(11, 2, MODES[3])
    }

    for key, level in pairs(LEVELS) do
        levelSelections[key] = Selection(key < 5 and 1.75 or 4.75, 2 + (key < 5 and key * 2 or (key - 5) * 2), key)
    end

    level = 0
    mode = 1
    levelSelections[level]:update(true)
    modeSelections[mode]:update(true)
end

function StartState:enter(def)

end

function StartState:exit() 

end

function StartState:update(dt) 
    if love.keyboard.keysPressed['left'] then
        gSounds['select']:play()
        modeSelections[mode]:update(false)
        if mode > 1 then
            mode = mode - 1
        else
            mode = 3
        end
        modeSelections[mode]:update(true)
    end    
    
    if love.keyboard.keysPressed['right'] then
        gSounds['select']:play()
        modeSelections[mode]:update(false)
        if mode < 3 then
            mode = mode + 1
        else
            mode = 1
        end
        modeSelections[mode]:update(true)
    end    
    
    if love.keyboard.keysPressed['up'] then
        gSounds['select']:play()
        levelSelections[level]:update(false)
        if level > 0 then
            level = level - 1
        else
            level = 9
        end
        levelSelections[level]:update(true)
    end    

    if love.keyboard.keysPressed['down'] then
        gSounds['select']:play()
        levelSelections[level]:update(false)
        if level < 9 then
            level = level + 1
        else
            level = 0
        end
        levelSelections[level]:update(true)
    end    
    
    if love.keyboard.keysPressed['return'] then
        gSounds['select']:play()
        gStateMachine:change('play', {level=level, mode=MODES[mode]})
    end
end

function StartState:render() 
    -- draw background
    love.graphics.setColor(LEVELS[level][1], LEVELS[level][2], LEVELS[level][3], 1)
    love.graphics.draw(gTextures['background'], 0, 0)
    love.graphics.setColor(1, 1, 1, 1)

    startContainer:render(level, "LEVEL")
    difficultyContainer:render(level, "MODE")

    for key, selection in pairs(modeSelections) do
        selection:render(difficultyContainer.fill_x, difficultyContainer.fill_y, level)
    end

    for key, selection in pairs(levelSelections) do
        selection:render(startContainer.fill_x, startContainer.fill_y, level)
    end
end