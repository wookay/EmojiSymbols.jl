module test_emojisymbols_latex

using Test
using EmojiSymbols

@test EmojiSymbols.latex_name_table['β'] == "\\beta"
@test sprint(show, MIME"text/plain"(), 'β') == "\\beta 'β': Unicode U+03B2 (category Ll: Letter, lowercase)"
@test sprint(show, MIME"text/plain"(), ' ') == "\\thickspace ' ': Unicode U+2005 (category Zs: Separator, space)"

@test length("⊊︀") == 2
@test EmojiSymbols.latex_name_table["⊊︀"] == "\\varsubsetneqq"
@test sprint(show, MIME"text/plain"(), "⊊︀") == string("\\varsubsetneqq ", repr("⊊︀"))

end # module test_emojisymbols_latex
