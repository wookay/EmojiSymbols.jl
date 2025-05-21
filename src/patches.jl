# module EmojiSymbols

"""
    patches_to_be_loaded(; down_to::VersionNumber = VERSION,
                           up_to::VersionNumber   = LATEST_PATCH_VERSION,
                           patches::Vector{Patch} = REPL_COMPLETIONS_PATCHES)::Vector{Patch}
"""
function patches_to_be_loaded(; down_to::VersionNumber = VERSION,
                                up_to::VersionNumber   = LATEST_PATCH_VERSION,
                                patches::Vector{Patch} = REPL_COMPLETIONS_PATCHES)::Vector{Patch}
    filter(patches) do patch
        down_to < patch.version <= up_to
    end
end

function load_2fc32f2ea2(mod::Module, isdefined_symbols_latex_canonical::Bool)::Int
    m = Module()
    for filename in ("emoji_symbols.jl", "latex_symbols.jl")
        code = read(normpath(@__DIR__, "../gen/2fc32f2ea2_1.7.0-DEV.849", filename), String)
        include_string(m, code, filename)
    end
    cnt::Int = 0
    cnt += length(setdiff(keys(m.emoji_symbols), keys(mod.emoji_symbols)))
    cnt += length(setdiff(keys(m.latex_symbols), keys(mod.latex_symbols)))
    if isdefined_symbols_latex_canonical
        cnt += length(setdiff(keys(m.symbols_latex_canonical), keys(mod.symbols_latex_canonical)))
    end
    empty!(mod.emoji_symbols)
    empty!(mod.latex_symbols)
    isdefined_symbols_latex_canonical && empty!(mod.symbols_latex_canonical)
    merge!(mod.emoji_symbols, m.emoji_symbols)
    merge!(mod.latex_symbols, m.latex_symbols)
    isdefined_symbols_latex_canonical && merge!(mod.symbols_latex_canonical, m.symbols_latex_canonical)
    cnt
end

"""
    apply_patches_to_repl_completions(patches::Vector{Patch}, mod::Module)::Int

Load each symbols into `mod` (like `REPL.REPLCompletions`)
"""
function apply_patches_to_repl_completions(patches::Vector{Patch}, mod::Module)::Int
    cnt::Int = 0
    isdefined_symbols_latex_canonical::Bool = isdefined(mod, :symbols_latex_canonical)
    for patch in reverse(patches)
        for action in patch.actions
            Ta = typeof(action)
            if Ta === Load2fc32f2ea2
                cnt += load_2fc32f2ea2(mod, isdefined_symbols_latex_canonical)
            else
                for (k, v) in action.symbol_pairs
                    if Ta === AddEmojiSymbols
                        setindex!(mod.emoji_symbols, v, k)
                    elseif Ta === AddLatexSymbols
                        setindex!(mod.latex_symbols, v, k)
                    elseif Ta === RemoveLatexSymbols
                        delete!(mod.latex_symbols, k)
                    elseif Ta === AddSymbolsLatexCanonical
                        if isdefined_symbols_latex_canonical
                            setindex!(mod.symbols_latex_canonical, v, k)
                        end
                    end
                    cnt += 1
                end # for (k, v) in action.symbol_pairs
            end
        end
    end # for patch in reverse(patches)
    cnt
end

# module EmojiSymbols
