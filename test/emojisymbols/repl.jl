module test_emojisymbols_repl

using Test
using EmojiSymbols
using REPL

@test REPL.REPLCompletions.emoji_symbols["\\:thinking_face:"] == "🤔"

end # module test_emojisymbols_repl
