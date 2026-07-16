# check_for_updates_using_sugar_cubes.jl
#
# ~/.julia/dev/EmojiSymbols main✔   ln -s  JULIA_SOURCE_PATH  sources

using Test
using SugarCubes: code_block_with, has_diff
# https://github.com/wookay/SugarCubes.jl

function check_the_code_block_diff(src_path::String,
                                   src_signature::Union{Nothing, Expr},
                                   dest_path::String,
                                   dest_signature::Union{Nothing, Expr})
    printstyled(stdout, "✔ ", color = :blue)
    print(stdout, " ", basename(src_path), " ")
    src_filepath = normpath(@__DIR__, "..", src_path)
    dest_filepath = normpath(@__DIR__, "..", dest_path)
    @test isfile(src_filepath)
    @test isfile(dest_filepath)
    src_block = code_block_with(; filepath = src_filepath, signature = src_signature)
    if src_block.signature !== nothing
        (depth, kind, sig) = src_block.signature.layers[end]
        printstyled(stdout, sig.args[1], color = :cyan)
    end
    dest_block = code_block_with(; filepath = dest_filepath, signature = dest_signature)
    @test has_diff(src_block, dest_block) === false
    println(stdout)
end

if VERSION >= v"1.14-DEV"

f = :(function show_limited(io::IO, mime::MIME, x) end)
check_the_code_block_diff(
    "src/REPL.jl",
    :(if VERSION >= v"1.13.0-DEV.620" elseif VERSION >= v"1.11.0" function show_limited(io::IO, mime::MIME, x) end end),
    "sources/stdlib/REPL/src/REPL.jl",
    :(module REPL $f end)
)

check_the_code_block_diff(
    "src/REPL.jl",
    :(if VERSION >= v"1.13.0-DEV.620" elseif VERSION >= v"1.11.0" function display(d::REPLDisplay, mime::MIME"text/plain", x::AbstractChar) end end),
    "sources/stdlib/REPL/src/REPL.jl",
    :(module REPL function display(d::REPLDisplay, mime::MIME"text/plain", x) end end)
)

f = :(function show_repl(io::IO, mime::MIME"text/plain", c::AbstractChar) end)
check_the_code_block_diff(
    "src/REPL.jl",
    :(if v"1.13.0-DEV.620" > VERSION >= v"1.11.0" function show_repl(io::IO, mime::MIME"text/plain", c::AbstractChar) end end),
    "sources/stdlib/REPL/src/REPL.jl",
    :(module REPL $f end)
)

check_the_code_block_diff(
    "gen/codex/emoji_symbols.jl", nothing,
    "sources/stdlib/REPL/src/emoji_symbols.jl", nothing
)

check_the_code_block_diff(
    "gen/codex/latex_symbols.jl", nothing,
    "sources/stdlib/REPL/src/latex_symbols.jl", nothing
)

end # if
