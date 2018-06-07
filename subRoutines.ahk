exitRoutine:
    ExitApp
return

reloadRoutine:
    SoundPlay, Sounds\Cabassa4.wav
    Sleep, 500
    Reload
    MsgBox, 4,, The PD Autocomplete script could not be reloaded.
return