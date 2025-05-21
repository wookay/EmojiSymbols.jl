# module EmojiSymbols

using REPL: REPL


# from julia/stdlib/REPL/src/REPL.jl

# REPL
# +show_repl(io::IO, mime::MIME"text/plain", c::AbstractChar)
if VERSION >= v"1.13.0-DEV.620"     # julia commit 4c0017684829a410b5d7a2df16ce6e819a77fb73

# REPL
# +show_repl(io::IO, mime::MIME"text/plain", x)
elseif VERSION >= v"1.12.0-DEV.901" # julia commit 9dd49c056f7b95ccbac85de44ed123f34f419c5f
import .REPL: show_repl

elseif VERSION >= v"1.11.0"
function show_repl end
using .REPL: REPLDisplay, LineEditREPL, LineEdit, with_repl_linfo, answer_color
import Base: display
function display(d::REPLDisplay, mime::MIME"text/plain", x::AbstractChar)
    x = Ref{Any}(x)
    with_repl_linfo(d.repl) do io
        io = IOContext(io, :limit => true, :module => Base.active_module(d)::Module)
        if d.repl isa LineEditREPL
            mistate = d.repl.mistate
            mode = LineEdit.mode(mistate)
            if mode isa LineEdit.Prompt
                LineEdit.write_output_prefix(io, mode, get(io, :color, false)::Bool)
            end
        end
        get(io, :color, false)::Bool && write(io, answer_color(d.repl))
        if isdefined(d.repl, :options) && isdefined(d.repl.options, :iocontext)
            # this can override the :limit property set initially
            io = foldl(IOContext, d.repl.options.iocontext, init=io)
        end
        show_repl(io, mime, x[])
        println(io)
    end
    return nothing
end # function display(d::REPLDisplay, mime::MIME"text/plain", x::AbstractChar)
end


if v"1.13.0-DEV.620" > VERSION >= v"1.11.0"
using .REPL: symbol_latex
function show_repl(io::IO, mime::MIME"text/plain", c::AbstractChar)
    show(io, mime, c) # Call the original Base.show
    # Check for LaTeX/emoji alias and print if found and using symbol_latex which is used in help?> mode
    latex = symbol_latex(string(c))
    if !isempty(latex)
        print(io, ", input as ")
        printstyled(io, latex, "<tab>"; color=:cyan)
    end
end # function show_repl(io::IO, mime::MIME"text/plain", c::AbstractChar)
end

# module EmojiSymbols
