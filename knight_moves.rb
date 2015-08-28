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
		#puts "potential_moves = #{potential_moves}"
		potential_moves.each do |move|
			#puts "move  = #{move}"
			move = Space.new(move, current_space)
			#puts "move object = #{move} with value #{move.value} and parent #{move.parent}"
			queue << move if !visited.include? move.value
		end
		#puts "queue #{queue}"
		current_space = queue[0]
		queue = queue [1..-1]
		#puts "iterate"
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

# knight moves should not be responsible for convering arrays to Chess Space objects
# is chess space even the correct class name? not really, because the tree structure is dependenet on knight moves
# assume that moves are converted to objects before being called



# do you need to do bfs twice (once to populate and once to find the path) or only once (populate tree and find in one step?)
	# with BFS, you are guaranteed to find the shortest path, and you can terminate once you do
	# the code may not be as clean, but it will be faster

		# therefore, BFS once, looking as you populate

#architecture

	# helper method is_legal_move? checks legality of an array of moves
	# generate possible moves uses the previous helper to create an array of all possible moves from a particular spot
	# bfs method uses the two
		# visited keeps track of visited spaces, so if they appear again, don't add them to cue
		# target keeps track of where we are trying to go
		# start gives the initial space we are moving from (do we recurse here or just iterate?)
		# queue keeps track of the upcoming spaces to explore
		# how do you return the path once you've found the target space? this structure does not keep a tree structure	
			# tree structure is not that complicated - create a class with parents and children, then add spaces
			# argument here may be that by creating the tree, you can quickly check the # of steps to get to a different space if you change your mind

		# should you just create a node network of the board, save it, and reuse it?
			# no directionality, just siblings
			# keep track of progress using a 'visited' array that you were going to use anyway

		# for this case, we can assign parents and children to establish direcionality, so that once a path is found, you can trace your way back up the tree, parent by parent



