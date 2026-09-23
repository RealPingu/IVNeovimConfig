#Requires AutoHotkey v2.0                                                                                                                                                            
#SingleInstance Force                                                                                                                                                                
Persistent                                                                                                                                                                           
                                                                                                                                                                                     
lastHwnd := 0                                                                                                                                                                        
SetTimer CheckActiveWindow, 200                                                                                                                                                      
                                                                                                                                                                                     
CheckActiveWindow() {                                                                                                                                                                
    global lastHwnd                                                                                                                                                                  
    try {                                                                                                                                                                            
        ; 1. SAFETY: If holding Alt (Alt-Tabbing), do nothing                                                                                                                        
        if GetKeyState("Alt", "P")                                                                                                                                                   
            return                                                                                                                                                                   
                                                                                                                                                                                     
        ; 2. SAFETY: If mouse is interacting with the taskbar or tray, do nothing!                                                                                                   
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
                                                                                                                                                                                     
        ; Check if active window is Windows Terminal                                                                                                                                 
        if (WinGetProcessName(activeHwnd) = "WindowsTerminal.exe") {                                                                                                                 
            CleanSameMonitor(activeHwnd)                                                                                                                                             
        }                                                                                                                                                                            
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

        ; Skip invisible (WS_VISIBLE = 0x10000000) or already minimized
        if !(style & 0x10000000) || (style & 0x20000000)
            continue

        ; 3. SAFETY: Skip all tool windows, flyouts, popups, and tray menus (WS_EX_TOOLWINDOW = 0x80)
        if (exStyle & 0x00000080)
            continue

        title := WinGetTitle(thisHwnd)
        class := WinGetClass(thisHwnd)
        proc  := WinGetProcessName(thisHwnd)

        ; 4. SAFETY: Never touch Windows Explorer shell elements (taskbar, tray, start menu)
        ; (Only allow actual File Explorer folders: CabinetWClass)
        if (proc == "explorer.exe" && class != "CabinetWClass")
            continue

        ; Check monitor of background window
        hMonWindow := DllCall("user32\MonitorFromWindow", "Ptr", thisHwnd, "UInt", 2, "Ptr")

        ; Only minimize normal applications on the exact same monitor
        if (hMonWindow == hMonTerminal) {
            WinMinimize(thisHwnd)
        }
    }
}
