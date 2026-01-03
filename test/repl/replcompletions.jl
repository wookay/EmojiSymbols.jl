module test_repl_replcompletions

loaded = haskey(Base.loaded_modules, Base.PkgId(Base.UUID("c599478c-de41-4aed-94ea-b47665d7a42a"), "EmojiSymbols"))

module Codex
include(normpath(@__DIR__, "../../src/types.jl"))
include(normpath(@__DIR__, "../../src/patches.jl"))
end # module Codex

using .Codex: Patch, AddEmojiSymbols, AddLatexSymbols, RemoveLatexSymbols, AddSymbolsLatexCanonical,
              patches_to_be_loaded

include(normpath(@__DIR__, "../common/routines.jl"))

check_the_patches(loaded)

end # module test_repl_replcompletions
