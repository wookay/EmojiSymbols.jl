module EmojiSymbols

include(normpath(@__DIR__, "../gen/emoji_symbols.jl"))
include(normpath(@__DIR__, "../gen/emoji_name_table.jl"))
include(normpath(@__DIR__, "../gen/latex_name_table.jl"))

function __init__()
    REPL = Base.REPL_MODULE_REF[]
    merge!(REPL.REPLCompletions.emoji_symbols, emoji_symbols)
end

# from julia/base/char.jl
using Base: Unicode, ismalformed, isoverlong, decode_overlong
function show_char(io::IO, ::MIME"text/plain", c::T) where {T<:AbstractChar}
    show(io, c)
    get(io, :compact, false) && return
    if !ismalformed(c)
        print(io, ": ")
        if isoverlong(c)
            print(io, "[overlong] ")
            u = decode_overlong(c)
            c = T(u)
        else
            u = codepoint(c)
        end
        h = uppercase(string(u, base = 16, pad = 4))
        print(io, (isascii(c) ? "ASCII/" : ""), "Unicode U+", h)
    else
        print(io, ": Malformed UTF-8")
    end
    abr = Unicode.category_abbrev(c)
    str = Unicode.category_string(c)
    print(io, " (category ", abr, ": ", str, ")")
end

# emoji ranges
#     0x00a9 <= n <= 0x00ae || 0x200d <= n <= 0x3299 || 0x1f004 <= n <= 0x1f251 || 0x1f300 <= n <= 0x1fad6
# latex ranges
#     0x00a1 <= n <= 0x03f6 || 0x1d2c <= n <= 0x1dbf || 0x2002 <= n <= 0x3012 || 0x1d400 <= n <= 0x1d7ff
function lookup_and_show_short_name(io::IO, ::MIME"text/plain", c::Char)
    n = UInt32(c)
    if 0x1f004 <= n <= 0x1f251 || 0x1f300 <= n <= 0x1fad6
        haskey(emoji_name_table, c) && printstyled(io, emoji_name_table[c], ' ', color=:cyan)
    elseif 0x1d2c <= n <= 0x1dbf || 0x1d400 <= n <= 0x1d7ff
        haskey(latex_name_table, c) && printstyled(io, latex_name_table[c], ' ', color=:cyan)
    elseif 0x00a9 <= n <= 0x00ae || 0x200d <= n <= 0x3299 ||   # emoji
           0x00a1 <= n <= 0x03f6 || 0x2002 <= n <= 0x3012      # latex
        if haskey(emoji_name_table, c)
            printstyled(io, emoji_name_table[c], ' ', color=:cyan)
        elseif haskey(latex_name_table, c)
            printstyled(io, latex_name_table[c], ' ', color=:cyan)
        end
    end
end

function Base.show(io::IO, mime::MIME"text/plain", c::Char)
    lookup_and_show_short_name(io, mime, c)
    show_char(io, mime, c)
end

function Base.show(io::IO, mime::MIME"text/plain", s::String)
    len = length(s)
    if isone(len)
        lookup_and_show_short_name(io, mime, first(s))
    elseif len == 2
        haskey(latex_name_table, s) && printstyled(io, latex_name_table[s], ' ', color=:cyan)
    end
    print(io, repr(s))
end

end # module EmojiSymbols
