
<!-- <div class="navbar navbar-fixed-top"> -->
<div class="navbar " style="margin-bottom:0;">
  <div class="navbar-inner">
    <div class="container">
      <!-- Menu button for smallar screens -->
      <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
        <span>Menu</span>
      </a>
      <!-- Site name for smallar screens -->
      <a href="index.html" class="brand hidden-desktop">Project METIS 2.0</a>

      <!-- Navigation starts -->
      <div class="nav-collapse collapse">        


        <!-- Logo section -->
        <div class="span4">
          <!-- Logo. -->
          <div class="logo">
            <h1 style="margin: 0px; font-size: 25px; "><a href="/">Project <span class="bold"><b>METIS 2.0</b></span></a></h1>
            <!-- <p class="meta">something goes in meta area</p> -->
          </div>
          <!-- Logo ends -->
        </div>

        <ul class="nav">  
        <%If Session("Grade")="관리자" Then'관리자만 상단바%>
          <!-- Upload to server link. Class "dropdown-big" creates big dropdown -->
          <li class="dropdown dropdown-big">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown"><span class="badge badge-important"><i class="icon-cloud-upload"></i></span> 충원 진행상황</a>
            <!-- Dropdown -->
            <ul class="dropdown-menu">
              <li>
                <!-- Progress bar -->
                <p>Remain in Progress</p>
                <!-- Bootstrap progress bar -->
                <div class="progress">
                  <div class="bar bar-success" style="width: 40%;"></div>
                </div>
                <hr />
                <!-- Progress bar -->
                <p>Dial in Progress</p>
                <!-- Bootstrap progress bar -->
                <div class="progress">
                  <div class="bar bar-important" style="width: 80%;"></div>
                </div>   
                <hr />             
                <!-- Dropdown menu footer -->
                <div class="drop-foot">
                  <a href="#">View All</a>
                </div>
              </li>
            </ul>
          </li>

          <!-- Sync to server link -->
          <li class="dropdown dropdown-big">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown"><span class="badge badge-success"><i class="icon-refresh"></i></span> Sync with Server</a>
            <!-- Dropdown -->
            <ul class="dropdown-menu">
              <li>
                <!-- Using "icon-spin" class to rotate icon. -->
                <p><span class="badge badge-success"><i class="icon-refresh icon-spin"></i></span> Syncing Members Lists to Server</p>
                <hr />
                <p><span class="badge badge-warning"><i class="icon-refresh icon-spin"></i></span> Syncing Bookmarks Lists to Cloud</p>
                <hr />
                <!-- Dropdown menu footer -->
                <div class="drop-foot">
                  <a href="#">View All</a>
                </div>
              </li>
            </ul>
          </li>
        <%End If%>

        </ul>

        <!-- Search form --><!-- 
        <form class="navbar-search pull-left">
          <input type="text" class="search-query" placeholder="Search" style="width: 100px;">
        </form> -->

        <!-- Links -->
        <ul class="nav pull-right">
          <li class="dropdown pull-right">            
            <a data-toggle="dropdown" class="dropdown-toggle" href="#">
              <i class="icon-user"></i> <%=Session("MemberName")%> <b class="caret"></b>              
            </a>
            
            <!-- Dropdown menu -->
            <ul class="dropdown-menu"><!-- 
              <li><a href="#"><i class="icon-user"></i> Profile</a></li>
              <li><a href="#"><i class="icon-cogs"></i> Settings</a></li> -->
              <li><a href="Logout.asp"><i class="icon-off"></i> Logout</a></li>
            </ul>
          </li>
          
        </ul>
      </div>

    </div>
  </div>
</div>