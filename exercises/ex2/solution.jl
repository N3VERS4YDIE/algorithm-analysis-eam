function t_function(n::Int)::Tuple{Int,Int}
    e = 5 + 7n + 3n * floor(log2(n))
    s = n + n * floor(log2(n))
    return e, s
end

function t_simulation(n::Int)::Tuple{Int,Int}
    e = 5
    s = 0

    for _ in 1:n
        e += 4
        j = n

        while j > 0
            e += 3
            s += 1
            j = div(j, 2)
        end
    end

    return e, s
end

println("\nSOLUTION 2 -------------------")
println("T(n) = 5 + 7n + 3n ⌊log2(n)⌋")
println("------------------------------")
println("SIMULATION VS FUNCTION")

N = 10

for i in 1:N
    simulation_executions, simulation_result = t_simulation(i)
    function_executions, function_result = t_function(i)
    comparison = simulation_executions == function_executions && simulation_result == function_result
    println("T($i) = $simulation_executions == $function_executions  &&  su = $simulation_result == $function_result  =>  $comparison")
end
