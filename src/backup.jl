# module EmojiSymbols

BackupREPLCompletions = Tuple{Dict{String, String}, Dict{String, String}, Dict{String, String}}

function backup_REPLCompletions()::BackupREPLCompletions
    R = Base.REPL_MODULE_REF[]
    emoji_symbols = copy(R.REPLCompletions.emoji_symbols)
    latex_symbols = copy(R.REPLCompletions.latex_symbols)
    if isdefined(R.REPLCompletions, :symbols_latex_canonical)
        symbols_latex_canonical = copy(R.REPLCompletions.symbols_latex_canonical)
    else
        symbols_latex_canonical = Dict{String, String}()
    end
    BackupREPLCompletions((emoji_symbols, latex_symbols, symbols_latex_canonical))
end

function rollback_REPLCompletions(backup::BackupREPLCompletions)
    R = Base.REPL_MODULE_REF[]
    (emoji_symbols, latex_symbols, symbols_latex_canonical) = backup
    copy!(R.REPLCompletions.emoji_symbols, emoji_symbols)
    copy!(R.REPLCompletions.latex_symbols, latex_symbols)
    if isdefined(R.REPLCompletions, :symbols_latex_canonical)
        copy!(R.REPLCompletions.symbols_latex_canonical, symbols_latex_canonical)
    end
end

# module EmojiSymbols
