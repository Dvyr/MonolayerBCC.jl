module Moves

# Go up to the parent container, then down into Configuration
using ..Configuration: SimulationState, Coordinate
export propose_crankshaft_move!, revert_move!

function propose_crankshaft_move!(state::SimulationState, index::Int)
    # 1. Save old state for potential rejection later
    old_coord = state.positions[index]
    
    # 2. Mutate the state with a mock crankshaft rotation
    state.positions[index] = Coordinate(old_coord.x + 1, old_coord.y)
    
    # Return the old coordinate so MonteCarlo can revert if rejected
    return old_coord 
end

function revert_move!(state::SimulationState, index::Int, old_coord::Coordinate)
    # Undo the mutation if the move is rejected
    state.positions[index] = old_coord
end

end # module Moves