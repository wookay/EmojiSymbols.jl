module EmojiSymbols

include(normpath(@__DIR__, "../gen/v1.7.0-DEV.jl"))
include(normpath(@__DIR__, "../gen/v1.9.0-DEV.jl"))
include(normpath(@__DIR__, "../gen/v1.10.0-DEV.jl"))
include(normpath(@__DIR__, "../gen/v1.11.0-DEV.jl"))

function create_symbols_latex(REPL::Module)
    (REPL.symbol_latex ∘ string)()
end

function merge_symbols_latex_canonical!(REPL::Module, symbols_latex_canonical)
    if isdefined(REPL.REPLCompletions, :symbols_latex_canonical)
        merge!(REPL.REPLCompletions.symbols_latex_canonical, symbols_latex_canonical)
    end
end

function reset_REPL_completions(emoji_symbols, latex_symbols, symbols_latex_canonical)
    REPL = Base.REPL_MODULE_REF[]
    copy!(REPL.REPLCompletions.emoji_symbols, emoji_symbols)
    copy!(REPL.REPLCompletions.latex_symbols, latex_symbols)
    if isdefined(REPL.REPLCompletions, :symbols_latex_canonical)
        copy!(REPL.REPLCompletions.symbols_latex_canonical, symbols_latex_canonical)
    end
    empty!(REPL.symbols_latex)
end

function __init__()
    REPL = Base.REPL_MODULE_REF[]
    init_v170_DEV(REPL)
    init_v190_DEV(REPL)
    init_v1100_DEV(REPL)
    init_v1110_DEV(REPL)
    create_symbols_latex(REPL)
end

end # module EmojiSymbols
