//--------------------------------------------------------------------------------------------------
//��    �� : ���� ���ε� function
//�Ķ���� :
//��    �� : ����
//--------------------------------------------------------------------------------------------------
var PrdExcelImport = {
		fnPrdidFileUpload : function() {
		var imgPath = $("uploadMultiFile").value;
		var src = FileUtil.getFileExtension(imgPath);
		if((src.toLowerCase() == "xls")){
			var objForm = document.getElementById("frmExecute");
			document.frmExecute.target = "iframeFileUpload";
			document.frmExecute.action="/prd/popup/prdRegExcelImportPop.gs";
			document.frmExecute.submit();
		} else {
			alert("�������ϸ� ���ε尡 �����մϴ�.");
			return;
		}
	}
};

var FileUtil = {
	/**
	* @param : ���ϰ��
	* @usage : FileUtil.getFileSize("path")
	* @description : ������ ũ�⸦ �Ѱ��ش�.
	*/
	getFileSize : function(path){
		var img = new Element('IMG');
		img.src = path;
		return img.fileSize;
	},
	/**
	* @param : ���ϰ��
	* @usage : FileUtil.getFileExtension("path")
	* @description : ������ Ȯ���ڸ� �Ѱ��ش�.
	*/
	getFileExtension : function(filePath){
			var extension = "";
			var lastIndex = -1;
			lastIndex = filePath.lastIndexOf('.');

		if(lastIndex != -1) {
			extension = filePath.substring( lastIndex+1, filePath.length );
		} else {
			extension = "";
		}
		return extension;
	}
};

