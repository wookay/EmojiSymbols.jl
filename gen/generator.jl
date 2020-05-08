# code from https://github.com/JuliaLang/julia/blob/master/stdlib/REPL/src/emoji_symbols.jl

# last changes - b9924d1 on Jan 11, 2020
# https://github.com/iamcal/emoji-data/blob/master/emoji_pretty.json

import JSON
emojis = JSON.parsefile(download("https://raw.githubusercontent.com/iamcal/emoji-data/master/emoji_pretty.json"))

using REPL
repl_emoji_symbols = REPL.REPLCompletions.emoji_symbols

result = Dict{String, String}()
symbol_table = Dict{Char, String}()

for (name, emoji) in repl_emoji_symbols
    symbol_table[first(emoji)] = name
end

for emj in emojis
    name = "\\:" * emj["short_name"] * ":"
    unicode = emj["unified"]
    if '-' in unicode
        continue
    end
    push_emoji = false
    c = Char(parse(UInt32, unicode, base = 16))
    emoji = string(c)
    if haskey(repl_emoji_symbols, name)
        if repl_emoji_symbols[name] != emoji # \:egg: 🍳 🥚
            push_emoji = true
        end
    else
        push_emoji = true
    end
    if push_emoji
        result[name] = emoji
    end
    symbol_table[c] = name
end

open(normpath(@__DIR__, "emoji_name_table.jl"), "w") do fh
    println(fh, "# generated")
    println(fh, "const emoji_name_table = Dict{Char, String}(")
    for (c, name) in symbol_table
        println(fh, "    ", repr(c), " => ", repr(name), ",")
    end
    println(fh, ")")
end

skeys = sort(collect(keys(result)))
open(normpath(@__DIR__, "emoji_symbols.jl"), "w") do fh
    println(fh, "# generated")
    println(fh, "const emoji_symbols = Dict{String,String}(")
    for key in skeys
        println(fh, "    \"", escape_string(key), "\" => \"", escape_string(result[key]), "\",")
    end
    println(fh, ")")
end

function gen_doc(docfile, title, dict)
    skeys = sort(collect(keys(dict)))
    open(normpath(@__DIR__, docfile), "w") do fh
        println(fh, title)
        println(fh, "| short name | unicode |")
        println(fh, "|------------|---------|")
        for key in skeys
            println(fh, "| `", key, "` | ", escape_string(dict[key]), " |")
        end
        println(fh)
        for emoji in sort(collect(values(dict)))
            print(fh, emoji, " ")
        end
        println(fh)
    end
end

gen_doc("../docs/src/additional_symbols.md", "### additional Emoji symbols", result)
gen_doc("../docs/src/symbols_in_repl.md",    "### Emoji symbols in REPL",    repl_emoji_symbols)
