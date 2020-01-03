atreplinit() do repl
    try
        @eval using Pkg
        haskey(Pkg.installed(), "OhMyREPL") || @eval Pkg.add("OhMyREPL")
        haskey(Pkg.installed(), "Revise") || @eval Pkg.add("Revise")
        haskey(Pkg.installed(), "Traceur") || @eval Pkg.add("Traceur")
        haskey(Pkg.installed(), "Rebugger") || @eval Pkg.add("Rebugger")
        haskey(Pkg.installed(), "ProgressMeter") || @eval Pkg.add("ProgressMeter")
        haskey(Pkg.installed(), "BenchmarkTools") || @eval Pkg.add("BenchmarkTools")
        haskey(Pkg.installed(), "ProfileView") || @eval Pkg.add("ProfileView")
    catch
    end
    try
        @eval using OhMyREPL
        @eval using Traceur
        @eval using Rebugger
        @eval using ProgressMeter
        @eval using BenchmarkTools
        @eval using ProfileView
        @eval using Revise
        @async Revise.wait_steal_repl_backend()
    catch
    end
end
