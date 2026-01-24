# EmojiSymbols.jl

additional Emoji, LaTeX Symbols for Julia REPL 🤔

|  **Documentation**                        |  **Build Status**                                                  |
|:-----------------------------------------:|:------------------------------------------------------------------:|
|  [![][docs-latest-img]][docs-latest-url]  |  [![][actions-img]][actions-url]  [![][codecov-img]][codecov-url]  |

```julia-repl
               _
   _       _ _(_)_     |  Documentation: https://docs.julialang.org
  (_)     | (_) (_)    |
   _ _   _| |_  __ _   |  Type "?" for help, "]?" for Pkg help.
  | | | | | | |/ _` |  |
  | | |_| | | | (_| |  |  Version 1.11.5 (2025-04-14)
 _/ |\__'_|_|_|\__'_|  |  Official https://julialang.org/ release
|__/                   |

julia> \hookunderrightarrow <tab>

julia> using EmojiSymbols

julia> \hookunderrightarrow <tab>

julia> 🢲

julia> '🢲'
'\U1f8b2': Unicode U+1F8B2 (category Cn: Other, not assigned), input as \hookunderrightarrow<tab>

julia> '🤔'
'🤔': Unicode U+1F914 (category So: Symbol, other), input as \:thinking_face:<tab>
```

See also [Glyphy.jl](https://github.com/cormullion/Glyphy.jl).


[docs-latest-img]: https://img.shields.io/badge/docs-latest-blue.svg
[docs-latest-url]: https://wookay.github.io/docs/EmojiSymbols.jl/

[actions-img]: https://github.com/wookay/EmojiSymbols.jl/workflows/CI/badge.svg
[actions-url]: https://github.com/wookay/EmojiSymbols.jl/actions

[codecov-img]: https://codecov.io/gh/wookay/EmojiSymbols.jl/branch/master/graph/badge.svg
[codecov-url]: https://codecov.io/gh/wookay/EmojiSymbols.jl/branch/master
