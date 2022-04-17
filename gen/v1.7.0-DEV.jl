# module EmojiSymbols

function init_v170_DEV(REPL::Module)
    for f in reverse((
       init_v170_DEV_894,
       init_v170_DEV_893,
       init_v170_DEV_849,
       ))
       f(REPL)
    end
end

# julia commit 4996445df37e526dac2772e333caf82f1ea987f0
# Fri Apr 9 16:19:28 2021 +0200
# Add U+2AEA (⫪) and U+2AEB (⫫) to binary operators (#39403)
function init_v170_DEV_894(REPL::Module)
    if VERSION < v"1.7.0-DEV.894"
        latex_symbols = Dict(
            "\\Top" => "⫪",
            "\\Bot" => "⫫",
            "\\indep" => "⫫",
            "\\downvDash" => "⫪",
            "\\upvDash" => "⫫",
        )
        symbols_latex_canonical = Dict(
            "⫫" => "\\Bot",
            "⫪" => "\\Top",
        )
        merge!(REPL.REPLCompletions.latex_symbols, latex_symbols)
        merge_symbols_latex_canonical!(REPL, symbols_latex_canonical)
    end
end

# julia commit b838cdfbb54515f8007a2958ebcdd58b76513db5
# Fri Apr 9 09:16:03 2021 -0500
# Implemented bitwise nand and nor (#40339)
function init_v170_DEV_893(REPL::Module)
    if VERSION < v"1.7.0-DEV.893"
        latex_symbols = Dict(
            "\\nand" => "⊼",
            "\\nor" => "⊽",
        )
        symbols_latex_canonical = Dict(
            "⊼" => "\\nand",
            "⊽" => "\\nor",
        )
        merge!(REPL.REPLCompletions.latex_symbols, latex_symbols)
        merge_symbols_latex_canonical!(REPL, symbols_latex_canonical)
    end
end

# julia commit 2fc32f2ea247c0c03ea78b229ff159af84c45fb1
# Tue Apr 6 16:19:22 2021
# Update Emoji Completions (#39111)
# * Update Emoji Completions
# * =new should overwrite old
function init_v170_DEV_849(REPL::Module)
    if VERSION < v"1.7.0-DEV.849"
        empty!(REPL.REPLCompletions.emoji_symbols)
        empty!(REPL.REPLCompletions.latex_symbols)
        isdefined(REPL.REPLCompletions, :symbols_latex_canonical) && empty!(REPL.REPLCompletions.symbols_latex_canonical)

        # emoji_symbols, latex_symbols, symbols_latex_canonical
        m = Module()
        for file in ("emoji_symbols.jl", "latex_symbols.jl")
            code = read(normpath(@__DIR__, "2fc32f2ea2_1.7.0-DEV.849", file), String)
            include_string(m, code, file)
        end
        merge!(REPL.REPLCompletions.emoji_symbols, m.emoji_symbols)
        merge!(REPL.REPLCompletions.latex_symbols, m.latex_symbols)
        merge_symbols_latex_canonical!(REPL, m.symbols_latex_canonical)
    end
end

# module EmojiSymbols
