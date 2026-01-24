module test_pkgs_glyphy_glyphy

using Test
using Glyphy

result = glyphy("smile"; output=:array)
@test result[end, :][2] == '😼'

result = glyphy("beans"; output=:array)
@test result[end, :][2] == '🫘'

end # module test_pkgs_glyphy_glyphy
