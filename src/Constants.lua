-- physical screen dimensions
WINDOW_WIDTH = 896
WINDOW_HEIGHT = 784

-- virtual resolution dimensions
VIRTUAL_WIDTH = 256
VIRTUAL_HEIGHT = 224
TILE_SIZE = 8

-- tetromino letters
LETTERS = {'t', 'j', 'z', 'o', 's', 'l', 'i'}

-- level data (r, g, b, frames/line)
LEVELS = {
    [0] = {0.6, 0.6, 1, 48},
    [1] = {0.6, 1, 0.6, 43},
    [2] = {1, 0.4, 0.8, 38},
    [3] = {0.8, 0.8, 1, 33},
    [4] = {1, 0.6, 0.6, 28},
    [5] = {0.8, 1, 0.8, 23},
    [6] = {1, 0.4, 0.4, 18},
    [7] = {1, 0.6, 1, 13},
    [8] = {0.8, 0.8, 1, 8},
    [9] = {1, 0.6, 0.4, 6}
}