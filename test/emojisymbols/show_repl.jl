using Jive
@If VERSION >= v"1.11" module test_emojisymbols_show_repl

using Test
using EmojiSymbols

mod::Module = VERSION >= v"1.12.0-DEV.901" ? EmojiSymbols.REPL : EmojiSymbols

c = '😄'
@test sprint(mod.show_repl, MIME("text/plain"), c) ==
    """'😄': Unicode U+1F604 (category So: Symbol, other), input as \\:smile:<tab>"""

using REPL: symbol_latex
@test symbol_latex("😄") == "\\:smile:"
@test symbol_latex("⎋") == "\\escape"

using REPL: REPLCompletions
escape = REPLCompletions.latex_symbols["\\escape"]
@test escape == "⎋"

if VERSION >= v"1.14.0-DEV.3371" # julia commit a966e11862  new emoji completions!
printer_fe0f = "\U1F5A8\UFE0F"
# '🖨': Unicode U+1F5A8 (category So: Symbol, other)
# '️': Unicode U+FE0F (category Mn: Mark, nonspacing)
@test sprint(mod.show_repl, MIME("text/plain"), printer_fe0f) == repr(printer_fe0f)
@test symbol_latex(printer_fe0f) == "\\:printer:"
end # if

end # @If VERSION >= v"1.11" module test_emojisymbols_show_repl
