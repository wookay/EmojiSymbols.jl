using Documenter
using EmojiSymbols
using .EmojiSymbols: AbstractPatchAction,
                     Load2fc32f2ea2, AddEmojiSymbols, AddLatexSymbols, RemoveLatexSymbols, AddSymbolsLatexCanonical

makedocs(
    build = joinpath(@__DIR__, "local" in ARGS ? "build_local" : "build"),
    modules = [EmojiSymbols],
    clean = false,
    format = Documenter.HTML(
        prettyurls = !("local" in ARGS),
        assets = ["assets/custom.css"],
        size_threshold = 1_000_000,
    ),
    sitename = "EmojiSymbols.jl 🤔",
    authors = "WooKyoung Noh",
    pages = Any[
        "Home" => "index.md",
        "Emoji symbols" => "emoji_symbols.md",
        "LaTeX symbols" => "latex_symbols.md",
        "API" => "api.md",
        "Patches" => "patches.md",
    ],
)
