;https://autohotkey.com/board/topic/66726-method-to-detect-active-window-change/

;Gui +LastFound 
hWnd := WinExist()
DllCall( "RegisterShellHookWindow", UInt,Hwnd )
MsgNum := DllCall( "RegisterWindowMessage", Str,"SHELLHOOK" )
OnMessage( MsgNum, "ShellMessage" )
;Return

ShellMessage( wParam,lParam )
{
    global listeningToHotkeys
    WinGetTitle, title, ahk_id %lParam%
    ;If (wParam=4) { ;HSHELL_WINDOWACTIVATED
    ;ToolTip WinActivated`n%Title%, 500, 500
    ;sleep 1000
    ;ToolTip 
    ;listeningToHotkeys := false
    ;MsgBox, % "bool = " . bool
    If( WinActive("ahk_exe wish85.exe") = false && WinActive("ahk_exe AutoHotkey.exe") = false )
    {  
        WinGetTitle, haha , A
        ;MsgBox, % haha
        stopListening()
    }
    ;}
}