// Ajax ��ü ����
function GetXMLHTTP()
{
	//���̾����
	if(window.XMLHttpRequest) return new XMLHttpRequest();

	// IE 6���ϸ� ���� �ڵ�
	var versions = [
		"MSXML2.XMLHTTP.5.0",
		"MSXML2.XMLHTTP.4.0",
		"MSXML2.XMLHTTP.3.0",
		"MSXML2.XMLHTTP",
		"Microsoft.XMLHTTP",
	]
	
	for(var i = 0 ; i < versions.length; i++)
	{
		try
		{
			var oXMLHTTP = new ActiveXObject(versions[i]);
			return oXMLHTTP;
		}
		catch(e) {}
	}
	
	throw new Error ("NO XMLHTTP");
}

// Textarea Byte üũ
var tmpMSG, tmpByte
function getByteLength(obj)
{		
		var msg = obj;
		var str = new String(msg);
		var len = str.length;
		var count = 0;

		for (k=0;k<len ; k++)
		{
			temp = str.charAt(k);
			if (escape(temp).length > 4)
			{
				count += 2;
			} else if (temp == '\r' && str.charAt(k+1) == '\n')
			{
				count +=1
			} else if (temp != '\n')
			{
				count++;
			}
		}

		return count;
}