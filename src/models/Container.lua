Container = Class{}

function Container:init(containerData)
    -- outline 1
    self.o1x = containerData.x * TILE_SIZE + 1.5
    self.o1y = containerData.y * TILE_SIZE + 1.5
    self.o1w = containerData.w * TILE_SIZE - 3
    self.o1h = containerData.h * TILE_SIZE - 3
    self.o1 = 'line'

    -- outline 2
    self.o2x = containerData.x * TILE_SIZE + 4
    self.o2y = containerData.y * TILE_SIZE + 4
    self.o2w = containerData.w * TILE_SIZE - 8
    self.o2h = containerData.h * TILE_SIZE - 8
    self.o2 = 'line'

    -- outline 3
    self.o3x = containerData.x * TILE_SIZE + 6
    self.o3y = containerData.y * TILE_SIZE + 6
    self.o3w = containerData.w * TILE_SIZE - 12
    self.o3h = containerData.h * TILE_SIZE - 12
    self.o3 = 'line'

    -- fill
    self.fill_x = containerData.x * TILE_SIZE + 8
    self.fill_y = containerData.y * TILE_SIZE + 8
    self.fill_w = containerData.w * TILE_SIZE - 16
    self.fill_h = containerData.h * TILE_SIZE - 16
    self.fill = 'fill'
end

function Container:render(level, text, padding)
    love.graphics.setLineWidth(3)
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.rectangle(self.o1, self.o1x, self.o1y, self.o1w, self.o1h)
    love.graphics.rectangle(self.fill, self.fill_x, self.fill_y, self.fill_w, self.fill_h)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.rectangle(self.o3, self.o3x, self.o3y, self.o3w, self.o3h)
    love.graphics.setLineWidth(2)
    love.graphics.setColor(LEVELS[level][1], LEVELS[level][2], LEVELS[level][3], 0.5)
    love.graphics.rectangle(self.o2, self.o2x, self.o2y, self.o2w, self.o2h)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setLineWidth(1)
    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf(text or '', self.fill_x, self.fill_y + (padding or 0), self.fill_w / 0.6, 'center', 0, 0.6)
end