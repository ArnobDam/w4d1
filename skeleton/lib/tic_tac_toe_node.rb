require_relative 'tic_tac_toe'
require "byebug"

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    # @next_mover_mark == :x ? @next_mover_mark = :o : @next_mover_mark = :x
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
  end

  def winning_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    # @next_mover_mark == :x ? @next_mover_mark = :o : @next_mover_mark = :x
    
    # debugger
    # arr = @board.rows
    nodes_arr = []
    # orig_dup = @board.dup
    (0..2).each do |i|
      (0..2).each do |j|
        if @board[[i,j]].nil?
          new_board = @board.dup
          new_board[[i,j]] = @next_mover_mark
          @next_mover_mark == :x ? child_mark = :o : child_mark = :x
          nodes_arr << TicTacToeNode.new(new_board, child_mark, [i,j])
        end
      end
    end
    # @board.rows.flatten
    nodes_arr
  end

  # def deep_dup(board)
  #   # arr = board.rows
  #   board.map {|ele| ele.is_a?(Array) ? deep_dup(ele) : ele}
  # end
end
