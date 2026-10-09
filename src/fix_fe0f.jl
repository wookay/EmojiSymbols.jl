# module EmojiSymbols

const U_FE0F = '\UFE0F'
const fixed_symbols_latex = Dict{String, String}()

function fix_fe0f_for_symbols_latex(; force::Bool = false)::Int
    !force && !isempty(fixed_symbols_latex) && return 0
    for (k, v) in REPL.symbols_latex
        if length(k) == 2 && last(k) == U_FE0F
            s = string(first(k))
            fixed_symbols_latex[s] = v
        end # if
    end # for
    cnt_fixed_fe0f = length(fixed_symbols_latex)
    merge!(REPL.symbols_latex, fixed_symbols_latex)
    return cnt_fixed_fe0f
end

# module EmojiSymbols
