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

* run the CLI application:
> Change firstly the "./lib/game.rb" file to uncomment the last two lines, as:
```sh
game = Game.new`
game.start_game`
```
> Save the file and start up the CLI application
```sh
$ ruby ./lib/game.rb
```

### Used Technologies
* ruby 2.3.4p301
* rspec (3.6.0)
* simplecov (0.15.0)

## Specification
### User Stories

```sh

```



### Requirements


## Application design

### Asumptions

### Implementation
#### Class diagram

### Limitations

### Results

## Future extensions
