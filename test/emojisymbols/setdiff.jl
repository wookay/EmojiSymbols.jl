module test_emojisymbols_setdiff

using Test

legacy_emoji = ["☺", "☎", "🅰", "▫", "㊗", "◼", "⤵", "✖", "❄", "‼", "↔", "☑", "♥", "✉", "♣", "✒", "✈", "®", "〰", "🅱", "↪", "⬅", "⤴", "◀", "❇", "♨", "◻", "✴", "✔", "🈷", "▶", "☁", "♠", "ℹ", "☀", "⁉", "©", "⬇", "↙", "⚠", "〽", "▪", "✂", "✌", "↗", "™", "Ⓜ", "↘", "➡", "↖", "㊙", "☝", "↕", "⬆", "♻", "🅿", "🈂", "♦", "↩", "✏", "🅾", "❤", "✳"]

using REPL
@test !haskey(REPL.REPLCompletions.emoji_symbols, "\\:thinking_face:")
s1 = values(copy(REPL.REPLCompletions.emoji_symbols))
@test intersect(legacy_emoji, s1) == legacy_emoji

using EmojiSymbols
s2 = values(EmojiSymbols.emoji_symbols)
@test isempty(intersect(legacy_emoji, s2))
@test REPL.REPLCompletions.emoji_symbols["\\:thinking_face:"] == "🤔"

end # module test_emojisymbols_setdiff
