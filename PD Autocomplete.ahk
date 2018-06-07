#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
;#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance, force

#Include ../Shared/scriptCommunication.ahk
#Include OnScreenDisplay.ahk
#Include ShellHook.ahk
#Include Gui.ahk
#Include hotkeyListening.ahk ;THIS SHOULD BE SHARED
#Include ObjectAbstraction.ahk ;THIS SHOULD BE SHARED
#Include objectsParser.ahk ;THIS SHOULD BE SHARED

;IniWrite, C:\Users\User\Dropbox\PureData\pd-0.47-1.msw\pd\extra, settings.ini, Folders, extrasFolder

ExitFunc(){
    Exit
}

parseVanillaObjects() ;run on initialization
parseExtras()
SetupSuggestionsWindow()

;Variables

userInput := ""

keyTyped(key){
    global userInput
    userInput := userInput . key
    showListeningForHotkey("PD Autocomplete:" . userInput)
    StringLeft, firstChar, userInput, 1
    ;TrayTip, , searching for %userInput%, 1000
    if(firstChar="."){
        withoutDot := SubStr(userInput, 2)
        searchForCompletionsMode2(   withoutDot   )
    } else if(firstChar=","){
        withoutComma := SubStr(userInput, 2)
        monolithicSearch( withoutComma )
    } else {
        searchForCompletions( userInput )
    }
}

searchForCompletions(whatToLookFor){
    ;global userInput
    global vanillaObjects
    Gui, ListeningWindow:Color, Black
    results := ""
    ;lastFoundObject := ""
    Loop, % vanillaObjects.Length()
    {
        Needle := whatToLookFor
        Haystack := vanillaObjects[A_Index].boxName
        IfInString, Haystack, %Needle%
        {
            ;MsgBox, The string %Needle% was found in %Haystack%.
            ;TrayTip, Found it!, The string %Needle% was found in %Haystack%, 3000
            results := results . "|" . Haystack
        }
    }
    If (results = ""){
        results := "|"
    }
    
    showListBox(results)
    ;TrayTip, searching for %userInput%, results: =`n %results%, 3000

}

showListBox( options ){
    ColorChoice :=
    global suggestionsHwnd
    GuiControl, , %suggestionsHwnd%, %options%
    GuiControl, Choose, %suggestionsHwnd%, 1
    WinGetPos, xVar, yVar, , , A ;A for acive window
    CoordMode, Mouse, Screen
    MouseGetPos, xVar, yVar
    xVar := xVar +30
    Gui, Suggestions:Show, x%xVar% y%yVar% NoActivate
    return
}


autoComplete(desiredText){
    Loop, % StrLen(desiredText)
    {
        c := SubStr(desiredText, A_Index , 1)
        ;MsgBox, % "c = " . c
        ;TrayTip, AutoComplete, %c%, 3000
        if ( c= "~" ){
            Send {ASC 126}
        } else if( c="+"){
            Send {ASC 43}
        } else {
            Send, %c%            
        }
        ;Send, %c%
    }
    ;Send, %prefix%        ;
    ;StringReplace, NewStr, OldStr, %A_SPACE%, +, All
    StringReplace, prefix, prefix, ~, ~~, All
    ;Send, %prefix%        
    ;Send, %userInput%     ;
    StringReplace, sufix, sufix, ~, ~~, All
    ;Send, %sufix%         ;
    StringRight, lastChar, sufix, 1
    if (lastChar = "~"){
        ;Sleep, 100
        ;Send, {~}
    }
    userInput := ""
    showListeningForHotkey("PD Autocomplete:" . userInput) ;keyTyped("")
    Gui, ListeningWindow:Color, Black
    stopListening()
}

#Include searchMode2.ahk
#Include monolithicSearchMode.ahk


TrayTip, PD AutoComplete, Loading done, 1000
; ===================================================END OF INITIALIZATION CODE===================
#Include hotkeys.ahk

;NOTHING UNDER HERE WILL RUN BECAUSE THE HOTKEYS HAVE BEGUN

#include subRoutines.ahk