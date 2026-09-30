# module EmojiSymbols

const OR = Vector

"""
    abstract type AbstractPatchAction end
"""
abstract type AbstractPatchAction end

for action in (:Load_2fc32f2ea2,
               :Load_a966e11862,
               :AddEmojiSymbols,
               :RemoveEmojiSymbols,
               :AddLatexSymbols,
               :RemoveLatexSymbols,
               :AddSymbolsLatexCanonical)
    expr = quote
        struct $(action) <: AbstractPatchAction
            symbol_pairs::Vector{Pair{String, String}}
            function $(action)(symbol_pairs...)
                new(collect(symbol_pairs))
            end
        end
    end
    Core.eval(@__MODULE__, expr)
end

"""
    struct Load_2fc32f2ea2 <: AbstractPatchAction

used in [`apply_patches_to_repl_completions`](@ref)
"""
Load_2fc32f2ea2

"""
    struct Load_a966e11862 <: AbstractPatchAction

used in [`apply_patches_to_repl_completions`](@ref)
"""
Load_a966e11862

"""
    struct AddEmojiSymbols <: AbstractPatchAction

used in [`apply_patches_to_repl_completions`](@ref)
"""
AddEmojiSymbols

"""
    struct RemoveEmojiSymbols <: AbstractPatchAction

used in [`apply_patches_to_repl_completions`](@ref)
"""
RemoveEmojiSymbols

"""
    struct AddLatexSymbols <: AbstractPatchAction

used in [`apply_patches_to_repl_completions`](@ref)
"""
AddLatexSymbols

"""
    struct RemoveLatexSymbols <: AbstractPatchAction

used in [`apply_patches_to_repl_completions`](@ref)
"""
RemoveLatexSymbols

"""
    struct AddSymbolsLatexCanonical <: AbstractPatchAction

used in [`apply_patches_to_repl_completions`](@ref)
"""
AddSymbolsLatexCanonical


"""
    struct Patch
        version::VersionNumber
        commit::String
        actions::Vector{<: AbstractPatchAction}
    end
"""
struct Patch
    version::Union{OR{VersionNumber}, VersionNumber}
    commit::String
    actions::Vector{<: AbstractPatchAction}
    function Patch(version, commit, actions...)
        new(version, commit, collect(actions))
    end
end

# module EmojiSymbols
