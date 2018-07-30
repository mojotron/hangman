class Hangman
	attr_accessor :hits, :misses, :lifes, :secret_word, :guessing_word
	@@dictionary = "dictionary.txt"

	def initialize
		@misses = Array.new
		@secret_word = "word"#pick_secret_word(@@dictionary)
		@guessing_word = []
		@secret_word.length.times {guessing_word << '_'}
		@display_hangman = DisplayHangman.new
		game_logic	
	end

	def pick_secret_word(filename)
		dictionary = File.readlines(filename)
		secret_word = ''
		while true
			word = dictionary.sample.rstrip
			if word.length >= 5 && word.length <= 12
				secret_word = word 
				return secret_word.downcase
			end
		end
	end

	def game_logic
		trys = 0
		until trys == 9
			puts `clear`
			puts "Secret word: #{guessing_word.join(' ')}"
			puts @display_hangman.hangman_displays["display_#{trys}".to_sym]
			puts "\nHits: #{hits.inspect.gsub(/"/, "")}"
			puts "Misses: #{misses.inspect.gsub(/"/, "")}"
			
			if !guessing_word.include?('_')
				puts "YOU WON!"
				exit
			end

			puts "Enter letter:"
			user_input = gets.chomp.downcase
			if secret_word.include?(user_input)
				puts "Bravo!\n"
				sleep 1
				secret_word.split(//).each_with_index do |letter, idx|
					if letter == user_input
						guessing_word[idx] = letter
					end
				end 
			else	
				misses << user_input
				trys += 1
			end	
		end
		puts `clear`
		puts @display_hangman.hangman_displays["display_#{trys}".to_sym]
		puts "YOU LOSE!"
		puts "Secret word was: #{secret_word}"
	end
end

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
