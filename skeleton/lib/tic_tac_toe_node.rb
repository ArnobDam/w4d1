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
    # debugger
    # if evaluator == :o and board.over? and board.winner == evaluator return true
    return true if board.over? && evaluator == :x && board.winner == :o
    # return true if board.over? && board.winner != evaluator 
    # && board.winner != nil
    # return false if board.over? && board.winner == evaluator
    #  || board.winner == nil
    # debugger
    if evaluator == :x
      children.all? {|child| child.losing_node?(evaluator)}
    else
      children.any? {|child| child.losing_node?(evaluator)}
    end
  end

  def winning_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    nodes_arr = []

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
    nodes_arr
  end
end
