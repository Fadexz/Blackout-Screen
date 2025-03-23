#Requires AutoHotkey v2.0

screenBoundsLeft := SysGet(76)
screenBoundsTop := SysGet(77)
screenBoundsWidth := SysGet(78)
screenBoundsHeight := SysGet(79)

global blackout := ""
global blackoutActive := false

F12:: {
    global blackoutActive
    global blackout

    if (blackoutActive) {
        blackout.Destroy()
        blackoutActive := false
        ; Show the cursor when blackout is deactivated
        DllCall("ShowCursor", "Int", true)
    } else {
        blackout := Gui("+AlwaysOnTop -Caption -DPIScale +ToolWindow")
        blackout.BackColor := "Black"
        blackout.Show("x" screenBoundsLeft " y" screenBoundsTop " w" screenBoundsWidth " h" screenBoundsHeight)
        blackoutActive := true
        ; Hide the cursor when blackout is activated
        DllCall("ShowCursor", "Int", false)
    }
}
