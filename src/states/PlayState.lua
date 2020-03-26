PlayState = Class{__includes = BaseState}

-- indices of inside of GUI containers [x, y, width, height]
CONTAINER_DATA = {
    ['mode'] = {['x'] = 2, ['y'] = 2, ['w'] = 8, ['h'] = 3},
    ['stats'] = {['x'] = 1, ['y'] = 7, ['w'] = 10, ['h'] = 19},
    ['lines'] = {['x'] = 11, ['y'] = 1, ['w'] = 12, ['h'] = 3},
    ['play'] = {['x'] = 11, ['y'] = 4, ['w'] = 12, ['h'] = 22},
    ['scores'] = {['x'] = 23, ['y'] = 1, ['w'] = 8, ['h'] = 9},
    ['next'] = {['x'] = 23, ['y'] = 11, ['w'] = 6, ['h'] = 7},
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

    testTromino = Tetromino(18, 6, LETTERS[math.random(7)], 'normal')
end

function PlayState:enter() 
    -- TODO: Enter with level, mode, etc
    level = 0
    mode = "EASY"
    lines_cleared = 0
    top_score = 10000
    current_score = 0
end

function PlayState:exit() 

end

function PlayState:update(dt) 
    if love.keyboard.keysPressed['a'] then
        level = level - 1 >= 0 and level - 1 or 0
    end

    if love.keyboard.keysPressed['d'] then
        level = level + 1 <= 9 and level + 1 or 9
    end

    if love.keyboard.keysPressed['w'] then
        lines_cleared = lines_cleared + 1
    end

    if love.keyboard.keysPressed['s'] then
        lines_cleared = lines_cleared - 1
    end

    if love.keyboard.keysPressed['left'] then
        testTromino:move(-1, 0)
    end    
    
    if love.keyboard.keysPressed['right'] then
        testTromino:move(1, 0)
    end    
    
    if love.keyboard.keysPressed['up'] then
        testTromino:move(0, -1)
    end    
    
    if love.keyboard.keysPressed['down'] then
        testTromino:move(0, 1)
    end

    if love.keyboard.keysPressed['v'] then
        testTromino:rotate('left')
    end

    if love.keyboard.keysPressed['b'] then
        testTromino:rotate('right')
    end

    if love.keyboard.keysPressed['space'] then
        testTromino = Tetromino(18, 6, LETTERS[math.random(7)], 'normal')
    end
end

function PlayState:render() 
    -- draw background
    love.graphics.setColor(LEVEL_COLORS[level][1], LEVEL_COLORS[level][2], LEVEL_COLORS[level][3], 1)
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
        tetromino:render(0, 0, level)
    end

    testTromino:render(0, 0, level)

    -- love.graphics.draw(gTextures['main'], gFrames['blocks'][level]['sign'], 80 + 20, 20 + 20)
    -- love.graphics.draw(gTextures['main'], gFrames['blocks'][level]['t']['small'], 80 + 20, 20 + 54)
    -- love.graphics.draw(gTextures['main'], gFrames['blocks'][level]['t']['normal'], 80 + 30, 20 + 54)
    -- love.graphics.draw(gTextures['main'], gFrames['blocks'][level]['j_small'], 80 + 20, 20 + 64)
    -- love.graphics.draw(gTextures['main'], gFrames['blocks'][level]['j'], 80 + 30, 20 + 64)
    -- love.graphics.draw(gTextures['main'], gFrames['blocks'][level]['z_small'], 80 + 20, 20 + 74)
    -- love.graphics.draw(gTextures['main'], gFrames['blocks'][level]['z'], 80 + 30, 20 + 74)
    -- love.graphics.draw(gTextures['main'], gFrames['blocks'][level]['o_small'], 80 + 20, 20 + 84)
    -- love.graphics.draw(gTextures['main'], gFrames['blocks'][level]['o'], 80 + 30, 20 + 84)
    -- love.graphics.draw(gTextures['main'], gFrames['blocks'][level]['s_small'], 80 + 20, 20 + 94)
    -- love.graphics.draw(gTextures['main'], gFrames['blocks'][level]['s'], 80 + 30, 20 + 94)
    -- love.graphics.draw(gTextures['main'], gFrames['blocks'][level]['l_small'], 80 + 20, 20 + 104)
    -- love.graphics.draw(gTextures['main'], gFrames['blocks'][level]['l'], 80 + 30, 20 + 104)
    -- love.graphics.draw(gTextures['main'], gFrames['blocks'][level]['i_small'], 80 + 20, 20 + 114)
    -- love.graphics.draw(gTextures['main'], gFrames['blocks'][level]['i'], 80 + 30, 20 + 114)
end