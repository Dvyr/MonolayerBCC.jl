# Monolayer lattice model

BCC sub-lattice geometry.

## Project structure

MyLatticeSim/

- Project.toml

- src/

  - *MyLatticeSim.jl*         # Top-level entry point

  - Lattice/

    - *Lattice.jl*          # Parent module for Lattice

    - *coordinates.jl*      # coordinate transformations

    - *neighbors.jl*        # neighbor generation

    - *geometry.jl*         # interface geometry

  - Configuration/

    - *Configuration.jl*    # Parent module for Configuration

    - *chain.jl*            # chain coordinates

    - *grid.jl*             # occupancy grid

    - *identities.jl*       # chemical identities

  - Moves/

    - *Moves.jl*            # Parent module for Moves

    - *end_moves.jl*

    - *crankshaft.jl*

    - *validation.jl*

  - MonteCarlo/

    - *MonteCarlo.jl*       # Parent module for MonteCarlo

    - *proposal.jl*

    - *energy.jl*

    - *acceptance.jl*

    - *statistics.jl*


