TitleState = Class{__includes = BaseState}

function TitleState:init()
    -- new Box2D "world" which will run all of our physics calculations
    world = love.physics.newWorld(0, 400)

    -- static ground and wall bodies
    groundBody = love.physics.newBody(world, 0, VIRTUAL_HEIGHT, 'static')
    leftWallBody = love.physics.newBody(world, 0, 0, 'static')
    rightWallBody = love.physics.newBody(world, VIRTUAL_WIDTH, 0, 'static')

    -- edge shape Box2D provides, perfect for ground and walls
    edgeShape = love.physics.newEdgeShape(0, 0, VIRTUAL_WIDTH, 0)
    wallShape = love.physics.newEdgeShape(0, 0, 0, VIRTUAL_HEIGHT)

    -- affix edge shape to our body
    groundFixture = love.physics.newFixture(groundBody, edgeShape)
    leftWallFixture = love.physics.newFixture(leftWallBody, wallShape)
    rightWallFixture = love.physics.newFixture(rightWallBody, wallShape)

    -- table holding dynamic bodies (balls)
    dynamicBodies = {}
    dynamicFixtures = {}
    rectangleShape = love.physics.newRectangleShape(TILE_SIZE, TILE_SIZE)

    for i = 1, 600 do
        table.insert(dynamicBodies, {
            love.physics.newBody(world, 
                math.random(VIRTUAL_WIDTH), math.random(VIRTUAL_HEIGHT - 30), 'dynamic'),
            level = math.random(10) - 1,
            letter = LETTERS[math.random(7)]
        })
        table.insert(dynamicFixtures, love.physics.newFixture(dynamicBodies[i][1], rectangleShape))
    end
end

function TitleState:enter(def)

end

function TitleState:exit() 

end

function TitleState:update(dt)
    if love.keyboard.keysPressed['return'] then
        gSounds['select']:play()
        gStateMachine:change('start')
    end

    -- update world, calculating collisions
    world:update(dt)
end

function TitleState:render()
    -- render tetromino pit
    for i = 1, #dynamicBodies do
        love.graphics.setColor(1, 1, 1, 1)
        x, y = dynamicBodies[i][1]:getWorldPoints(rectangleShape:getPoints())
        love.graphics.draw(
            gTextures['main'],
            gFrames['blocks'][dynamicBodies[i].level][dynamicBodies[i].letter]['normal'],
            x,
            y
        )
    end

    love.graphics.setFont(gFonts['large'])
    love.graphics.print("TETRIS", 27, 2)
    love.graphics.setFont(gFonts['small'])
    love.graphics.print("press enter to play", 88, 0)
end