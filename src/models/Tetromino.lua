Tetromino = Class{}

function Tetromino:init(x, y, type, size)
    self.blocks = {}
    self.rotation = 1
    self.size = size or 'normal'
    self.type = type
    self.live = true

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

function Tetromino:render(x, y, level, board)
    love.graphics.setColor(1, 1, 1, 1)
    for key, block in pairs(self.blocks) do
        block:render(x, y, level, board)
    end
end

function Tetromino:move(dx, dy, board, level)
    for key, block in pairs(self.blocks) do
        if block:collides(dx, dy, board) then
            if dy > 0 then
                self:dropTetromino(board, level)
            end
            return false
        end
    end
    for key, block in pairs(self.blocks) do
        block:move(dx, dy)
    end
    return true
end

function Tetromino:rotate(direction, board, level)
    -- TODO: rotate away from wall & fix collision
    bounceRight = false
    bounceLeft = false

    if direction == 'right' then
        for i = 2, 4 do
            nextX = TETROMINOES[self.type][self.rotation < 4 and self.rotation + 1 or 1][i][1] - TETROMINOES[self.type][self.rotation][i][1]
            nextY = TETROMINOES[self.type][self.rotation < 4 and self.rotation + 1 or 1][i][2] - TETROMINOES[self.type][self.rotation][i][2]

            if self.blocks[i]:collides(nextX, nextY, board) then
                if self.blocks[i].gridX + nextX >= board.gridX + board.width then
                    bounceLeft = true
                elseif self.blocks[1].gridX + nextX < board.gridX then
                    bounceRight = true
                end
                -- print(self.blocks[i].gridX, self.blocks[i].gridY, nextX, nextY, board.gridX, board.width)
            end
        end
            
        -- if bounceRight then
        --     if self:move(1, 0, board) == true then
        --         self:rotate(direction, board)
        --         return
        --     end
        -- elseif bounceLeft then
        --     if self:move(-1, 0, board) == true then
        --         self:rotate(direction, board)
        --         return
        --     end
        -- end

        for i = 2, 4 do
            newX = TETROMINOES[self.type][self.rotation < 4 and self.rotation + 1 or 1][i][1] - TETROMINOES[self.type][self.rotation][i][1]
            newY = TETROMINOES[self.type][self.rotation < 4 and self.rotation + 1 or 1][i][2] - TETROMINOES[self.type][self.rotation][i][2]
            self.blocks[i]:move(newX, newY, level)
        end
        self.rotation = self.rotation < 4 and self.rotation + 1 or 1
    else
        for i = 2, 4 do
            nextX = TETROMINOES[self.type][self.rotation > 1 and self.rotation - 1 or 4][i][1] - TETROMINOES[self.type][self.rotation][i][1]
            nextY = TETROMINOES[self.type][self.rotation > 1 and self.rotation - 1 or 4][i][2] - TETROMINOES[self.type][self.rotation][i][2]
            
            if self.blocks[i]:collides(nextX, nextY, board) == true then
                return
            end
        end

        for i = 2, 4 do
            newX = TETROMINOES[self.type][self.rotation > 1 and self.rotation - 1 or 4][i][1] - TETROMINOES[self.type][self.rotation][i][1]
            newY = TETROMINOES[self.type][self.rotation > 1 and self.rotation - 1 or 4][i][2] - TETROMINOES[self.type][self.rotation][i][2]
            self.blocks[i]:move(newX, newY, level)
        end
        self.rotation = self.rotation > 1 and self.rotation - 1 or 4
    end
end

function Tetromino:dropTetromino(board, level)
    for k, block in pairs(self.blocks) do
        board.tiles[block.gridY - board.gridY][block.gridX - board.gridX] = block
    end
    if board:calculateCompletedRows() then
        board:removeCompletedRows(level)
    end
    self.live = false
end