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
    if !isassigned(Base.REPL_MODULE_REF)
        eval(:(using REPL: REPL))
        R = REPL
    else
        R = Base.REPL_MODULE_REF[]
    end
    patches = patches_to_be_loaded()
    cnt = apply_patches_to_repl_completions(patches, R.REPLCompletions)

    if haskey(ENV, "CI")
        printstyled(@__MODULE__, color = :blue)
        printstyled(": Applied ", cnt, " patches.", color = :cyan)
        println()
    end
end

end # module EmojiSymbols
