module test_emojisymbols_emoji

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

@test EmojiSymbols.emoji_name_table['🤔'] == "\\:thinking_face:"
@test sprint(show, MIME"text/plain"(), '🤔') == "\\:thinking_face: '🤔': Unicode U+1F914 (category So: Symbol, other)"
@test sprint(show, MIME"text/plain"(), "🤔") == "\\:thinking_face: \"🤔\""
@test sprint(show, MIME"text/plain"(), '☔') == "\\:umbrella_with_rain_drops: '☔': Unicode U+2614 (category So: Symbol, other)"

end # module test_emojisymbols_emoji
