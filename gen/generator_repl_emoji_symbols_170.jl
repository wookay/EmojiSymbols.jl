if VERSION < v"1.7.0-DEV.849"
    @error "" VERSION < v"1.7.0-DEV.849"
    error()
end

include("generator_utils.jl")

using REPL
write_dict_to_file("repl_emoji_symbols_170.jl",
                   "repl_emoji_symbols_170",
                   REPL.REPLCompletions.emoji_symbols)
