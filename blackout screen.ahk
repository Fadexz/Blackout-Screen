#Requires AutoHotkey v2.0

screenBoundsLeft := SysGet(76) ; Get the left edge of the screen
screenBoundsTop := SysGet(77)  ; Get the top edge of the screen
screenBoundsWidth := SysGet(78) ; Get the width of the screen
screenBoundsHeight := SysGet(79) ; Get the height of the screen

global blackout := ""
global blackoutActive := false

F12:: {
    global blackoutActive
    global blackout

    if (blackoutActive) {
        blackout.Destroy()
        blackoutActive := false
        DllCall("ShowCursor", "Int", true)
    } else {
        activeWindow := WinActive("A")

        blackout := Gui("+AlwaysOnTop -Caption -DPIScale +ToolWindow")
        blackout.BackColor := "Black" ; Set the background color
        blackout.Show("x" screenBoundsLeft " y" screenBoundsTop " w" screenBoundsWidth " h" screenBoundsHeight)
        hwnd := blackout.Hwnd

        ; Click-through window
        ;exStyle := DllCall("GetWindowLong", "Ptr", hwnd, "Int", -20)
        ;DllCall("SetWindowLong", "Ptr", hwnd, "Int", -20, "Int", exStyle | 0x20 | 0x80000)
        ;DllCall("SetWindowPos", "Ptr", hwnd, "Ptr", -1, "Int", 0, "Int", 0, "Int", 0, "Int", 0, "UInt", 0x13)

        WinActivate("ahk_id " activeWindow)

        blackoutActive := true
        DllCall("ShowCursor", "Int", false)
    }
}
