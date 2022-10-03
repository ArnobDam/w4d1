class PolyTreeNode
    attr_reader(:parent, :children, :value)
    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end

    def parent=(parent_node)
        if @parent != nil
            @parent.children.delete(self)
        end

        @parent = parent_node
        @parent.children << self unless @parent == nil
    end

    def add_child(child_node)
        child_node.parent=self
    end

    def remove_child(child_node)
        raise "not a child" if child_node.parent == nil
        child_node.parent=nil
    end

    def dfs(target_value)
        return self if value == target_value

        children.each do |child|
            child_node = child.dfs(target_value)
            return child_node if child_node != nil
        end

        nil
    end

    def bfs(target_value)
        queue_arr = []

        queue_arr.push(self)

        until queue_arr.empty?
            ele = queue_arr.shift
            return ele if ele.value == target_value
            ele.children.each do |child|
                queue_arr.push(child)
            end
        end

        nil
    end

    def inspect
        puts
        p value
        # children.each {|child| p child.value}
    end
end

# [[6,3],[4,2],[2,1],[0,0]]
# if ele.value == target.value
#     move ele into an array
#     while array[-1].parent != nil
#         move array[-1].parent into array
#     end
#     return array
# end

