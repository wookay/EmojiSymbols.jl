using Jive
@If VERSION >= v"1.11" module test_emojisymbols_show_repl

using Test
using EmojiSymbols

mod = VERSION >= v"1.12.0-DEV.901" ? EmojiSymbols.REPL : EmojiSymbols

c = '😄'
@test sprint(mod.show_repl, MIME("text/plain"), c) == "'😄': Unicode U+1F604 (category So: Symbol, other), input as \\:smile:<tab>"

using REPL: symbol_latex
@test symbol_latex("😄") == "\\:smile:"
@test symbol_latex("⎋") == "\\escape"

using REPL: REPLCompletions
escape = REPLCompletions.latex_symbols["\\escape"]
@test escape == "⎋"

printer = "\U1F5A8" # 🖨  \:printer:
@test sprint(mod.show_repl, MIME("text/plain"), only(printer)) == "'🖨': Unicode U+1F5A8 (category So: Symbol, other), input as \\:printer:<tab>"
@test symbol_latex(printer) == "\\:printer:"

printer_fe0f = "\U1F5A8\UFE0F"
# '🖨': Unicode U+1F5A8 (category So: Symbol, other)
# '️': Unicode U+FE0F (category Mn: Mark, nonspacing)
@test sprint(mod.show_repl, MIME("text/plain"), printer_fe0f) == "\"🖨️\", input as \\:printer:<tab>"
@test symbol_latex(printer_fe0f) == "\\:printer:"

upblackarrow = "\U2B06" #⬆  \upblackarrow
@test sprint(mod.show_repl, MIME("text/plain"), only(upblackarrow)) == "'⬆': Unicode U+2B06 (category So: Symbol, other), input as \\upblackarrow<tab>"
@test symbol_latex(upblackarrow) == "\\upblackarrow"

arrow_up = "\U2B06\UFE0F" # ⬆️  \:arrow_up:
@test sprint(mod.show_repl, MIME("text/plain"), arrow_up) == "\"⬆️\", input as \\:arrow_up:<tab>"
@test symbol_latex(arrow_up) == "\\:arrow_up:"

end # @If VERSION >= v"1.11" module test_emojisymbols_show_repl
