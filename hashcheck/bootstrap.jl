(pwd() != @__DIR__) && cd(@__DIR__) # allow starting app from bin/ dir

using Hashcheck
push!(Base.modules_warned_for, Base.PkgId(Hashcheck))
Hashcheck.main()
