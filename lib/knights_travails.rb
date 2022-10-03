require_relative '00_tree_node.rb'

class KnightPathFinder
    def self.valid_moves(position)
        move_array = []

        all_position_changes = [[1,2],[-1,2],[2,1],[2,-1],[1,-2],[-1,-2],[-2,1],[-2,-1]]
        all_position_changes.each do |position_change|
            new_position = [position_change[0] + position[0], position_change[1] + position[1]]
            if new_position[0] < 8 && new_position[0] >= 0 && new_position[1] < 8 && new_position[1] >= 0
                move_array << new_position
            end
        end
        move_array
    end

    def initialize(position)
        @root_node = PolyTreeNode.new(position)
        @considered_positions = [position]
    end

    def new_move_positions(pos)
        valid_positions = KnightPathFinder.valid_moves(pos)
        new_positions = []

        valid_positions.each do |position|
            if !@considered_positions.include?(position)
                @considered_positions << position
                new_positions << position
            end
        end
        new_positions
    end

    def build_move_tree
        move_queue = []
        move_queue << @root_node

        until move_queue.empty?
            shifted_node = move_queue.shift
            move_positions = new_move_positions(shifted_node.value)
            move_positions.each do |pos|
                node = PolyTreeNode.new(pos)
                node.parent = shifted_node
                move_queue << node
            end
        end
        @root_node
    end

    def find_path(end_pos)
        node = @root_node.bfs(end_pos)
        trace_path_back(node)
    end

    def trace_path_back(node)
        pos_array = []
        until node.nil?
            pos_array << node.value
            node = node.parent
        end
        pos_array
    end
    
end

k = KnightPathFinder.new([0,0])

tree = k.build_move_tree

p k.find_path([5,5])

