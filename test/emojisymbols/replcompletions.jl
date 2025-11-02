module test_emojisymbols_replcompletions

using EmojiSymbols: Patch, AddEmojiSymbols, AddLatexSymbols, RemoveLatexSymbols, AddSymbolsLatexCanonical,
                    patches_to_be_loaded

include(normpath(@__DIR__, "../common/routines.jl"))

check_the_patches(true)

end # module test_emojisymbols_replcompletions
