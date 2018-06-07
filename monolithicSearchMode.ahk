monolithicSearch( whatToLookFor){
    global monolithicObjects
    Gui, ListeningWindow:Color, Purple
    results := ""
    Loop, % monolithicObjects.Length()
    {
        Needle := whatToLookFor
        Haystack := monolithicObjects[A_Index].boxName
        ;found := findStringMode2InObjectName( whatToLookFor, Haystack)
        t := InStr(Haystack, Needle)
        if ( StrLen(whatToLookFor)>1 ){
            ;MsgBox, % "t = " . t . "`nNeedle = " . Needle . "`nHaystack = " . haystack
        }
        if ( t>0  ){
            results := results . "|" . monolithicObjects[A_Index].library . "/" . Haystack
        }
    }
    ;TrayTip, heh,  % "results = `n" . results, 1
    showListBox(results)
}

autoCompleteMonolithic(desiredText){
    slashIndex := InStr(desiredText, "/" )
    libName := SubStr(desiredText, 1, slashIndex-1)
    objName := SubStr(desiredText, slashIndex+1)
    Loop, % StrLen(objName)
    {
        c := SubStr(objName, A_Index , 1)
        ;MsgBox, % "c = " . c
        ;TrayTip, AutoComplete, %c%, 3000
        if ( c= "~" ){
            Send {ASC 126}
        } else {
            Send, %c%            
        }
        ;Send, %c%
    }
    TrayTip, PD Autocomplete, Object: [%objName%]`nLibrary: %libName%, 5
    userInput := ""
    showListeningForHotkey("PD Autocomplete:" . userInput) ;keyTyped("")
    Gui, ListeningWindow:Color, Black
}