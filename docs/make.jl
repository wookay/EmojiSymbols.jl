using Documenter
using EmojiSymbols

makedocs(
    build = joinpath(@__DIR__, "local" in ARGS ? "build_local" : "build"),
    modules = [EmojiSymbols],
    clean = false,
    format = Documenter.HTML(
        prettyurls = !("local" in ARGS),
        assets = ["assets/custom.css"],
    ),
    sitename = "EmojiSymbols.jl 🤔",
    authors = "WooKyoung Noh",
    pages = Any[
        "Home" => "index.md",
        "additional Emoji symbols" => "additional_symbols.md",
        "Emoji symbols in REPL" => "symbols_in_repl.md",
    ],
)
