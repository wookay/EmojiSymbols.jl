# check_for_updates_using_sugar_cubes.jl
#
# ~/.julia/dev/EmojiSymbols main✔   ln -s  JULIA_SOURCE_PATH  sources

using Test
using SugarCubes: code_block_with, has_diff
# https://github.com/wookay/SugarCubes.jl

function check_the_code_block_diff(src_path::String,
                                   src_signature::Expr,
                                   dest_path::String,
                                   dest_signature::Expr)
    printstyled(stdout, "check_the_code_block_diff", color = :blue)
    print(stdout, " ", basename(src_path), " ")
    src_filepath = normpath(@__DIR__, "..", src_path)
    dest_filepath = normpath(@__DIR__, "..", dest_path)
    @test isfile(src_filepath)
    @test isfile(dest_filepath)
    src_block = code_block_with(; filepath = src_filepath, signature = src_signature)
    (depth, kind, sig) = src_block.signature.layers[end]
    printstyled(stdout, sig.args[1], color = :cyan)
    dest_block = code_block_with(; filepath = dest_filepath, signature = dest_signature)
    @test has_diff(src_block, dest_block) === false
    println(stdout)
end

if VERSION >= v"1.14-DEV"
check_the_code_block_diff(
    "sources/stdlib/REPL/src/REPL.jl",
    :(module REPL function show_limited(io::IO, mime::MIME, x) end end),
    "src/REPL.jl",
    :(if VERSION >= v"1.13.0-DEV.620" elseif VERSION >= v"1.11.0" function show_limited(io::IO, mime::MIME, x) end end)
)

check_the_code_block_diff(
    "sources/stdlib/REPL/src/REPL.jl",
    :(module REPL function display(d::REPLDisplay, mime::MIME"text/plain", x) end end),
    "src/REPL.jl",
    :(if VERSION >= v"1.13.0-DEV.620" elseif VERSION >= v"1.11.0" function display(d::REPLDisplay, mime::MIME"text/plain", x::AbstractChar) end end)
)

check_the_code_block_diff(
    "sources/stdlib/REPL/src/REPL.jl",
    :(module REPL function show_repl(io::IO, mime::MIME"text/plain", c::AbstractChar) end end),
    "src/REPL.jl",
    :(if v"1.13.0-DEV.620" > VERSION >= v"1.11.0" function show_repl(io::IO, mime::MIME"text/plain", c::AbstractChar) end end)
)
end # if
