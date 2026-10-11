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


if VERSION < v"1.12"
using .REPL: REPLDisplay, LineEditREPL, LineEdit, with_repl_linfo, answer_color
import Base: display
function show_limited(io::IO, mime::MIME, x)
    try
        # We wrap in a LimitIO to limit the amount of printing.
        # We unpack `IOContext`s, since we will pass the properties on the outside.
        inner = io isa IOContext ? io.io : io
        wrapped_limiter = IOContext(LimitIO(inner, SHOW_MAXIMUM_BYTES), io)
        # `show_repl` to allow the hook with special syntax highlighting
        show_repl(wrapped_limiter, mime, x)
    catch e
        e isa LimitIOException || rethrow()
        printstyled(io, """…[printing stopped after displaying $(Base.format_bytes(e.maxbytes)); call `show(stdout, MIME"text/plain"(), ans)` to print without truncation]"""; color=:light_yellow, bold=true)
    end
end
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
        show_limited(io, mime, x[])
        println(io)
    end
    return nothing
end # function display(d::REPLDisplay, mime::MIME"text/plain", x::AbstractChar)
end # if VERSION < v"1.12"

# module EmojiSymbols
