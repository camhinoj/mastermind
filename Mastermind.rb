class Mastermind
	attr_reader :computer

	def initialize(player)
		@player = Player.new(player)
		@answer = Computer.new.answer
		@board = Board.new(@answer, @player)
	end

	def play
		index = 1 
		loop do
			if index > 12
				puts "You have lost the game"
				break
			end
			puts "Enter your guess (four colors of red, green, yellow, purple, pink, or blue seperated by a comma, and the colors can repeat):"
			guess = gets.chomp.split(', ')
			if @board.add_guess(guess, index)
				puts "You have won the game congrats"
				break
			else
				@board.display
			end
			index += 1
		end
	end


	Player = Struct.new(:name)


	class Computer
		attr_reader :answer

		def initialize
			@colors = { "1" => "red", "2" => "green", "3" => "yellow", "4" => "purple", "5" => "pink", "6" => "blue" }
			@answer = []
			create_answer
		end

		def create_answer
			4.times do
				@answer << @colors[rand(1..6).to_s]
			end
			p @answer
		end
	end

	class Board
		attr_reader :answer

		def initialize(answer, player)
			@answer = answer
			@player = player
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
			black = 0
			white = 0
			@answer.each do |i|
				guess.each do |j|
					white += 1 if i == j
				end
			end
			index = 0
			while index < 3
				if @answer[index] == guess[index]
					black += 1
					white -= 1
				end
				index += 1
			end
			return [black, white]
		end
	end
end

game = Mastermind.new("Cam")	
game.play


	# @rows.each do |row|
	# 			row.each_with_index do |peg, 

