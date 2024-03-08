# Source: https://discourse.julialang.org/t/building-a-dockerfile-with-packages/37272/2
using Pkg
pkg"add BenchmarkTools"
pkg"add Colors"
pkg"add CSV"
pkg"add CSVFiles"
pkg"add Compat"
pkg"add CoordinateTransformations"
pkg"add DataFrames"
pkg"add DelimitedFiles"
pkg"add DifferentialEquations"
pkg"add Distributions"
pkg"add FileIO"
pkg"add FiniteDiff"
pkg"add ForwardDiff"
pkg"add GeometryBasics"
pkg"add GMT"
pkg"add Images"
pkg"add ImageInTerminal"
pkg"add ImageFiltering"
pkg"add ImageFeatures"
pkg"add Interact"
pkg"add Interpolations"
pkg"add JLD2"
pkg"add LinearAlgebra"
pkg"add LaTeXStrings"
pkg"add Latexify"
pkg"add MeshCat"
pkg"add OSQP"
pkg"add Plots"
pkg"add Plotly"
pkg"add Printf"
pkg"add ProgressBars"
pkg"add PyPlot"
pkg"add Random"
pkg"add Rotations"
pkg"add Roots"
pkg"add SparseArrays"
pkg"add SymEngine"
pkg"add Symbolics"
pkg"add Statistics"
pkg"add StaticArrays"
pkg"add WebIO"
pkg"add WGLMakie"
pkg"add https://github.com/VMLS-book/VMLS.jl"
Pkg"precompile"
