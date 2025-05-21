module EmojiSymbols

export Patch
include("types.jl")

export LATEST_PATCH_VERSION
include(normpath(@__DIR__, "../gen/repl_completions_patches.jl"))

export patches_to_be_loaded, apply_patches_to_repl_completions
include("patches.jl")

include("REPL.jl")
include("init.jl")

end # module EmojiSymbols
