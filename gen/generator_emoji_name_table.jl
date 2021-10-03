include("generator_utils.jl")

emoji_data       = get_emoji_data()
emoji_name_table = reverse(emoji_data)

write_dict_to_file("emoji_name_table.jl", "emoji_name_table", emoji_name_table)
