# code from https://github.com/JuliaLang/julia/blob/master/stdlib/REPL/src/emoji_symbols.jl

# Latest commit e512953 on Nov 19, 2020
# https://github.com/iamcal/emoji-data/blob/master/emoji_pretty.json

using JSON
using Downloads


url = "https://raw.githubusercontent.com/iamcal/emoji-data/master/emoji_pretty.json"
emoji_data_path = normpath(@__DIR__, "emoji_pretty.json")
!isfile(emoji_data_path) && Downloads.download(url, emoji_data_path)
emojis = JSON.parsefile(emoji_data_path)

using REPL
repl_emoji_symbols = REPL.REPLCompletions.emoji_symbols
repl_latex_symbols = REPL.REPLCompletions.latex_symbols


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


const generated_text = string("# generated")

open(normpath(@__DIR__, "emoji_name_table.jl"), "w") do fh
    println(fh, generated_text)
    println(fh, "const emoji_name_table = Dict{Char, String}(")
    for (c, name) in symbol_table
        println(fh, "    ", repr(c), " => ", repr(name), ",")
    end
    println(fh, ")")
end

open(normpath(@__DIR__, "latex_name_table.jl"), "w") do fh
    println(fh, generated_text)
    println(fh, "const latex_name_table = Dict{Union{Char,String}, String}(")
    for (name, latex) in repl_latex_symbols
        if (isone ∘ length)(latex)
            println(fh, "    ", repr(first(latex)), " => ", repr(name), ",")
        else
            println(fh, "    ", repr(latex), " => ", repr(name), ",")
        end
    end
    println(fh, ")")
end

skeys = sort(collect(keys(result)))
open(normpath(@__DIR__, "emoji_symbols.jl"), "w") do fh
    println(fh, generated_text)
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
            print(fh, "| `", key, "` | ")
            val = dict[key]
            if (isone ∘ length)(val)
                c = first(val)
                if isspace(c)
                    print(fh, string("'", c, "'", " == Char(0x", string(codepoint(c), base=16), ")"))
                else
                    print(fh, escape_string(val))
                end
            else
                print(fh, '"', escape_string(val), '"')
            end
            println(fh, " |")
        end
        println(fh)
        println(fh, "```@raw html")
        for (name, emoji) in sort(collect(dict), by=last)
            title = replace(name, '\\' => "&#92;")
            println(fh, """<span title="$title">$emoji</span>""")
        end
        println(fh, "```")
    end
end

# gen_doc("../docs/src/additional_symbols.md",    "### additional Emoji symbols", result)
gen_doc("../docs/src/emoji_symbols_in_repl.md", "### Emoji symbols in REPL",    repl_emoji_symbols)
gen_doc("../docs/src/latex_symbols_in_repl.md", "### LaTeX symbols in REPL",    repl_latex_symbols)
