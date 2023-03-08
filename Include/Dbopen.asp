<%
Dim Dbcon
Set Dbcon = Server.CreateObject("ADODB.Connection")
Dbcon.ConnectionTimeout = 200
Dbcon.CommandTimeout = 600
server.scripttimeout = 600

Dim DBConnectionString
'DBConnectionString = "provider=SQLOLEDB.1;Password=east12!@;Persist Security Info=True;User ID=METIS; Initial Catalog=METIS_MJC_2016_Susi;Data source=localhost"
'DBConnectionString = "provider=SQLOLEDB.1;Password=east12!@;Persist Security Info=True;User ID=METIS; Initial Catalog=METIS_MJC_2017_JungSi;Data source=localhost"
DBConnectionString = "provider=SQLOLEDB.1;Password=east12!@;Persist Security Info=True;User ID=METIS; Initial Catalog=METIS;Data source=localhost"
Dbcon.Open DBConnectionString

Dim DbaseConnectionString
DbaseConnectionString = "provider=SQLOLEDB.1;Password=east12!@;Persist Security Info=True;User ID=METIS; Initial Catalog=METIS;Data source=localhost"

Dim TimerStart,TimerEnd
TimerStart = Timer()

'****************************
'모든 DB객체를 소멸 시킨다.
'****************************
Public Sub NothingDB(ByVal DBConnection, ByVal RecordSet)

    'If RecordSet.State=adStateOpen Then RecordSet.Close
    If RecordSet.State=1 Then RecordSet.Close
    If Not RecordSet Is Nothing Then Set RecordSet = Nothing
    If DBConnection.State=1 Then DBConnection.Close
    If Not DBConnection Is Nothing Then Set DBConnection = Nothing

End Sub


'*****************************
'RecordSet 객체를 소멸 시킨다.
'*****************************
Public Sub NothingRS(ByVal RecordSet)

    If RecordSet.State=1 Then RecordSet.Close
    If Not RecordSet Is Nothing Then Set RecordSet = Nothing

End Sub


'*****************************
'RecordSet 객체를 Close 시킨다.
'*****************************
Public Sub CloseRS(ByVal RecordSet)

    If RecordSet.State=1 Then RecordSet.Close

End Sub
%>