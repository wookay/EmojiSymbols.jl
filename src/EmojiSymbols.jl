module EmojiSymbols

export Patch
include("types.jl")

include(normpath(@__DIR__, "../gen/repl_completions_patches.jl"))

export LATEST_PATCH_VERSION
export patches_to_be_loaded
export apply_patches_to_repl_completions
include("patches.jl")

include("backup.jl")

function __init__()
    R = Base.REPL_MODULE_REF[]
    patches = patches_to_be_loaded()
    cnt = apply_patches_to_repl_completions(patches, R.REPLCompletions)

    if haskey(ENV, "CI")
        printstyled(@__MODULE__, color = :blue)
        printstyled(": Applied ", cnt, " patches.", color = :cyan)
        println()
    end
end

end # module EmojiSymbols
