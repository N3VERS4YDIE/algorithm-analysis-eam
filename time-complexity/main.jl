function t_function(n::Int, m::Int)::Int
    return 4 + 3n + 4n * m
end

function t_simulation(n::Int, m::Int)::Int
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

println("SOLUTION 1 -------------------")
println("T(n, m) = 4 + 3n + 4nm")
println("------------------------------")
println("SIMULATION VS FUNCTION")

N = 10
M = 10

for i in 1:N
    for j in 1:M
        simulation_executions = t_simulation(i, j)
        function_executions = t_function(i, j)
        comparison = simulation_executions == function_executions
        println("T($i, $j) = $simulation_executions == $function_executions  =>  $comparison")
    end
end
