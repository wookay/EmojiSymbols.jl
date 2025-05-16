using EmojiSymbols
using REPL
using Markdown: MD, Header, Table, Code, List, Paragraph, htmlesc

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
    write(filepath, string(md, generated_comments))
end

function gen_patches(title::String)
    contents = []
    for patch in EmojiSymbols.repl_completions_patches
        push!(contents, Header{3}(patch.version))
        for action in patch.actions
            push!(contents, List(Paragraph((String ∘ nameof ∘ typeof)(action))))
            if action isa EmojiSymbols.Load2fc32f2ea2
            else
                push!(contents, Code("julia", join(action.symbol_pairs, "\n")))
            end
        end
    end
    MD(Header{1}(title), contents...)
end

function write_doc_patches(name::Symbol, title::String)
    filepath = normpath(@__DIR__, "../docs/src/$name.md")
    md = gen_patches(title)
    @info "save $title" filepath
    write(filepath, string(md, generated_comments))
end

if true # false
write_doc(:emoji_symbols, "Emoji symbols")
write_doc(:latex_symbols, "LaTeX symbols")
write_doc_patches(:patches, "Patches")
end
