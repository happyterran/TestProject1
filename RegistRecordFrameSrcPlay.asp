<%
Dim SaveFile
SaveFile = Request.QueryString("SaveFile")
If SaveFile = "" Then SaveFile = "004038.mp3"
If SaveFile <> "" Then%>

    <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
    <!-- saved from url=(0080)http://m.endic.naver.com/enkrEntry.nhn?entryId=57390702949d4351859fef3005e9c7a0# -->
    <html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko"><head><meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">

    <!-- <a class="sbt1" onClick="nclk(this, '', '', 1)" href="/Record/004038.mp3"><span class="play"><span class="hc">play</span></span></a> -->
    <!-- 
    <span class="dicsp _dicsp">
    <a href="javascript: void(0);" onclick="metis.MobilePronListening.audioPlay(&#39;/Record/004038.mp3&#39;,this,&#39;&#39;);return false;" class="read" id="read"><span class="dicl">Play</span></a>
    </span>
     -->

    <span class="dicsp _dicsp"><a class="read" id="read"><span class="dicl"></span></a></span>

    <script type="text/javascript" src="/MobilePronListening/nclk.js"></script>
    <script type="text/javascript" src="/MobilePronListening/Common.org.js"></script>
    <script type="text/javascript" src="/MobilePronListening/notMain_common.org.js"></script>
    <script type="text/javascript">metis.MobilePronListening.init();</script>
    <!-- MP3만 가능 -->
    <span id="loading" style="display:none;" class="dicj"><!-- Play... --></span>


    <script type="text/javascript">
    function Play(){
        metis.MobilePronListening.audioPlay("/Record/<%=SaveFile%>",document.getElementById("loading"),"");
    }
    //setTimeout(Play,500);
    Play();
    </script>

<%End If%>