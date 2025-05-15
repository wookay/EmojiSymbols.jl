# module EmojiSymbols

include(normpath(@__DIR__, "../src/types.jl"))

# repl_patches::Vector{Patch}
repl_patches = Vector{Patch}([
    Patch(v"1.13.0-DEV.595",
          "229a6984ee142283d81955d8d53d7985fd5736ca",
          AddLatexSymbols(1)),          # \hookunderrightarrow => 🢲

    Patch(v"1.11.0-DEV.12",
          "fcb31107a9515dda8b519e126c039c345ef7daf9",
          AddLatexSymbols(3)),          # \guilsinglleft  => ‹
                                        # \guillemotleft  => «
                                        # \guillemotright => »

    Patch(v"1.10.0-DEV.1204",
          "ad939df098a58f38c6a2dc9aec5976f098a5e5e5",
          AddLatexSymbols(2)),          # \leftarrowless   => ⥷
                                        # \leftarrowsubset => ⥺
    Patch(v"1.10.0-DEV.570",
          "a647575ff68ffec44ef7980545479915fcf3d62e",
          AddLatexSymbols(1)),          # \veedot => ⟇

    Patch(v"1.9.0-DEV.346",
          "315a5ddb46628373b72e1b700d5bd8e35cd78df7",
          ReplaceLatexSymbols(1)),      # \sqsupsetneq => ⋥
    Patch(v"1.9.0-DEV.332",
          "559244b383cf1a146f6c8e4ed81b1b746276abe0",
          AddLatexSymbols(1),           # \neq => ≠
          AddSymbolsLatexCanonical(1)), # ≠    => \ne
])

# LATEST_PATCH_VERSION::VersionNumber
const LATEST_PATCH_VERSION = first(repl_patches).version

function patches_to_be_loaded(; down_to::VersionNumber = VERSION,
                                up_to::VersionNumber = LATEST_PATCH_VERSION)::Vector{Patch}
    filter(repl_patches) do patch
        down_to <= patch.version <= up_to
    end
end

# module EmojiSymbols
