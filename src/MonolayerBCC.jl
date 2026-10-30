module MonolayerBCC

# Include files in order of architectural dependency
include("Configuration/Configuration.jl")
include("Moves/Moves.jl")
include("MonteCarlo/MonteCarlo.jl")

using .Configuration
using .Moves
using .MonteCarlo

export run_demo

function run_demo()
    # Initialize a clean starting state
    initial_coords = [Coordinate(0,0), Coordinate(0,1), Coordinate(1,1)]
    state = SimulationState(initial_coords, 5.0, 0, 0)
    
    println("Initial Energy: ", state.energy)
    
    # Run 5 Monte Carlo steps on particle index 2
    for _ in 1:5
        run_metropolis_step!(state, 2, 1.0)
    end
    
    println("Final Energy: ", state.energy)
    println("Acceptance Rate: ", state.accepted_moves / state.total_moves)
end

end # module MonolayerBCC