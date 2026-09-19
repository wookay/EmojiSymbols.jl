# module EmojiSymbols

const REPL_COMPLETIONS_PATCHES = Vector{Patch}([
    # v1.14
    Patch(v"1.14.0-DEV.3246", # 289916806447593343fb41475bb40387e87552d2    Support `\escape` for `⎋` and `\xmark` for `✗`
         AddLatexSymbols("\\escape" => "⎋",
                         "\\xmark" => "✗")),
     Patch(v"1.14.0-DEV.22",  # ed705d859ab9d2f03d134ee45d9f51ebed300f1a    Add superscript capital C, F, Q
         AddLatexSymbols("\\^C" => "ꟲ",
                         "\\^F" => "ꟳ",
                         "\\^Q" => "ꟴ")),

    # v1.13
    Patch(v"1.13.0-DEV.1250", # 0e30e0f39dd92a868373739cf8989c64dd29eaa2    Support superscript small q
        AddLatexSymbols("\\^q" => "𐞥")),
    Patch(
        OR(v"1.12.3",
           v"1.13.0-DEV.595"  # 229a6984ee142283d81955d8d53d7985fd5736ca    Rightwards Arrow with Lower Hook
        ),
        AddLatexSymbols("\\hookunderrightarrow" => "🢲")),

    # v1.12
    Patch(v"1.12.0-DEV.492",  # 6f6bb950b3e7b0a6e77bb11ffd7cc001cb87439d    Music Symbols
        AddLatexSymbols("\\flatflat" => "𝄫",
                        "\\sharpsharp" => "𝄪",
                        "\\leftrepeatsign" => "𝄆",
                        "\\rightrepeatsign" => "𝄇",
                        "\\dalsegno" => "𝄉",
                        "\\dacapo" => "𝄊",
                        "\\segno" => "𝄋",
                        "\\coda" => "𝄌",
                        "\\clefg" => "𝄞",
                        "\\clefg8va" => "𝄟",
                        "\\clefg8vb" => "𝄠",
                        "\\clefc" => "𝄡",
                        "\\cleff" => "𝄢",
                        "\\cleff8va" => "𝄣",
                        "\\cleff8vb" => "𝄤",
                        "\\restmulti" => "𝄺",
                        "\\restwhole" => "𝄻",
                        "\\resthalf" => "𝄼",
                        "\\restquarter" => "𝄽",
                        "\\rest8th" => "𝄾",
                        "\\rest16th" => "𝄿",
                        "\\rest32th" => "𝅀",
                        "\\rest64th" => "𝅁",
                        "\\rest128th" => "𝅂",
                        "\\notedoublewhole" => "𝅜",
                        "\\notewhole" => "𝅝",
                        "\\notehalf" => "𝅗𝅥",
                        "\\notequarter" => "𝅘𝅥",
                        "\\note8th" => "𝅘𝅥𝅮",
                        "\\note16th" => "𝅘𝅥𝅯",
                        "\\note32th" => "𝅘𝅥𝅰",
                        "\\note64th" => "𝅘𝅥𝅱",
                        "\\note128th" => "𝅘𝅥𝅲")),
    Patch(v"1.12.0-DEV.467",  # f3561ae5af05713480aa9a8166501449305a0339
        AddLatexSymbols("\\_<" => "˱",
                        "\\_>" => "˲")),
    Patch(v"1.12.0-DEV.278",  # 0ac60b736a26f4b92b67edad16f3e90e1eb32cd8
        AddEmojiSymbols("\\:beans:" => "🫘",
                        "\\:biting_lip:" => "🫦",
                        "\\:bubbles:" => "🫧",
                        "\\:coral:" => "🪸",
                        "\\:crutch:" => "🩼",
                        "\\:donkey:" => "🫏",
                        "\\:dotted_line_face:" => "🫥",
                        "\\:empty_nest:" => "🪹",
                        "\\:face_holding_back_tears:" => "🥹",
                        "\\:face_with_diagonal_mouth:" => "🫤",
                        "\\:face_with_open_eyes_and_hand_over_mouth:" => "🫢",
                        "\\:face_with_peeking_eye:" => "🫣",
                        "\\:flute:" => "🪈",
                        "\\:folding_hand_fan:" => "🪭",
                        "\\:ginger_root:" => "🫚",
                        "\\:goose:" => "🪿",
                        "\\:grey_heart:" => "🩶",
                        "\\:hair_pick:" => "🪮",
                        "\\:hamsa:" => "🪬",
                        "\\:hand_with_index_finger_and_thumb_crossed:" => "🫰",
                        "\\:heart_hands:" => "🫶",
                        "\\:heavy_equals_sign:" => "🟰",
                        "\\:hyacinth:" => "🪻",
                        "\\:identification_card:" => "🪪",
                        "\\:index_pointing_at_the_viewer:" => "🫵",
                        "\\:jar:" => "🫙",
                        "\\:jellyfish:" => "🪼",
                        "\\:khanda:" => "🪯",
                        "\\:leftwards_hand:" => "🫲",
                        "\\:leftwards_pushing_hand:" => "🫷",
                        "\\:light_blue_heart:" => "🩵",
                        "\\:lotus:" => "🪷",
                        "\\:low_battery:" => "🪫",
                        "\\:maracas:" => "🪇",
                        "\\:melting_face:" => "🫠",
                        "\\:mirror_ball:" => "🪩",
                        "\\:moose:" => "🫎",
                        "\\:nest_with_eggs:" => "🪺",
                        "\\:palm_down_hand:" => "🫳",
                        "\\:palm_up_hand:" => "🫴",
                        "\\:pea_pod:" => "🫛",
                        "\\:person_with_crown:" => "🫅",
                        "\\:pink_heart:" => "🩷",
                        "\\:playground_slide:" => "🛝",
                        "\\:pouring_liquid:" => "🫗",
                        "\\:pregnant_man:" => "🫃",
                        "\\:pregnant_person:" => "🫄",
                        "\\:rightwards_hand:" => "🫱",
                        "\\:rightwards_pushing_hand:" => "🫸",
                        "\\:ring_buoy:" => "🛟",
                        "\\:saluting_face:" => "🫡",
                        "\\:shaking_face:" => "🫨",
                        "\\:troll:" => "🧌",
                        "\\:wheel:" => "🛞",
                        "\\:wing:" => "🪽",
                        "\\:wireless:" => "🛜",
                        "\\:x-ray:" => "🩻")),

    # v1.11
    Patch(v"1.11.0-DEV.1103", # 5e4e7fa153ed0c272c73076a9c386abc3f434c1b
        RemoveLatexSymbols("\\upMu" => "Μ",  # capital mu, greek
                           "\\upNu" => "Ν",  # capital nu, greek
                           "\\upOmicron" => "Ο",  # capital omicron, greek
                           "\\upepsilon" => "ε",  # rounded small epsilon, greek
                           "\\upomicron" => "ο",  # small omicron, greek
                           "\\upvarbeta" => "ϐ",  # rounded small beta, greek
                           "\\upoldKoppa" => "Ϙ",  # greek letter archaic koppa
                           "\\upoldkoppa" => "ϙ",  # greek small letter archaic koppa
                           "\\upstigma" => "ϛ",  # greek small letter stigma
                           "\\upkoppa" => "ϟ",  # greek small letter koppa
                           "\\upsampi" => "ϡ"),  # greek small letter sampi
        AddLatexSymbols("\\Mu" => "Μ",  # capital mu, greek
                        "\\Nu" => "Ν",  # capital nu, greek
                        "\\Omicron" => "Ο",  # capital omicron, greek
                        "\\omicron" => "ο",  # small omicron, greek
                        "\\varbeta" => "ϐ",  # rounded small beta, greek
                        "\\oldKoppa" => "Ϙ",  # greek letter archaic koppa
                        "\\oldkoppa" => "ϙ",  # greek small letter archaic koppa
                        "\\stigma" => "ϛ",  # greek small letter stigma
                        "\\koppa" => "ϟ",  # greek small letter koppa
                        "\\sampi" => "ϡ")),  # greek small letter sampi
  # Patch(v"1.11.0-DEV.656")  # 0c4af3288e8a4aab71c39b6ee5174964101e0704    Fix typos
    Patch(v"1.11.0-DEV.12",   # fcb31107a9515dda8b519e126c039c345ef7daf9
        AddLatexSymbols("\\guillemotleft" => "«",
                        "\\guillemotright" => "»")),

    # v1.10
    Patch(v"1.10.0-DEV.1204", # ad939df098a58f38c6a2dc9aec5976f098a5e5e5
        AddLatexSymbols("\\leftarrowless" => "⥷",
                        "\\leftarrowsubset" => "⥺")),
    Patch(v"1.10.0-DEV.570",  # a647575ff68ffec44ef7980545479915fcf3d62e
        AddLatexSymbols("\\veedot" => "⟇")),

    # v1.9
    Patch(v"1.9.0-DEV.346",   # 315a5ddb46628373b72e1b700d5bd8e35cd78df7
        RemoveLatexSymbols("\\sqspne" => "⋥"),
        AddLatexSymbols("\\sqsupsetneq" => "⋥")),
    Patch(v"1.9.0-DEV.332",   # 559244b383cf1a146f6c8e4ed81b1b746276abe0
        AddLatexSymbols("\\neq" => "≠"),
        AddSymbolsLatexCanonical("≠" => "\\ne")),

    # v1.7
    Patch(v"1.7.0-DEV.894",   # 4996445df37e526dac2772e333caf82f1ea987f0
        AddLatexSymbols("\\Top" => "⫪",
                        "\\Bot" => "⫫",
                        "\\indep" => "⫫",
                        "\\downvDash" => "⫪",
                        "\\upvDash" => "⫫"),
        AddSymbolsLatexCanonical("⫫" => "\\Bot",
                                 "⫪" => "\\Top")),
    Patch(v"1.7.0-DEV.893",   # b838cdfbb54515f8007a2958ebcdd58b76513db5
        AddLatexSymbols("\\nand" => "⊼",
                        "\\nor" => "⊽"),
        AddSymbolsLatexCanonical("⊼" => "\\nand",
                                 "⊽" => "\\nor")),
    Patch(v"1.7.0-DEV.849",   # 2fc32f2ea247c0c03ea78b229ff159af84c45fb1
        Load2fc32f2ea2())
])

# LATEST_PATCH_VERSION::VersionNumber
const LATEST_PATCH_VERSION = first(REPL_COMPLETIONS_PATCHES).version

# module EmojiSymbols
