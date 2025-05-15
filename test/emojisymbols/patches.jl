module test_emojisymbols_patches

using Test
using EmojiSymbols # Patch patches_to_be_loaded LATEST_PATCH_VERSION

patches = patches_to_be_loaded(down_to = VERSION, up_to = LATEST_PATCH_VERSION)
@test patches == patches_to_be_loaded()

patches = patches_to_be_loaded(down_to = v"1.10", up_to = v"1.12")
@test !isempty(patches)

patches = patches_to_be_loaded(down_to = v"1.12", up_to = v"1.11")
@test isempty(patches)

end # module test_emojisymbols_patches
