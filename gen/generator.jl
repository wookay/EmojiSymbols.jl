# code from https://github.com/JuliaLang/julia/blob/master/stdlib/REPL/src/emoji_symbols.jl

# last changes - b9924d1 on Jan 11, 2020
# https://github.com/iamcal/emoji-data/blob/master/emoji_pretty.json

import JSON
emojis = JSON.parsefile(download("https://raw.githubusercontent.com/iamcal/emoji-data/master/emoji_pretty.json"))

using REPL
repl_emoji_symbols = REPL.REPLCompletions.emoji_symbols

result = Dict()
for emj in emojis
    name = "\\:" * emj["short_name"] * ":"
    unicode = emj["unified"]
    if '-' in unicode
        continue
    end
    if !haskey(repl_emoji_symbols, name)
        result[name] = "$(Char(parse(UInt32, unicode, base = 16)))"
    end
end

skeys = sort(collect(keys(result)))

open(normpath(@__DIR__, "emoji_symbols.jl"), "w") do fh
    println(fh, "# generated")
    println(fh, "const emoji_symbols = Dict{String,String}(")
    for key in skeys
        println(fh, "    \"", escape_string(key), "\" => \"",
                 escape_string(result[key]), "\",")
    end
    println(fh, ")")
end

open(normpath(@__DIR__, "../docs/src/additional_symbols.md"), "w") do fh
    println(fh, "### additional Emoji symbols")
    println(fh, "| short name | unicode |")
    println(fh, "|------------|---------|")
    for key in skeys
        println(fh, "| `", key, "` | ", escape_string(result[key]), " |")
    end
end

repl_skeys = sort(collect(keys(repl_emoji_symbols)))
open(normpath(@__DIR__, "../docs/src/symbols_in_repl.md"), "w") do fh
    println(fh, "### Emoji symbols in REPL")
    println(fh, "| short name | unicode |")
    println(fh, "|------------|---------|")
    for key in repl_skeys
        println(fh, "| `", key, "` | ", escape_string(repl_emoji_symbols[key]), " |")
    end
end
