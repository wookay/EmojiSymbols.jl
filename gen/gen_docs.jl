using EmojiSymbols
using REPL
using Markdown: MD, Header, Table, Code, htmlesc

function gen_patches()
    data = EmojiSymbols.repl_completions_patches
    table = pretty_table(
        String,
        data,
        backend = Val(:markdown)
    )
    @info table
end

function tag_span(k, v)::String
    string("<span title=\"", htmlesc(k), "\">", v, "</span>")
end

function generate_markdown(title::String, dict_data::Dict{String, String})
    header = ["short name", "unicode"]
    align  = [:l, :l]
    table_data = Vector{Any}()
    push!(table_data, header)
    for (k, v) in sort(collect(dict_data), by=first)
        push!(table_data, [Code(k), v])
    end
    spans = []
    for (k, v) in sort(collect(dict_data), by=last)
        push!(spans, tag_span(k, v))
    end
    MD(Header{1}(title),
       Table(table_data, align),
       Code("@raw html", join(spans, "\n")))
end

function write_doc(name::Symbol, title::String)
    filepath = normpath(@__DIR__, "../docs/src/$name.md")
    md = generate_markdown(title, getfield(REPL.REPLCompletions, name))
    @info "save $title" filepath
    write(filepath, string(md, """
```@raw html
<!-- generated -->
```
"""))
end

write_doc(:emoji_symbols, "Emoji symbols")
write_doc(:latex_symbols, "LaTeX symbols")
