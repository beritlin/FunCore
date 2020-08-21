<!DOCTYPE html>
<html>


<head>
    <title>FunCore - Browse</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css"> 
    <link href="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.12.0/css/mdb.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.11.2/css/all.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
    

    

</head>

<body>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script> 
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script> 
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
  
<!-- navbar -->
<style>

.tab {
    display: block;
    background: #FFFFFF;
    font-size: 17px;
    font-weight: 700;
    color: #333333;
    text-transform: uppercase;
    text-align: center;
    border-radius: 0;
    border: none;
    margin-left: 0;
    overflow: hidden;
    z-index: 1;
    position: relative;
}

.tab .navbar-brand{
    display: block;
    padding: 20px 15px;
    background: #FFFFFF;
    font-size: 17px;
    font-weight: 700;
    color: #333333;
    text-transform: uppercase;
    text-align: center;
    border-radius: 0;
    border: none;
    margin-left: 15px;
    overflow: hidden;
    z-index: 1;
    position: relative;
}

.nav-tabs{
    position: relative;
    border-bottom: none;
    margin-right: 15px;
}
.tab .nav-tabs li{
    margin: 0;
}

.tab .nav-tabs li a{
    display: block;
    padding: 20px 15px;
    background: #FFFFFF;
    font-size: 17px;
    font-weight: 700;
    color: #333333;
    text-transform: uppercase;
    text-align: center;
    border-radius: 0;
    border: none;
    margin-right: 0;
    overflow: hidden;
    z-index: 1;
    position: relative;
    transition: all 0.3s ease 0s;
}
.tab .nav-tabs .nav-item a:after{
    content: "";
    width: 100%;
    height: 100%;
    background: #e9e9e9;
    position: absolute;
    top: 0;
    left: 0;
    z-index: -1;
    perspective-origin: 50% 100%;
    transform: perspective(900px) rotate3d(1, 0, 0, 90deg);
    transform-origin: 50% 100% 0;
    transition: transform 0.3s ease 0s, background-color 0.3s ease 0s;
}
.tab .nav-tabs li.active a:after{
    background: #B2B2B2;
    transform: perspective(900px) rotate3d(1, 0, 0, 0deg);
}
.tab .nav-tabs .nav-item .active ,
.tab .nav-tabs li a:hover{
    color: #333333;
    background: #E5E5E5;
    border: none;
}
@media only screen and (max-width: 479px){
    .tab .nav-tabs li{
        width: 100%;
        text-align: center;
    }
}
</style>
<div class="tab">
  <div >
    <a class="navbar-brand" href="">FunCore</a>
  </div>
    <ul class="nav nav-tabs navbar-right">
        <li class="nav-item">
          <a class="nav-link" href="http://140.109.56.61"><span class="glyphicon glyphicon-home"></span> Home</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="http://140.109.56.61/About.html"><span class="glyphicon glyphicon-info-sign"></span> About</a>
        </li>
        <li class="nav-item">
          <a class="nav-link active" href="http://140.109.56.61/Browse.php"><span class="glyphicon glyphicon-list"></span> Browse</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="http://140.109.56.61/Query-simple.html"><span class="glyphicon glyphicon-search"></span> Query</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="http://140.109.56.61/Help.html"><span class="glyphicon glyphicon-question-sign"></span> Help</a>
          </li>
      </ul>
</div>

<!-- middle part -->
<style>
  #header{
      background: #E5E5E5;
      width: 100%;
      height: 100%;
      font-weight: 700;
      text-align: left;
  }
  
  </style>
  
      <!-- header -->
      <div class="jumbotron jumbotron-fluid" id="header">
        <div class="container">
          <div class="row justify-content-md-center">
            <div class="col-6">
                <h1>Browse</h1>
            </div>
            </div>
          </div>
        </div>
      </div>

  

    <!-- text -->
    <style>
      #content{
      background: #ffffff;
      width: 100%;
      height: 100%;
      font-weight: 700;
      text-align: left;
      box-shadow: none;
      }
      #content h1{
      font-size: 28px;
      }
      .table {
      margin-bottom: 30px;
      font-size: 17px;
    }

    #pills-tab .nav-link{
      background: black;
      color: #ffffff;
      font-size: 17px;
    }

    h3{
      font-size: 13px;
    }
    h4{
      font-size: 13px;
    }

    h2{
      font-size: 13px;
    }


    </style>
