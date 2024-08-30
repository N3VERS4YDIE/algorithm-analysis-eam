function t1_function(n::Int, m::Int)::Int
    return 4 + 3n + 4n * m
end

function t1_simulation(n::Int, m::Int)::Int
    e = 4

    for k in 1:n
        e += 4

        for j in 1:m
            e += 3

            if k != j
                e += 1
            end
        end
    end

    return e
end

N1 = 5
println("SOLUTION 1 -------------------")
println("T(n, m) = 4 + 3n + 4nm")
println("------------------------------")
println("FUNCTION VS SIMULATION")

for i in 1:N1
    for j in 1:N1
        e1 = t1_simulation(i, j)
        e2 = t1_function(i, j)
        comparison = e1 == e2
        println("T($i, $j) = $e1 == $e2  =>  $comparison")
    end
end
