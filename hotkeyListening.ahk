listeningToHotkeys := false

stopListening(){
        global listeningToHotkeys
        global userInput
        Gui, ListeningWindow:Color, Black
        listeningToHotkeys := false
        Gui, ListeningWindow:Hide
        userInput := ""
        Gui, Suggestions:Hide
}

startListening(){
    global listeningToHotkeys
    showListeningForHotkey("PD Autocomplete:")
    listeningToHotkeys := true
}