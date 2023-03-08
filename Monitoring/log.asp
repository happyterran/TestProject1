
<% session.CodePage = "65001" %>
<% Response.CharSet = "utf-8" %>
<%
	''@ �Ѱ� ���� �� 
	strLog = Request("strLog")

	Dim objFSO, objCreatedFile, objOpenedFile
	Dim objTextFile
	Dim sRead, sReadLine, sReadAll
	
	'Create the FSO.
	Set objFSO = CreateObject("Scripting.FileSystemObject")
	Const ForReading = 1, ForWriting = 2, ForAppending = 8

	''@ ���� �ִ��� üũ �� ����
	Dim strDir

	strDir = Server.MapPath("\") 
	strDir = strDir & "\Log"

	''@ ���� üũ �ϰ� ������ ���������.
	If Not objFSO.FolderExists(strDir) Then 
		objFSO.CreateFolder(strDir)
	End If 

	''@ �������ִ��� Ȯ�� ����. C:\METIS\log\��  ��������.log ����
	Dim FileName

	fileName = "web_" & replace(Date(), "-", "") & ".log"
	strFilePathName = strDir & "\"& fileName

	''@ ���� �ִ��� üũ �ϰ� ������ ������
	If Not objFSO.FileExists(strFilePathName) Then 
		Set objCreatedFile = objFSO.CreateTextFile(strFilePathName, True)
		objCreatedFile.Close
	End If

	''@ ������ ���� ����.
	Set objOpenedFile = objFSO.OpenTextFile(strFilePathName, ForAppending, True)

	objOpenedFile.Writeline ("[" & Now() & "] : " & strLog)
	objOpenedFile.Close


	''@********************************************************************************
	''@ �ؽ�Ʈ ������ ����� ���� �����ϴ� ���
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
	''@ �ؽ�Ʈ ���Ͽ��� ���� �д� ���
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
	''@ �ؽ�Ʈ ������ �̵��ϰ� �����ϴ� ���
	''@********************************************************************************
	'objFSO.MoveFile "c:\HowToDemoFile.txt", "c:\Temp\"
	'objFSO.CopyFile "c:\Temp\HowToDemoFile.txt", "c:\"


	Set objFSO = nothing

	
%>




