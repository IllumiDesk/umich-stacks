#!/bin/bash
set -exuo pipefail
# Requirements:
# - Run as a non-root user
# - The JULIA_PKGDIR environment variable is set
# - Julia is already set up, with the setup_julia.py command

# replaces the default julia environment with the one we want
# ref: https://github.com/jupyter/docker-stacks/blob/main/images/minimal-notebook/setup-scripts/setup-julia-packages.bash
if [ "$(uname -m)" == "x86_64" ]; then
    # See https://github.com/JuliaCI/julia-buildkite/blob/70bde73f6cb17d4381b62236fc2d96b1c7acbba7/utilities/build_envs.sh#L24
    # for an explanation of these options
    export JULIA_CPU_TARGET="generic;sandybridge,-xsaveopt,clone_all;haswell,-rdrnd,base(1)"
elif [ "$(uname -m)" == "aarch64" ]; then
    # See https://github.com/JuliaCI/julia-buildkite/blob/70bde73f6cb17d4381b62236fc2d96b1c7acbba7/utilities/build_envs.sh#L54
    # for an explanation of these options
    export JULIA_CPU_TARGET="generic;cortex-a57;thunderx2t99;carmel"
fi

# Install base Julia packages
julia -e '
import Pkg;
Pkg.update();
Pkg.add([
    "BenchmarkTools"
    "Colors"
    "CSV"
    "CSVFiles"
    "Compat"
    "CoordinateTransformations"
    "DataFrames"
    "DelimitedFiles"
    "DifferentialEquations"
    "Distributions"
    "FileIO"
    "FiniteDiff"
    "ForwardDiff"
    "GeometryBasics"
    "GMT"
    "Images"
    "ImageInTerminal"
    "ImageFiltering"
    "ImageFeatures"
    "Interact"
    "Interpolations"
    "JLD2"
    "LinearAlgebra"
    "LaTeXStrings"
    "Latexify"
    "MeshCat"
    "OSQP"
    "Plots"
    "Plotly"
    "Printf"
    "ProgressBars"
    "PyPlot"
    "Random"
    "Rotations"
    "Roots"
    "SparseArrays"
    "SymEngine"
    "Symbolics"
    "Statistics"
    "StaticArrays"
    "WebIO"
    "WGLMakie"
]);
Pkg.precompile();
'

# Move the kernelspec out of ${HOME} to the system share location.
# Avoids problems with runtime UID change not taking effect properly
# on the .local folder in the jovyan home dir.
mv "${HOME}/.local/share/jupyter/kernels/julia"* "${CONDA_DIR}/share/jupyter/kernels/"
chmod -R go+rx "${CONDA_DIR}/share/jupyter"
rm -rf "${HOME}/.local"
fix-permissions "${JULIA_PKGDIR}" "${CONDA_DIR}/share/jupyter"
