class Space
	attr_accessor :value, :parent

	def initialize (value, parent = nil)
		@value = value
		@parent = parent
	end
end

@knight_movements = [[2,-1], [2, 1], [-2, -1], [-2, 1], [1, -2], [1, 2], [-1, -2], [-1, 2]]

def is_legal_move?(move)
	((0..7).include?(move[0])) && ((0..7).include?(move[1]))
end

def generate_all_possible_moves(start, movements)
	output = []
	movements.each do |move|
		try = [start[0]+move[0], start[1]+move[1]]
		output << try if is_legal_move?(try)
	end
	return output
end

def trace_path_back(start, target)
	current_space = target
	output = [current_space.value]
	until current_space.value == start.value
		current_space = current_space.parent
		output << current_space.value
	end
	puts "You made it in #{output.size} moves! Here's your path:"
	return output.reverse!
end

# feed in Space object for start and target
def knight_moves(start, target, queue = [], visited = [])
	current_space = start
	#puts "current_space.value #{current_space.value}"
	#puts "target.value #{target.value}"

	until current_space.value == target.value
		visited << current_space.value
		potential_moves = generate_all_possible_moves(current_space.value, @knight_movements)
		potential_moves.each do |move|
			move = Space.new(move, current_space)
			queue << move if (!visited.include? move.value) 
		end
		current_space = queue[0]
		queue = queue [1..-1]
	end
	trace_path_back(start, current_space)
end


space02 = Space.new([0,2])
space33 = Space.new([3,3])

puts "from 0,2 to 3,3"
puts knight_moves(space02, space33).inspect
puts

puts "from 4,7 to 2,2"
space47 = Space.new([4,7])
space22 = Space.new([2,2])

puts knight_moves(space47, space22).inspect
puts
puts "from 0,0 to 7,7"
space00 = Space.new([0,0])
space77 = Space.new([7,7])
puts knight_moves(space00, space77).inspect

