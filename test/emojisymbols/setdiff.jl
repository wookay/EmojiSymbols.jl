module test_emojisymbols_setdiff

using Test

using REPL
s1 = values(copy(REPL.REPLCompletions.emoji_symbols))
@test !haskey(REPL.REPLCompletions.emoji_symbols, "\\:thinking_face:")

using EmojiSymbols
s2 = values(EmojiSymbols.emoji_symbols)

@test setdiff(s1, s2) == ["☺", "☎", "🅰", "▫", "㊗", "◼", "⤵", "✖", "❄", "‼", "↔", "☑", "♥", "✉", "♣", "✒", "✈", "®", "〰", "🅱", "↪", "⬅", "⤴", "◀", "❇", "♨", "◻", "✴", "✔", "🈷", "▶", "☁", "♠", "ℹ", "☀", "⁉", "©", "⬇", "↙", "⚠", "〽", "▪", "✂", "✌", "↗", "™", "Ⓜ", "↘", "➡", "↖", "㊙", "☝", "↕", "⬆", "♻", "🅿", "🈂", "♦", "↩", "✏", "🅾", "❤", "✳"]
@test !isempty(setdiff(s2, s1))

@test REPL.REPLCompletions.emoji_symbols["\\:thinking_face:"] == "🤔"

end # module test_emojisymbols_setdiff
