
;ADAPTED FROM KeupressOSD.ahk which was
    
    ;----------------------------------------------------------
    ;               KeypressOSD v1.00
    ; Author    : tmplinshi
    ; Date      : 2013-10-11
    ; Tested on : Windows XP SP3 / AutoHotkey v1.1.13.00
    ; Thanks    : HotShow.ahk by RaptorX (http://www.autohotkey.com/board/topic/51641-hotshow-10-osd-hotkeys-for-video-tutorials/)
    ;----------------------------------------------------------

; #################################
;       Settings
; #################################
;
transN := 200

; #################################
;       Create GUI
; #################################
;
Gui, ListeningWindow:New, +AlwaysOnTop -Caption +Owner +LastFound +E0x20, ListeningWindowTitle
Gui, ListeningWindow:Margin, 0, 0
Gui, ListeningWindow:Color, Black
Gui, ListeningWindow:Font, cWhite s17 bold, Arial
Gui, ListeningWindow:Add, Text, vHotkeyText Center y7 ;y7 is the position of the text on the rectangle
;Gui, ListeningWindow:Show, x500 y500 h100 w100
WinSet, Transparent, %transN% ;only works because of +LastFound

ShowListeningForHotkey(Hotkey)
{
    GuiControl, ListeningWindow: , HotkeyText, %Hotkey%
 
    ;WinActivate, ahk_exe wish85.exe
    ;TrayTip, ehueh, currentActiveWindow = %currentActiveWindow%, 1000
    WinGetPos, ActWin_X, ActWin_Y, ActWin_W, ActWin_H, ahk_exe %currentActiveWindow%
    if !ActWin_W
        Return "Error"
 
    text_w := ActWin_W
    gui_y := (ActWin_Y+ActWin_H) - 40 -5
    ;gui_y := 0
    GuiControl, ListeningWindow:Move, HotkeyText, w%text_w% Center
 
    Gui, ListeningWindow:Show, NoActivate x%ActWin_X% y%gui_y% h40 w%text_w%
    ;Gui, ListeningWindow:Show, x300 y300 h400 w%text_w%
}