include("generator_utils.jl")

using REPL
write_dict_to_file("repl_latex_symbols.jl",
                   "repl_latex_symbols",
                   REPL.REPLCompletions.latex_symbols)
