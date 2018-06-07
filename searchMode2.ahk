;this searches for the characters, in order, any place in the string. 
;For ex:
;input: abc
;would match
;[a]braham [b]eatrice [c]arl
searchForCompletionsMode2( whatToLookFor){
    ;global userInput
    global vanillaObjects
    Gui, ListeningWindow:Color, Green
    ;whatToLookFor := userInput
    results := ""
    ;lastFoundObject := ""
    ;listOfObjects := getListOfObjects()
    results := ""
    Loop, % vanillaObjects.Length()
    {
        Needle := whatToLookFor
        Haystack := vanillaObjects[A_Index].boxName
        found := findStringMode2InObjectName( whatToLookFor, Haystack)
        if (found=true){
            results := results . "|" . Haystack
        }
    }
    ;TrayTip, heh,  % "results = `n" . results, 1
    showListBox(results)
}

findStringMode2InObjectName( whatToLookFor, objName){
    inputLen := StrLen(whatToLookFor)
    subStrToLook := objName
    Loop, % inputLen
    {
            char1Index := A_Index
            StringMid, char1, whatToLookFor, A_Index, 1
            i := InStr(subStrToLook, char1)
            if(i>0){
                ;newsubStrToLook := SubStr(subStrToLook, i+1)
                ;MsgBox, % "found " . char1 . " in " . i . "-pos of " . subStrToLook . "`nnew sub str " . newsubStrToLook
                subStrToLook := SubStr(subStrToLook, i+1)
            } else {
                ;MsgBox, % "DIDN'T found " . char1 . " in " subStrToLook
                return false ;no match!
            }
    }
    return true
}

;ex: findAfterChar( a, 5 )
;would match
;    1234a
;but not
;    12a45
findAfterCharNumber( whatToFind, afterWichCharNumber, listOfObjects ){
    global vanillaObjects


}

;gets a list of all the vanilla objects
getListOfObjects(){
    global vanillaObjects
    results := ""
    Loop, % vanillaObjects.Length()
    {
        results := results . vanillaObjects[A_Index].boxName . "|"
    }
    ;MsgBox, % results
    return results
}