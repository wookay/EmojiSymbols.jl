module test_emojisymbols_latex

using Test
using EmojiSymbols

@test EmojiSymbols.latex_name_table['β'] == "\\beta"
@test sprint(show, MIME"text/plain"(), 'β') == "\\beta 'β': Unicode U+03B2 (category Ll: Letter, lowercase)"

end # module test_emojisymbols_latex
