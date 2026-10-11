# module EmojiSymbols

function __init__()
    patches = patches_to_be_loaded()
    cnt_patches = apply_patches_to_repl_completions(patches, REPL.REPLCompletions)
    if haskey(ENV, "CI")
        printstyled(@__MODULE__, color = :blue)
        printstyled(": Applied ", cnt_patches, " patches."; color = :cyan)
        println()
    end
end

# module EmojiSymbols
