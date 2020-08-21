<html>
    <head>
            <title>DBhw3</title>
    </head>
    <body>
    <?php      
    $user = 'root'; //資料庫使用者名稱  
    $password = '27871139'; //資料庫的密碼    
    $db = new mysqli("localhost",$user, $password,"FunCore");      
    if ($db -> connect_errno) {
  echo "Failed to connect to MySQL: " . $db -> connect_error;
  exit();
}    
        ?> 
    </body>
</html>
