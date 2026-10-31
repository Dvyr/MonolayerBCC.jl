
struct Monolayer
    box::NTuple{3,Int32}    
    chains::Vector{Chain}
    occupancy::Array{Int32,3}
    n_chains::Int
    n_bonds::Int
end

# Generate a dense array of tethering points for the chains
# on the XY plane with z=0.
# The tethering points are generated with equation: R = (x, y, 0)
# where x and y are even interior coordinates in the ranges (2, max_x-2) and (2, max_y-2).
# Border points are excluded.
function generate_tethering_points(max_x::Int, max_y::Int)
    if max_x < 0 || max_y < 0
        throw(ArgumentError("max_x and max_y must be non-negative"))
    end

    points = NTuple{3,Int32}[]
    for x_coord in 2:2:(max_x - 2)
        for y_coord in 2:2:(max_y - 2)
            push!(points, (x_coord, y_coord, 0))
        end
    end
    return points
end

# Build a monolayer in a box of size (x_box, y_box, n+2) using zig-zag chains
# of length n tethered to all generated tethering points.
function generate_monolayer(x_box::Int, y_box::Int, n::Int)
    x_box > 0 || throw(ArgumentError("x_box must be positive"))
    y_box > 0 || throw(ArgumentError("y_box must be positive"))
    n >= 1 || throw(ArgumentError("n must be positive"))

    z_box = n + 2 # safe z box size to accommodate chains of length n

    tethering_points = generate_tethering_points(x_box, y_box)
    chains = Vector{Chain}(undef, length(tethering_points))
    occupancy = zeros(Int32, x_box, y_box, z_box)

    for (idx, anchor) in enumerate(tethering_points)
        chain = zigzag_chain(n; anchor=anchor)
        chains[idx] = chain

        for coord in chain.coordinates
            x_idx = Int(coord[1]) + 1
            y_idx = Int(coord[2]) + 1
            z_idx = Int(coord[3]) + 1

            if x_idx < 1 || x_idx > x_box || y_idx < 1 || y_idx > y_box || z_idx < 1 || z_idx > z_box
                throw(ArgumentError("Chain coordinate $(coord) is out of monolayer box bounds"))
            end

            occupancy[x_idx, y_idx, z_idx] = Int32(1)
        end
    end

    n_chains = length(chains)
    n_bonds = n_chains * n
    return Monolayer((Int32(x_box), Int32(y_box), Int32(z_box)), chains, occupancy, n_chains, n_bonds)
end
