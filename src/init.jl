# module EmojiSymbols

function __init__()
    patches = patches_to_be_loaded()
    cnt = apply_patches_to_repl_completions(patches, REPL.REPLCompletions)

    if haskey(ENV, "CI")
        printstyled(@__MODULE__, color = :blue)
        printstyled(": Applied ", cnt, " patches.", color = :cyan)
        println()
    end
end

# module EmojiSymbols
