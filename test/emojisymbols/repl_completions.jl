module test_emojisymbols_repl_completions

using Test

# cur_ver::VersionNumber
global cur_ver = VERSION

function found(ver::VersionNumber, ver_check::Bool, table::Dict{String, String}, pair::Pair{String, String})::Bool
    (k, v) = pair
    if ver_check
        if cur_ver < ver
            if haskey(table, k)
                table[k] != v
            else
                true
            end
        else
            haskey(table, k) && table[k] == v
        end
    else
        haskey(table, k) && table[k] == v
    end
end

function compat_v1_13(mod::Module; ver_check::Bool)
    found(v"1.13.0-DEV.595", ver_check, mod.latex_symbols, "\\hookunderrightarrow" => "🢲")
end

function compat_v1_11(mod::Module; ver_check::Bool)
    found(v"1.11.0-DEV.12", ver_check, mod.latex_symbols, "\\guillemotleft" => "«")
end

function compat_v1_10(mod::Module; ver_check::Bool)
    found(v"1.10.0-DEV.1204", ver_check, mod.latex_symbols, "\\leftarrowless" => "\u2977") &&
    found(v"1.10.0-DEV.570", ver_check, mod.latex_symbols, "\\veedot" => "⟇")
end

function compat_v1_9(mod::Module; ver_check::Bool)
    ver346 = v"1.9.0-DEV.346"
    !found(ver346, ver_check, mod.latex_symbols, "\\sqspne" => "⋥") &&
     found(ver346, ver_check, mod.latex_symbols, "\\sqsupsetneq" => "⋥") &&
    found(v"1.9.0-DEV.332", ver_check, mod.latex_symbols, "\\neq" => "≠")
end

function compat_v1_7(mod::Module; ver_check::Bool)
    found(v"1.7.0-DEV.894", ver_check, mod.latex_symbols, "\\Top" => "⫪") &&
    found(v"1.7.0-DEV.893", ver_check, mod.latex_symbols, "\\nand" => "⊼") &&
    found(v"1.7.0-DEV.849", ver_check, mod.latex_symbols, "\\^ltphi" => "ᶲ") &&
    found(v"1.7.0-DEV.849", ver_check, mod.emoji_symbols, "\\:thinking_face:" => "🤔")
end

compats = (compat_v1_13, compat_v1_11, compat_v1_9, compat_v1_7)

function test_part1()
    R = Base.REPL_MODULE_REF[]
    for f in compats
        b = f(R.REPLCompletions, ver_check = true)
        @test b
    end
end

test_part1()

include(normpath(@__DIR__, "../../src/backup.jl"))
backup = backup_REPLCompletions()

already_loaded = haskey(Base.loaded_modules, Base.PkgId(Base.UUID("c599478c-de41-4aed-94ea-b47665d7a42a"), "EmojiSymbols"))
using EmojiSymbols
already_loaded && EmojiSymbols.__init__()

function test_part2()
    R = Base.REPL_MODULE_REF[]
    for f in compats
        b = f(R.REPLCompletions, ver_check = false)
        @test b
    end
end

test_part2()
EmojiSymbols.rollback_REPLCompletions(backup)

test_part1()

end # module test_emojisymbols_repl_completions
