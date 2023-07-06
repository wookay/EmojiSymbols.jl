# module EmojiSymbols

function init_v1110_DEV(REPL::Module)
    for f in reverse((
       init_v1110_DEV_12,
       ))
       f(REPL)
    end
end

# julia commit fcb31107a9515dda8b519e126c039c345ef7daf9
# Wed Jul 5 14:03:10 2023 +0300
# REPL/latex_symbols: define commands for « and » (#50399)
function init_v1110_DEV_12(REPL::Module)
    if VERSION < v"1.11.0-DEV.12"
        latex_symbols = Dict(
            "\\guilsinglleft" => "‹", # note: \guil* quote names follow the LaTeX csquotes package
            "\\guillemotleft" => "«",
            "\\guillemotright" => "»",
        )
        merge!(REPL.REPLCompletions.latex_symbols, latex_symbols)
    end
end

# module EmojiSymbols
