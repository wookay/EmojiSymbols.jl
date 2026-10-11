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
        if patch.version isa VersionNumber
            down_to < patch.version <= up_to
        else
            any(ver -> down_to < ver <= up_to, patch.version)
        end
    end
end

function load_symbols(m::Module, mod::Module, isdefined_symbols_latex_canonical::Bool)::Int
    cnt::Int = 0
    emoji_setdiff = Set{String}([])
    for (k, v) in m.emoji_symbols
        if haskey(mod.emoji_symbols, k) && mod.emoji_symbols[k] == v
            if !(haskey(REPL.symbols_latex, v))
                REPL.symbols_latex[v] = k
            end
        else
            push!(emoji_setdiff, k)
        end
    end
    cnt += length(emoji_setdiff)
    for k in emoji_setdiff
        v = m.emoji_symbols[k]
        REPL.symbols_latex[v] = k
    end
    latex_setdiff = Set{String}([])
    for (k, v) in m.latex_symbols
        if haskey(mod.latex_symbols, k) && mod.latex_symbols[k] == v
        else
            push!(latex_setdiff, k)
        end
    end
    cnt += length(latex_setdiff)
    for k in latex_setdiff
        v = m.latex_symbols[k]
        REPL.symbols_latex[v] = k
    end
    if isdefined_symbols_latex_canonical
        latex_canonical_setdiff = Set{String}([])
        for (k, v) in m.symbols_latex_canonical
            if haskey(mod.symbols_latex_canonical, k) && mod.symbols_latex_canonical[k] == v
            else
                push!(latex_canonical_setdiff, k)
            end
        end
        cnt += length(latex_canonical_setdiff)
        for k in latex_canonical_setdiff
            v = m.symbols_latex_canonical[k]
            REPL.symbols_latex[v] = k
        end
    end
    empty!(mod.emoji_symbols)
    empty!(mod.latex_symbols)
    isdefined_symbols_latex_canonical && empty!(mod.symbols_latex_canonical)
    merge!(mod.emoji_symbols, m.emoji_symbols)
    merge!(mod.latex_symbols, m.latex_symbols)
    isdefined_symbols_latex_canonical && merge!(mod.symbols_latex_canonical, m.symbols_latex_canonical)
    cnt
end

function load_commit(action::LoadCommit, mod::Module, isdefined_symbols_latex_canonical::Bool)::Int
    dir = normpath(@__DIR__, "..", "gen", string(action.commit, "_", action.version))
    m = Module()
    for filename in ("emoji_symbols.jl", "latex_symbols.jl")
        code = read(joinpath(dir, filename), String)
        include_string(m, code, filename)
    end
    Base.invokelatest(load_symbols, m, mod, isdefined_symbols_latex_canonical)
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
            if Ta === LoadCommit
                cnt += load_commit(action, mod, isdefined_symbols_latex_canonical)
            else
                for (k, v) in action.symbol_pairs
                    if Ta === AddEmojiSymbols
                        setindex!(mod.emoji_symbols, v, k)
                        REPL.symbols_latex[v] = k
                    elseif Ta === AddLatexSymbols
                        setindex!(mod.latex_symbols, v, k)
                        REPL.symbols_latex[v] = k
                    elseif Ta === RemoveEmojiSymbols
                        delete!(mod.emoji_symbols, k)
                        # delete!(REPL.symbols_latex, v)
                    elseif Ta === RemoveLatexSymbols
                        delete!(mod.latex_symbols, k)
                        # delete!(REPL.symbols_latex, v)
                    elseif Ta === AddSymbolsLatexCanonical
                        if isdefined_symbols_latex_canonical
                            setindex!(mod.symbols_latex_canonical, v, k)
                            REPL.symbols_latex[v] = k
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
