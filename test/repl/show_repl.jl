module test_repl_show_repl

using Test

loaded = haskey(Base.loaded_modules, Base.PkgId(Base.UUID("c599478c-de41-4aed-94ea-b47665d7a42a"), "EmojiSymbols"))
@test loaded === false

using REPL: symbol_latex
if VERSION >= v"1.14.0-DEV.3246"
@test symbol_latex("⎋") == "\\escape"
else
@test symbol_latex("⎋") == ""
end

end # module test_repl_show_repl
