module test_emojisymbols_latex

using Test
using REPL

function compat_v190_DEV_346()
    @test !haskey(REPL.REPLCompletions.latex_symbols, "\\sqspne")
    @test REPL.REPLCompletions.latex_symbols["\\sqsupsetneq"] == "⋥"
end

function not_compat_v190_DEV_346()
    @test haskey(REPL.REPLCompletions.latex_symbols, "\\sqspne")
    @test !haskey(REPL.REPLCompletions.latex_symbols, "\\sqsupsetneq")
end

function compat_v190_DEV_332()
    @test REPL.REPLCompletions.latex_symbols["\\neq"] == "≠"
end

function not_compat_v190_DEV_332()
    @test !haskey(REPL.REPLCompletions.latex_symbols, "\\neq")
end

function compat_v170_DEV_894()
    @test REPL.REPLCompletions.latex_symbols["\\Top"] == "⫪"
end

function not_compat_v170_DEV_894()
    @test !haskey(REPL.REPLCompletions.latex_symbols, "\\Top")
end

function compat_v170_DEV_893()
    @test REPL.REPLCompletions.latex_symbols["\\nand"] == "⊼"
end

function not_compat_v170_DEV_893()
    @test !haskey(REPL.REPLCompletions.latex_symbols, "\\nand")
end

function compat_v1110_DEV_12()
    @test REPL.REPLCompletions.latex_symbols["\\guillemotleft"] == "«"
end

function not_compat_v1110_DEV_12()
    @test !haskey(REPL.REPLCompletions.latex_symbols, "\\guillemotleft")
end

function test_part1()
    VERSION >= v"1.9.0-DEV.346" ? compat_v190_DEV_346() : not_compat_v190_DEV_346()
    VERSION >= v"1.9.0-DEV.332" ? compat_v190_DEV_332() : not_compat_v190_DEV_332()
    VERSION >= v"1.7.0-DEV.894" ? compat_v170_DEV_894() : not_compat_v170_DEV_894()
    VERSION >= v"1.7.0-DEV.893" ? compat_v170_DEV_893() : not_compat_v170_DEV_893()
    VERSION >= v"1.11.0-DEV.12" ? compat_v1110_DEV_12() : not_compat_v1110_DEV_12()
end

function test_part2()
    compat_v190_DEV_346()
    compat_v190_DEV_332()
    compat_v170_DEV_894()
    compat_v170_DEV_893()
    compat_v1110_DEV_12()
end


test_part1()

(emoji_symbols, latex_symbols) = copy(REPL.REPLCompletions.emoji_symbols), copy(REPL.REPLCompletions.latex_symbols)
symbols_latex_canonical = isdefined(REPL.REPLCompletions, :symbols_latex_canonical) ? copy(REPL.REPLCompletions.symbols_latex_canonical) : Dict()
loaded_EmojiSymbols = haskey(Base.loaded_modules, Base.PkgId(Base.UUID("c599478c-de41-4aed-94ea-b47665d7a42a"), "EmojiSymbols"))

using EmojiSymbols
loaded_EmojiSymbols && EmojiSymbols.__init__()

test_part2()

EmojiSymbols.reset_REPL_completions(emoji_symbols, latex_symbols, symbols_latex_canonical)

test_part1()

end # module test_emojisymbols_latex
