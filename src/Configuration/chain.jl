
struct Chain
    coordinates::Vector{NTuple{3,Int32}}
end


#    zigzag_chain(N; anchor=(0, 0, 0))
# Generate a zig-zag chain of N bonds, oriented perpendicular
# to the XY plane, using BCC-lattice bond vectors.
# Returns a Chain with N+1 monomer positions.
function zigzag_chain(N::Int; anchor::NTuple{3,<:Integer}=(0, 0, 0))
    N >= 1 || throw(ArgumentError("N must be positive"))

    positions = Vector{NTuple{3,Int32}}(undef, N + 1)
    positions[1] = (Int32(anchor[1]), Int32(anchor[2]), Int32(anchor[3]))

    b1 = (Int32(1), Int32(1), Int32(1))
    b2 = (Int32(-1), Int32(-1), Int32(1))

    for i in 1:N
        b = isodd(i) ? b1 : b2
        p = positions[i]

        positions[i+1] = (
            p[1] + b[1],
            p[2] + b[2],
            p[3] + b[3]
        )
    end

    return Chain(positions)
end
