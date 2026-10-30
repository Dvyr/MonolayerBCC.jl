using MonolayerBCC
using Test

@testset "MonolayerBCC.jl Total Suite" begin

    @testset "Configuration Tests" begin
        include("test_configuration.jl")
    end

    @testset "Moves Tests" begin
        include("test_moves.jl")
    end

    @testset "Monte Carlo Tests" begin
        include("test_montecarlo.jl")
    end

end