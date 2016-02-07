# minesweeper
[Minesweeper][minesweeper] recreated in Ruby!

![Minesweeper][minesweeper-screenshot]

The [gosu][gosu] library is used handle the graphics and user input within the `Minesweeper` class.

To install the `gosu` gem run the following command:

```no-highlight
$ gem install gosu
```

The `minesweeper.rb` file contains the code for setting up the game and drawing the minefield. To test the game, you can run the `minesweeper.rb` program:

```no-highlight
$ ruby minesweeper.rb
```

The game depends on the `Minefield` class defined in `minefield.rb`. 
This class is used to represent the state of the game. 


[minesweeper]: http://en.wikipedia.org/wiki/Minesweeper_(video_game)
[gosu]: http://www.libgosu.org/
[minesweeper-screenshot]: https://s3.amazonaws.com/hal-assets.launchacademy.com/minesweeper/minesweeper.png
