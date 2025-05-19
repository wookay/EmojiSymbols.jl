using Test
using REPL

const TARGET_PATCHES = Patch[
    # v1.13
    Patch(v"1.13.0-DEV.595", # 229a6984ee142283d81955d8d53d7985fd5736ca
        AddLatexSymbols("\\hookunderrightarrow" => "🢲")),

    # v1.12
    Patch(v"1.12.0-DEV.278", #0ac60b736a26f4b92b67edad16f3e90e1eb32cd8
        AddEmojiSymbols("\\:beans:" => "🫘",
                        "\\:flute:" => "🪈")),

    # v1.9
    Patch(v"1.9.0-DEV.346", # 315a5ddb46628373b72e1b700d5bd8e35cd78df7
        RemoveLatexSymbols("\\sqspne" => "⋥"),
        AddLatexSymbols("\\sqsupsetneq" => "⋥")),
    Patch(v"1.9.0-DEV.332", # 559244b383cf1a146f6c8e4ed81b1b746276abe0
        AddLatexSymbols("\\neq" => "≠"),
        AddSymbolsLatexCanonical("≠" => "\\ne")),
]

function check_the_patches(f)
    latest_patch_version = first(TARGET_PATCHES).version
    patches = patches_to_be_loaded(; down_to = VERSION, up_to = latest_patch_version, patches = TARGET_PATCHES)
    mod = REPL.REPLCompletions
    for patch in patches
        for action in patch.actions
            for (k, v) in action.symbol_pairs
                if action isa AddEmojiSymbols
                    t = haskey(mod.emoji_symbols, k)
                    t && @test mod.emoji_symbols[k] == v
                    b = f(t)
                    @test b
                elseif action isa AddLatexSymbols
                    t = haskey(mod.latex_symbols, k)
                    t && @test mod.latex_symbols[k] == v
                    b = f(t)
                    @test b
                elseif action isa RemoveLatexSymbols
                    t = haskey(mod.latex_symbols, k)
                    b = f(!t)
                    @test b
                elseif action isa AddSymbolsLatexCanonical && isdefined(mod, :symbols_latex_canonical)
                    t = haskey(mod.symbols_latex_canonical, k)
                    t && @test mod.symbols_latex_canonical[k] == v
                    b = f(t)
                    @test b
                end
            end # for (k, v) in action.symbol_pairs
        end # for action in patch.actions
    end # for action in patch.actions
end
