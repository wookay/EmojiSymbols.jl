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
        "additional Emoji symbols" => [
            "additional_symbols_170.md",
            "additional_symbols_below_170.md",
        ],
        "Emoji symbols in REPL" => [
            "emoji_symbols_in_repl_170.md",
            "emoji_symbols_in_repl_below_170.md",
        ],
        "LaTeX symbols in REPL" => "latex_symbols_in_repl.md",
    ],
)
