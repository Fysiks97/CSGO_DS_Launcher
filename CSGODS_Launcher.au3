#region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=41821-steam-steam-logo.ico
#AutoIt3Wrapper_Outfile=CSGO_DS_Launcher.exe
#AutoIt3Wrapper_Outfile_x64=CSGO_DS_Launcher-x64.exe
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseUpx=n
#AutoIt3Wrapper_Res_Fileversion=1.2.0.0
#AutoIt3Wrapper_Res_LegalCopyright=broodplank.net 2013
#AutoIt3Wrapper_Run_Tidy=y
#AutoIt3Wrapper_Run_Obfuscator=y
#endregion ;**** Directives created by AutoIt3Wrapper_GUI ****
;~ #NoTrayIcon#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
;Includes

#include <Process.au3>
#include <File.au3>
#include <WindowsConstants.au3>
#include <GuiConstantsEx.au3>
#include <ButtonConstants.au3>
#include <WinAPI.au3>
#include <EditConstants.au3>
#include <ComboConstants.au3>
#include <Constants.au3>
#include <Inet.au3>

; COPYRIGHT 2013 broodplank.net
; This work is licensed under a Creative Commons Attribution-NonCommercial-NoDerivs 3.0 Unported License

If Not FileExists(@ScriptDir & "\steamcmd.exe") Then FileInstall("D:\csgo-ds\steamcmd.exe", @ScriptDir & "\steamcmd.exe")

$GUI = GUICreate("CS:GO DS Launcher v1.2 - by broodplank", 250, 575, -1, -1, $WS_SIZEBOX);-1, $WS_EX_TOOLWINDOW)
GUISetBkColor(0x4C5844, $GUI)

