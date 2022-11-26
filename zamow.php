<html>
<body>
<?php
    require("connect.php");

    $conn = new mysqli($host,$user,$passwd,$database);

    // Check connection
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    } 

    $id_pizza = $_POST["pizzaversion"];
    $id_ciasta = $_POST["pizza_ciasto"];
    $id_rozmiar = $_POST["pizza_size"];
    $id_stolika = $_POST["table_number"];
    $name = $_POST["name"];
    $surname = $_POST["surname"];

    $sql = "INSERT INTO klienci (imie, nazwisko) VALUES ('$name', '$surname');";
    $result = $conn->query($sql);

    $sql = "SELECT id_klienta FROM klienci ORDER BY id_klienta DESC LIMIT 1;";
    $result = $conn->query($sql);
    $row = mysqli_fetch_array($result);
    $id_klienta = $row[0];

    $sql = "SELECT mnoznik FROM rozmiar WHERE id_rozmiar=$id_rozmiar";
    $result = $conn->query($sql);
    $row = mysqli_fetch_array($result);
    $mnoznik = $row[0];

    $sql = "SELECT cena FROM pizza WHERE id_pizza=$id_pizza";
    $result = $conn->query($sql);
    $row = mysqli_fetch_array($result);
    $cena = $row[0];

    // PIZZA STANDARDOWA

    if(!isset($_POST['ingredient']))
    {

        $wartosc_zamowienia = 0.8 * $cena * $mnoznik;

        // sprawdzanie czy pizza jest standardowa
        // $sql = "SELECT standard FROM pizza WHERE id_pizza=$id_pizza";
        // $result = $conn->query($sql);
        // $row = mysqli_fetch_array($result);
        // $standard = $row[0];
        // if($standard == 1)
        // {
        //     $wartosc_zamowienia = 0.8 * $cena * $mnoznik;
        // }else{
        //     $wartosc_zamowienia = $cena;
        // }
        

        $sql = "INSERT INTO zamowienia (id_ciasta, id_rozmiar, id_pizza, id_stolika, id_klienta, wartosc_zamowienia) VALUES ('$id_ciasta', '$id_rozmiar', '$id_pizza', '$id_stolika', '$id_klienta', '$wartosc_zamowienia');";
        $result = $conn->query($sql);

    }

    // PIZZA NIESTANDARDOWA

    else{
        $ingredients = $_POST['ingredient'];

        $sql = "SELECT id_skladnika, cena FROM skladniki;";
        $result = $conn->query($sql);
        $wartosc_dodatkow = 0;
        if ($result->num_rows > 0) {
            while($row = $result->fetch_assoc()) {
             
                foreach($ingredients as $key=>$value){
                    if($key == $row['id_skladnika'])
                    {
                        if($value == 1)
                        {
                            $wartosc_dodatkow += $row['cena'] * $mnoznik * 1;
                        }else{
                            $wartosc_dodatkow += $row['cena'] * $mnoznik * 2;
                        }
                    }
                }
        }
    }

    $wartosc_zamowienia = $wartosc_dodatkow + ($cena * $mnoznik);

    $sql = "INSERT INTO pizza (nazwa, cena, standard) VALUES ('niestandardowa', '$wartosc_zamowienia', 0);";
    $result = $conn->query($sql);

    $id_pizzy_bazowej = (int)$id_pizza; // zapisujemy id pizzy na bazie ktorej powstala niestandardowa

    // nadpisujemy id_pizza na nowej pizzy niestandardowej
    $sql = "SELECT id_pizza FROM pizza ORDER BY id_pizza DESC LIMIT 1;";
    $result = $conn->query($sql);
    $row = mysqli_fetch_array($result);
    $id_pizza = (int)$row[0];

    // dodajemy skladniki z pizzy_bazowej dla nowej pizzy niestandardowej do tabeli pizza_skladniki
    $sql = "SELECT id_skladnika FROM pizza_skladniki WHERE id_pizza=$id_pizzy_bazowej;";
    $result = $conn->query($sql);
    if ($result->num_rows > 0) {
        while($row = $result->fetch_assoc()) {
            $wiersz = (int)$row['id_skladnika'];
            $sql2 = "INSERT INTO pizza_skladniki (id_pizza, id_skladnika, podwojny) VALUES ('$id_pizza', '$wiersz', 0);";
            $result2 = $conn->query($sql2);
    }
}

    // dodajemy dodatki dodane do pizzy bazowej
    foreach($ingredients as $key=>$value){
        $sql = "SELECT id_skladnika FROM skladniki;";
        $result = $conn->query($sql);
        while($row = $result->fetch_assoc()) {
            if($key == (int)$row['id_skladnika'])
            {
                $wiersz = $row['id_skladnika'];
                if($value == 1)
                {
                    $sql2 = "INSERT INTO pizza_skladniki (id_pizza, id_skladnika, podwojny) VALUES ('$id_pizza', '$wiersz', 0);";
                    $result2 = $conn->query($sql2);
                }else{
                    $sql2 = "INSERT INTO pizza_skladniki (id_pizza, id_skladnika, podwojny) VALUES ('$id_pizza', '$wiersz', 1);";
                    $result2 = $conn->query($sql2);
                }
            }
        }
    }

    $sql = "INSERT INTO zamowienia (id_ciasta, id_rozmiar, id_pizza, id_stolika, id_klienta, wartosc_zamowienia) VALUES ('$id_ciasta', '$id_rozmiar', '$id_pizza', '$id_stolika', '$id_klienta', '$wartosc_zamowienia');";
    $result = $conn->query($sql);
}

    $sql = "SELECT id_zamowienia FROM zamowienia ORDER BY id_zamowienia DESC LIMIT 1;";
    $result = $conn->query($sql);
    $row = mysqli_fetch_array($result);
    $id_zamowienia = $row[0];
    if(isset($_POST['faktura']))
    {
        $sql = "INSERT INTO faktura (id_zamowienia) VALUES ('$id_zamowienia');";
        $result = $conn->query($sql);
    }

    echo "Przyjęto zamówienie!!!<br/>";

    $sql = "SELECT nazwa FROM pizza WHERE id_pizza='$id_pizza';";
    $result = $conn->query($sql);
    $row = mysqli_fetch_array($result);
    $nazwa_pizzy = $row[0];
    echo "Nazwa pizzy: ".$nazwa_pizzy."<br/>";


    $sql = "SELECT group_concat(skladniki.nazwa ORDER BY skladniki.nazwa DESC SEPARATOR ', ') AS 'skladniki', pizza.id_pizza FROM pizza JOIN pizza_skladniki ON pizza.id_pizza = pizza_skladniki.id_pizza JOIN skladniki ON pizza_skladniki.id_skladnika = skladniki.id_skladnika WHERE pizza.id_pizza='$id_pizza'";
    $result = $conn->query($sql);
    while($row = $result->fetch_assoc()) {
        echo "Składniki: ";
        echo $row['skladniki']."<br/>";
    }

    $sql = "SELECT rozmiar FROM rozmiar WHERE id_rozmiar='$id_rozmiar';";
    $result = $conn->query($sql);
    $row = mysqli_fetch_array($result);
    $rozmiar = $row[0];
    echo "Rozmiar: ".$rozmiar."<br/>";

    $sql = "SELECT rodzaj FROM ciasto WHERE id_ciasta='$id_ciasta';";
    $result = $conn->query($sql);
    $row = mysqli_fetch_array($result);
    $rodzaj = $row[0];
    echo "Ciasto: ".$rodzaj."<br/>";

    $sql = "SELECT numer_stolika FROM stolik WHERE id_stolika='$id_stolika';";
    $result = $conn->query($sql);
    $row = mysqli_fetch_array($result);
    $stolik = $row[0];
    echo "Numer stolika: ".$stolik."<br/>";

    $sql = "SELECT id_kelnera FROM stolik WHERE id_stolika='$id_stolika';";
    $result = $conn->query($sql);
    $row = mysqli_fetch_array($result);
    $id_kelnera = $row[0];
    $sql = "SELECT imie, nazwisko FROM kelner WHERE id_kelnera='$id_kelnera';";
    $result = $conn->query($sql);
    $row = mysqli_fetch_array($result);
    $kelner_name = $row[0];
    $kelner_surname = $row[1];
    echo "Kelner obsługujący: ".$kelner_name." ".$kelner_surname."<br/>";
    echo "Zaawiający: ".$name." ".$surname."<br/>";
    echo "Wartosc zamowienia: ".$wartosc_zamowienia." PLN<br/>";



    // $sql = "SELECT * FROM skladniki;";
    // $result = $conn->query($sql);
    
    // if ($result->num_rows > 0) {
    //     while($row = $result->fetch_assoc()) {

    //         if (isset($_POST['id_skladnika']['single']])) {
    //             echo "pojedynczy ".$row['id_skladnika']['single'];
    //         } elseif(isset($_POST[$row['id_skladnika']['double']])){
    //             echo "podwojny ".$row['id_skladnika']['double'];
    //         }
    //     }
    // } else {
    //     echo "0 results";
    // }   
    
?>

</body>
</html>