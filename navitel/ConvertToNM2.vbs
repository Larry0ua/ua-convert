Option Explicit

'
' ConvertToNM2.vbs
'
' Copyright (c) Konstantin Galichsky (kg@geopainting.com), 2004-2007
' All rights reserved.
'
'
' This script uses GPSMapEdit to convert multiple maps to NM2 format.
'
' USAGE:
' Input files should be put into .\Maps folder (relative to the script file).
' Log.txt file is created to log progress.
'

	' Connect to GPSMapEdit.
Dim a
Set a = CreateObject ("GPSMapEdit.Application.1")
a.MinimizeWindow

	' Check version of GPSMapEdit
If a.Version < "1.0.36.0" Then
	MsgBox "Obsolete version of GPSMapEdit is used. Please upgrade."
	WScript.Quit
End If

Dim fso
Set fso = CreateObject ("Scripting.FileSystemObject")

Dim strRoot
strRoot = fso.GetAbsolutePathName (WScript.ScriptFullName + "\..\")

Dim log
Set log = fso.CreateTextFile (strRoot + "\Log.txt")

Dim pMapsFolder

If Not fso.FolderExists (strRoot + "\Maps") Then
	MsgBox "Couldn't find '\Maps' folder."
	WScript.Quit
End if
Set pMapsFolder = fso.GetFolder (strRoot + "\Maps")

Dim pFile
For Each pFile In pMapsFolder.Files
	Dim strExt
	strExt = LCase (fso.GetExtensionName (pFile.Path))
	If strExt = "img" Or strExt = "ntm" Or strExt = "rus" Or strExt = "mp" Then
		Dim strOutFile
		strOutFile = fso.GetParentFolderName(pFile.Path) + "\" + fso.GetBaseName (pFile.Path) + ".nm2"

		If Not fso.FileExists (strOutFile) Then
			a.Open pFile.Path, False

			a.SaveAs strOutFile, "navitel-nm2"
		End If
	End if

	log.WriteLine strOutFile
Next

a.Exit

'MsgBox "Converting maps is completed!"
