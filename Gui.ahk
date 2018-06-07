;w400 is normal font wieght
;w600 or w700 is bold

#Include OnScreenDisplay.ahk
Menu, Tray, Icon, .\Icons\Icon1.ico, 1, 1

Menu, Tray, NoStandard
Menu, Tray, Add, Help, ShowHelpWindow
Menu,Tray, Add, reload, reloadRoutine
Menu, Tray, Add, Exit, exitRoutine
Menu,Tray, Default, Help

;USED FOR THE SUGGESTION WINDOW

suggestionsHwnd :=

;create the help window!

Gui, Help:New
Gui, Help:font, c000000, Arial
;title
Gui, Help:Font, S14 CDefault, Verdana
Gui, Help:Add, Text, , PD AutoComplete - Help
;press apostrophe
Gui, Help:Font, S10 w600 CDefault, Verdana
Gui, Help:Add, Text, , Press ' (apostrophe) to make PD AutoComplete listen to the hotkeys below`nall hotkeys only works when a pd window is active
;main description
Gui, Help:Font, S8 w400 CDefault, Verdana
Gui, Help:Add, Text, , While PD AutoComplete is listening for hotkeys you can just type the name of the object you want. It will immediately look for it and display a list of matches. `nWhat you type will appear in the app's bar. You can use the up/down arrow and PgUp/PgDown to navigate. 
Gui, Help:Add, Text, , After finding the desired object press Enter and PD AutoComplete will type it for you!
Gui, Help:Add, Text, , How does it works? There is a 'Vanilla Objects.txt' file that it uses to know what are the pd's vanilla objects. It also scans automatically your externals located in the folders you've set into the pd window
Gui, Help:Font, S8 w600 CDefault, Verdana
Gui, Help:Add, Text, , "edit->preferences->path"
Gui, Help:Font, S8 w400 CDefault, Verdana

;press Options
Gui, Help:Font, S10 w600 CDefault, Verdana
Gui, Help:Add, Text, , Options
;options description
Gui, Help:Font, S8 w600 CDefault, Verdana
Gui, Help:Add, Text, , Search modes: exact and skipping
Gui, Help:Font, S8 w400 CDefault, Verdana
Gui, Help:Add, Text, , The normal search operation looks for exact occurrences of what you type. Ex: if you're looking for [zexy/polyfun] you could type 'poly' or 'polyfun'
Gui, Help:Add, Text, , There is a special operation that looks for the occurentes of the chars you type allowing for 'skips'`nFor example if instead of typing 'polyfun' you type '.plf' (notice the period before plf!). The app bar will turn green. You might see the results
Gui, Help:Add, Text, , zexy/polyfun`nmrpeach/life2x
Gui, Help:Add, Text, , because it found the characters p, l and f in that order
Gui, Help:Add, Text, , zexy/[p]o[l]y[f]un`nmr[p]each/[l]i[f]e2x
Gui, Help:Font, S8 w600 CDefault, Verdana
Gui, Help:Add, Text, , Searching monolithic libs
Gui, Help:Font, S8 w400 CDefault, Verdana
Gui, Help:Add, Text, , Some libraries like zexy have a file that contains a group of externals. If you're on windows and using zexy for example it will be "zexy.dll"`nThere are two particularities on this case
Gui, Help:Add, Text, , 1) You can't use a forward declaration to create those objects. For example, you can NOT create a [zexy/demux] object`nfor that you must use [declare -lib zexy] and then type just [demux]`n2) PD AutoComplete can not guess what abstractions are located inside that files.
Gui, Help:Add, Text, , For that reason there is a "monolithicLibs.txt" where you can write the objects that are contained inside the monolithic libs.
Gui, Help:Add, Text, , Those are separated in the standard search because of their unique declaration (you must use [declare]) so in order to search them you`nmust use an "," before the search words. For example if you want to type [demux] search for:
Gui, Help:Add, Text, , ",demux"
Gui, Help:Add, Text, , The app bar will turn purple to indicate you're searching monolithic abstraction. After pressing enter it will ignore the "zexy/" from [zexy/demux] and type just [demux].
;created by
Gui, Help:Font, S10 w600 CDefault, Verdana
Gui, Help:Add, Text, ,Created by Henri Augusto


; ===SUGESTION WINDOW===
SetupSuggestionsWindow(){
    global suggestionsHwnd
    global SUggestionChoice
    Gui, Suggestions:New , +Delimiter -Caption +ToolWindow +AlwaysOnTop +LastFound, SuggestionsWindow
    Gui, Suggestions:Margin, 0, 0
    ;Gui, Suggestions:New, +Delimiter -Caption +ToolWindow +LastFound, SuggestionsWindow'
    Gui, Suggestions:Add, ListBox, w200 h350 vSuggestionChoice gAutoComplete HwndSuggestionsBox Choose1 AltSubmit, Red|Green|Blue|Black|White|Teal|Magenta|Purple|Violet|Orange|Gray
    suggestionsHwnd := SuggestionsBox
    ;find first ID
    
    ;<dbg>WinGet, ActiveWindowId, Id, A
    ;<dbg>MsgBox, % "active window id" . ActiveWindowId
    

    DetectHiddenWindows, On

    ;THIS IS OF UTMOST IMPORTANCE BECAUSE IT IS THE ONLY WAY TO 
    ;ACTIVATE THE LISTBOX COMPONENT SO SET WIN TITLE WORKS ON THE RIGHT WINDOW
    Gui, Suggestions:show , x40 y50, ListBox 
    ;Gui, Suggestions:show , x40 y50 ;this would not work
    WinSetTitle, ListBox, , "SuggestionsWindowListBox" ;Gui, New fails to set window name

    ;without this line, the MsgBoxs with the dbg prefix would show the same id
    ;with it you can see they're different. So you're activating the inner component

    ;TRY A WORKAROUND (LAST POST)
    ;https://autohotkey.com/board/topic/55795-how-to-get-the-controlid-of-gui-control-just-created/

    ;find second ID
    ;WinGet, ActiveWindowId, Id, A
    ;MsgBox, % "active window id" . ActiveWindowId
    
    Gui, Suggestions:Hide
    ;MsgBox, % suggestionsHwnd
    ;TrayTip, suggestionsHwnd, %suggestionsHwnd%, 3000
}


ShowHelpWindow(){
    global
    Gui, Help:Show
}

getNumberOfSuggestions(){
    DetectHiddenWindows, on
    SetTitleMatchMode, 2
    ;https://autohotkey.com/board/topic/67521-listbox-count/
    ControlGet, outputVar, List,  ,ListBox1, "SuggestionsWindowListBox"

    b_index := 666
    loop, parse, outputVar, `n, `r
    {
        b_index:=a_index
    }
    return b_index
}