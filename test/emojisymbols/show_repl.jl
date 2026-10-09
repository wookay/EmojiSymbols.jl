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

printer_fe0f = "\U1F5A8\UFE0F"
# '🖨': Unicode U+1F5A8 (category So: Symbol, other)
# '️': Unicode U+FE0F (category Mn: Mark, nonspacing)
@test symbol_latex(printer_fe0f) == "\\:printer:"

printer = "\U1F5A8"
@test sprint(mod.show_repl, MIME("text/plain"), only(printer)) == "'🖨': Unicode U+1F5A8 (category So: Symbol, other), input as \\:printer:<tab>"
@test symbol_latex(printer) == "\\:printer:"

end # @If VERSION >= v"1.11" module test_emojisymbols_show_repl
