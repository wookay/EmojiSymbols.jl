# code from https://github.com/JuliaLang/julia/blob/master/stdlib/REPL/src/emoji_symbols.jl

# last changes - b9924d1 on Jan 11, 2020
# https://github.com/iamcal/emoji-data/blob/master/emoji_pretty.json

import JSON
emojis = JSON.parsefile(download("https://raw.githubusercontent.com/iamcal/emoji-data/master/emoji_pretty.json"))

result = Dict()
for emj in emojis
    name = "\\:" * emj["short_name"] * ":"
    unicode = emj["unified"]
    if '-' in unicode
        continue
    end
    result[name] = "$(Char(parse(UInt32, unicode, base = 16)))"
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
