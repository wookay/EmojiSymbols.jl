module test_emojisymbols_emoji

using Test
using REPL

function compat_v170_DEV_849()
    @test REPL.REPLCompletions.emoji_symbols["\\:thinking_face:"] == "🤔"
end

function not_compat_v170_DEV_849()
    @test !haskey(REPL.REPLCompletions.emoji_symbols, "\\:thinking_face:")
end


# part 1
VERSION >= v"1.7.0-DEV.849" ? compat_v170_DEV_849() : not_compat_v170_DEV_849()

(emoji_symbols, latex_symbols) = copy(REPL.REPLCompletions.emoji_symbols), copy(REPL.REPLCompletions.latex_symbols)
symbols_latex_canonical = isdefined(REPL.REPLCompletions, :symbols_latex_canonical) ? copy(REPL.REPLCompletions.symbols_latex_canonical) : Dict()
loaded_EmojiSymbols = haskey(Base.loaded_modules, Base.PkgId(Base.UUID("c599478c-de41-4aed-94ea-b47665d7a42a"), "EmojiSymbols"))

using EmojiSymbols
loaded_EmojiSymbols && EmojiSymbols.__init__()

# part 2
compat_v170_DEV_849()

EmojiSymbols.reset_REPL_completions(emoji_symbols, latex_symbols, symbols_latex_canonical)

# part 1
VERSION >= v"1.7.0-DEV.849" ? compat_v170_DEV_849() : not_compat_v170_DEV_849()

end # module test_emojisymbols_emoji
