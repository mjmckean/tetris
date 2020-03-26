function GenerateTileQuads(atlas)
    local tiles = {}
    local types = {
        -- ['sign'] = {['x'] = 4, ['y'] = 0, ['w'] = 56, ['h'] = 32},
        ['t'] = {
            ['normal'] = {['x'] = 40, ['y'] = 48, ['w'] = 8, ['h'] = 8},
            ['small'] = {['x'] = 3, ['y'] = 50, ['w'] = 6, ['h'] = 6}
        },
        ['j'] = {
            ['normal'] = {['x'] = 40, ['y'] = 88, ['w'] = 8, ['h'] = 8},
            ['small'] = {['x'] = 3, ['y'] = 90, ['w'] = 6, ['h'] = 6}
        },
        ['z'] = {
            ['normal'] = {['x'] = 40, ['y'] = 128, ['w'] = 8, ['h'] = 8},
            ['small'] = {['x'] = 3, ['y'] = 130, ['w'] = 6, ['h'] = 6}
        },
        ['o'] = {
            ['normal'] = {['x'] = 44, ['y'] = 168, ['w'] = 8, ['h'] = 8},
            ['small'] = {['x'] = 6, ['y'] = 170, ['w'] = 6, ['h'] = 6}
        },
        ['s'] = {
            ['normal'] = {['x'] = 40, ['y'] = 216, ['w'] = 8, ['h'] = 8},
            ['small'] = {['x'] = 9, ['y'] = 210, ['w'] = 6, ['h'] = 6}
        },
        ['l'] = {
            ['normal'] = {['x'] = 40, ['y'] = 248, ['w'] = 8, ['h'] = 8},
            ['small'] = {['x'] = 3, ['y'] = 250, ['w'] = 6, ['h'] = 6}
        },
        ['i'] = {
            ['normal'] = {['x'] = 48, ['y'] = 280, ['w'] = 8, ['h'] = 8},
            ['small'] = {['x'] = 0, ['y'] = 293, ['w'] = 6, ['h'] = 6}
        },
    }

    local x = 0
    local y = 0

    local level = 0

    -- levels arranged in 5 rows
    for row = 1, 5 do
        
        -- 2 columns
        for i = 1, 2 do
            tiles[level] = {}
            
            for letter, type in pairs(types) do
                tiles[level][letter] = {}

                for size, value in pairs(type) do
                    tiles[level][letter][size] = love.graphics.newQuad(
                        x + value.x,
                        y + value.y,
                        value.w,
                        value.h,
                        atlas:getDimensions())
                end
            end
            
            
            level = level + 1
            x = 200
        end
        y = y + 320
        x = 0
    end

    return tiles
end