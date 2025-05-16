module test_emojisymbols_patches

using Test

include(normpath(@__DIR__, "../../src/backup.jl"))
backup = backup_REPLCompletions()

already_loaded = haskey(Base.loaded_modules, Base.PkgId(Base.UUID("c599478c-de41-4aed-94ea-b47665d7a42a"), "EmojiSymbols"))
using EmojiSymbols
already_loaded && EmojiSymbols.__init__()

patches = patches_to_be_loaded(down_to = VERSION, up_to = LATEST_PATCH_VERSION)
@test patches == patches_to_be_loaded()

module MyREPL
module Completions_v1_10
emoji_symbols = Dict{String, String}()
latex_symbols = Dict{String, String}()
end
end # module MyREPL
patches = patches_to_be_loaded(down_to = v"1.11-DEV.1", up_to = v"1.11-DEV.15")
@test !isempty(patches)
cnt = apply_patches_to_repl_completions(patches, MyREPL.Completions_v1_10)
@test Set(values(MyREPL.Completions_v1_10.latex_symbols)) == Set(["»", "«"])
@test cnt == 2

patches = patches_to_be_loaded(down_to = v"1.12.0-beta3", up_to = v"1.13.0-DEV.595")
@test !isempty(patches)

patches = patches_to_be_loaded(down_to = v"1.13.0-DEV.594", up_to = v"1.13.0-DEV.595")
@test !isempty(patches)

patches = patches_to_be_loaded(down_to = v"1.13.0-DEV.595", up_to = v"1.13.0-DEV.595")
@test isempty(patches)

EmojiSymbols.rollback_REPLCompletions(backup)

end # module test_emojisymbols_patches
