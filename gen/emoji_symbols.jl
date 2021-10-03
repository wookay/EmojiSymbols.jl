if VERSION < v"1.7.0-DEV.849"
    include("generated_emoji_symbols_below_170.jl")
else
    include("generated_emoji_symbols_170.jl")
end
