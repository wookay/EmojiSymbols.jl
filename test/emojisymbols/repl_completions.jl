module test_emojisymbols_repl_completions

using Test

function found(ver_check::Bool, down_to::VersionNumber, up_to::VersionNumber, table::Dict{String, String}, pair::Pair{String, String})::Bool
    (k, v) = pair
    if ver_check && down_to < up_to
        return haskey(table, k) ? table[k] != v : true
    end
    return haskey(table, k) && table[k] == v
end

function compat_v1_13(mod::Module; ver_check::Bool, down_to::VersionNumber = VERSION)
    found(ver_check, down_to, v"1.13.0-DEV.595", mod.latex_symbols, "\\hookunderrightarrow" => "🢲")
end

function compat_v1_11(mod::Module; ver_check::Bool, down_to::VersionNumber = VERSION)
    found(ver_check, down_to, v"1.11.0-DEV.12", mod.latex_symbols, "\\guillemotleft" => "«")
end

function compat_v1_10(mod::Module; ver_check::Bool, down_to::VersionNumber = VERSION)
    found(ver_check, down_to, v"1.10.0-DEV.1204", mod.latex_symbols, "\\leftarrowless" => "\u2977") &&
    found(ver_check, down_to, v"1.10.0-DEV.570", mod.latex_symbols, "\\veedot" => "⟇")
end

function compat_v1_9(mod::Module; ver_check::Bool, down_to::VersionNumber = VERSION)
    ver346 = v"1.9.0-DEV.346"
    !found(ver_check, down_to, ver346, mod.latex_symbols, "\\sqspne" => "⋥") &&
    found(ver_check, down_to, ver346, mod.latex_symbols, "\\sqsupsetneq" => "⋥") &&
    found(ver_check, down_to, v"1.9.0-DEV.332", mod.latex_symbols, "\\neq" => "≠")
end

function compat_v1_7(mod::Module; ver_check::Bool, down_to::VersionNumber = VERSION)
    found(ver_check, down_to, v"1.7.0-DEV.894", mod.latex_symbols, "\\Top" => "⫪") &&
    found(ver_check, down_to, v"1.7.0-DEV.893", mod.latex_symbols, "\\nand" => "⊼") &&
    found(ver_check, down_to, v"1.7.0-DEV.849", mod.latex_symbols, "\\^ltphi" => "ᶲ") &&
    found(ver_check, down_to, v"1.7.0-DEV.849", mod.emoji_symbols, "\\:thinking_face:" => "🤔")
end

module MyREPL
module REPLCompletions
emoji_symbols = Dict{String, String}()
latex_symbols = Dict{String, String}()
end
end # module MyREPL
@test compat_v1_13(MyREPL.REPLCompletions; ver_check = true, down_to = v"1.13.0-DEV.594")

merge!(MyREPL.REPLCompletions.latex_symbols, Dict("\\hookunderrightarrow" => "🢲"))
@test compat_v1_13(MyREPL.REPLCompletions; ver_check = false, down_to = v"1.13.0-DEV.594")


compats = (compat_v1_13, compat_v1_11, compat_v1_10, compat_v1_9, compat_v1_7)

function get_repl()::Module
    if isassigned(Base.REPL_MODULE_REF)
        Base.REPL_MODULE_REF[]
    else
        eval(:(using REPL: REPL))
        REPL
    end
end

function test_part1()
    R::Module = get_repl()
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
    R::Module = get_repl()
    for f in compats
        b = f(R.REPLCompletions, ver_check = false)
        @test b
    end
end

test_part2()
EmojiSymbols.rollback_REPLCompletions(backup)

test_part1()

end # module test_emojisymbols_repl_completions
