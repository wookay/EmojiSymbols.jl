# emoji_pretty.json
# Latest commit 33af9bc on 12 Jun, 2021
# https://github.com/iamcal/emoji-data/blob/master/emoji_pretty.json

using Downloads
function download_emoji_data(filepath::String)
    url = "https://raw.githubusercontent.com/iamcal/emoji-data/master/emoji_pretty.json"
    Downloads.download(url, filepath)
end

# generator_repl_emoji_symbols_170.jl
# generator_repl_emoji_symbols_below_170.jl
function write_dict_to_file(filename::String, varname::String, dict::Dict{K, V}) where {K, V}
    open(filename, "w") do io
        write(io, string("# generated\n"))
        write(io, string("# length(dict) = ", length(dict), "\n"))
        write(io, string("const ", varname, " = ", Dict,"{", K, ", ", V, "}("))
        write(io, '\n')
        for k in (sort ∘ collect ∘ keys)(dict)
            write(io, string(repeat(' ', 4), repr(k), " => ", repr(dict[k]), ","))
            write(io, '\n')
        end
        write(io, string(")"))
        write(io, '\n')
    end
end

function get_diff_dict(d1::Dict{K, V}, d2::Dict{K, V}) where {K, V}
    d = Dict{K, V}()
    for (k, v) in d2
        if haskey(d1, k)
            if v != d1[k]
                d[k] = v
            end
        else
            d[k] = v
        end
    end
    d
end

using JSON
# code from https://github.com/JuliaLang/julia/blob/master/stdlib/REPL/src/emoji_symbols.jl
function get_emoji_data(filepath::String)::Dict{String, String}
    emojis = JSON.parsefile(filepath)
    result = Dict{String, String}()
    for emj in emojis
        name = "\\:" * emj["short_name"] * ":"
        unified = emj["unified"]
        uint32s = split(unified, '-')
        unicode = join(Char.(parse.(UInt32, uint32s, base=16)))
        result[name] = unicode
    end
    return result
end

function get_emoji_data()::Dict{String, String}
    get_emoji_data(normpath(@__DIR__, "emoji_pretty.json"))
end

function Base.reverse(dict::Dict{K, V})::Dict{V, K} where {K, V}
    d = Dict{V, K}()
    for (k, v) in dict
        d[v] = k
    end
    d
end

# generator_doc.jl
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
