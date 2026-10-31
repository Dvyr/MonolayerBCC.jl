module Visualization

using CairoMakie
using ..Lattice: Monolayer, generate_monolayer

export plot_monolayer_3d, save_rotating_monolayer_3d, plot_monolayer_3d_example

include("monolayer_makie.jl")

function plot_monolayer_3d_example(; x_box::Int=10, y_box::Int=10, n::Int=4)
    monolayer = generate_monolayer(x_box, y_box, n)
    return plot_monolayer_3d(monolayer)
end


end # module