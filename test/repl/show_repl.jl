loaded = haskey(Base.loaded_modules, Base.PkgId(Base.UUID("c599478c-de41-4aed-94ea-b47665d7a42a"), "EmojiSymbols"))
using Jive
@If !loaded module test_repl_show_repl

using Test
using REPL: REPL, symbol_latex

if VERSION >= v"1.14.0-DEV.3246"
@test symbol_latex("⎋") == "\\escape"
else
@test symbol_latex("⎋") == ""
end

const mod = REPL

printer = "\U1F5A8"            # 🖨   \:printer:
printer_fe0f = "\U1F5A8\UFE0F" # '🖨 ': Unicode U+1F5A8 (category So: Symbol, other)
                               # '️': Unicode U+FE0F (category Mn: Mark, nonspacing)
upblackarrow = "\U2B06"        #⬆  \upblackarrow
arrow_up = "\U2B06\UFE0F"      # ⬆️  \:arrow_up:

@test symbol_latex(printer) == "" # "\\:printer:"

if VERSION >= v"1.14.0-DEV.3371" # julia commit a966e11862    new emoji completions!
@test symbol_latex(printer_fe0f) == "\\:printer:"
@test symbol_latex(upblackarrow) == "\\upblackarrow"
@test symbol_latex(arrow_up) == "\\:arrow_up:"
else
@test symbol_latex(printer_fe0f) == ""
@test symbol_latex(upblackarrow) == "\\:arrow_up:"
@test symbol_latex(arrow_up) == ""
end

if VERSION >= v"1.14.0-DEV.3371" # julia commit a966e11862    new emoji completions!
@test sprint(mod.show_repl, MIME("text/plain"), only(upblackarrow)) == "'⬆': Unicode U+2B06 (category So: Symbol, other), input as \\upblackarrow<tab>"
elseif VERSION >= v"1.13"
@test sprint(mod.show_repl, MIME("text/plain"), only(upblackarrow)) == "'⬆': Unicode U+2B06 (category So: Symbol, other), input as \\:arrow_up:<tab>"
elseif VERSION >= v"1.12"
@test sprint(mod.show_repl, MIME("text/plain"), only(upblackarrow)) == "'⬆': Unicode U+2B06 (category So: Symbol, other)" # input as \\:arrow_up:<tab>
end

if VERSION >= v"1.12"
@test sprint(mod.show_repl, MIME("text/plain"), only(printer)) == "'🖨': Unicode U+1F5A8 (category So: Symbol, other)" # input as \\:printer:<tab>
@test sprint(mod.show_repl, MIME("text/plain"), printer)      == repr(printer)
@test sprint(mod.show_repl, MIME("text/plain"), printer_fe0f) == repr(printer_fe0f)
@test sprint(mod.show_repl, MIME("text/plain"), upblackarrow) == repr(upblackarrow)
@test sprint(mod.show_repl, MIME("text/plain"), arrow_up)     == repr(arrow_up)
end

end # module test_repl_show_repl
