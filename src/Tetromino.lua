Tetromino = Class{}

-- tetrominoes and their block positions
TETROMINOES = {
    ['t'] = {
        [1] = {{0, 0}, {1, 0}, {0, 1}, {-1, 0}},
        [2] = {{0, 0}, {0, 1}, {-1, 0}, {0, -1}},
        [3] = {{0, 0}, {-1, 0}, {0, -1}, {1, 0}},
        [4] = {{0, 0}, {0, -1}, {1, 0}, {0, 1}}
    },
    ['j'] = {
        [1] = {{0, 0}, {1, 0}, {1, 1}, {-1, 0}},
        [2] = {{0, 0}, {0, 1}, {-1, 1}, {0, -1}},
        [3] = {{0, 0}, {-1, 0}, {-1, -1}, {1, 0}},
        [4] = {{0, 0}, {0, -1}, {1, -1}, {0, 1}}
    },
    ['z'] = {
        [1] = {{0, 0}, {0, 1}, {1, 1}, {-1, 0}},
        [2] = {{0, 0}, {-1, 0}, {-1, 1}, {0, -1}},
        [3] = {{0, 0}, {0, -1}, {-1, -1}, {1, 0}},
        [4] = {{0, 0}, {1, 0}, {1, -1}, {0, 1}}
    },
    ['o'] = {
        [1] = {{0, 0}, {0, 1}, {-1, 1}, {-1, 0}},
        [2] = {{0, 0}, {0, 1}, {-1, 1}, {-1, 0}},
        [3] = {{0, 0}, {0, 1}, {-1, 1}, {-1, 0}},
        [4] = {{0, 0}, {0, 1}, {-1, 1}, {-1, 0}}
    },
    ['s'] = {
        [1] = {{0, 0}, {1, 0}, {0, 1}, {-1, 1}},
        [2] = {{0, 0}, {0, 1}, {-1, 0}, {-1, -1}},
        [3] = {{0, 0}, {-1, 0}, {0, -1}, {1, -1}},
        [4] = {{0, 0}, {0, -1}, {1, 0}, {1, 1}}
    },
    ['l'] = {
        [1] = {{0, 0}, {1, 0}, {-1, 0}, {-1, 1}},
        [2] = {{0, 0}, {0, 1}, {0, -1}, {-1, -1}},
        [3] = {{0, 0}, {-1, 0}, {1, 0}, {1, -1}},
        [4] = {{0, 0}, {0, -1}, {0, 1}, {1, 1}}
    },
    ['i'] = {
        [1] = {{0, 0}, {1, 0}, {2, 0}, {-1, 0}},
        [2] = {{0, 0}, {0, 1}, {0, 2}, {0, -1}},
        [3] = {{0, 0}, {-1, 0}, {-2, 0}, {1, 0}},
        [4] = {{0, 0}, {0, -1}, {0, -2}, {0, 1}}
    }
}

function Tetromino:init(x, y, type, size)
    self.blocks = {}
    self.rotation = 1
    self.size = size or 'normal'
    self.type = type

    for i = 1, 4 do
        self.blocks[i] = Block(x + TETROMINOES[self.type][self.rotation][i][1],
                            y + TETROMINOES[self.type][self.rotation][i][2],
                            self.type,
                            size)
    end

    -- coordinate positions
    self.x = self.blocks[1].x
    self.y = self.blocks[1].y
end

function Tetromino:render(x, y, level)
    love.graphics.setColor(1, 1, 1, 1)
    for key, block in pairs(self.blocks) do
        block:render(x, y, level)
    end
end

function Tetromino:collides(blocks)
    for key, block in pairs(self.blocks) do
        block:collides(blocks)
    end
end

function Tetromino:move(x, y)
    for key, block in pairs(self.blocks) do
        if block:canMove(x, y) == false then
            return
        end
    end
    for key, block in pairs(self.blocks) do
        block:move(x, y)
    end
end

function Tetromino:rotate(direction)
    if direction == 'right' then
        for i = 2, 4 do
            newX = TETROMINOES[self.type][self.rotation < 4 and self.rotation + 1 or 1][i][1] - TETROMINOES[self.type][self.rotation][i][1]
            newY = TETROMINOES[self.type][self.rotation < 4 and self.rotation + 1 or 1][i][2] - TETROMINOES[self.type][self.rotation][i][2]

            if self.blocks[i]:canMove(newX, newY) == false then
                return
            end
        end

        for i = 2, 4 do
            self.blocks[i]:move(newX, newY)
        end
        self.rotation = self.rotation < 4 and self.rotation + 1 or 1
    else
        for i = 2, 4 do
            newX = TETROMINOES[self.type][self.rotation > 1 and self.rotation - 1 or 4][i][1] - TETROMINOES[self.type][self.rotation][i][1]
            newY = TETROMINOES[self.type][self.rotation > 1 and self.rotation - 1 or 4][i][2] - TETROMINOES[self.type][self.rotation][i][2]
            
            if self.blocks[i]:canMove(newX, newY) == false then
                return
            end
        end

        for i = 2, 4 do
            self.blocks[i]:move(newX, newY)
        end
        self.rotation = self.rotation > 1 and self.rotation - 1 or 4
    end
end