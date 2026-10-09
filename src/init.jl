# module EmojiSymbols

function __init__()
    patches = patches_to_be_loaded()
    cnt_patches = apply_patches_to_repl_completions(patches, REPL.REPLCompletions)
    cnt_fixed_fe0f = fix_fe0f_for_symbols_latex()

    if haskey(ENV, "CI")
        printstyled(@__MODULE__, color = :blue)
        printstyled(": Applied ", cnt_patches, " patches. Fix \\UFE0F: ", cnt_fixed_fe0f, ".", color = :cyan)
        println()
    end
end

# module EmojiSymbols
