# module EmojiSymbols

using REPL: REPL

# from julia/stdlib/REPL/src/REPL.jl

# +show_repl(io::IO, mime::MIME"text/plain", c::AbstractChar)
# VERSION >= v"1.13.0-DEV.620"    # julia commit 4c0017684829a410b5d7a2df16ce6e819a77fb73

# +show_repl(io::IO, mime::MIME"text/plain", x)
# VERSION >= v"1.12.0-DEV.901"    # julia commit 9dd49c056f7b95ccbac85de44ed123f34f419c5f

# function show_repl(io::IO, mime::MIME"text/plain", c::AbstractChar)
function show_repl_input_as(io::IO, mime::MIME"text/plain", s::String)
    # Check for LaTeX/emoji alias and print if found and using symbol_latex which is used in help?> mode
    latex = REPL.symbol_latex(s)  #
    if !isempty(latex)
        print(io, ", input as ")
        printstyled(io, latex, "<tab>"; color=:cyan)
    end
end

if VERSION >= v"1.12.0-DEV.901"
import .REPL: show_repl
else
function show_repl end
end

function show_repl(io::IO, mime::MIME"text/plain", s::String)
    show(io, mime, s)
    show_repl_input_as(io, mime, s)
end # function show_repl(io::IO, mime::MIME"text/plain", s::String)

if v"1.13.0-DEV.620" > VERSION >= v"1.11.0"
function show_repl(io::IO, mime::MIME"text/plain", c::AbstractChar)
    show(io, mime, c) # Call the original Base.show
    s = string(c)
    show_repl_input_as(io, mime, s)
end # function show_repl(io::IO, mime::MIME"text/plain", c::AbstractChar)
end # if

# module EmojiSymbols
