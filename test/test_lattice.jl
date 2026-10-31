using MonolayerBCC
using Test

@testset "Lattice Geometry Tests" begin
    @testset "generate_tethering_points builds interior even points" begin
        points = MonolayerBCC.Lattice.generate_tethering_points(6, 8)
        expected = NTuple{3,Int32}[
            (2, 2, 0), (2, 4, 0), (2, 6, 0),
            (4, 2, 0), (4, 4, 0), (4, 6, 0),
        ]
        @test points == expected
    end

    @testset "generate_tethering_points excludes borders and handles small planes" begin
        @test MonolayerBCC.Lattice.generate_tethering_points(2, 2) == NTuple{3,Int32}[]
        @test MonolayerBCC.Lattice.generate_tethering_points(4, 4) == NTuple{3,Int32}[(2, 2, 0)]
    end

    @testset "generate_tethering_points validates non-negative bounds" begin
        @test_throws ArgumentError MonolayerBCC.Lattice.generate_tethering_points(-1, 4)
        @test_throws ArgumentError MonolayerBCC.Lattice.generate_tethering_points(4, -1)
    end

    @testset "generate_monolayer builds tethered chains in fixed-height box" begin
        monolayer = MonolayerBCC.Lattice.generate_monolayer(6, 6, 11)

        @test monolayer.box == (Int32(6), Int32(6), Int32(13))
        @test monolayer.n_chains == 4
        @test size(monolayer.occupancy) == (6, 6, 13)
        @test all(length(chain.coordinates) == 12 for chain in monolayer.chains)
    end

    @testset "generate_monolayer validates non-negative bounds" begin
        @test_throws ArgumentError MonolayerBCC.Lattice.generate_monolayer(-1, 4, 11)
        @test_throws ArgumentError MonolayerBCC.Lattice.generate_monolayer(4, -1, 11)
        @test_throws ArgumentError MonolayerBCC.Lattice.generate_monolayer(4, 4, -1)
    end
end
