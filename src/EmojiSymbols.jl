module EmojiSymbols

include(normpath(@__DIR__, "../gen/emoji_symbols.jl"))
include(normpath(@__DIR__, "../gen/emoji_name_table.jl"))

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

symbol_table = Dict{Char,String}(
    '🤔' => "\\:thinking_face:",
)

function Base.show(io::IO, mime::MIME"text/plain", c::Char)
    n = UInt32(c)
    if 0x00a9 <= n <= 0x3299 || 0x1f004 <= n <= 0x1fa95
        haskey(emoji_name_table, c) && printstyled(io, emoji_name_table[c], ' ', color=:cyan)
    end
    show_char(io, mime, c)
end

end # module EmojiSymbols
