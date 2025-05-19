module test_emojisymbols_patches

using Test
using EmojiSymbols

patches = patches_to_be_loaded(down_to = VERSION, up_to = LATEST_PATCH_VERSION)
@test patches == patches_to_be_loaded()

module MyREPL
module REPLCompletions
emoji_symbols = Dict{String, String}()
latex_symbols = Dict{String, String}()
end
end # module MyREPL
patches = patches_to_be_loaded(down_to = v"1.11-DEV.1", up_to = v"1.11-DEV.15")
@test !isempty(patches)
cnt = apply_patches_to_repl_completions(patches, MyREPL.REPLCompletions)
@test (sort ∘ collect ∘ values)(MyREPL.REPLCompletions.latex_symbols) == ["«", "»"]
@test cnt == 2

patches = patches_to_be_loaded(down_to = v"1.12.0-beta3", up_to = v"1.13.0-DEV.595")
@test !isempty(patches)

patches = patches_to_be_loaded(down_to = v"1.13.0-DEV.594", up_to = v"1.13.0-DEV.595")
@test !isempty(patches)

patches = patches_to_be_loaded(down_to = v"1.13.0-DEV.595", up_to = v"1.13.0-DEV.595")
@test isempty(patches)

end # module test_emojisymbols_patches
