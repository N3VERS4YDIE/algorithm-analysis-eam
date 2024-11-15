using PrettyTables

function print_matrix(A)
    pretty_table(A, header=(), tf=tf_matrix)
end

A = [0 1 0 1 0
    1 0 1 0 1
    0 1 0 0 0
    1 0 0 0 1
    0 1 0 1 0]

n = size(A, 1)
S = zeros(Int, n, n)

for k in 1:n
    B = A^k
    global S += B
    println("A^$k")
    print_matrix(B)
    println()
end

println("S")
print_matrix(S)