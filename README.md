# Tetris
As part of my self-driven "Introduction to Video Game Development" curriculum, 
I decided to recreate one of the first video games that I played and enjoyed (Tetris on NES).

I began this curriculum having experience with programming; however, I had never attempted to work on any games and did not know where to start.
Fortunately, Harvard University has an extensive continuing education program that includes an 
[Introduction to Game Development](https://online-learning.harvard.edu/course/cs50s-introduction-game-development?delta=0) course.
This course includes discussing and working with a variety of different games, beginning with 2D games (e.g., Pong, Flappy Bird, Pokémon) using the Lua programming lanuage and LÖVE framework
and then progressing to a few 3D games, working in Unity.

I am happy with how much I was able to build in a short time frame. The game most likely has bugs and is not as robust as other
versions of Tetris currently available, but the core gameplay does work (and is just as fun for me).

## Running on LÖVE
In order to run this version of Tetris, you will need to install LÖVE (see the [getting started guide](https://love2d.org/wiki/Getting_Started)).
I built this game using LÖVE 11.2

## Controls
### Gameplay
#### UP
Slam tetromino down, navigate on game selection screen
#### DOWN, LEFT, RIGHT
Move tetromino, navigate on game selection screen
#### B
Rotate clockwise
#### V
Rotate counterclockwise
#### RETURN
Navigate to the next screen (unless currently in play state)
#### ESC
Close the running game with the escape key
### Debugging
#### A, D
Decrease, increase level during gameplay
#### W, S
Increase, decrease number of lines cleared
#### P
Stop the tetromino from falling automatically
#### SPACE
Remove the current tetromino and generate a new one
