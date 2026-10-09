loaded = haskey(Base.loaded_modules, Base.PkgId(Base.UUID("c599478c-de41-4aed-94ea-b47665d7a42a"), "EmojiSymbols"))
using Jive
@If !loaded module test_repl_show_repl

using Test

using REPL: REPL
if VERSION >= v"1.14.0-DEV.3246"
@test REPL.symbol_latex("⎋") == "\\escape"
else
@test REPL.symbol_latex("⎋") == ""
end

printer = "\U1F5A8"
@test REPL.symbol_latex(printer) == ""
if VERSION >= v"1.12"
@test sprint(REPL.show_repl, MIME("text/plain"), only(printer)) == "'🖨': Unicode U+1F5A8 (category So: Symbol, other)"
end

end # module test_repl_show_repl
