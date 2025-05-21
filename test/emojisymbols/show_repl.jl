using Jive
@If VERSION >= v"1.11" module test_emojisymbols_show_repl

using Test
using EmojiSymbols

mod::Module = VERSION >= v"1.12.0-DEV.901" ? EmojiSymbols.REPL : EmojiSymbols

c = '😄'
@test sprint(mod.show_repl, MIME("text/plain"), c) ==
    """'😄': Unicode U+1F604 (category So: Symbol, other), input as \\:smile:<tab>"""

end # @If VERSION >= v"1.11" module test_emojisymbols_show_repl
