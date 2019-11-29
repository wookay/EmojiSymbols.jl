# EmojiSymbols.jl

|  **Build Status**                                                                 |
|:----------------------------------------------------------------------------------|
|  [![][actions-img]][actions-url]  [![][nightly-actions-img]][nightly-actions-url] |

```julia
julia> using EmojiSymbols

julia> \:thinking_face:<TAB>
julia> 🤔
```


```julia
julia> using REPL

julia> length(REPL.REPLCompletions.emoji_symbols)
829

julia> using EmojiSymbols

julia> length(REPL.REPLCompletions.emoji_symbols)
1066
```


[actions-img]: https://github.com/wookay/EmojiSymbols.jl/workflows/CI/badge.svg
[actions-url]: https://github.com/wookay/EmojiSymbols.jl/actions
[nightly-actions-img]: https://github.com/wookay/EmojiSymbols.jl/workflows/nightly/badge.svg
[nightly-actions-url]: https://github.com/wookay/EmojiSymbols.jl/actions
