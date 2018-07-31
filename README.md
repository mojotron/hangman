# Hangman with Ruby
Hangman is a paper and pencil guessing game for two or more players. One 
player thinks of a word, phrase or sentence and the other(s) tries to guess 
it by suggesting letters or numbers, within a certain number of guesses. 
Learn more on [Wikipedia](https://en.wikipedia.org/wiki/Hangman_(game)).

This project is all about implementing files. Load them and save them. Game 
starts by loading the dictionary and picking one random word between five and 
twelve characters. Player has nine guesses to win the game. The secret word is 
transformed into underscore characters. Main game logic is to check if there 
are no more underscore characters in secret word => game is won. 
Player has the option to save the game and load it later to resume and 
continue to play next time when the game starts.
For file serialization in this project is used JSON format.

Dictionary used to create this game is 5desk.txt from [scrapmaker.com](https://www.scrapmaker.com/view/twelve-dicts/5desk.txt)

This project is part of [The Odin Project curriculum](https://www.theodinproject.com/). 
Awesome on-line web development learning place!