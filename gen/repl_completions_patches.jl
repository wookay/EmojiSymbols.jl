# module EmojiSymbols

const repl_completions_patches = Vector{Patch}([
    Patch(v"1.13.0-DEV.595", # 229a6984ee142283d81955d8d53d7985fd5736ca
        AddLatexSymbols("\\hookunderrightarrow" => "🢲")),

    Patch(v"1.11.0-DEV.12", # fcb31107a9515dda8b519e126c039c345ef7daf9
        AddLatexSymbols("\\guilsinglleft" => "‹",
                        "\\guillemotleft" => "«",
                        "\\guillemotright" => "»")),

    Patch(v"1.10.0-DEV.1204", # ad939df098a58f38c6a2dc9aec5976f098a5e5e5
        AddLatexSymbols("\\leftarrowless" => "⥷",
                        "\\leftarrowsubset" => "⥺")),
    Patch(v"1.10.0-DEV.570", # a647575ff68ffec44ef7980545479915fcf3d62e
        AddLatexSymbols("\\veedot" => "⟇")),

    Patch(v"1.9.0-DEV.346", # 315a5ddb46628373b72e1b700d5bd8e35cd78df7
        RemoveLatexSymbols("\\sqspne" => "⋥"),
        AddLatexSymbols("\\sqsupsetneq" => "⋥")),
    Patch(v"1.9.0-DEV.332", # 559244b383cf1a146f6c8e4ed81b1b746276abe0
        AddLatexSymbols("\\neq" => "≠"),
        AddSymbolsLatexCanonical("≠" => "\\ne")),

    Patch(v"1.7.0-DEV.894", # 4996445df37e526dac2772e333caf82f1ea987f0
        AddLatexSymbols("\\Top" => "⫪",
                        "\\Bot" => "⫫",
                        "\\indep" => "⫫",
                        "\\downvDash" => "⫪",
                        "\\upvDash" => "⫫"),
        AddSymbolsLatexCanonical("⫫" => "\\Bot",
                                 "⫪" => "\\Top")),
    Patch(v"1.7.0-DEV.893", # b838cdfbb54515f8007a2958ebcdd58b76513db5
        AddLatexSymbols("\\nand" => "⊼",
                        "\\nor" => "⊽"),
        AddSymbolsLatexCanonical("⊼" => "\\nand",
                                 "⊽" => "\\nor")),
    Patch(v"1.7.0-DEV.849", # 2fc32f2ea247c0c03ea78b229ff159af84c45fb1
        Load2fc32f2ea2())
])

# module EmojiSymbols
