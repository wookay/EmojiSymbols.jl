using EmojiSymbols
using REPL
using Markdown: MD, Header, Table, Code, List, Paragraph, htmlesc, @md_str

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
    MD(Header{2}("short names"),
       Table(table_data, align),
       Header{2}("characters"),
       Code("@raw html", join(spans, "\n")))
end

const generated_comments = """
```@raw html
<!-- generated -->
```
"""

function write_doc(name::Symbol, title::String)
    filename = string(name, ".md")
    filepath = normpath(@__DIR__, "../docs/src/$filename")
    top_doc = """
# $title

```@contents
Pages = ["$filename"]
Depth = 2:2
```

```@index
Pages = ["$filename"]
```
"""
    md = generate_markdown(title, getfield(REPL.REPLCompletions, name))
    @info "save $title" filepath
    write(filepath, string(generated_comments, "\n", top_doc, "\n", md))
end

function gen_patches()
    contents = []
    for patch in EmojiSymbols.REPL_COMPLETIONS_PATCHES
        if patch.version isa VersionNumber
            push!(contents, Header{2}(patch.version))
        else
            push!(contents, Header{2}(join(map(repr, patch.version), ", ")))
        end
        for action in patch.actions
            push!(contents, List(Paragraph((String ∘ nameof ∘ typeof)(action))))
            if action isa EmojiSymbols.Load2fc32f2ea2
            else
                push!(contents, Code("julia", join(action.symbol_pairs, "\n")))
            end
        end
    end
    MD(contents...)
end

function write_doc_patches(name::Symbol, title::String)
    filename = string(name, ".md")
    filepath = normpath(@__DIR__, "../docs/src/$filename")
    top_doc = """
# $title

`REPL_COMPLETIONS_PATCHES` contains the actual patch data,
which defined in [`gen/repl_completions_patches.jl`](https://github.com/wookay/EmojiSymbols.jl/blob/master/gen/repl_completions_patches.jl)

```@contents
Pages = ["$filename"]
Depth = 2:2
```

```@index
Pages = ["$filename"]
```
"""
    md = gen_patches()
    @info "save $title" filepath
    write(filepath, string(generated_comments, "\n", top_doc, "\n", md))
end

if true # false
write_doc(:emoji_symbols, "Emoji symbols")
write_doc(:latex_symbols, "LaTeX symbols")
write_doc_patches(:patches, "Patches")
end
