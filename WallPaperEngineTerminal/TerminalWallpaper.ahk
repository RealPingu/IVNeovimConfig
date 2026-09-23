#Requires AutoHotkey v2.0
#SingleInstance Force
Persistent

lastHwnd := 0
isCleaning := false
SetTimer CheckActiveWindow, 200

CheckActiveWindow() {
    global lastHwnd, isCleaning

    ; Evitar reentrancia o ejecuciones concurrentes
    if (isCleaning)
        return

    try {
        ; 1. SEGURIDAD: Si está usando Alt-Tab, no hacer nada
        if GetKeyState("Alt", "P")
            return

        ; 2. SEGURIDAD: Si el mouse interactúa con la barra de tareas o la bandeja del sistema
        MouseGetPos ,, &mouseHwnd
        if (mouseHwnd) {
            mouseClass := WinGetClass(mouseHwnd)
            if (mouseClass == "Shell_TrayWnd"
                || mouseClass == "Shell_SecondaryTrayWnd"
                || InStr(mouseClass, "Overflow")
                || InStr(mouseClass, "XamlIsland"))
                return
        }

        activeHwnd := WinActive("A")
        if (!activeHwnd || activeHwnd == lastHwnd)
            return

        lastHwnd := activeHwnd

        ; Solo actuar si la ventana activa es Windows Terminal
        if (WinGetProcessName(activeHwnd) = "WindowsTerminal.exe") {
            isCleaning := true
            CleanSameMonitor(activeHwnd)
            isCleaning := false
        }
    } catch {
        isCleaning := false
    }
}

CleanSameMonitor(termHwnd) {
    if GetKeyState("Alt", "P")
        return

    hMonTerminal := DllCall("user32\MonitorFromWindow", "Ptr", termHwnd, "UInt", 2, "Ptr")
    if (!hMonTerminal)
        return

    for thisHwnd in WinGetList() {
        if (thisHwnd == termHwnd)
            continue

        style := WinGetStyle(thisHwnd)
        exStyle := WinGetExStyle(thisHwnd)

        ; Omitir ventanas invisibles (WS_VISIBLE = 0x10000000) o ya minimizadas (WS_MINIMIZE = 0x20000000)
        if !(style & 0x10000000) || (style & 0x20000000)
            continue

        ; 3. SEGURIDAD: Omitir ventanas de herramientas, flyouts, popups (WS_EX_TOOLWINDOW = 0x80)
        if (exStyle & 0x00000080)
            continue

        title := WinGetTitle(thisHwnd)
        class := WinGetClass(thisHwnd)
        proc  := WinGetProcessName(thisHwnd)

        ; 4. SEGURIDAD: No tocar elementos del sistema Windows Explorer
        if (proc == "explorer.exe" && class != "CabinetWClass")
            continue

        ; Comprobar si está en el mismo monitor que la terminal
        hMonWindow := DllCall("user32\MonitorFromWindow", "Ptr", thisHwnd, "UInt", 2, "Ptr")

        if (hMonWindow == hMonTerminal) {
            ; SW_SHOWMINNOACTIVE = 7
            ; Minimiza la ventana SIN activar otra ni robar/cambiar el foco de Windows Terminal.
            ; Esto previene los rebotes de foco que provocan el autoscroll indeseado en la terminal.
            DllCall("user32\ShowWindow", "Ptr", thisHwnd, "Int", 7)
        }
    }

    ; Asegurar que Windows Terminal retiene el foco activo firmemente
    if (WinExist("ahk_id " termHwnd) && WinActive("A") != termHwnd) {
        WinActivate("ahk_id " termHwnd)
    }
}
