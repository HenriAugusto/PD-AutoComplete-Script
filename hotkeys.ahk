;!   Alt
;^   Control
;+   Shift

global currentActiveWindow :=

;#IfWinActive, ahk_exe wish85.exe
#If ( ( WinActive( "ahk_exe wish85.exe") || WinActive( "ahk_exe nw.exe")) && !listeningToHotkeys )
;#If
{
    '::      ;old apostrophe
    ;^Space::
        currentActiveWindow :=
        ;if a pd window is active
        if ( WinActive( "ahk_exe wish85.exe") ) {
            currentActiveWindow := "wish85.exe"
        ;if a nw.exe window is active
        } else if ( WinActive( "ahk_exe nw.exe")) {
            ;if exists a purr-data window
            if (WinExist("purr-data") ){
                currentActiveWindow := "nw.exe" ;it is very likely that this nw.exe is purr-data
            } else {
                ;there is another window with ahk_exe nw.exe that is not purr-data
                return
            }
        }
        receiveApostrophe()
    return
}

#If listeningToHotkeys
{
    esc::
        stopListening()
    return
}

#If

f8::
    Sleep, 500
    Reload
;MsgBox, 4,, The script could not be reloaded. Would you like to open it for editing?
;IfMsgBox, Yes, Edit
return

+f12::
    ExitApp
return


#If, ((WinActive("ahk_exe wish85.exe") || (WinActive("ahk_exe nw.exe"))) and ((listeningToHotkeys)))
{
    ;While we are active listen for what the user is typing so we can search the abstractions
    a::
    b::
    c::
    d::
    e::
    f::
    g::
    h::
    i::
    j::
    k::
    l::
    m::
    n::
    o::
    p::
    q::
    r::
    s::
    t::
    u::
    v::
    w::
    x::
    y::
    z::
    0::
    1::
    2::
    3::
    4::
    5::
    6::
    7::
    8::
    9::
    .:: ;scpecial case for mode2
    ,:: ;scpecial case for monolithic mode
    _::
    >::
    <::
    =::
    +::
    -::
    *::
    /::
    ~::
        keyTyped(A_ThisHotkey)
    return
    
    ;this is the "/"" key
    ;i don't know why it's not grabbing it, but this forces so
    SC073::
        keyTyped( "/" )
    return

    ;delete a char
    BackSpace::
        userInput := SubStr(userInput, 1 , StrLen(userInput)-1)
        keyTyped("")
    return

    ;clear search word
    +BackSpace::
        userInput := ""
        keyTyped("")
    return

    ;recentes the listBox
    Tab::keyTyped("") ;recenters the listBox

    Enter::
        ;Gui, Suggestions:Submit
        ;MsgBox, % "selected = " . selected
        ;MsgBox, % "SuggestionChoice = " . SuggestionChoice
        GuiControlGet, selected, , %suggestionsHwnd%
        ;see
        ;/https://autohotkey.com/board/topic/1902-getting-the-text-of-all-items-in-a-listbox/?p=11726
        ControlGet, outputVar, List,  ,ListBox1, "SuggestionsWindowListBox"
        Loop, Parse, outputVar, `n
        {
            if( A_Index = selected ){
                ;MsgBox Item number %A_Index% is %A_LoopField%.
                if (  SubStr(userInput, 1, 1) = ","  ){
                        autoCompleteMonolithic(A_LoopField)
                    } else {
                        autoComplete(A_LoopField)
                }
            }
        }
        userInput := ""
        Gui, Suggestions:Hide
        ;stopListening()
    return


    ;+f1:: MsgBox, 0, , Working dir = %A_WorkingDir% `n mode = %mode%
    ;tinha um return aqui

    f1::Gui, Help:Show










} ;end if win active <==LOOK HERE

;#IfWinActive, ahk_exe wish85.exe
#If, ((WinActive("ahk_exe wish85.exe") || (WinActive("ahk_exe nw.exe"))) and ((listeningToHotkeys)))
{

    ~Up::
        GuiControlGet, suggestionIndex , , %suggestionsHwnd%
        target := suggestionIndex-1
        if (target=0){
            target := getNumberOfSuggestions()
        }
        GuiControl, Choose, %suggestionsHwnd%, % target
        TrayTip, , suggestionIndex = %target%, 3000

    return

    ~Down::
        GuiControlGet, suggestionIndex , , %suggestionsHwnd%
        target := suggestionIndex+1
        if (target=getNumberOfSuggestions()+1){
            target := 1
        }
        GuiControl, Choose, %suggestionsHwnd%, % target
        TrayTip, , suggestionIndex = %target%, 3000

    return

    PgDn::
        GuiControlGet, suggestionIndex , , %suggestionsHwnd%
        target := Mod(suggestionIndex+5, getNumberOfSuggestions())
            target += 1 ;no zero
        GuiControl, Choose, %suggestionsHwnd%, % target
        TrayTip, , suggestionIndex = %target%, 3000
    return

    PgUp::
        GuiControlGet, suggestionIndex , , %suggestionsHwnd%
        target := suggestionIndex-5
        While, target < 0
        {
            target += getNumberOfSuggestions()
        }
            target += 1 ;no zero
        GuiControl, Choose, %suggestionsHwnd%, % target
        TrayTip, , suggestionIndex = %target%, 3000
    return

}