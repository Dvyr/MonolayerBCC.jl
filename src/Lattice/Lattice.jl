module Lattice

# Export functions you want visible to other modules automatically
export transform_coords, generate_neighbors

# Include the source files containing the actual code
include("coordinates.jl")
include("neighbors.jl")
include("geometry.jl")

end # module Lattice
