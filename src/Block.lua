Block = Class{}

PLAY_BOUNDS = {['x1'] = 12, ['y1'] = 5, ['x2'] = 23, ['y2'] = 26}

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

function Block:render(x, y, level)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(gTextures['main'], gFrames['blocks'][level][self.type][self.size], self.x + x, self.y + y)
end

function Block:collides(blocks)

end

function Block:canMove(x, y)
    newX = self.gridX + x
    newY = self.gridY + y
    return (newX > PLAY_BOUNDS.x1 and newX < PLAY_BOUNDS.x2) and (newY > PLAY_BOUNDS.y1 and newY < PLAY_BOUNDS.y2)
end

function Block:move(x, y)
    self.gridX = self.gridX + x
    self.gridY = self.gridY + y
    self.x = (self.gridX - 1) * (self.size == 'small' and 6 or TILE_SIZE)
    self.y = (self.gridY - 1) * (self.size == 'small' and 6 or TILE_SIZE)
end