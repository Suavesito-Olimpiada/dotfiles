using BenchmarkTools
using Debugger
using OhMyREPL
using ProgressMeter
using Revise
using REPL
REPL.REPLCompletions.latex_symbols["\\julia"] = "\ue624"

push!(LOAD_PATH, "/media/data/Programming/Langs/Julia")
ENV["PAGER"] = "julia_pager.sh"

# using Cthulhu
# using IJulia
# using ProfileView
# using Traceur

# using JuliaFormatter
# using LanguageServer

#=
    haskey(Pkg.installed(), "SymbolServer") || @eval Pkg.add("SymbolServer")
    haskey(Pkg.installed(), "StaticLint") || @eval Pkg.add("StaticLint")
    haskey(Pkg.installed(), "JuliaFormatter") || @eval Pkg.add("StaticLint")
=#
