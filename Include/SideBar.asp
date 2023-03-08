    <%Dim PageURL
    PageURL=Request.ServerVariables("URL")
    'Response.Write PageURL%>
  	<div class="sidebar" style="">
      	<div class="sidebar-dropdown" style=""><a href="#" style="">Navigation</a></div>

      	<!--- Sidebar navigation -->
      	<!-- If the main navigation has sub navigation, then add the class "has_sub" to "li" of main navigation. -->
        <%If Session("Grade")="관리자" Then%>
            <ul id="nav">
        <%Else%>
      	    <ul id="" style="display: none;">
        <%End If%>
            <!-- Main menu with font awesome icon -->
            <%If Session("Grade")="관리자" Then%><!-- 
            <li><a href="index.html" <%If PageURL="/Default.asp" Then Response.Write "class='open'"%>><i class="icon-home"></i> Dashboard</a></li> -->
            <%End If%>
            <li><a href="Root.asp" <%If PageURL="/Root.asp" Then Response.Write "class='open'"%>><i class="icon-phone"></i> 충원작업</a></li> 
            <li><a href="RootResult.asp" <%If PageURL="/RootResult.asp" Then Response.Write "class='open'"%>><i class="icon-bar-chart"></i> 작업결과</a></li> 
            <%If Session("Grade")="관리자" Then%>
            <li><a href="RootSubject.asp" <%If PageURL="/RootSubject.asp" Then Response.Write "class='open'"%>><i class="icon-table"></i> 모집단위 관리</a></li>
            <li><a href="RootSubjectHistory.asp" <%If PageURL="/RootSubjectHistory.asp" Then Response.Write "class='open'"%>><i class="icon-table"></i> 모집단위 히스토리</a></li>
            <li><a href="RootStudent.asp" <%If PageURL="/RootStudent.asp" Then Response.Write "class='open'"%>><i class="icon-user"></i> 지원자 관리</a></li>
            <li><a href="RootRegist.asp" <%If PageURL="/RootRegist.asp" Then Response.Write "class='open'"%>><i class="icon-file-alt"></i> 결과 관리</a></li> <!-- 
            <li><a href="RootBulk.asp" <%If PageURL="/RootBulk.asp" Then Response.Write "class='open'"%>><i class="icon-file-alt"></i> 파일로 명단입력</a></li> 
            <li><a href="RootBulk2.asp" <%If PageURL="/RootBulk2.asp" Then Response.Write "class='open'"%>><i class="icon-table"></i> DB로 명단입력</a></li> -->
            <li><a href="DegreeSetting.asp" <%If PageURL="/DegreeSetting.asp" Then Response.Write "class='open'"%>><i class="icon-wrench"></i> 환경 설정</a></li>
            <li><a href="StatsSubject.asp" <%If PageURL="/StatsSubject.asp" Then Response.Write "class='open'"%>><i class="icon-list"></i> 종합통계</a>
            <li><a href="StatsDegree.asp" <%If PageURL="/StatsDegree.asp" Then Response.Write "class='open'"%>><i class="icon-pencil"></i> 차수별 입력건수</a>
            <li><a href="StatsList.asp" <%If PageURL="/StatsList.asp" Then Response.Write "class='open'"%>><i class="icon-zoom-in"></i> 통계 세부내역</a>
            <li><a href="Permission.asp" <%If PageURL="/Permission.asp" Then Response.Write "class='open'"%>><i class="icon-key"></i> 사용자 권한설정</a>
            <%End If%>
            <!-- 
            <li class="has_sub"><a href="#"><i class="icon-list-alt"></i> Widgets  <span class="pull-right"><i class="icon-chevron-right"></i></span></a>
                <ul>
                    <li><a href="widgets1.html">Widgets #1</a></li>
                    <li><a href="widgets2.html">Widgets #2</a></li>
                    <li><a href="widgets3.html">Widgets #3</a></li>
                </ul>
            </li>  
            <li class="has_sub"><a href="#"><i class="icon-file-alt"></i> Pages #1  <span class="pull-right"><i class="icon-chevron-right"></i></span></a>
                <ul>
                    <li><a href="post.html">Post</a></li>
                    <li><a href="login.html">Login</a></li>
                    <li><a href="register.html">Register</a></li>
                    <li><a href="support.html">Support</a></li>
                    <li><a href="invoice.html">Invoice</a></li>
                    <li><a href="profile.html">Profile</a></li>
                    <li><a href="gallery.html">Gallery</a></li>
                </ul>
            </li> 
            <li class="has_sub"><a href="#"><i class="icon-file-alt"></i> Pages #2  <span class="pull-right"><i class="icon-chevron-right"></i></span></a>
                <ul>
                    <li><a href="media.html">Media</a></li>
                    <li><a href="statement.html">Statement</a></li>
                    <li><a href="error.html">Error</a></li>
                    <li><a href="error-log.html">Error Log</a></li>
                    <li><a href="calendar.html">Calendar</a></li>
                    <li><a href="grid.html">Grid</a></li>
                </ul>
            </li> -->
            <!-- 
            <li><a href="charts.html"><i class="icon-bar-chart"></i> Charts</a></li> 
            <li><a href="tables.html"><i class="icon-table"></i> Tables</a></li>
            <li><a href="forms.html"><i class="icon-tasks"></i> Forms</a></li> -->
            <!-- Sub menu markup 
            <li><a href="ui.html"><i class="icon-magic"></i> User Interface</a></li>
              <ul>
                <li><a href="#">Submenu #1</a></li>
                <li><a href="#">Submenu #2</a></li>
                <li><a href="#">Submenu #3</a></li>
              </ul>
            </li>-->
      	</ul>
  	</div>
