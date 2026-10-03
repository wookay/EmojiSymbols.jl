using Jive
targets = string("repl emojisymbols", haskey(ENV, "CI") ? " pkgs" : "")
into = Main
runtests(@__DIR__; targets, into)
