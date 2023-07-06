# module EmojiSymbols

function init_v1100_DEV(REPL::Module)
    for f in reverse((
       init_v1100_DEV_1204,
       init_v1100_DEV_570,
       ))
       f(REPL)
    end
end

# julia commit ad939df098a58f38c6a2dc9aec5976f098a5e5e5
# Fri May 5 02:13:55 2023 +0200
# Add U+297A (`⥺`) and U+2977 (`⥷`) to binary operators (recreated) (#49623)
function init_v1100_DEV_1204(REPL::Module)
    if VERSION < v"1.10.0-DEV.1204"
        latex_symbols = Dict(
            "\\leftarrowless" => "\u2977",  # leftwards arrow through less-than
            "\\leftarrowsubset" => "\u297a",  # leftwards arrow through subset
        )
        merge!(REPL.REPLCompletions.latex_symbols, latex_symbols)
    end
end

# julia commit a647575ff68ffec44ef7980545479915fcf3d62e
# Fri Feb 10 21:05:05 2023 +0100
# Add \veedot operator (#47647)
function init_v1100_DEV_570(REPL::Module)
    if VERSION < v"1.10.0-DEV.570"
        latex_symbols = Dict(
            "\\veedot" => "⟇",  # or with dot
        )
        merge!(REPL.REPLCompletions.latex_symbols, latex_symbols)
    end
end

# module EmojiSymbols
