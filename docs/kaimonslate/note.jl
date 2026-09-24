try; import KaimonSlate; catch; error("This is a Kaimon Slate notebook — running it as plain Julia needs the KaimonSlate runtime in this environment. Add it with `import Pkg; Pkg.add(\"KaimonSlate\")`, or open it in Kaimon Slate."); end; KaimonSlate.standalone!(@__MODULE__; dir=@__DIR__)

#%% md id=intro
@md"""
# KaimonSlate Note
<https://github.com/kahliburke/KaimonSlate.jl>
"""

#%% code id=a91bbc
using Pkg
Pkg.status("EmojiSymbols")

#%% code id=ab784d
using EmojiSymbols

#%% code id=8b3aa3
# \hookunderrightarrow <tab>
# 🢲
'🢲'

# ╔═╡ Slate.config · per-notebook settings (Settings panel)
#   docid = a55773c2-e124-45d6-b8b6-8d8a5dde3b82
# ╚═╡
