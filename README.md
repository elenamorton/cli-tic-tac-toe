[![CodeClimate](https://codeclimate.com/github/elenamorton/cli-tic-tac-toe/badges/gpa.svg)](https://codeclimate.com/github/elenamorton/cli-tic-tac-toe)


# Tic Tac Toe Game - console (CLI) version

## Usage Instructions
* clone the repo and install the Ruby gems
```sh
$ git clone https://github.com/elenamorton/cli-tic-tac-toe.git
$ cd cli-tic-tac-toe
$ bundle install
```
* run tests
```sh
$ rspec
```
* test coverage

`COVERAGE:  98.37% -- 361/367 lines in 12 files`

| coverage | file | lines | missed | missing
| ---------- | ------------------- | ------- | -------- | --------------:
| 80.00% | lib/iolike.rb | 20 | 4 | 4, 8, 12, 16
| 96.00% | lib/computer.rb | 25 | 1 | 35
| 96.77% | spec/game_spec.rb | 31 | 1 | 13

`9 file(s) with 100% coverage not shown`

* run the CLI application.
> We have to make sure the script is marked as executable. If it is not, please run the command `chmod +x app.rb`
```sh
$ ./app.rb
```

#### Used Technologies
* ruby 2.3.4p301
* rspec (3.6.0)
* simplecov (0.15.0)

## Specification

### Headline specifications
* Allow the user to choose the level of difficulty (“easy” means the computer can easily be beaten, “medium” means it can be beaten but only with a series of intelligent moves, and “hard” means the it is unbeatable).
* Allow the user to choose the game type (human v. human, computer v. computer, human v. computer).
* Allow the user to choose which player goes first.
* Allow the user to choose with what "symbol" the players will mark their selections on the board (traditionally it's "X" and "O")

### User Stories extracted from the specification

```
As a user
So as I can have a nice time
I'd like to be able to play tic-tac-toe game

As a user
So as I can decide on computer play level
I'd like to see the options available

As a user
So as I can make a choice the computer play level
I'd like to be able to select it

As a user
So as I can make a choice about the players
I'd like to be able to select the players type

As a user
So as I can make a choice about the players order
I'd like to be able to select the which players starts first
```






## Application design

### Asumptions

### Implementation
#### Class diagram

### Limitations

### Results

```sh
$ ./app.rb
Please, choose a player (human|computer): computer
Please, choose another player (human|computer): computer
Please, choose a player symbol (X|other letter): 7
You've entered 7, which is invalid
Please, choose a player symbol (X|other letter): o
Please, choose the other player symbol (O|other letter): z
Please, choose the difficulty level (easy|medium|hard): easy
Please, choose which players goes first (1|2): 1
 0 | 1 | 2 
===+===+===
 3 | 4 | 5 
===+===+===
 6 | 7 | 8 
 0 | 1 | 2 
===+===+===
 3 | O | 5 
===+===+===
 6 | 7 | 8 
 0 | 1 | 2 
===+===+===
 3 | O | 5 
===+===+===
 6 | Z | 8 
 0 | 1 | 2 
===+===+===
 3 | O | O 
===+===+===
 6 | Z | 8 
 Z | 1 | 2 
===+===+===
 3 | O | O 
===+===+===
 6 | Z | 8 
 Z | 1 | O 
===+===+===
 3 | O | O 
===+===+===
 6 | Z | 8 
 Z | 1 | O 
===+===+===
 Z | O | O 
===+===+===
 6 | Z | 8 
 Z | 1 | O 
===+===+===
 Z | O | O 
===+===+===
 6 | Z | O 
Game over
```
## Future extensions
