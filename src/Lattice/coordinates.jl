# This code implicitly belongs to the MyLatticeSim.Lattice module

struct Coordinate3D
    x::Int
    y::Int
    z::Int
end

function transform_coords(coord::Coordinate3D)
    # math transformations go here
    return coord
end

function generate_neighbors(coord::Coordinate3D)
    # neighbor generation goes here
    return [coord]
end