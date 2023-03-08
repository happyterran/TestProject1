
<% session.CodePage = "65001" %>
<% Response.CharSet = "utf-8" %>
<%
	''@ 넘겨 받은 값 
	strLog = Request("strLog")

	Dim objFSO, objCreatedFile, objOpenedFile
	Dim objTextFile
	Dim sRead, sReadLine, sReadAll
	
	'Create the FSO.
	Set objFSO = CreateObject("Scripting.FileSystemObject")
	Const ForReading = 1, ForWriting = 2, ForAppending = 8

	''@ 폴더 있는지 체크 및 생성
	Dim strDir

	strDir = Server.MapPath("\") 
	strDir = strDir & "\Log"

	''@ 폴더 체크 하고 없으면 만들어주자.
	If Not objFSO.FolderExists(strDir) Then 
		objFSO.CreateFolder(strDir)
	End If 

	''@ 파일이있는지 확인 하자. C:\METIS\log\에  오늘일자.log 파일
	Dim FileName

	fileName = "web_" & replace(Date(), "-", "") & ".log"
	strFilePathName = strDir & "\"& fileName

	''@ 파일 있는지 체크 하고 없으면 만들자
	If Not objFSO.FileExists(strFilePathName) Then 
		Set objCreatedFile = objFSO.CreateTextFile(strFilePathName, True)
		objCreatedFile.Close
	End If

	''@ 파일을 열고 쓰자.
	Set objOpenedFile = objFSO.OpenTextFile(strFilePathName, ForAppending, True)

	objOpenedFile.Writeline ("[" & Now() & "] : " & strLog)
	objOpenedFile.Close


	''@********************************************************************************
	''@ 텍스트 파일을 만들고 열고 삭제하는 방법
	''@********************************************************************************
	'Set objCreatedFile = objFSO.CreateTextFile("c:\HowToDemoFile.txt", True)
	'Set objOpenedFile = objFSO.OpenTextFile("c:\HowToDemoFile2.txt", ForWriting, True)
	''Use objCreatedFile and objOpenedFile to manipulate the corresponding files.
	'objCreatedFile.Close
	'objOpenedFile.Close

	''Delete the files.
	'objFSO.DeleteFile "c:\HowToDemoFile.txt"
	'objFSO.DeleteFile "c:\HowToDemoFile2.txt"



	''@********************************************************************************
	''@ 텍스트 파일에서 쓰고 읽는 방법
	''@********************************************************************************
	'Set objTextFile = objFSO.CreateTextFile("c:\HowToDemoFile.txt", True)
	'' Write a line with a newline character.
	'objTextFile.WriteLine("This line is written using WriteLine().")
	'' Write a line.
	'objTextFile.Write ("This line is written using Write().")
	'' Write three newline characters to the file.
	'objTextFile.WriteBlankLines(3)
	'objTextFile.Close

	'' Open file for reading.
	'Set objTextFile = objFSO.OpenTextFile("c:\HowToDemoFile.txt", ForReading)
	'' Use different methods to read contents of file.
	'sReadLine = objTextFile.ReadLine
	'sRead = objTextFile.Read(4)
	'sReadAll = objTextFile.ReadAll
	'objTextFile.Close

	''@********************************************************************************
	''@ 텍스트 파일을 이동하고 복사하는 방법
	''@********************************************************************************
	'objFSO.MoveFile "c:\HowToDemoFile.txt", "c:\Temp\"
	'objFSO.CopyFile "c:\Temp\HowToDemoFile.txt", "c:\"


	Set objFSO = nothing

	
%>




