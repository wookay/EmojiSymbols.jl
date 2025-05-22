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
    MD(Header{1}(title),
       Table(table_data, align),
       Code("@raw html", join(spans, "\n")))
end

const generated_comments = """
```@raw html
<!-- generated -->
```
"""

function write_doc(name::Symbol, title::String)
    filepath = normpath(@__DIR__, "../docs/src/$name.md")
    md = generate_markdown(title, getfield(REPL.REPLCompletions, name))
    @info "save $title" filepath
    write(filepath, string(generated_comments, md))
end

function gen_patches(title::String)
    contents = []
    for patch in EmojiSymbols.REPL_COMPLETIONS_PATCHES
        push!(contents, Header{3}(patch.version))
        for action in patch.actions
            push!(contents, List(Paragraph((String ∘ nameof ∘ typeof)(action))))
            if action isa EmojiSymbols.Load2fc32f2ea2
            else
                push!(contents, Code("julia", join(action.symbol_pairs, "\n")))
            end
        end
    end
    p = md"""
`REPL_COMPLETIONS_PATCHES` contains the actual patch data,
which defined in [`gen/repl_completions_patches.jl`](https://github.com/wookay/EmojiSymbols.jl/blob/master/gen/repl_completions_patches.jl)
"""
    MD(Header{1}(title), p, contents...)
end

function write_doc_patches(name::Symbol, title::String)
    filepath = normpath(@__DIR__, "../docs/src/$name.md")
    md = gen_patches(title)
    @info "save $title" filepath
    write(filepath, string(generated_comments, md))
end

if true # false
write_doc(:emoji_symbols, "Emoji symbols")
write_doc(:latex_symbols, "LaTeX symbols")
write_doc_patches(:patches, "Patches")
end
