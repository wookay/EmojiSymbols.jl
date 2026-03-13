# check_for_updates_using_sugar_cubes.jl
#
# ~/.julia/dev/EmojiSymbols main✔   ln -s  JULIA_SOURCE_PATH  sources

using Test
using SugarCubes: remove_linenums_in_macrocall!, code_block_with, has_diff
# https://github.com/wookay/SugarCubes.jl

function checks_has_diff(src_path::String,
                         src_signature::Expr,
                         dest_path::String,
                         dest_signature::Expr)
    remove_linenums_in_macrocall!(src_signature)
    printstyled(stdout, "checks_has_diff", color = :cyan)
    print(stdout, " ", basename(src_path), " ")
    printstyled(stdout, src_signature.args[4].args[1].args[1].args[1], color = :blue)
    src_filepath = normpath(@__DIR__, "..", src_path)
    dest_filepath = normpath(@__DIR__, "..", dest_path)
    @test isfile(src_filepath)
    @test isfile(dest_filepath)
    src_block = code_block_with(; filepath = src_filepath, signature = src_signature)
    dest_block = code_block_with(; filepath = dest_filepath, signature = dest_signature)
    @test has_diff(src_block, dest_block) === false
    println(stdout)
end

if VERSION >= v"1.14-DEV"
checks_has_diff(
    "sources/stdlib/REPL/src/REPL.jl",
    :(module REPL function show_limited(io::IO, mime::MIME, x) end end),
    "src/REPL.jl",
    :(if VERSION >= v"1.13.0-DEV.620" elseif VERSION >= v"1.11.0" function show_limited(io::IO, mime::MIME, x) end end)
)
checks_has_diff(
    "sources/stdlib/REPL/src/REPL.jl",
    :(module REPL function display(d::REPLDisplay, mime::MIME"text/plain", x) end end),
    "src/REPL.jl",
    :(if VERSION >= v"1.13.0-DEV.620" elseif VERSION >= v"1.11.0" function display(d::REPLDisplay, mime::MIME"text/plain", x::AbstractChar) end end)
)
end
