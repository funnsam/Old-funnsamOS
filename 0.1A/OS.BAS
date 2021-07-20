Loading:
Print "Loading Screen..."
_FullScreen _Stretch
_MouseHide
_Title "funnsam OS Alpha 0.0.1"
_Delay .5
CheckSize
$Resize:On

Print "Loading Images and Sounds..."
logo& = _LoadImage("LOGO.BMP")
cursor& = _LoadImage("CUR.PNG")
shutdown& = _LoadImage("Exit.bmp")
explorer& = _LoadImage("explorer.bmp")
home& = _LoadImage("home.bmp")
music& = _LoadImage("music.bmp")
musicstop& = _LoadImage("musicstop.bmp")

Color _RGB32(255), _RGB32(127)
warn1& = _LoadImage("Warnings\Startup\L1.bmp")
warnY& = _LoadImage("Warnings\Startup\Y.bmp")
warnN& = _LoadImage("Warnings\Startup\N.bmp")

sel& = _SndOpen("select.wav")
If sel& = 0 Then Error 100

_Icon logo&

Print "Welcome!"
_Delay 1.5

Do
    _Limit 15
    Cls

    _PutImage (1, 1), warn1&
    _PutImage (1, 21), warnN&
    _PutImage (1, 41), warnY&
    _PutImage (_MouseX, _MouseY), cursor&
    Do While _MouseInput
        If _MouseY >= 21 Then
            If _MouseY <= 39 Then
                If _MouseButton(1) Then
                    System
                End If
            End If
        End If
        If _MouseY >= 41 Then
            If _MouseY <= 59 Then
                If _MouseButton(1) Then
                    _FreeImage warn1&
                    _FreeImage warnY&
                    _FreeImage warnN&
                    GoTo Home
                End If
            End If
        End If
    Loop
    
Loop

2 Print "Starting System..."

On Error GoTo ErrHandler

Home:
rootpath$ = Environ$("SYSTEMROOT")
fontfile$ = rootpath$ + "\Fonts\Arial.ttf"
font& = _LoadFont(fontfile$, 18)
_Font font&

Color _RGB32(127, 255, 127), _RGB32(127)
Do
    _Limit 15
    Cls , _RGB32(127)

    Line (0, 0)-(1366, 20), _RGB32(127, 255, 127), BF
    _PutImage (1, 1), logo&
    If MPMusic& = 0 Then Else _PutImage (21, 1), musicstop&
    _PutImage (_MouseX, _MouseY), cursor&

    Do While _MouseInput
        If _MouseX >= 1 Then
            If _MouseX <= 19 Then
                If _MouseY >= 1 Then
                    If _MouseY <= 19 Then
                        If _MouseButton(1) Then
                            GoTo SScreen
                        End If
                    End If
                End If
            End If
        End If
        If _MouseX >= 21 Then
            If _MouseX <= 39 Then
                If _MouseY >= 1 Then
                    If _MouseY <= 19 Then
                        If _MouseButton(1) Then
                            _SndStop MPMusic&
                            _SndClose MPMusic&
                            MPMusic& = 0
                        End If
                    End If
                End If
            End If
        End If

    Loop

    
Loop

ErrHandler:
Color _RGB32(255), _RGB32(16, 16, 255)
Cls
Print "============================FUNNSAM OS ERROR HANDLER============================"
Print "Debug Infomation: Error"; Err; "Found in Line"; _ErrorLine; "!"
Print "Error Number can be Found in http://www.qb64.org/wiki/ERROR_Codes."
Beep
Input "Press Enter Key to Exit.", temp
System

SScreen:
Do
    _Limit 15
    Cls , _RGB32(127, 255, 127)

    _PutImage (1, 1), home&
    _PutImage (21, 1), shutdown&
    _PutImage (41, 1), explorer&
    _PutImage (61, 1), music&
    _PutImage (_MouseX, _MouseY), cursor&

    scncode% = Inp(&H60)

    Do While _MouseInput
        If _MouseX >= 1 Then
            If _MouseX <= 19 Then
                If _MouseY >= 1 Then
                    If _MouseY <= 19 Then
                        If _MouseButton(1) Then
                            GoTo Home
                        End If
                    End If
                End If
            End If
        End If
        If _MouseX >= 21 Then
            If _MouseX <= 39 Then
                If _MouseY >= 1 Then
                    If _MouseY <= 19 Then
                        If _MouseButton(1) Then
                            _SndPlay sel&
                            ShutAsk
                        End If
                    End If
                End If
            End If
        End If
        If _MouseX >= 41 Then
            If _MouseX <= 59 Then
                If _MouseY >= 1 Then
                    If _MouseY <= 19 Then
                        If _MouseButton(1) Then
                            _SndPlay sel&
                            Shell "cmd /c explorer"
                        End If
                    End If
                End If
            End If
        End If
        If _MouseX >= 61 Then
            If _MouseX <= 79 Then
                If _MouseY >= 1 Then
                    If _MouseY <= 19 Then
                        If _MouseButton(1) Then
                            GoTo MPlayer1
                        End If
                    End If
                End If
            End If
        End If

    Loop


    
Loop Until scancode% = 1
GoTo Home

MPlayer1:
_SndStop MPMusic&
_SndClose MPMusic&
Cls
Input "File Path + Name"; MPPath$
Print "Loading..."
MPMusic& = _SndOpen(MPPath$)
If MPMusic& = 0 Then Beep Else _SndPlay MPMusic&
GoTo Home


Sub ShutdownAct
    Print "Shutting down funnsam OS..."
    System
End Sub

Sub ShutAsk
    Input "Did you wanted to exit funnsam OS (1/0)?", Shutdown
    If Shutdown = 1 Then
        ShutdownAct
    End If
End Sub

Sub CheckSize
    CurrentScreen = _NEWIMAGE(_RESIZEWIDTH, _RESIZEHEIGHT, 32)
    SCREEN CurrentScreen
End FUNCTION