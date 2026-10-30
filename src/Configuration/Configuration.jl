module Configuration

export SimulationState, Coordinate

struct Coordinate
x::Int
y::Int
end

# A mutable struct allows you to alter the state during the simulation
mutable struct SimulationState
positions::Vector{Coordinate}
energy::Float64
accepted_moves::Int
total_moves::Int
end

end # module Configuration