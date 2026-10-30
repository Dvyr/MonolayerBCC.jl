module MonteCarlo

using ..Configuration: SimulationState
using ..Moves: propose_crankshaft_move!, revert_move!

export run_metropolis_step!

function run_metropolis_step!(state::SimulationState, index::Int, temperature::Float64)
    state.total_moves += 1
    
    # Propose the move and keep track of old data to allow rolling back
    old_coord = propose_crankshaft_move!(state, index)
    
    # Mock energy calculation
    new_energy = rand() * 10.0 
    energy_difference = new_energy - state.energy
    
    # Metropolis acceptance criteria
    if energy_difference <= 0 || rand() < exp(-energy_difference / temperature)
        # Accept the move
        state.energy = new_energy
        state.accepted_moves += 1
    else
        # Reject the move and cleanly roll back the state
        revert_move!(state, index, old_coord)
    end
end

end # module MonteCarlo