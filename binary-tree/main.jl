using Term.Dendograms: Dendogram, link
using AlgebraicSolving

mutable struct Node
	value::Any
	left::Union{Node, Nothing}
	right::Union{Node, Nothing}

	Node(value, left = nothing, right = nothing) = new(
		value,
		typeof(left) === Node || left === nothing ? left : Node(left),
		typeof(right) === Node || right === nothing ? right : Node(right),
	)
end

"Preorder traversal: Node -> Left -> Right"
function preorder(node::Union{Node, Nothing})
	node === nothing && return []
	[node.value; preorder(node.left)...; preorder(node.right)...]
end

"Inorder traversal: Left -> Node -> Right"
function inorder(node::Union{Node, Nothing})
	node === nothing && return []
	[inorder(node.left)...; node.value; inorder(node.right)...]
end

"Postorder traversal: Left -> Right -> Node"
function postorder(node::Union{Node, Nothing})
	node === nothing && return []
	[postorder(node.left)...; postorder(node.right)...; node.value]
end

function build_tree(values::Vector{Int})::Node
	n = length(values)
	nodes = [Node(values[i]) for i in 1:n]

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

function to_dendogram(node::Union{Node, Nothing})
	if node === nothing
		return Dendogram("")
	end

	left_dend = to_dendogram(node.left)
	right_dend = to_dendogram(node.right)

	if node.left === nothing && node.right === nothing
		return Dendogram(node.value)
	end

	return link(left_dend, right_dend; title = string(map_bitwise(node.value)))
end

function print_tree(node::Union{Node, Nothing})
	print_filtered(string(to_dendogram(node)))
end

function tree_info(values::Vector{Int})
	println("Nodes:")
	println(join(values, ", "))

	tree = build_tree(values)
	println("\nTree:")
	print_tree(tree)

	traversals = Dict(
		"Preorder Traversal" => preorder,
		"Inorder Traversal" => inorder,
		"Postorder Traversal" => postorder,
	)

	for (name, traversal) in traversals
		println("\n$name:")
		println(join(traversal(tree), ", "))
	end
end

function expression_tree_info(node::Node)
	println("Tree:")
	print_tree(node)

	expression = generate_expression(node)
	println("\nExpression:")
	print_filtered(expression)

	nodes = inorder(node)
	variables = filter(x -> typeof(x) === String, nodes)
	joined_variables = join(variables, ", ")
	joined_str_variables = join(variables, "\", \"")

	try
		if !isempty(variables)
			eval(Meta.parse("_, ($joined_variables) = polynomial_ring(QQ, [\"$joined_str_variables\"])"))
		end

		evaluated_math_expression = string(eval(Meta.parse(expression)))

		if evaluated_math_expression != expression
			println("\nEvaluated Expression:")
			print_filtered(evaluated_math_expression)
		end
	catch e
		println("\nInvalid Expression: $e")
	end
end

function generate_expression(node::Union{Node, Nothing}; top_level::Bool = true)::String
	if node isa Nothing
		return ""
	elseif node.left === nothing && node.right === nothing
		return string(node.value)
	end

	left_expr = generate_expression(node.left, top_level = false)
	right_expr = generate_expression(node.right, top_level = false)
	expr = "$left_expr $(map_bitwise(node.value)) $right_expr"

	return top_level ? expr : "($expr)"
end

function print_filtered(expression::String)
	println(replace(expression, "//" => "/", "xor" => "⊻", "nand" => "⊼", "nor" => "⊽"))
end

function map_bitwise(x)
	if x === ⊻
		return "⊻"
	elseif x === ⊼
		return "⊼"
	elseif x === ⊽
		return "⊽"
	end

	return x
end

values = [14, 15, 4, 9, 7, 18, 3, 5, 16, 4, 20, 17]

println("--- ORIGINAL TREE ---")
tree_info(values)

println("\n\n--- INVERTED TREE ---")
tree_info(reverse(values))

algebraic_tree_example1 = Node(//, Node(*, "Y", "X"), Node(*, Node(+, "A", "B"), "C"))
algebraic_tree_example2 = Node(+, Node(//, Node(*, "X", "Y"), "A"), Node(*, "B", "C"))

algebraic_tree_examples = Dict(
	"Y * X / ( A + B ) * C" => algebraic_tree_example1,
	"X * Y / A + B * C" => algebraic_tree_example2,
)

for (i, (expression, tree)) in enumerate(algebraic_tree_examples)
	println("\n\n--- ALGEBRAIC EXPRESSION TREE EXAMPLE $i ---")
	println("Tree:")
	print_tree(tree)
	println("\nExpression:")
	print_filtered(expression)
end

algebraic_tree1 = Node(+, Node(*, "a", "b"), Node(//, "c", "d"))
algebraic_tree2 = Node(+, Node(+, Node(+, "a", "b"), "c"), "d")
algebraic_tree3 = Node(//, Node(+, Node(-, nothing, "a"), Node(+, "x", "y")), Node(*, Node(+, nothing, "b"), Node(*, "c", "d")))

for (i, tree) in enumerate((algebraic_tree1, algebraic_tree2, algebraic_tree3))
	println("\n\n--- ALGEBRAIC EXPRESSION TREE $i ---")
	expression_tree_info(tree)
end

arithmetic_tree1 = Node(+, Node(*, 3, 4), Node(//, 5, 6))
arithmetic_tree2 = Node(+, Node(+, Node(+, 1, 2), 3), 4)
arithmetic_tree3 = Node(//, Node(+, Node(-, nothing, 1), Node(+, 2, 3)), Node(*, Node(+, nothing, 4), Node(*, 5, 6)))

for (i, tree) in enumerate((arithmetic_tree1, arithmetic_tree2, arithmetic_tree3))
	println("\n\n--- ARITHMETIC EXPRESSION TREE $i ---")
	expression_tree_info(tree)
end

bitwise_tree1 = Node(&, Node(⊻, 10, 12), Node(⊼, 9, 14))
bitwise_tree2 = Node(&, Node(|, Node(&, 10, 12), 14), 10)
bitwise_tree3 = Node(⊼, Node(&, Node(⊻, 10, 12), Node(⊼, 10, 12)), Node(|, Node(⊽, 10, 12), Node(⊼, 12, 10)))

for (i, tree) in enumerate((bitwise_tree1, bitwise_tree2, bitwise_tree3))
	println("\n\n--- BITWISE EXPRESSION TREE $i ---")
	expression_tree_info(tree)
end

logical_tree1 = Node(&, Node(⊻, false, false), Node(⊼, true, true))
logical_tree2 = Node(&, Node(|, Node(&, true, false), true), false)
logical_tree3 = Node(⊼, Node(&, Node(⊻, false, false), Node(⊼, false, true)), Node(|, Node(⊽, false, false), Node(⊼, true, false)))

for (i, tree) in enumerate((logical_tree1, logical_tree2, logical_tree3))
	println("\n\n--- LOGICAL EXPRESSION TREE $i ---")
	expression_tree_info(tree)
end
