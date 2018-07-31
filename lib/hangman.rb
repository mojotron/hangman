require 'json'

class Hangman
	attr_accessor :misses, :secret_word, :guessing_word, :turns
	@@dictionary = "dictionary.txt"

	def initialize
		puts `clear`
		@display_hangman = DisplayHangman.new
		@misses = Array.new
		@guessing_word = Array.new
		@turns = 0 #variable used for calling correct display from @display_hangman
		game_option		
	end

	def game_option #ask user for starting a clean slate game or load last saved game
		display_banner
		puts %q{
For new game enter: new
For saved game enter: load
		}
		user_input = gets.chomp.downcase
		case user_input
		when "new" 
			@secret_word = pick_secret_word(@@dictionary)#"word"
			@secret_word.length.times {guessing_word << '_'}
			game_logic(@turns)
		when "load" 
			load_game
		else game_option #using recursion insted of begin/rescue for correct user input
		end
	end

	def display_banner
		puts %q{
 _   _                                   _   _    
| | | | _WELCOME TO GAME OF___________  | \ | |  
| |_| | __ _ _ __   __ _ _ __ ___   __ _|  \| |  
|  _  |/ _` | '_ \ / _` | '_ ` _ \ / _` | .   |
| | | | (_| | | | | (_| | | | | | | (_| | |\  |
|_| |_|\__,_|_| |_|\__, |_| |_| |_|\__,_|_| \_|
                    __/ |                      
                   |___/                        
}
	end

	def display_game_rules
		puts "You need to guess Secret Word."
		puts "You have 9 guesses before you are hanged!"
		puts "You can save game end exit by typing 'exit'."
	end

	def save_and_exit #save key variables in json file
		x = JSON.dump ({
			:misses => @misses,
			:secret_word => @secret_word,
			:guessing_word => @guessing_word,
			:turns => @turns.to_s
		})
		#save key variables into new file
		File.open("savefile.json", "w") do |file|
			file.puts x
		end
		puts "...game saved!"
		exit
	end

	def load_game #load savefaile, assigne varables and start game logic
		file = File.open("savefile.json", "r")
		x = JSON.load(file)
		@misses = x["misses"]
		@secret_word = x["secret_word"]
		@guessing_word = x["guessing_word"]
		@turns = x["turns"].to_i
		puts "...loading..."
		sleep 1
		game_logic(@turns)
	end

	def pick_secret_word(filename) #from dictionary select secret word
		dictionary = File.readlines(filename)
		secret_word = ''
		while true
			word = dictionary.sample.rstrip
			if word.length >= 5 && word.length <= 12 #conditions
				secret_word = word 
				return secret_word.downcase
			end
		end
	end

	def game_log_display #display game status to player
		puts `clear`
		display_banner
		display_game_rules
		puts @display_hangman.hangman_displays["display_#{turns}".to_sym]
		puts "\nSecret word: #{guessing_word.join(' ')}"
		puts "Misses: #{misses.inspect.gsub(/"|\[|\]/, "")}"
	end

	def winner_found? #check for winning condition, if @guseesin_word array has no "_", must be win
		!@guessing_word.include?('_')
	end

	def user_game_input #prompt user for letter input
		puts "Enter letter:"
		user_input = gets.chomp.downcase
		case user_input
		when "exit" then save_and_exit
		else user_input[0]
		end
	end

	def end_game_message(option="win") #display correct message and exit game
		case option
		when "win"
			puts "\nYOU WON!"
			exit
		when "lose"
			puts "\nYOU LOSE!"
			puts "Secret word was: #{@secret_word}"
			exit
		end
	end

	def game_logic(turns) #main game logic
		until turns == 9
			game_log_display #display secret word in dashes
			#check if player has guess all letters
			end_game_message("win") if winner_found? #if so call end game with winning message
			#player didnt guess all letters so prompt him/her for new entrie
			user_input = user_game_input #if user enter exit here, game will be saved
			#if player enters letter, time to cech main logic
			if @secret_word.include?(user_input) #if player entrie includs correct guess
				secret_word.split(//).each_with_index do |letter, idx| #program seraches for index
					if letter == user_input #of correct letter, and changes '_' dash in @guessing_word array
						@guessing_word[idx] = letter 
					end
				end 
			else #if playerd didnt have corrct guess, pogram, appends that letter into @misses
				misses << user_input 
				turns += 1 #and add 1 to turns for correct hangman display
				@turns += 1 #@turns is used for saveing game
			end	
		end
		game_log_display
		end_game_message("lose")
	end
end
#class with all possible displays for game of hangman
class DisplayHangman
	attr_accessor :hangman_displays

	def initialize
		@hangman_displays = {
			:display_0 => [
					["    _________"],
					["    |      ||"],
					["           ||"],
					["           ||"],
					["           ||"],
					["           ||"],
					["           ||"],
					["           ||"],
					["           ||"],
					["///////////||"]
				],
				:display_1 => [
					["    _________"],
					["    |      ||"],
					["   ////    ||"],
					["  (   )    ||"],
					["           ||"],
					["           ||"],
					["           ||"],
					["           ||"],
					["           ||"],
					["///////////||"]
				],
				:display_2 => [
					["    _________"],
					["    |      ||"],
					["   ////    ||"],
					["  (0  )    ||"],
					["           ||"],
					["           ||"],
					["           ||"],
					["           ||"],
					["           ||"],
					["///////////||"]
				],
				:display_3 => [
					["    _________"],
					["    |      ||"],
					["   ////    ||"],
					["  (0 0)    ||"],
					["           ||"],
					["           ||"],
					["           ||"],
					["           ||"],
					["           ||"],
					["///////////||"]
				],
				:display_4 => [
					["    _________"],
					["    |      ||"],
					["   ////    ||"],
					["  (0_0)    ||"],
					["           ||"],
					["           ||"],
					["           ||"],
					["           ||"],
					["           ||"],
					["///////////||"]
				],
				:display_5 => [
					["    _________"],
					["    |      ||"],
					["   ////    ||"],
					["  (0_0)    ||"],
					["  |   |    ||"],
					["  |___|    ||"],
					["           ||"],
					["           ||"],
					["           ||"],
					["///////////||"]
				],
				:display_6 => [
					["    _________"],
					["    |      ||"],
					["   ////    ||"],
					["  (0_0)    ||"],
					[" /|   |    ||"],
					["/ |___|    ||"],
					["           ||"],
					["           ||"],
					["           ||"],
					["///////////||"]
				],
				:display_7 => [
					["    _________"],
					["    |      ||"],
					["   ////    ||"],
					["  (0_0)    ||"],
					[" /|   |\\   ||"],
					["/ |___||   ||"],
					["           ||"],
					["           ||"],
					["           ||"],
					["///////////||"]
				],
				:display_8 => [
					["    _________"],
					["    |      ||"],
					["   ////    ||"],
					["  (0_0)    ||"],
					[" /|   |\\   ||"],
					["/ |___||   ||"],
					["  |        ||"],
					[" _|        ||"],
					["           ||"],
					["///////////||"]
				],
				:display_9 => [
					["    _________"],
					["    |      ||"],
					["   ////    ||"],
					["  (x_x)    ||"],
					[" /|   |\\   ||"],
					["/ |___||   ||"],
					["  |   |    ||"],
					[" _|   |_   ||"],
					["           ||"],
					["///////////||"]
		]}
	end
end

Hangman.new
