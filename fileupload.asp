<%
	dim dxUp
	set dxUp =  Server.CreateObject("DEXT.FileUpload")
	dxUp.DefaultPath = Server.MapPath ("/upload/") & "\"

	dim filename1
	filename1=trim(dxUp("callbackfile"))
	dxUp("callbackfile").Save, False

	response.write dxUp.LastSavedFileName'�ߺ��˻��� ���̸����� ����� �����̸� 
%>