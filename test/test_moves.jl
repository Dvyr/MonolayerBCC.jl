using MonolayerBCC.Configuration
using MonolayerBCC.Moves
using Test

# Setup test fixtures (mock data)
coords = [Coordinate(0,0), Coordinate(0,1)]
state = SimulationState(coords, 0.0, 0, 0)

@testset "Crankshaft Move Mechanics" begin
    # Test that the proposal mutates the state correctly
    old_coord = propose_crankshaft_move!(state, 2)
    
    @test state.positions[2] == Coordinate(1, 1)
    @test old_coord == Coordinate(0, 1)

    # Test that reverting a move restores the original state
    revert_move!(state, 2, old_coord)
    @test state.positions[2] == Coordinate(0, 1)
end