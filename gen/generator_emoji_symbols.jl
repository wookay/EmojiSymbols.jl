include("generator_utils.jl")

# repl_emoji_symbols_170
# repl_emoji_symbols_below_170
include("repl_emoji_symbols.jl")

emoji_data     = get_emoji_data()
dict_170       = get_diff_dict(repl_emoji_symbols_170,       emoji_data)
dict_below_170 = get_diff_dict(repl_emoji_symbols_below_170, emoji_data)

write_dict_to_file("generated_emoji_symbols_170.jl",       "emoji_symbols", dict_170)
write_dict_to_file("generated_emoji_symbols_below_170.jl", "emoji_symbols", dict_below_170)
