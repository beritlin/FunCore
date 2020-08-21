<!DOCTYPE html>
<html>


<head>
    <title>FunCore - Output</title>
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
    <a class="navbar-brand" href="http://140.109.56.61">Logo</a>
  </div>
    <ul class="nav nav-tabs navbar-right">
        <li class="nav-item">
          <a class="nav-link" href="http://140.109.56.61"><span class="glyphicon glyphicon-home"></span> Home</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="http://140.109.56.61/About.html"><span class="glyphicon glyphicon-info-sign"></span> About</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="http://140.109.56.61/Browse.php"><span class="glyphicon glyphicon-list"></span> Browse</a>
        </li>
        <li class="nav-item">
          <a class="nav-link active" href="http://140.109.56.61/Query-simple.html"><span class="glyphicon glyphicon-search"></span> Query</a>
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
                <h1>Query</h1>
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
      font-size: 15px;
    }

    </style>
  
    <style>
    #waiting {
      margin-top: -25px;
      margin-left: 200px;
    }

    </style>
       
     


        <div class="jumbotron jumbotron-fluid" id="content">
          <div class="container">
            <div class="row justify-content-md-center">
              <div class="col-6">
               

		<h1 id="sName">
                <?php
                include "db_conn.php";
                $specie=$_POST["find_species"];
		if(isset($specie)){
		echo $specie;
		}

		$sqid=$_POST["find_sqid"];
                if(isset($sqid)){
                echo $sqid;
                }
                
		$sq=$_POST["find_sq"];
                if(isset($sq)){
                echo $sq;
                }
		
		$sq=$_POST["find_func"];
                if(isset($func)){
                echo $func;
                }
		
                ?>
                </h1>
                <table class="table table-hover" id="tbl">
                    <thead>
                      <tr>
                        <th scope="col">Rank</th>
			<th scope="col">Clsuter ID</th>
			<th scope="col">Probability Score</th>
			<th scope="col">Species</th>
			<th scope="col">Nodes</th>
                        
                      </tr>
                    </thead>
                    <tbody id="tbodyy">


<?php
			require("db_conn.php");
			$specie=$_POST["find_species"];
			$sqid=$_POST["find_sqid"];
			$sq=$_POST["find_sq"];
			$func=$_POST["find_func"];
			if(isset($specie) && $specie != ""){
			$sql_query="SELECT DISTINCT clustertable.Rank, clustertable.Clsuter_ID, clustertable.Score, clustertable.SpeciesN,  clustertable.NodeN
			FROM clustertable 
			INNER JOIN sequencetable ON sequencetable.Clsuter_ID=clustertable.Clsuter_ID  
			WHERE exists (SELECT * FROM sequencetable WHERE  sequencetable.Clsuter_ID=clustertable.Clsuter_ID AND sequencetable.Speices like '%$specie%')  
			order by clustertable.Rank asc;";
			if($result=mysqli_query($db,$sql_query)) {
			while($row=mysqli_fetch_array($result)){
			
			echo "<tr onclick='trclickfunc();'><th id='tr-0'>";
			echo $row[0];
			echo "</th><th id='tr-1'>";
			
			echo "
				<form method=\'post\' action=http://140.109.56.61/Output-sequence.php> 
				<input type=\"submit\" id=\"submitButton\" name=\"submitButton\" value=$row[1]>
				</form>"
			;
			//echo $row[1];
			echo "</th><th id='tr-2'>";
			echo $row[2];
			echo "</th><th id='tr-3'>";
			echo $row[3];
			echo "</th><th id='tr-4'>";
			echo $row[4];	
			}	
			}
			}
			if(isset($sqid) && $sqid!=""){
			$sql_query="SELECT DISTINCT clustertable.Rank, clustertable.Clsuter_ID, clustertable.Score, clustertable.SpeciesN,  clustertable.NodeN
			FROM clustertable 
			INNER JOIN sequencetable ON sequencetable.Clsuter_ID=clustertable.Clsuter_ID
			WHERE exists (SELECT * FROM sequencetable WHERE  sequencetable.Clsuter_ID=clustertable.Clsuter_ID AND sequencetable.Seq_ID = '$sqid')  
			order by clustertable.Rank asc;";
			if($result=mysqli_query($db,$sql_query)) {
			while($row=mysqli_fetch_array($result)){
			
			echo "<tr onclick='trclickfunc();'><th id='tr-0'>";
			echo $row[0];
			echo "</th><th id='tr-1'>";
			echo $row[1];
			echo "</th><th id='tr-2'>";
			echo $row[2];
			echo "</th><th id='tr-3'>";
			echo $row[3];
			echo "</th><th id='tr-4'>";
			echo $row[4];	
			}	
			}
			}
		if(isset($sq) && $sq!=""){
		$sql_query="SELECT DISTINCT clustertable.Rank, clustertable.Clsuter_ID, clustertable.Score, clustertable.SpeciesN,  clustertable.NodeN
		FROM clustertable
		INNER JOIN sequencetable ON sequencetable.Clsuter_ID=clustertable.Clsuter_ID
		INNER JOIN fastaetable ON fastaetable.Seq_ID=sequencetable.Seq_ID
		WHERE exists (SELECT * FROM fastaetable WHERE fastaetable.Seq_ID=sequencetable.Seq_ID AND sequencetable.Clsuter_ID=clustertable.Clsuter_ID AND fastatable.Seq LIKE '%$sq%')
		order by clustertable.Rank asc;";
		if($result=mysqli_query($db,$sql_query)) {
		while($row=mysqli_fetch_array($result)){

		echo "<tr onclick='trclickfunc();'><th id='tr-0'>";
		echo $row[0];
		echo "</th><th id='tr-1'>";
		echo $row[1];
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
		}
			if(isset($func) && $func!=""){
			$sql_query="SELECT DISTINCT clustertable.Rank, clustertable.Clsuter_ID, clustertable.Score, clustertable.SpeciesN,  clustertable.NodeN
			FROM clustertable
			INNER JOIN sequencetable ON sequencetable.Clsuter_ID=clustertable.Clsuter_ID
			INNER JOIN functiontable ON functiontable.Seq_ID=sequencetable.Seq_ID
			WHERE functiontable.Seq_ID=sequencetable.Seq_ID AND sequencetable.Clsuter_ID=clustertable.Clsuter_ID AND functiontable.GO_Function LIKE '%$func%'
			order by clustertable.Rank asc;";
			if($result=mysqli_query($db,$sql_query)) {
			while($row=mysqli_fetch_array($result)){

			echo "<tr onclick='trclickfunc();'><th id='tr-0'>";
			echo $row[0];
			echo "</th><th id='tr-1'>";
			echo $row[1];
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
			}
	?>                                                  
		  </tbody>
                  </table>
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
    <a> FunCore</a>
  </div>
</footer>
   



</body>
</html>
