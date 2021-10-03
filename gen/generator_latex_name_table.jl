include("generator_utils.jl")

# repl_latex_symbols
include("repl_latex_symbols.jl")

latex_name_table = reverse(repl_latex_symbols)

write_dict_to_file("latex_name_table.jl", "latex_name_table", latex_name_table)
