include("generator_utils.jl")

# const repl_emoji_symbols_170
# const repl_emoji_symbols_below_170
include("repl_emoji_symbols.jl")

emoji_data     = get_emoji_data()
dict_170       = get_diff_dict(repl_emoji_symbols_170,       emoji_data)
dict_below_170 = get_diff_dict(repl_emoji_symbols_below_170, emoji_data)

# const repl_latex_symbols
include("repl_latex_symbols.jl")

gen_doc("../docs/src/additional_symbols_170.md",
        """# VERSION >= v\"1.7.0-DEV.849\"""",
        dict_170)
gen_doc("../docs/src/additional_symbols_below_170.md",
        """# VERSION <  v\"1.7.0-DEV.849\"""",
        dict_below_170)
gen_doc("../docs/src/emoji_symbols_in_repl_170.md",
        """# VERSION >= v\"1.7.0-DEV.849\"""",
        repl_emoji_symbols_170)
gen_doc("../docs/src/emoji_symbols_in_repl_below_170.md",
        """# VERSION <  v\"1.7.0-DEV.849\"""",
        repl_emoji_symbols_below_170)
gen_doc("../docs/src/latex_symbols_in_repl.md",
        """# LaTeX symbols in REPL""",
        repl_latex_symbols)
