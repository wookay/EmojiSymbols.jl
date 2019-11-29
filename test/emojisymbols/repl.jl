module test_emojisymbols_repl

using Test
using REPL

@test !haskey(REPL.REPLCompletions.emoji_symbols, "\\:thinking_face:")

end # module test_emojisymbols_repl