GUICtrlCreateGroup("SteamCMD", 5, 5, 240, 103)
GUICtrlSetBkColor(-1, 0xffffff)
GUICtrlCreateLabel("Username:", 15, 25)
GUICtrlSetColor(-1, 0xffffff)
$username = GUICtrlCreateInput("csgodsaccount1338", 85, 23, 155, 20)
GUICtrlCreateLabel("Password:", 15, 55)
GUICtrlSetColor(-1, 0xffffff)
$password = GUICtrlCreateInput("broodplank.net", 85, 53, 155, 20)
GUICtrlCreateLabel("Dest. dir:", 15, 85)
GUICtrlSetColor(-1, 0xffffff)
$tardir = GUICtrlCreateInput(".\cs_go\", 85, 82, 155, 20)
GUICtrlSetState($tardir, $GUI_DISABLE)
GUICtrlCreateGroup("SRCDS", 5, 115, 240, 350)
GUICtrlSetBkColor(-1, 0xffffff)
GUICtrlCreateLabel("Game Mode:", 15, 135)
GUICtrlSetColor(-1, 0xffffff)
$gamemode = GUICtrlCreateCombo("Classic Casual", 85, 132, 155, 20, $CBS_DROPDOWNLIST)
GUICtrlSetData($gamemode, "Classic Competitive|Arms Race|Demolition|Deathmatch", "Classic Casual")
GUICtrlCreateLabel("Map Group:", 15, 165)
GUICtrlSetColor(-1, 0xffffff)
$mapgroup = GUICtrlCreateCombo("mg_bomb", 85, 162, 155, 20, $CBS_DROPDOWNLIST)
GUICtrlSetData($mapgroup, "mg_bomb_se|mg_armsrace|mg_demolition|mg_allclassic", "mg_bomb")
GUICtrlCreateLabel("Map:", 15, 195)
GUICtrlSetColor(-1, 0xffffff)
$map = GUICtrlCreateInput("de_dust", 85, 192, 155, 20)
GUICtrlCreateLabel("Max Players:", 15, 225)
GUICtrlSetColor(-1, 0xffffff)
$maxplayers = GUICtrlCreateCombo("4", 85, 222, 155, 20, $CBS_DROPDOWNLIST)
GUICtrlSetData($maxplayers, "5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27|28|29|30|31|32", "20")
GUICtrlCreateLabel("Rcon Pass:", 15, 255)
GUICtrlSetColor(-1, 0xffffff)
$rconpass = GUICtrlCreateInput("password", 85, 252, 155, 20)
GUICtrlCreateLabel("Server Pass:", 15, 285)
GUICtrlSetColor(-1, 0xffffff)
$serverpass = GUICtrlCreateInput("", 85, 282, 155, 20)
GUICtrlCreateLabel("Tickrate:", 15, 315)
GUICtrlSetColor(-1, 0xffffff)
$tickrate = GUICtrlCreateCombo("64", 85, 312, 155, 20, $CBS_DROPDOWNLIST)
GUICtrlSetData($tickrate, "128", "64")
GUICtrlCreateLabel("IP:", 15, 345)
GUICtrlSetColor(-1, 0xffffff)
$ip = GUICtrlCreateInput(@IPAddress1, 85, 342, 155, 20)
GUICtrlCreateLabel("Port:", 15, 375)
GUICtrlSetColor(-1, 0xffffff)
$port = GUICtrlCreateInput("27015", 85, 372, 155, 20)
GUICtrlCreateLabel("Network:", 15, 405)
GUICtrlSetColor(-1, 0xffffff)
$network = GUICtrlCreateCombo("Internet", 85, 402, 155, 20, $CBS_DROPDOWNLIST)
GUICtrlSetData($network, "Lan", "Internet")
GUICtrlCreateLabel("Server Name:", 15, 435)
GUICtrlSetColor(-1, 0xffffff)
$name = GUICtrlCreateInput("CSGO Dedicated Server", 85, 432, 155, 20)

$installcsgo = GUICtrlCreateButton("Install/Update Server", 5, 470, 120, 20, $BS_FLAT)
$validatecsgo = GUICtrlCreateButton("Validate CS:GO files", 125, 470, 120, 20, $BS_FLAT)
$startsrcds = GUICtrlCreateButton("Start Server", 5, 510, 120, 20, $BS_FLAT)
$exitlauncher = GUICtrlCreateButton("Exit Launcher", 125, 510, 120, 20, $BS_FLAT)
$advanced = GUICtrlCreateButton("Addon Integration", 5, 490, 120, 20, $BS_FLAT)
$implement = GUICtrlCreateButton("Implement CS:GO DS", 125, 490, 120, 20, $BS_FLAT)

$copyright = GUICtrlCreateLabel("©2013 broodplank.net - All Rights Reserved", 5, 535)

$checkreg = RegRead("HKEY_CURRENT_USER\Software\CSGODSLauncher", "Check")
If $checkreg = 0 Or $checkreg = "" Then
	;
Else
	_ReadData()
EndIf



GUISetState()

While 1

	$msg = GUIGetMsg()

	Select

		Case $msg = $gamemode And GUICtrlRead($gamemode) = "Classic Casual"
			GUICtrlSetData($mapgroup, "mg_bomb")

		Case $msg = $gamemode And GUICtrlRead($gamemode) = "Classic Competitive"
			GUICtrlSetData($mapgroup, "mg_bomb_se")

		Case $msg = $gamemode And GUICtrlRead($gamemode) = "Arms Race"
			GUICtrlSetData($mapgroup, "mg_armsrace")

		Case $msg = $gamemode And GUICtrlRead($gamemode) = "Demolition"
			GUICtrlSetData($mapgroup, "mg_demolition")

		Case $msg = $gamemode And GUICtrlRead($gamemode) = "Deathmatch"
			GUICtrlSetData($mapgroup, "mg_allclassic")


		Case $msg = $gui_event_close Or $msg = $exitlauncher
			Exit

		Case $msg = $installcsgo
			_StoreData()
			Run(@ScriptDir & "\steamcmd.exe +login " & GUICtrlRead($username) & " " & GUICtrlRead($password) & " +force_install_dir " & Chr(34) & GUICtrlRead($tardir) & Chr(34) & " +app_update 740")

		Case $msg = $validatecsgo
			_StoreData()
			Run(@ScriptDir & "\steamcmd.exe +login " & GUICtrlRead($username) & " " & GUICtrlRead($password) & " +force_install_dir " & Chr(34) & GUICtrlRead($tardir) & Chr(34) & " +app_update 740 validate")

		Case $msg = $startsrcds

			If GUICtrlRead($gamemode) = "Classic Casual" Then
				$game_type = 0
				$game_mode = 0
			EndIf

			If GUICtrlRead($gamemode) = "Classic Competitive" Then
				$game_type = 0
				$game_mode = 1
			EndIf

			If GUICtrlRead($gamemode) = "Arms Race" Then
				$game_type = 1
				$game_mode = 0
			EndIf

			If GUICtrlRead($gamemode) = "Demolition" Then
				$game_type = 1
				$game_mode = 1
			EndIf

			If GUICtrlRead($gamemode) = "Deathmatch" Then
				$game_type = 1
				$game_mode = 2
			EndIf

			If GUICtrlRead($network) = "Internet" Then
				$sv_lan = 0
			EndIf

			If GUICtrlRead($network) = "Lan" Then
				$sv_lan = 1
			EndIf

			_StoreData()



			Run(GUICtrlRead($tardir) & "srcds.exe -console -usercon -game csgo +game_type " & $game_type & " +game_mode " & $game_mode & " +mapgroup " & GUICtrlRead($mapgroup) & " +map " & GUICtrlRead($map) & " -maxplayers_override " & GUICtrlRead($maxplayers) & " +rcon_password " & GUICtrlRead($rconpass) & " +sv_password " & Chr(34) & GUICtrlRead($serverpass) & Chr(34) & " +sv_lan " & $sv_lan & " -tickrate " & GUICtrlRead($tickrate) & " -port " & GUICtrlRead($port) & " +hostname " & Chr(34) & GUICtrlRead($name) & Chr(34))


		Case $msg = $implement
			_Implement()

		Case $msg = $advanced
			_Advanced()


	EndSelect


WEnd


Func _StoreData()
	RegWrite("HKEY_CURRENT_USER\Software\CSGODSLauncher", "Check", "REG_SZ", "1")
	RegWrite("HKEY_CURRENT_USER\Software\CSGODSLauncher", "GameMode", "REG_SZ", GUICtrlRead($gamemode))
	RegWrite("HKEY_CURRENT_USER\Software\CSGODSLauncher", "MapGroup", "REG_SZ", GUICtrlRead($mapgroup))
	RegWrite("HKEY_CURRENT_USER\Software\CSGODSLauncher", "Map", "REG_SZ", GUICtrlRead($map))
	RegWrite("HKEY_CURRENT_USER\Software\CSGODSLauncher", "MaxPlayers", "REG_SZ", GUICtrlRead($maxplayers))
	RegWrite("HKEY_CURRENT_USER\Software\CSGODSLauncher", "RconPass", "REG_SZ", GUICtrlRead($rconpass))
	RegWrite("HKEY_CURRENT_USER\Software\CSGODSLauncher", "ServerPass", "REG_SZ", GUICtrlRead($serverpass))
	RegWrite("HKEY_CURRENT_USER\Software\CSGODSLauncher", "Tickrate", "REG_SZ", GUICtrlRead($tickrate))
	RegWrite("HKEY_CURRENT_USER\Software\CSGODSLauncher", "IP", "REG_SZ", GUICtrlRead($ip))
	RegWrite("HKEY_CURRENT_USER\Software\CSGODSLauncher", "Port", "REG_SZ", GUICtrlRead($port))
	RegWrite("HKEY_CURRENT_USER\Software\CSGODSLauncher", "Network", "REG_SZ", GUICtrlRead($network))
	RegWrite("HKEY_CURRENT_USER\Software\CSGODSLauncher", "Name", "REG_SZ", GUICtrlRead($name))
EndFunc   ;==>_StoreData

Func _ReadData()
	GUICtrlSetData($gamemode, RegRead("HKEY_CURRENT_USER\Software\CSGODSLauncher", "GameMode"), "")
	GUICtrlSetData($mapgroup, RegRead("HKEY_CURRENT_USER\Software\CSGODSLauncher", "MapGroup"), "")
	GUICtrlSetData($map, RegRead("HKEY_CURRENT_USER\Software\CSGODSLauncher", "Map"), "")
	GUICtrlSetData($maxplayers, RegRead("HKEY_CURRENT_USER\Software\CSGODSLauncher", "MaxPlayers"), "")
	GUICtrlSetData($rconpass, RegRead("HKEY_CURRENT_USER\Software\CSGODSLauncher", "RconPass"), "")
	GUICtrlSetData($serverpass, RegRead("HKEY_CURRENT_USER\Software\CSGODSLauncher", "ServerPass"), "")
	GUICtrlSetData($tickrate, RegRead("HKEY_CURRENT_USER\Software\CSGODSLauncher", "Tickrate"), "")
	GUICtrlSetData($ip, RegRead("HKEY_CURRENT_USER\Software\CSGODSLauncher", "IP"), "")
	GUICtrlSetData($port, RegRead("HKEY_CURRENT_USER\Software\CSGODSLauncher", "Port"), "")
	GUICtrlSetData($network, RegRead("HKEY_CURRENT_USER\Software\CSGODSLauncher", "Network"), "")
	GUICtrlSetData($name, RegRead("HKEY_CURRENT_USER\Software\CSGODSLauncher", "Name"), "")
EndFunc   ;==>_ReadData


Func _Implement()

	$getdir = GUICtrlRead($tardir)
	If StringInStr($getdir, ".", 0, 1, 1) Then
		$newdir = StringReplace($getdir, ".", @ScriptDir, 1)
	Else
		$newdir = $getdir
	EndIf

	$implementgui = GUICreate("Possible implementation methods", 250, 120, -1, -1, -1, BitOR($WS_EX_TOOLWINDOW, $WS_EX_MDICHILD), $GUI)
	GUISetBkColor(0xefefef, $implementgui)

	GUICtrlCreateLabel("Implement the CS:GO DS Server as a startup task" & @CRLF & "This task can be found in msconfig" & @CRLF & "The server (srcds) will start along windows.", 5, 5)
	$implement_startup = GUICtrlCreateButton("Implement server as startup-task", 5, 65, 240, 40)


	GUISetState(@SW_SHOW, $implementgui)
	GUISwitch($implementgui)

	While 1
		$msg2 = GUIGetMsg()

		Select

			Case $msg2 = $gui_event_close
				GUIDelete($implementgui)
				ExitLoop


			Case $msg2 = $implement_startup

				If GUICtrlRead($gamemode) = "Classic Casual" Then
					$game_type = 0
					$game_mode = 0
				EndIf

				If GUICtrlRead($gamemode) = "Classic Competitive" Then
					$game_type = 0
					$game_mode = 1
				EndIf

				If GUICtrlRead($gamemode) = "Arms Race" Then
					$game_type = 1
					$game_mode = 0
				EndIf

				If GUICtrlRead($gamemode) = "Demolition" Then
					$game_type = 1
					$game_mode = 1
				EndIf

				If GUICtrlRead($gamemode) = "Deathmatch" Then
					$game_type = 1
					$game_mode = 2
				EndIf

				If GUICtrlRead($network) = "Internet" Then
					$sv_lan = 0
				EndIf

				If GUICtrlRead($network) = "Lan" Then
					$sv_lan = 1
				EndIf

				RegWrite("HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run", "SRCDS", "REG_SZ", Chr(34) & $newdir & "srcds.exe -console -usercon -game csgo -game_type " & $game_type & " -game_mode " & $game_mode & " +mapgroup " & GUICtrlRead($mapgroup) & " +map " & GUICtrlRead($map) & " -maxplayers_override " & GUICtrlRead($maxplayers) & " +rcon_password " & GUICtrlRead($rconpass) & " +sv_password " & Chr(34) & GUICtrlRead($serverpass) & Chr(34) & " +sv_lan " & $sv_lan & " -tickrate " & GUICtrlRead($tickrate) & " -port " & GUICtrlRead($port) & " " & Chr(34))

				MsgBox(0, "Added startup task", "Wrote " & Chr(34) & "SRCDS" & Chr(34) & " (REG_SZ) entry in HKCU\Software\Microsoft\CurrentVersion\Run" & @CRLF & @CRLF & "Value:" & @CRLF & $newdir & "srcds.exe -console -usercon -game csgo -game_type " & $game_type & " -game_mode " & $game_mode & " +mapgroup " & GUICtrlRead($mapgroup) & " +map " & GUICtrlRead($map) & " -maxplayers_override " & GUICtrlRead($maxplayers) & " +rcon_password " & GUICtrlRead($rconpass) & " +sv_password " & Chr(34) & GUICtrlRead($serverpass) & Chr(34) & " +sv_lan " & $sv_lan & " -tickrate " & GUICtrlRead($tickrate) & " -port " & GUICtrlRead($port) & " +hostname " & Chr(34) & GUICtrlRead($name) & Chr(34))


		EndSelect


	WEnd


EndFunc   ;==>_Implement




Func _Advanced()

	Local $sizegui = WinGetPos("CS:GO DS Launcher v1.2 - by broodplank")
	ConsoleWrite($sizegui[0] + $sizegui[2] & @CRLF & $sizegui[1])

	$advancedgui = GUICreate("Addon Integration", 250, 120, $sizegui[2] + 20, -1, -1, BitOR($WS_EX_TOOLWINDOW, $WS_EX_MDICHILD), $GUI)
	GUISetBkColor(0xefefef, $advancedgui)

	GUICtrlCreateLabel("Install Metamod Source to your Dedicated Server" & @CRLF & "This is the base for all other addons", 5, 5)
	$advanced_metamod = GUICtrlCreateButton("Install MetaMod Source Now!", 5, 35, 240, 20)

	GUICtrlCreateLabel("Install SourceMod to your dedicated server" & @CRLF & "This addon adds loads of new abilities", 5, 65)
	$advanced_sourcemod = GUICtrlCreateButton("Install SourceMod Now!", 5, 95, 240, 20)

	GUISetState(@SW_SHOW, $advancedgui)
	GUISwitch($advancedgui)

	While 1
		$msg3 = GUIGetMsg()

		Local $size = WinGetPos("Addon Integration")

		Select

			Case $msg3 = $gui_event_close
				GUIDelete($advancedgui)
				ExitLoop


			Case $msg3 = $advanced_metamod

				$getdir = GUICtrlRead($tardir)
				If StringInStr($getdir, ".", 0, 1, 1) Then
					$newdir = StringReplace($getdir, ".", @ScriptDir, 1)
				Else
					$newdir = $getdir
				EndIf

				GUICtrlSetState($advanced_metamod, $GUI_DISABLE)
				SplashTextOn("Metamod Source", "Downloading Metamod Source..", 250, 20, $size[0], $size[1] + 160, 33, "Verdana", 8, 8)
				InetGet("http://www.metamodsource.net/mmsdrop/1.10/mmsource-1.10.0-hg830-windows.zip", @ScriptDir & "\mms.zip", 1, 0)
				SplashTextOn("Metamod Source", "Checking if server is running...", 250, 20, $size[0], $size[1] + 160, 33, "Verdana", 8, 8)
				Sleep(1000)
				If ProcessExists("srcds.exe") Then
					MsgBox(16, "Error", "SRCDS Is running! Close it and retry")
					SplashOff()
					ExitLoop
				Else
					SplashTextOn("Metamod Source", "Copying files to server...", 250, 20, $size[0], $size[1] + 160, 33, "Verdana", 8, 8)
					If Not FileExists(@ScriptDir & "\7za.exe") Then FileInstall("D:\csgo-ds\7za.exe", @ScriptDir & "\7za.exe")
					RunWait(@ScriptDir & "\7za.exe x -y mms.zip *")
					Sleep(500)
					DirMove(@ScriptDir & "\addons\metamod", @ScriptDir & "\cs_go\csgo\addons\metamod", 1)
					Sleep(1000)
					FileDelete(@ScriptDir & "\mms.zip")
					DirRemove(@ScriptDir & "\addons")
					FileDelete(@ScriptDir & "\7za.exe")
					SplashTextOn("Metamod Source", "Installing Metamod Source done!", 250, 20, $size[0], $size[1] + 160, 33, "Verdana", 8, 8)
					Sleep(2000)
					SplashOff()
				EndIf
				GUICtrlSetState($advanced_metamod, $GUI_ENABLE)


			Case $msg3 = $advanced_sourcemod


				$getdir = GUICtrlRead($tardir)
				If StringInStr($getdir, ".", 0, 1, 1) Then
					$newdir = StringReplace($getdir, ".", @ScriptDir, 1)
				Else
					$newdir = $getdir
				EndIf

				GUICtrlSetState($advanced_sourcemod, $GUI_DISABLE)
				SplashTextOn("SourceMod", "Downloading SourceMod..", 250, 20, $size[0], $size[1] + 160, 33, "Verdana", 8, 8)
				InetGet("http://www.sourcemod.net/smdrop/1.5/sourcemod-1.5.0-hg3830-windows.zip", @ScriptDir & "\sm.zip", 1, 0)
				SplashTextOn("SourceMod", "Checking if server is running...", 250, 20, $size[0], $size[1] + 160, 33, "Verdana", 8, 8)
				Sleep(1000)
				If ProcessExists("srcds.exe") Then
					MsgBox(16, "Error", "SRCDS Is running! Close it and retry")
					SplashOff()
					ExitLoop
				Else
					SplashTextOn("SourceMod", "Copying files to server...", 250, 20, $size[0], $size[1] + 160, 33, "Verdana", 8, 8)
					If Not FileExists(@ScriptDir & "\7za.exe") Then FileInstall("D:\csgo-ds\7za.exe", @ScriptDir & "\7za.exe")
					RunWait(@ScriptDir & "\7za.exe x -y sm.zip *")
					Sleep(500)
					DirMove(@ScriptDir & "\addons\metamod", @ScriptDir & "\cs_go\csgo\addons\metamod", 1)
					DirMove(@ScriptDir & "\addons\sourcemod", @ScriptDir & "\cs_go\csgo\addons\sourcemod", 1)
					DirMove(@ScriptDir & "\cfg\sourcemod", @ScriptDir & "\cs_go\csgo\cfg\sourcemod", 1)
					Sleep(1000)
					FileDelete(@ScriptDir & "\sm.zip")
					FileDelete(@ScriptDir & "\addons")
					DirRemove(@ScriptDir & "\cfg")
					FileDelete(@ScriptDir & "\7za.exe")
					SplashTextOn("SourceMod", "Installing SourceMod done!", 250, 20, $size[0], $size[1] + 160, 33, "Verdana", 8, 8)
					Sleep(2000)
					SplashOff()
				EndIf
				GUICtrlSetState($advanced_sourcemod, $GUI_ENABLE)

		EndSelect


	WEnd


EndFunc   ;==>_Advanced