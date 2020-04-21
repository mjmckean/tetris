PlayState = Class{__includes = BaseState}

function PlayState:init() 
    -- initialize gui containers
    modeContainer = Container(CONTAINER_DATA['mode'])
    statsContainer = Container(CONTAINER_DATA['stats'])
    linesContainer = Container(CONTAINER_DATA['lines'])
    playContainer = Container(CONTAINER_DATA['play'])
    scoresContainer = Container(CONTAINER_DATA['scores'])
    nextContainer = Container(CONTAINER_DATA['next'])
    levelContainer = Container(CONTAINER_DATA['level'])

    -- initialize small tetrominoes for stats container
    statsTetrominoes = {}
    stats = {}
    for i = 1, #LETTERS do
        statsTetrominoes[i] = Tetromino(6.5, 11.5 + (3 * i), LETTERS[i], 'small')
        stats[i] = 0
    end

    -- initialize next tetromino
    next = math.random(7)

    ended = false
end

function PlayState:enter(def)
    -- TODO: High scores
    level = def.level
    mode = def.mode
    testBoard = Board(13, 5, mode)
    generateNextTetromino()
    top_score = 10000
    lines_cleared = 0
    current_score = 0
    calibrateDropSpeed(level)
end

function PlayState:exit() 

end

function PlayState:update(dt) 
    if ended == false then
        if love.keyboard.keysPressed['a'] then
            level = level - 1 >= 0 and level - 1 or 0
            calibrateDropSpeed(level)
        end

        if love.keyboard.keysPressed['d'] then
            level = level + 1 <= 9 and level + 1 or 9
            calibrateDropSpeed(level)
        end

        if love.keyboard.keysPressed['w'] then
            testBoard.lines_cleared = testBoard.lines_cleared + 1
        end

        if love.keyboard.keysPressed['s'] then
            testBoard.lines_cleared = testBoard.lines_cleared - 1
        end

        if love.keyboard.keysPressed['left'] then
            gSounds['select']:play()
            testTromino:move(-1, 0, testBoard, level)
        end    
        
        if love.keyboard.keysPressed['right'] then
            gSounds['select']:play()
            testTromino:move(1, 0, testBoard, level)
        end    
        
        if love.keyboard.keysPressed['up'] then
            gSounds['select']:play()
            while testTromino.live do
                testTromino:move(0, 1, testBoard, level)
            end
        end    
        
        if love.keyboard.keysPressed['down'] then
            gSounds['select']:play()
            testTromino:move(0, 1, testBoard, level)
        end

        if love.keyboard.keysPressed['v'] then
            gSounds['select']:play()
            testTromino:rotate('left', testBoard, level)
        end

        if love.keyboard.keysPressed['b'] then
            gSounds['select']:play()
            testTromino:rotate('right', testBoard, level)
        end

        if love.keyboard.keysPressed['space'] then
            generateNextTetromino()
        end

        if love.keyboard.keysPressed['p'] then
            Timer.clear()
        end

        current_score = testBoard.score
        lines_cleared = testBoard.lines_cleared
        if math.floor(lines_cleared / 10) > level and lines_cleared < 100 then
            level = math.floor(lines_cleared / 10)
            calibrateDropSpeed(level)
        end
    else
        if love.keyboard.keysPressed['return'] then
            gStateMachine:change('start')
        end
    end
end

function PlayState:render() 
    -- draw background
    love.graphics.setColor(LEVELS[level][1], LEVELS[level][2], LEVELS[level][3], 1)
    love.graphics.draw(gTextures['background'], 0, 0)
    love.graphics.setColor(1, 1, 1, 1)

    -- draw containers
    modeContainer:render(level, mode)
    statsContainer:render(level, 'STATISTICS')
    linesContainer:render(level, 'LINES - ' .. tostring(lines_cleared))
    playContainer:render(level)
    scoresContainer:render(level, 'TOP\n' .. tostring(top_score) .. '\n\nSCORE\n' .. tostring(current_score), 5)
    nextContainer:render(level, 'NEXT')
    levelContainer:render(level, 'LEVEL\n' .. tostring(level), 3)
    
    -- draw stats tetrominoes
    for i, tetromino in pairs(statsTetrominoes) do
        tetromino:render(0, 0, level, testBoard)
        love.graphics.printf("- " .. tostring(stats[i]), 7 * TILE_SIZE, (8 + (2.2 * i)) * TILE_SIZE, (7 * TILE_SIZE) / 0.5, 'left', 0, 0.5)
    end

    -- draw next tetromino
    nextTetromino:render(0, 0, level, testBoard)

    testBoard:render(level)
    if testTromino.live then
        testTromino:render(0, 0, level, testBoard)
    elseif ended == true then
        love.graphics.setFont(gFonts['large'])
        love.graphics.print("GAME\nOVER", 50, 50)
        love.graphics.setFont(gFonts['small'])
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.print("press enter to play again", 88, 0)
    else
        testTromino = nil
        generateNextTetromino()
    end
end

function generateNextTetromino()
    testTromino = Tetromino(18, 5, LETTERS[next], 'normal')

    if testTromino:move(0, 1, testBoard, level) == false then
        -- game over
        ended = true
    end

    stats[next] = stats[next] + 1
    next = math.random(7)
    displayX = next == 7 and 26.5 or (next == 4 and 27.5 or 27)
    displayY = next == 7 and 15.5 or 15
    nextTetromino = Tetromino(displayX, displayY, LETTERS[next], 'normal')
end

function calibrateDropSpeed(level)
    Timer.clear()
    Timer.every(LEVELS[level][4] / 60, function()
        testTromino:move(0, 1, testBoard, level)
    end)
end