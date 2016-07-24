class Mastermind
	attr_reader :computer

	def initialize(player)
		@player = Player.new(player)
		@computer = Computer.new
	end

	def play
		puts "Creator or Guesser?"
		choice = gets.chomp
		index = 1
		if choice == "creator"
			#player creates a code
			#computer does random guesses
			puts "Enter your code (four colors):"
			answer = gets.chomp.split(', ')
			@board = Board.new(answer)
			#modified original gameplay
			loop do
				if index > 12
					puts "You have won code Creator"
					@board.display
					break
				end
				@computer.code
				guess = @computer.answer
				if @board.add_guess(guess, index)
					puts "You have lost the game in #{index} tries congrats"
					@board.display
					break
				end
				index += 1
			end
		else
			#regular gameplay
			@board = Board.new(@computer.code)
			loop do
				if index > 12
					puts "You have lost the game"
					break
				end
				puts "Enter your guess (four colors of red, green, yellow, purple, pink, or blue seperated by a comma, and the colors can repeat):"
				guess = gets.chomp.split(', ')
				if @board.add_guess(guess, index)
					puts "You have won the game in #{index} tries congrats"
					@board.answer_display
					break
				else
					@board.display
				end
				index += 1
			end
		end
	end


	Player = Struct.new(:name)


	class Computer
		attr_reader :answer

		def initialize
			@colors = { "1" => "red", "2" => "green", "3" => "yellow", "4" => "purple", "5" => "pink", "6" => "blue" }
			code
		end

		def code
			@answer = []
			4.times do
				@answer << @colors[rand(1..6).to_s]
			end
			@answer
		end
	end

	class Board
		attr_reader :answer

		def initialize(answer)
			@answer = answer
			create_rows
			display
		end

		def create_rows
			sample_row = ["O", "O", "O", "O", "black: ", "white: "]
			@rows = []
			i = 12
			12.times do
				@rows << sample_row
			end
		end

		# def init_display
		# 	row = "----------------------------------------------------------------------------\n" +
		# 		  "|\tO\t|\tO\t|\tO\t|\tO\tblack:\n|\t\s\t|\s\t\t|\t\s\t|\t\s\twhite:"
		# 	12.times do
		# 		puts row
		# 	end
		# end

		def answer_display
			puts "----------------------------------------------------------------------------\n" +
				  	   "|\t#{color(@answer[0])}\t|\t#{color(@answer[1])}\t|\t#{color(@answer[2])}\t|\t#{color(@answer[3])}"
		end

		def display
			@rows.reverse.each do |row|
				puts "----------------------------------------------------------------------------\n" +
				  	   "|\t#{color(row[0])}\t|\t#{color(row[1])}\t|\t#{color(row[2])}\t|\t#{color(row[3])}\t#{row[4]}\n|\t\s\t|\s\t\t|\t\s\t|\t\s\t#{row[5]}"
			end
		end
		
		def color(sym)
			if sym == "O"
				return "O"
			else
				case sym
				when "red"
					return "\033[1;31mO\033[0m"
				when "green"
					return "\033[1;32mO\033[0m"
				when "yellow"
					return "\033[1;33mO\033[0m"
				when "purple"
					return "\033[1;34mO\033[0m"
				when "pink"
					return "\033[1;35mO\033[0m"
				when "blue"
					return "\033[1;36mO\033[0m"
				else
					return StandardError
				end
			end
		end

		def add_guess(guess, turn)
			@rows[turn-1] = guess
			black_white = check_guess(guess)
			if black_white == true
				return true
			else
				@rows[turn-1] << "black:#{black_white[0]}"
				@rows[turn-1] << "white:#{black_white[1]}"
				return false
			end
		end

		def check_guess(guess)
			if guess == @answer
				return true
			end
			result_hash = {"red" => [0, 0], "green" => [0, 0], "yellow" => [0, 0], "purple" => [0, 0], "pink" => [0, 0], "blue" => [0, 0] }
			black = 0
			white = 0

			@answer.each do |i|
				guess.each do |j|
					result_hash[i][1] += 1 if i == j
				end
			end
			index = 0
			while index < 3
				if @answer[index] == guess[index]
					result_hash[guess[index]][0] += 1
				end
				index += 1
			end

			result_hash.each do |key, value|
				if value[0] >= 1
					black += value[0]
				else
					white += value[1]
				end
			end
			return [black, white]
		end
	end
end

game = Mastermind.new("Cam")	
game.play


	# @rows.each do |row|
	# 			row.each_with_index do |peg, 

