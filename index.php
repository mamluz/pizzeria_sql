<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pizzeria</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Roboto:wght@100&display=swap');
    </style>
    <link rel="stylesheet" href="./css/style.css">
</head>
<body>
    <div>
    <div>Menu</div>
    <div>
        <form action="zamow.php" method="POST">
        <div>
    <?php
        require("connect.php");

        $conn = new mysqli($host,$user,$passwd,$database);

        // Check connection
        if ($conn->connect_error) {
            die("Connection failed: " . $conn->connect_error);
        } 


        // RODZAJE PIZZY


        // $sql = "SELECT * FROM pizza";
          $sql = "SELECT pizza.nazwa, group_concat(DISTINCT skladniki.nazwa ORDER BY skladniki.nazwa DESC SEPARATOR ', ') AS 'skladniki', pizza.id_pizza, pizza.cena
          FROM pizza
          JOIN pizza_skladniki ON pizza.id_pizza = pizza_skladniki.id_pizza
          JOIN skladniki ON pizza_skladniki.id_skladnika = skladniki.id_skladnika
          WHERE pizza.standard=1
          GROUP by pizza.nazwa
          ORDER by pizza.id_pizza;";
        $result = $conn->query($sql);
        $index = 1;
        
        if ($result->num_rows > 0) {
            // output data of each row
            while($row = $result->fetch_assoc()) {
                echo "<div class='menu-item'><input type='radio' name='pizzaversion' value='" . $row["id_pizza"]. "' required>" . $index . ". " . $row["nazwa"]. "</input><div class='sub-item'>" . $row["skladniki"]. "</div>";
                $sql2 = "SELECT rozmiar, mnoznik FROM rozmiar";
                $result2 = $conn->query($sql2);
                if($result2->num_rows > 0)
                {
                    while($row2 = $result2->fetch_assoc()) {
                        $cena = $row["cena"] * $row2["mnoznik"];
                        echo "<div class='pizza-price'>" . $row2["rozmiar"] . " ".$cena." zł</div>";
                    }
                   
                }
                echo "</div>";
                $index = $index + 1;
            // echo "" . $row["nazwa"] . "";
            }
        } else {
            echo "0 results";
        }
        #$conn->close();
?>
</div>
<div>

    <!--DODATKI-->

    <h3>Dodatki:</h3>
    <?php
          // $sql = "SELECT * FROM pizza";
          $sql = "SELECT * FROM skladniki;";
        $result = $conn->query($sql);
        $index = 1;
        
        if ($result->num_rows > 0) {
            // output data of each row
            while($row = $result->fetch_assoc()) {
              echo "<div class='menu-item'>";
              echo "<fieldset>";
              echo "<input type='checkbox' name='ingredient[".$row["id_skladnika"]."]['single']' value='1'>" . $row["nazwa"]. "</input>";
              echo "<input type='checkbox' name='ingredient[".$row["id_skladnika"]."]['double']' value='2'>" . $row["nazwa"]. " x2</input>";
              echo "</fieldset>";
              echo "</div>";
            // echo "" . $row["nazwa"] . "";
            }
        } else {
            echo "0 results";
        }
    ?>
</div>
<div>

    <!--ROZMIAR-->

    <h3>Wielkość pizzy:</h3>
    <?php
          // $sql = "SELECT * FROM pizza";
          $sql = "SELECT id_rozmiar, rozmiar FROM rozmiar;";
        $result = $conn->query($sql);
        $index = 1;
        
        if ($result->num_rows > 0) {
            // output data of each row
            while($row = $result->fetch_assoc()) {
              echo "<div class='menu-item'><input type='radio' name='pizza_size' value='".$row["id_rozmiar"]."' required>" . $row["rozmiar"]. "</input></div>";
            // echo "" . $row["nazwa"] . "";
            }
        } else {
            echo "0 results";
        }
    ?>
</div>
<div>

    <!--RODZAJ CIASTA-->

    <h3>Rodzaj ciasta:</h3>
    <?php
          // $sql = "SELECT * FROM pizza";
          $sql = "SELECT * FROM ciasto;";
        $result = $conn->query($sql);
        $index = 1;
        
        if ($result->num_rows > 0) {
            // output data of each row
            while($row = $result->fetch_assoc()) {
              echo "<div class='menu-item'><input type='radio' name='pizza_ciasto' value='".$row["id_ciasta"]."' required>" . $row["rodzaj"]. "</input></div>";
            // echo "" . $row["nazwa"] . "";
            }
        } else {
            echo "0 results";
        }
    ?>
</div>
<div>
    <h3>Numer stolika:</h3>
    <select id="table" name="table_number" required>
    <?php
          // $sql = "SELECT * FROM pizza";
          $sql = "SELECT id_stolika, numer_stolika FROM stolik;";
        $result = $conn->query($sql);        
        if ($result->num_rows > 0) {
            // output data of each row
            while($row = $result->fetch_assoc()) {
              echo "<option value='". $row["id_stolika"]. "'>". $row["numer_stolika"]. "<option>";
            // echo "" . $row["nazwa"] . "";
            }
        } else {
            echo "0 results";
        }
    ?>
    </select>
</div>
<div>
    <h3>Dane klienta:</h3>
        <label for="name">Imie:</label><input id="name" name="name" type="name" required></input>
        <label for="surname">Nazwisko:</label><input id="surname" name="surname" type="name" required></input>
</div>
<div>
    <label for="name">Faktura</label><input id="fakt" name="faktura" type="checkbox"></input>
</div>
        
<input type="submit" value="Zamów">
        </form>   
        </div>
    <div>
</body>
</html>