<!--tree-->
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
<script type="text/javascript" language="javascript">
            $(document).ready(function(){
            $('.ann_header') 
            .hover(function() {
                cursorChange(this);
            })
            .click(function() {
                foldToggle(this);
            })
            //.trigger('click');
            
            $('.ann_sub_header')
            .hover(function() {
                cursorChange(this);
            })
            .click(function() {
                foldToggle(this);
            })
            .trigger('click');  // 預設是折疊起來
            
        });
        
        // 打開or摺疊選單
        function foldToggle(element) {
            $(element).next('ul').slideToggle();
        }
        
        // 讓游標移到標題上時，圖案會變成手指
        function cursorChange(element, cursorType) {
            $(element).css('cursor', 'pointer');
        }
</script>
  

        <div class="jumbotron jumbotron-fluid" id="content">
          <div class="container">
            <div class="row justify-content-md-center">
              <div class="col-6">

                <ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
                  <li class="nav-item">
                    <a class="nav-link active" id="pills-home-tab" data-toggle="pill" href="#pills-home" role="pills-tab" aria-controls="pills-home" aria-selected="true">Ranking</a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link" id="pills-profile-tab" data-toggle="pill" href="#pills-profile" role="tab" aria-controls="pills-profile" aria-selected="false">Phylogeny</a>
                  </li>
                </ul>
                <div class="tab-content" id="pills-tabContent">

                      <!-- ranking -->
                  <div class="tab-pane fade show active" id="pills-home" role="tabpanel" aria-labelledby="pills-home-tab">
                    <table class="table table-hover">
                      <thead>
                        <tr>
                          <th scope="col" id="col">Rank</th>
                          <th scope="col" id="col">Clsuter ID</th>
                          <th scope="col" id="col">Score</th>
                          <th scope="col" id="col">Species</th>
                          <th scope="col" id="col">Nodes</th>
			</thead>
                      <tbody>
      <?php
			        require("db_conn.php");
        
				$sql_query="SELECT DISTINCT clustertable.Rank, clustertable.Clsuter_ID, clustertable.Score, clustertable.SpeciesN,  clustertable.NodeN
				FROM clustertable 
				order by clustertable.Rank asc;";
				if($result=mysqli_query($db,$sql_query)) {
				while($row=mysqli_fetch_array($result)) {
				echo "<tr onclick='trclickfunc();'><th id='tr-0'>";
				echo $row[0];
				echo "</th><th id='tr-1'>";
                                echo "<form method=\'post\' action=http://140.109.56.61/Output-sequence.php>
                                <input type=\"submit\" id=\"submitButton\" name=\"submitButton\" value=$row[1]>
                                </form>";

				//echo $row[1];
				echo "</th><th id='tr-2'>";
				echo $row[2];
                                echo "</th><th id='tr-3'>";
                                echo $row[3];
				echo "</th><th id='tr-4'>";
                                echo $row[4];
				}
				}else{
				echo"Sorry, please try again!";
				}
			?>
                      </tbody>
                    </table>
                  </div>

                      <!-- phylogeny -->
                  <div class="tab-pane fade" id="pills-profile" role="tabpanel" aria-labelledby="pills-profile-tab">
                    <p> Browse the fungal core gene clusters by phylogeny.</p>


                     <!--tree-->
                  <div id="tree1">
                     <ul>
                      <h3 class='ann_header'>Blastocladiomycota</h3>
                      <ul>
          
                              <h4 class='ann_sub_header'>Blastocladiomycetes</h4>
                              <ul>
                                  <h2>Blastocladiales</h2>
                              </ul>
                      </ul>
              </ul>
          
              <ul>
                      <h3 class='ann_header'>Chytridiomycota</h3>
                      <ul>
                              <h4 class='ann_sub_header'>Chytridiomycetes</h4>
                              <ul>
                                  <h2>Chytridiales</h2>
                                  <h2>Cladochytriales</h2>
                                  <h2>Lobulomycetales</h2>
                                  <h2>Polychytriales</h2>
                                  <h2>Rhizophlyctidales</h2>
                                  <h2>Rhizophydiales</h2>
                                  <h2>Spizellomycetales</h2>
                              </ul>     
                              <h4 class='ann_sub_header'>Monoblepharidomycetes</h4>
                              <ul>
                                  <h2>Monoblepharidales</h2>
                              </ul>
                              <h4 class='ann_sub_header'>Neocallimastigomycetes</h4>
                      </ul>
              </ul>
          
              <ul>
                  <lpi>
                      <h3 class='ann_header'>Zoopagomycota</h3>
                      <ul>
                              <h4 class='ann_sub_header'>Zoopagomycotina</h4>
                              <h4 class='ann_sub_header'>Kickxellomycotina</h4>
                              <h4 class='ann_sub_header'>Entomophthoromycotina</h4>
                              <ul>
                                  <h5>Basidiobolomycetes</h5>
                                  <h5>Neozygitomycetes</h5>
                                  <h5>Entomophthoromycetes</h5>
                              </ul>
                      </ul>
              </ul>
              
              <ul>
                      <h3 class='ann_header'>Mucoromycota</h3>
                      <ul>
                              <h4 class='ann_sub_header'>Glomeromycotina</h4>
                              <ul>
                                  <h2>Glomeromycetes</h2>
                              </ul>
                              <h4 class='ann_sub_header'>Mortierellomycotina</h4>
                              <ul>
                                  <h2>Moretierellomycetes</h2>
                              </ul>
                              <h4 class='ann_sub_header'>Mucoromycotina</h4>
                      </ul>
              </ul>
          
              <ul>
                      <h3 class='ann_header'>Ascomycota</h3>
                      <ul>
                              <h4 class='ann_sub_header'>Pezizomycotina</h4>
                              <ul>
                                  <h2>Arthoniomycetes</h2>
                                  <h2>Coniocybomycetes</h2>
                                  <h2>Dothideomycetes</h2>
                                  <h2>Geoglossomycetes</h2>
                                  <h2>Laboulbeniomycetes</h2>
                                  <h2>Lecanoromycetes</h2>
                                  <h2>Leotiomycetes</h2>
                                  <h2>Lichinomycetes</h2>
                                  <h2>Orbiliomycetes</h2>
                                  <h2>Pezizomycetes</h2>
                                  <h2>Sordariomycetes</h2>
                                  <h2>Xylonomycetes</h2>
                              </ul>
                              <h4 class='ann_sub_header'>Saccharomycotina</h4>
                              <ul>
                                  <h2>Saccharomycetes</h2>
                              </ul>
                              <h4 class='ann_sub_header'>Taphrinomycotina</h4>
                              <ul>
                                  <h2>Archaeorhizomycetes</h2>
                                  <h2>Neolectomycetes</h2>
                                  <h2>Pneumocystidomycetes</h2>
                                  <h2>Schizosaccharomycetes</h2>
                                  <h2>Taphrinomycetes</h2>
                              </ul>
                      </ul>
              </ul>
          
              <ul>
                      <h3 class='ann_header'>Basidiomycota</h3>
                      <ul>
                              <h4 class='ann_sub_header'>Agaricomycotina</h4>
                              <ul>
                                  <h2>Agaricomycetes</h2>
                                  <h2>Dacrymycetes</h2>
                                  <h2>Tremellomycetes</h2>
                                  <h2>Wallemiomycetes</h2>
                              </ul>
                              <h4 class='ann_sub_header'>Pucciniomycotina</h4>
                              <ul>
                                  <h2>Agaricostilbomycetes</h2>
                                  <h2>Atractiellomycetes</h2>
                                  <h2>Classiculomycetes</h2>
                                  <h2>Cryptomycocolacomycetes</h2>
                                  <h2>Cystobasidiomycetes</h2>
                                  <h2>Microbotryomycetes</h2>
                              </ul>
                      </ul>
              </ul>
            </div>      

                            
                              </div>
                    </div>





                  </div>
                </div>
                


              </div>
            </div>
          </div>
        </div>


    <!-- footer -->
    <style>
    .page-footer{
      background-color: #2E2E2E;
      color: #FFFFFF;
    }
    .footer-copyright{
      background-color: #212121;
      color: #B2B2B2;
    }
    </style>


  <footer class="page-footer unique-color-dark pt-4">
  <!-- Footer Elements -->
  <div class="container">

    <!-- Call to action -->
    <ul class="list-unstyled list-inline text-center py-2">
      <li class="list-inline-item">
        <h5 class="mb-1">If you have found the FunCore database useful, please cite us.</h5>
      </li>
    </ul>
  </div>
  <!-- Copyright -->
  <div class="footer-copyright text-center py-3">© 2020 Copyright:
    <a> IPMB, Acadamia Sinica</a>
  </div>
</footer>
   



</body>

</html>



