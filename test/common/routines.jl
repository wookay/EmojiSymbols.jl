using Test
using REPL

const SAMPLE_PATCHES = Patch[
    # v1.14
     Patch(v"1.14.0-DEV.22",  # ed705d859ab9d2f03d134ee45d9f51ebed300f1a    Add superscript capital C, F, Q
         AddLatexSymbols("\\^C" => "ꟲ",
                         "\\^F" => "ꟳ",
                         "\\^Q" => "ꟴ")),
    # v1.13
    Patch(v"1.13.0-DEV.1250", # 0e30e0f39dd92a868373739cf8989c64dd29eaa2    Support superscript small q
        AddLatexSymbols("\\^q" => "𐞥")),
    Patch(v"1.13.0-DEV.595",  # 229a6984ee142283d81955d8d53d7985fd5736ca   Rightwards Arrow with Lower Hook
        AddLatexSymbols("\\hookunderrightarrow" => "🢲")),
    # v1.12
    Patch(v"1.12.0-DEV.278",  # 0ac60b736a26f4b92b67edad16f3e90e1eb32cd8
        AddEmojiSymbols("\\:beans:" => "🫘", "\\:flute:" => "🪈")), # v1.9
    Patch(v"1.9.0-DEV.346",   # 315a5ddb46628373b72e1b700d5bd8e35cd78df7
        RemoveLatexSymbols("\\sqspne" => "⋥"),
        AddLatexSymbols("\\sqsupsetneq" => "⋥")),
    Patch(v"1.9.0-DEV.332",   # 559244b383cf1a146f6c8e4ed81b1b746276abe0
        AddLatexSymbols("\\neq" => "≠"),
        AddSymbolsLatexCanonical("≠" => "\\ne")),
]

function is_past_version(patch::Patch)::Bool
    VERSION > patch.version
end

function check_the_patches(loaded::Bool)
    down_to = last(SAMPLE_PATCHES).version
    up_to = first(SAMPLE_PATCHES).version
    patches = patches_to_be_loaded(; down_to = down_to, up_to = up_to, patches = SAMPLE_PATCHES)
    mod = REPL.REPLCompletions
    for patch in patches
        is_past = is_past_version(patch)
        for action in patch.actions
            for (k, v) in action.symbol_pairs
                if action isa AddEmojiSymbols
                    found = haskey(mod.emoji_symbols, k)
                    if loaded
                        @test mod.emoji_symbols[k] == v
                    else
                        @test is_past == found
                    end
                elseif action isa AddLatexSymbols
                    found = haskey(mod.latex_symbols, k)
                    if loaded
                        @test mod.latex_symbols[k] == v
                    else
                        @test is_past == found
                    end
                elseif action isa RemoveLatexSymbols
                    found = haskey(mod.latex_symbols, k)
                    if loaded
                        @test !found
                    else
                        @test is_past == !found
                    end
                elseif action isa AddSymbolsLatexCanonical && isdefined(mod, :symbols_latex_canonical)
                    found = haskey(mod.symbols_latex_canonical, k)
                    if loaded
                        @test mod.symbols_latex_canonical[k] == v
                    else
                        @test is_past == found
                    end
                end
            end # for (k, v) in action.symbol_pairs
        end # for action in patch.actions
    end # for action in patch.actions
end
