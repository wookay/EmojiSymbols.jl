# module EmojiSymbols

abstract type AbstractPatchAction end

for action in (:AddEmojiSymbols,
               :AddLatexSymbols,
           :ReplaceLatexSymbols,
               :AddSymbolsLatexCanonical)
    expr = quote
        struct $(action) <: AbstractPatchAction
            delta::Int
        end
    end
    Core.eval(@__MODULE__, expr)
end

struct Patch
    version::VersionNumber
    commit::String
    actions::Vector{<: AbstractPatchAction}
    function Patch(version, commit, actions...)
        new(version, commit, collect(actions))
    end
end

# module EmojiSymbols
