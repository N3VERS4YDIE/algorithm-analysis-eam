using AbstractTrees

mutable struct BTNode
    value::Int
    left::Union{BTNode,Nothing}
    right::Union{BTNode,Nothing}

    BTNode(value::Int, left::Union{BTNode,Nothing}=nothing, right::Union{BTNode,Nothing}=nothing) = new(value, left, right)
end

"Preorder traversal: Node -> Left -> Right"
function preorder(node::Union{BTNode,Nothing})
    node === nothing && return []
    [node.value; preorder(node.left)...; preorder(node.right)...]
end

"Inorder traversal: Left -> Node -> Right"
function inorder(node::Union{BTNode,Nothing})
    node === nothing && return []
    [inorder(node.left)...; node.value; inorder(node.right)...]
end

"Postorder traversal: Left -> Right -> Node"
function postorder(node::Union{BTNode,Nothing})
    node === nothing && return []
    [postorder(node.left)...; postorder(node.right)...; node.value]
end

function build_tree(values::Vector{Int})::BTNode
    n = length(values)
    nodes = [BTNode(values[i]) for i in 1:n]

    for i in 1:n
        if 2i <= n
            nodes[i].left = nodes[2i]
        end
        if 2i + 1 <= n
            nodes[i].right = nodes[2i+1]
        end
    end

    return nodes[1]
end

function build_and_print_tree_info(values::Vector{Int})
    println("Nodes:")
    println(values)

    tree = build_tree(values)
    println("\nTree:")
    print_tree(tree)
    

    println("\nPreorder Traversal:")
    println(preorder(tree))

    println("\nInorder Traversal:")
    println(inorder(tree))

    println("\nPostorder Traversal:")
    println(postorder(tree))
end

AbstractTrees.children(node::BTNode) = filter!(x -> x !== nothing, [node.left, node.right])
AbstractTrees.nodevalue(node::BTNode) = node.value

values = [14, 15, 4, 9, 7, 18, 3, 5, 16, 4, 20, 17]

println("--- ORIGINAL TREE ---")
build_and_print_tree_info(values)

println("\n\n--- INVERTED TREE ---")
build_and_print_tree_info(reverse(values))