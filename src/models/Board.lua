Board = Class{}

function Board:init(x, y, mode, width, height)
    -- board positions
    self.gridX = x
    self.gridY = y
    self.width = width or 10
    self.height = height or 21

    -- coordinate positions
    self.x = (self.gridX - 1) * TILE_SIZE
    self.y = (self.gridY - 1) * TILE_SIZE

    self.completedRows = {}
    self.mode = mode or 'EASY'
    self.score = 0
    self.lines_cleared = 0

    self:initializeTiles()
end

function Board:initializeTiles()
    self.tiles = {}

    for row = 0, self.height - 1 do
        self.tiles[row] = {}

        for column = 0, self.width - 1 do
            if self.mode == 'HARD' and row > 5 then
                self.tiles[row][column] = (math.random(10) < 4) and Block(self.gridX + column,
                                                                        self.gridY + row,
                                                                        LETTERS[math.random(7)])
                                                                or nil
            elseif self.mode == 'NORMAL' and row > 10 then
                self.tiles[row][column] = (math.random(10) < 6) and Block(self.gridX + column,
                                                                        self.gridY + row,
                                                                        LETTERS[math.random(7)])
                                                                or nil
            else
                self.tiles[row][column] = nil
            end
        end
    end

    while self:calculateCompletedRows() do
        -- recursively initialize if completedRows were returned for non-easy modes
        self:initializeTiles()
    end 
end

function Board:calculateCompletedRows()
    local completedRows = {}
    local incomplete = false

    for row = 0, self.height - 1 do
        incomplete = false
        for block = 0, self.width - 1 do
            if not self.tiles[row][block] then
                incomplete = true
                break
            end
        end
        if not incomplete then
            table.insert(completedRows, row)
        end
    end

    self.completedRows = completedRows

    return #self.completedRows > 0 and self.completedRows or false
end

function Board:removeCompletedRows()
    for _, row in pairs(self.completedRows) do
        for column = 0, self.width - 1 do
            self.tiles[row][column] = nil
        end
    end
    for _, completedRow in pairs(self.completedRows) do
        for row = self.height - 1, 0, -1 do
            if row < completedRow then
                for column = 0, self.width - 1 do
                    self.tiles[row + 1][column] = self.tiles[row][column]
                    if self.tiles[row][column] then
                        self.tiles[row][column]:move(0, 1)
                    end
                end
            end
        end
    end
    self:addScore(#self.completedRows, level)
    self.completedRows = {}
end

function Board:addScore(rows, level)
    if rows == 1 then
        self.score = self.score + 100 * (math.floor(level/2) + 1)
    elseif rows == 2 then
        self.score = self.score + 400 * (math.floor(level/2) + 1)
    elseif rows == 3 then
        self.score = self.score + 900 * (math.floor(level/2) + 1)
    elseif rows == 4 then
        self.score = self.score + 2000 * (math.floor(level/2) + 1)
    end
    self.lines_cleared = self.lines_cleared + rows
end

function Board:render(level)
    for row = 0, self.height - 1 do
        for column = 0, self.width - 1 do
            if self.tiles[row][column] then
                self.tiles[row][column]:render(0, 0, level, self)
            end
            
            --------------------------------------
            -- for debugging: kills performance --
            --------------------------------------
            -- love.graphics.setColor(1, 0, 0, 1)
            -- love.graphics.printf(self.tiles[row][column] and self.tiles[row][column].type or 'n',
            --                     (self.gridX - 1 + column) * TILE_SIZE,
            --                     (self.gridY - 1 + row) * TILE_SIZE,
            --                     TILE_SIZE / 0.3,
            --                     'center',
            --                     0,
            --                     0.3)
            -- love.graphics.setColor(1, 1, 1, 1)
        end
    end
end