using MonolayerBCC
using Test

@testset verbose=true "MonolayerBCC.jl Total Suite" begin

    @testset "Configuration and Chain Tests" begin
        include("test_configuration.jl")
    end

    @testset "Lattice Tests" begin
        include("test_lattice.jl")
    end

    @testset "Moves Tests" begin
        include("test_moves.jl")
    end

    @testset "Monte Carlo Tests" begin
        include("test_montecarlo.jl")
    end

end