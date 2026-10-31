function plot_monolayer_3d(
    monolayer::Monolayer;
    chain_color=:dodgerblue,
    bead_color=:orange,
    linewidth::Real=2,
    markersize::Real=8,
    azimuth::Real=1.275 * pi,
    elevation::Real=pi / 8,
)
    fig = Figure()
    ax = Axis3(
        fig[1, 1],
        title="Monolayer 3D Chains",
        xlabel="x",
        ylabel="y",
        zlabel="z",
        azimuth=azimuth,
        elevation=elevation,
    )

    for chain in monolayer.chains
        xs = Float64[coord[1] for coord in chain.coordinates]
        ys = Float64[coord[2] for coord in chain.coordinates]
        zs = Float64[coord[3] for coord in chain.coordinates]

        lines!(ax, xs, ys, zs, color=chain_color, linewidth=linewidth)
        scatter!(ax, xs, ys, zs, color=bead_color, markersize=markersize)
    end

    x_box, y_box, z_box = monolayer.box
    xlims!(ax, 0, Int(x_box) - 1)
    ylims!(ax, 0, Int(y_box) - 1)
    zlims!(ax, 0, Int(z_box) - 1)

    return fig
end

function save_rotating_monolayer_3d(
    monolayer::Monolayer,
    output_path::AbstractString;
    chain_color=:dodgerblue,
    bead_color=:orange,
    linewidth::Real=2,
    markersize::Real=8,
    nframes::Int=120,
    fps::Int=30,
    loops::Int=1,
    elevation::Real=pi / 8,
)
    nframes > 1 || throw(ArgumentError("nframes must be greater than 1"))
    fps > 0 || throw(ArgumentError("fps must be positive"))
    loops >= 1 || throw(ArgumentError("loops must be at least 1"))

    fig = Figure()
    ax = Axis3(
        fig[1, 1],
        title="Monolayer 3D Chains",
        xlabel="x",
        ylabel="y",
        zlabel="z",
        elevation=elevation,
    )

    for chain in monolayer.chains
        xs = Float64[coord[1] for coord in chain.coordinates]
        ys = Float64[coord[2] for coord in chain.coordinates]
        zs = Float64[coord[3] for coord in chain.coordinates]

        lines!(ax, xs, ys, zs, color=chain_color, linewidth=linewidth)
        scatter!(ax, xs, ys, zs, color=bead_color, markersize=markersize)
    end

    x_box, y_box, z_box = monolayer.box
    xlims!(ax, 0, Int(x_box) - 1)
    ylims!(ax, 0, Int(y_box) - 1)
    zlims!(ax, 0, Int(z_box) - 1)

    total_frames = nframes * loops
    record(fig, output_path, range(0, 2pi * loops, length=total_frames); framerate=fps) do angle
        ax.azimuth[] = angle
    end

    return output_path
end