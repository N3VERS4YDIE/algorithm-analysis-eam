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

N2 = 10
println("\nSOLUTION 2 -------------------")
println("T(n) = 5 + 7n + 3n ⌊log2(n)⌋")
println("------------------------------")
println("FUNCTION VS SIMULATION")

for i in 1:N2
    e1, su1 = t_simulation(i)
    e2, su2 = t_function(i)
    comparison = e1 == e2 && su1 == su2
    println("T($i) = $e1 == $e2  &&  su = $su1 == $su2  =>  $comparison")
end
