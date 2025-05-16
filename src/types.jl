# module EmojiSymbols

abstract type AbstractPatchAction end

for action in (:Load2fc32f2ea2,
               :AddEmojiSymbols,
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
    struct Patch
        version::VersionNumber
        actions::Vector{<: AbstractPatchAction}
    end
"""
struct Patch
    version::VersionNumber
    actions::Vector{<: AbstractPatchAction}
    function Patch(version, actions...)
        new(version, collect(actions))
    end
end

# module EmojiSymbols
