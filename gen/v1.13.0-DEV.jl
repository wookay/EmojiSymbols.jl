# module EmojiSymbols

function init_v1130_DEV(REPL::Module)
    for f in reverse((
       init_v1130_DEV_595,
       ))
       f(REPL)
    end
end

# julia commit 229a6984ee142283d81955d8d53d7985fd5736ca
# Wed May 14 09:53:37 2025 -0700
# Add JuliaLang/JuliaSyntax.jl#525 to NEWS.md, flisp parser, and REPL (#57143)
#
# Now that JuliaLang/JuliaSyntax.jl#525 has been merged, also add it to
# the flisp parser and REPL, and document it!
function init_v1130_DEV_595(REPL::Module)
    if VERSION < v"1.13.0-DEV.595"
        latex_symbols = Dict(
            "\\hookunderrightarrow" => "🢲",
        )
        merge!(REPL.REPLCompletions.latex_symbols, latex_symbols)
    end
end

# module EmojiSymbols
