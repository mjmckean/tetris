Block = Class{}

function Block:init(x, y, type, size)
    self.type = type
    self.size = size or 'normal'

    -- board positions
    self.gridX = x
    self.gridY = y

    -- coordinate positions
    self.x = (self.gridX - 1) * (self.size == 'small' and 6 or TILE_SIZE)
    self.y = (self.gridY - 1) * (self.size == 'small' and 6 or TILE_SIZE)
end

function Block:render(x, y, level, board)
    if self.y + y >= (board.gridY - 1) * TILE_SIZE then
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.draw(gTextures['main'], gFrames['blocks'][level][self.type][self.size], self.x + x, self.y + y)
    end
end

function Block:collides(dx, dy, board)
    newX = self.gridX + dx
    newY = self.gridY + dy

    for row = 0, board.height - 1 do
        for column = 0, board.width - 1 do
            tile = board.tiles[row][column]
            if tile and newX == tile.gridX and newY == tile.gridY then
                return true
            end
        end
    end

    return newX < board.gridX or 
            newX >= board.gridX + board.width or 
            newY >= board.gridY + board.height
end

function Block:move(dx, dy)
    self.gridX = self.gridX + dx
    self.gridY = self.gridY + dy
    self.x = (self.gridX - 1) * (self.size == 'small' and 6 or TILE_SIZE)
    self.y = (self.gridY - 1) * (self.size == 'small' and 6 or TILE_SIZE)
end