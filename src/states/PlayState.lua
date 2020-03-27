PlayState = Class{__includes = BaseState}

-- indices of inside of GUI containers [x, y, width, height]
CONTAINER_DATA = {
    ['mode'] = {['x'] = 2, ['y'] = 2, ['w'] = 8, ['h'] = 3},
    ['stats'] = {['x'] = 1, ['y'] = 7, ['w'] = 10, ['h'] = 19},
    ['lines'] = {['x'] = 11, ['y'] = 1, ['w'] = 12, ['h'] = 3},
    ['play'] = {['x'] = 11, ['y'] = 4, ['w'] = 12, ['h'] = 22},
    ['scores'] = {['x'] = 23, ['y'] = 1, ['w'] = 8, ['h'] = 9},
    ['next'] = {['x'] = 23, ['y'] = 11, ['w'] = 7, ['h'] = 7},
    ['level'] = {['x'] = 23, ['y'] = 18, ['w'] = 7, ['h'] = 5}
}

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
    for i = 1, #LETTERS do
        statsTetrominoes[i] = Tetromino(6.5, 11.5 + (3 * i), LETTERS[i], 'small')
    end

    -- initialize next tetromino
    next = math.random(7)
    generateNextTetromino()

    testBoard = Board(13, 6, 'normal')

end

function PlayState:enter(def) 
    -- TODO: Enter with level, mode, etc
    level = def.level
    mode = "EASY"
    lines_cleared = 0
    top_score = 10000
    current_score = 0
    calibrateDropSpeed(level)
end

function PlayState:exit() 

end

function PlayState:update(dt) 
    if love.keyboard.keysPressed['a'] then
        level = level - 1 >= 0 and level - 1 or 0
        calibrateDropSpeed(level)
    end

    if love.keyboard.keysPressed['d'] then
        level = level + 1 <= 9 and level + 1 or 9
        calibrateDropSpeed(level)
    end

    if love.keyboard.keysPressed['w'] then
        lines_cleared = lines_cleared + 1
    end

    if love.keyboard.keysPressed['s'] then
        lines_cleared = lines_cleared - 1
    end

    if love.keyboard.keysPressed['left'] then
        gSounds['select']:play()
        testTromino:move(-1, 0, testBoard)
    end    
    
    if love.keyboard.keysPressed['right'] then
        gSounds['select']:play()
        testTromino:move(1, 0, testBoard)
    end    
    
    if love.keyboard.keysPressed['up'] then
        gSounds['select']:play()
        testTromino:move(0, -1, testBoard)
    end    
    
    if love.keyboard.keysPressed['down'] then
        gSounds['select']:play()
        testTromino:move(0, 1, testBoard)
    end

    if love.keyboard.keysPressed['v'] then
        gSounds['select']:play()
        testTromino:rotate('left', testBoard)
    end

    if love.keyboard.keysPressed['b'] then
        gSounds['select']:play()
        testTromino:rotate('right', testBoard)
    end

    if love.keyboard.keysPressed['space'] then
        generateNextTetromino()
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
    end

    -- draw next tetromino
    nextTetromino:render(0, 0, level, testBoard)

    testBoard:render(level)
    if testTromino.live then
        testTromino:render(0, 0, level, testBoard)
    else
        testTromino = nil
        generateNextTetromino()
    end
end

function generateNextTetromino()
    testTromino = Tetromino(18, 6, LETTERS[next], 'normal')
    next = math.random(7)
    displayX = next == 7 and 26.5 or (next == 4 and 27.5 or 27)
    displayY = next == 7 and 15.5 or 15
    nextTetromino = Tetromino(displayX, displayY, LETTERS[next], 'normal')
end

function calibrateDropSpeed(level)
    Timer.clear()
    Timer.every(LEVELS[level][4] / 60, function()
        testTromino:move(0, 1, testBoard)
    end)
end