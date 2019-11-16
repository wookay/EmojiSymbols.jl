module EmojiSymbols

include(normpath(@__DIR__, "../gen/emoji_symbols.jl"))

function __init__()
    REPL = Base.REPL_MODULE_REF[]
    merge!(REPL.REPLCompletions.emoji_symbols, emoji_symbols)
end

end # module EmojiSymbols
