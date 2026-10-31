using MonolayerBCC
using Test

@testset "Configuration Chain Tests" begin
    @testset "zigzag_chain returns Chain with expected coordinates" begin
        chain = MonolayerBCC.Configuration.zigzag_chain(4)
        expected = NTuple{3,Int32}[
            (0, 0, 0),
            (1, 1, 1),
            (0, 0, 2),
            (1, 1, 3),
            (0, 0, 4),
        ]

        @test chain isa MonolayerBCC.Configuration.Chain
        @test chain.coordinates == expected
    end

    @testset "zigzag_chain supports custom anchor" begin
        chain = MonolayerBCC.Configuration.zigzag_chain(1; anchor=(2, 4, 6))
        @test chain.coordinates == NTuple{3,Int32}[(2, 4, 6), (3, 5, 7)]
    end

    @testset "zigzag_chain validates bond count" begin
        @test_throws ArgumentError MonolayerBCC.Configuration.zigzag_chain(0)
    end
end