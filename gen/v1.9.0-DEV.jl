# module EmojiSymbols

function init_v190_DEV(REPL::Module)
    for f in reverse((
       init_v190_DEV_346,
       init_v190_DEV_332,
       ))
       f(REPL)
    end
end

# julia commit 315a5ddb46628373b72e1b700d5bd8e35cd78df7
# Fri Apr 8 03:39:04 2022 +0900
# [REPL] replace \sqspne with \sqsupsetneq (#44899)
function init_v190_DEV_346(REPL::Module)
    if VERSION < v"1.9.0-DEV.346"
        deleted_latex_symbols = [
            "\\sqspne" => "⋥",
        ]
        for (name, symbol) in deleted_latex_symbols
            delete!(REPL.REPLCompletions.latex_symbols, name)
        end
        latex_symbols = Dict(
            "\\sqsupsetneq" => "⋥",  # square superset, not equals
        )
        merge!(REPL.REPLCompletions.latex_symbols, latex_symbols)
    end
end

# julia commit 559244b383cf1a146f6c8e4ed81b1b746276abe0
# Wed Apr 6 12:01:37 2022 -0400
# Add \neq tab completion to ≠ (#44849)
function init_v190_DEV_332(REPL::Module)
    if VERSION < v"1.9.0-DEV.332"
        latex_symbols = Dict(
            "\\neq" => "≠",
        )
        symbols_latex_canonical = Dict(
            "≠" => "\\ne",
        )
        merge!(REPL.REPLCompletions.latex_symbols, latex_symbols)
        merge_symbols_latex_canonical!(REPL, symbols_latex_canonical)
    end
end

# module EmojiSymbols
