class Mastermind

	def initialize(player)
		@name = Player.new(player)
		@computer = Computer.new
		@board = Board.new
	end


	Player = Struct.new(:name)

	class Computer
		attr_reader :answer
		@answer = [0, 0, 0, 0]

		def inititialize
			create_answer
		end

		def create_answer
			@answer.collect! do |item|
				rand(7)
			end		
		end
	end

	class Board
		@colors = {
			red: 31,
			green: 32,
			yellow: 33,
			purple: 34,
			pink: 35,
			blue: 36,
		}

		def initialize
			create_rows
			display
		end

		def create_rows
			sample_row = ["O", "O", "O", "O", "black: ", "white: "]
			@rows = []
			i = 12
			12.times do
				#@rows << ("row" + i.to_s).intern
				@rows << sample_row
				#i -= 1
			end
			#p @rows
		end

		# def init_display
		# 	row = "----------------------------------------------------------------------------\n" +
		# 		  "|\tO\t|\tO\t|\tO\t|\tO\tblack:\n|\t\s\t|\s\t\t|\t\s\t|\t\s\twhite:"
		# 	12.times do
		# 		puts row
		# 	end
		# end


		def display
			@rows.each do |row|
				puts "----------------------------------------------------------------------------\n" +
				  	   "|\t#{color("red")}\t|\t#{row[1]}\t|\t#{row[2]}\t|\t#{row[3]}\t#{row[4]}\n|\t\s\t|\s\t\t|\t\s\t|\t\s\t#{row[5]}"
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


	end
end

game = Mastermind.new("Cam")		


	# @rows.each do |row|
	# 			row.each_with_index do |peg, 

