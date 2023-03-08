<%
	dim dxUp
	set dxUp =  Server.CreateObject("DEXT.FileUpload")
	dxUp.DefaultPath = Server.MapPath ("/upload/") & "\"

	dim filename1
	filename1=trim(dxUp("callbackfile"))
	dxUp("callbackfile").Save, False

	response.write dxUp.LastSavedFileName'중복검사후 새이름으로 저장된 파일이름 
%>