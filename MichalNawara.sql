-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Czas generowania: 14 Cze 2022, 01:55
-- Wersja serwera: 10.4.22-MariaDB
-- Wersja PHP: 8.1.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Baza danych: `pizzeria`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `ciasto`
--

CREATE TABLE `ciasto` (
  `id_ciasta` int(11) NOT NULL,
  `rodzaj` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `ciasto`
--

INSERT INTO `ciasto` (`id_ciasta`, `rodzaj`) VALUES
(1, 'grube'),
(2, 'cienkie');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `faktura`
--

CREATE TABLE `faktura` (
  `id_faktury` int(11) NOT NULL,
  `id_zamowienia` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `faktura`
--

INSERT INTO `faktura` (`id_faktury`, `id_zamowienia`) VALUES
(11, 28);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `kelner`
--

CREATE TABLE `kelner` (
  `id_kelnera` int(11) NOT NULL,
  `imie` varchar(40) DEFAULT NULL,
  `nazwisko` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `kelner`
--

INSERT INTO `kelner` (`id_kelnera`, `imie`, `nazwisko`) VALUES
(1, 'Jan', 'Kowalski'),
(2, 'Anna', 'Nowak');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `klienci`
--

CREATE TABLE `klienci` (
  `id_klienta` int(11) NOT NULL,
  `imie` varchar(40) DEFAULT NULL,
  `nazwisko` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `klienci`
--

INSERT INTO `klienci` (`id_klienta`, `imie`, `nazwisko`) VALUES
(49, 'ssss', 'dddd'),
(50, 'dawid', 'kokoko');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `pizza`
--

CREATE TABLE `pizza` (
  `id_pizza` int(11) NOT NULL,
  `nazwa` varchar(40) DEFAULT NULL,
  `cena` float DEFAULT NULL,
  `standard` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `pizza`
--

INSERT INTO `pizza` (`id_pizza`, `nazwa`, `cena`, `standard`) VALUES
(1, 'Margherita', 20, 1),
(2, 'Pepperoni', 25, 1),
(3, 'Hawajska', 28, 1),
(4, 'Capricciosa', 30, 1),
(5, 'Diavola', 35, 1),
(6, 'Vesuvio', 28, 1),
(20, 'niestandardowa', 115, 0),
(21, 'niestandardowa', 49, 0),
(22, 'niestandardowa', 115, 0),
(23, 'niestandardowa', 115, 0);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `pizza_skladniki`
--

CREATE TABLE `pizza_skladniki` (
  `id_pizza` int(11) DEFAULT NULL,
  `id_skladnika` int(11) DEFAULT NULL,
  `podwojny` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `pizza_skladniki`
--

INSERT INTO `pizza_skladniki` (`id_pizza`, `id_skladnika`, `podwojny`) VALUES
(2, 14, 0),
(3, 6, 0),
(3, 13, 0),
(4, 6, 0),
(4, 4, 0),
(5, 14, 0),
(5, 15, 0),
(5, 3, 0),
(6, 6, 0),
(1, 1, 0),
(1, 2, 0),
(2, 1, 0),
(2, 2, 0),
(3, 1, 0),
(3, 2, 0),
(4, 1, 0),
(4, 2, 0),
(5, 1, 0),
(5, 2, 0),
(6, 1, 0),
(6, 2, 0),
(23, 14, 0),
(23, 1, 0),
(23, 2, 0),
(23, 1, 0),
(23, 2, 1);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `rozmiar`
--

CREATE TABLE `rozmiar` (
  `id_rozmiar` int(11) NOT NULL,
  `rozmiar` varchar(40) DEFAULT NULL,
  `mnoznik` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `rozmiar`
--

INSERT INTO `rozmiar` (`id_rozmiar`, `rozmiar`, `mnoznik`) VALUES
(1, '30cm', 1),
(2, '45cm', 1.75),
(3, '60cm', 2.5);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `skladniki`
--

CREATE TABLE `skladniki` (
  `id_skladnika` int(11) NOT NULL,
  `nazwa` varchar(40) DEFAULT NULL,
  `cena` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `skladniki`
--

INSERT INTO `skladniki` (`id_skladnika`, `nazwa`, `cena`) VALUES
(1, 'sos pomidorowy', 5),
(2, 'ser mozzarella', 8),
(3, 'cebula', 4),
(4, 'pieczarki', 6),
(5, 'salami', 7),
(6, 'szynka', 6.5),
(7, 'papryka', 8.5),
(8, 'boczek', 8.5),
(9, 'oliwki czarne', 6.5),
(10, 'oliwki zielone', 6.5),
(11, 'kurczak', 7.5),
(12, 'kukurydza', 6),
(13, 'ananas', 8),
(14, 'pepperoni', 7.5),
(15, 'papryczki jalapenio', 7.5),
(16, 'sos pomidorowy', 5),
(17, 'ser mozzarella', 8),
(18, 'cebula', 4),
(19, 'pieczarki', 6),
(20, 'salami', 7),
(21, 'szynka', 6.5),
(22, 'papryka', 8.5),
(23, 'boczek', 8.5),
(24, 'oliwki czarne', 6.5),
(25, 'oliwki zielone', 6.5),
(26, 'kurczak', 7.5),
(27, 'kukurydza', 6),
(28, 'ananas', 8),
(29, 'pepperoni', 7.5),
(30, 'papryczki jalapenio', 7.5);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `stolik`
--

CREATE TABLE `stolik` (
  `id_stolika` int(11) NOT NULL,
  `numer_stolika` int(11) NOT NULL,
  `id_kelnera` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `stolik`
--

INSERT INTO `stolik` (`id_stolika`, `numer_stolika`, `id_kelnera`) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 1),
(4, 4, 2),
(5, 5, 2),
(6, 6, 2);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `zamowienia`
--

CREATE TABLE `zamowienia` (
  `id_zamowienia` int(11) NOT NULL,
  `id_ciasta` int(11) DEFAULT NULL,
  `id_rozmiar` int(11) DEFAULT NULL,
  `id_pizza` int(11) DEFAULT NULL,
  `id_stolika` int(11) DEFAULT NULL,
  `id_klienta` int(11) DEFAULT NULL,
  `wartosc_zamowienia` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `zamowienia`
--

INSERT INTO `zamowienia` (`id_zamowienia`, `id_ciasta`, `id_rozmiar`, `id_pizza`, `id_stolika`, `id_klienta`, `wartosc_zamowienia`) VALUES
(28, 1, 3, 23, 5, 49, 115),
(29, 2, 2, 6, 5, 50, 39.2);

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `ciasto`
--
ALTER TABLE `ciasto`
  ADD PRIMARY KEY (`id_ciasta`);

--
-- Indeksy dla tabeli `faktura`
--
ALTER TABLE `faktura`
  ADD PRIMARY KEY (`id_faktury`),
  ADD KEY `id_zamowienia` (`id_zamowienia`);

--
-- Indeksy dla tabeli `kelner`
--
ALTER TABLE `kelner`
  ADD PRIMARY KEY (`id_kelnera`);

--
-- Indeksy dla tabeli `klienci`
--
ALTER TABLE `klienci`
  ADD PRIMARY KEY (`id_klienta`);

--
-- Indeksy dla tabeli `pizza`
--
ALTER TABLE `pizza`
  ADD PRIMARY KEY (`id_pizza`);

--
-- Indeksy dla tabeli `pizza_skladniki`
--
ALTER TABLE `pizza_skladniki`
  ADD KEY `id_pizza` (`id_pizza`),
  ADD KEY `id_skladnika` (`id_skladnika`);

--
-- Indeksy dla tabeli `rozmiar`
--
ALTER TABLE `rozmiar`
  ADD PRIMARY KEY (`id_rozmiar`);

--
-- Indeksy dla tabeli `skladniki`
--
ALTER TABLE `skladniki`
  ADD PRIMARY KEY (`id_skladnika`);

--
-- Indeksy dla tabeli `stolik`
--
ALTER TABLE `stolik`
  ADD PRIMARY KEY (`id_stolika`),
  ADD KEY `id_kelnera` (`id_kelnera`);

--
-- Indeksy dla tabeli `zamowienia`
--
ALTER TABLE `zamowienia`
  ADD PRIMARY KEY (`id_zamowienia`),
  ADD KEY `id_ciasta` (`id_ciasta`),
  ADD KEY `id_rozmiar` (`id_rozmiar`),
  ADD KEY `id_pizza` (`id_pizza`),
  ADD KEY `id_stolika` (`id_stolika`),
  ADD KEY `id_klienta` (`id_klienta`);

--
-- AUTO_INCREMENT dla zrzuconych tabel
--

--
-- AUTO_INCREMENT dla tabeli `ciasto`
--
ALTER TABLE `ciasto`
  MODIFY `id_ciasta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT dla tabeli `faktura`
--
ALTER TABLE `faktura`
  MODIFY `id_faktury` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT dla tabeli `kelner`
--
ALTER TABLE `kelner`
  MODIFY `id_kelnera` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT dla tabeli `klienci`
--
ALTER TABLE `klienci`
  MODIFY `id_klienta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT dla tabeli `pizza`
--
ALTER TABLE `pizza`
  MODIFY `id_pizza` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT dla tabeli `rozmiar`
--
ALTER TABLE `rozmiar`
  MODIFY `id_rozmiar` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT dla tabeli `skladniki`
--
ALTER TABLE `skladniki`
  MODIFY `id_skladnika` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT dla tabeli `stolik`
--
ALTER TABLE `stolik`
  MODIFY `id_stolika` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT dla tabeli `zamowienia`
--
ALTER TABLE `zamowienia`
  MODIFY `id_zamowienia` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- Ograniczenia dla zrzutów tabel
--

--
-- Ograniczenia dla tabeli `faktura`
--
ALTER TABLE `faktura`
  ADD CONSTRAINT `faktura_ibfk_1` FOREIGN KEY (`id_zamowienia`) REFERENCES `zamowienia` (`id_zamowienia`);

--
-- Ograniczenia dla tabeli `pizza_skladniki`
--
ALTER TABLE `pizza_skladniki`
  ADD CONSTRAINT `pizza_skladniki_ibfk_1` FOREIGN KEY (`id_pizza`) REFERENCES `pizza` (`id_pizza`),
  ADD CONSTRAINT `pizza_skladniki_ibfk_2` FOREIGN KEY (`id_skladnika`) REFERENCES `skladniki` (`id_skladnika`);

--
-- Ograniczenia dla tabeli `stolik`
--
ALTER TABLE `stolik`
  ADD CONSTRAINT `stolik_ibfk_1` FOREIGN KEY (`id_kelnera`) REFERENCES `kelner` (`id_kelnera`);

--
-- Ograniczenia dla tabeli `zamowienia`
--
ALTER TABLE `zamowienia`
  ADD CONSTRAINT `zamowienia_ibfk_1` FOREIGN KEY (`id_ciasta`) REFERENCES `ciasto` (`id_ciasta`),
  ADD CONSTRAINT `zamowienia_ibfk_2` FOREIGN KEY (`id_rozmiar`) REFERENCES `rozmiar` (`id_rozmiar`),
  ADD CONSTRAINT `zamowienia_ibfk_3` FOREIGN KEY (`id_pizza`) REFERENCES `pizza` (`id_pizza`),
  ADD CONSTRAINT `zamowienia_ibfk_4` FOREIGN KEY (`id_stolika`) REFERENCES `stolik` (`id_stolika`),
  ADD CONSTRAINT `zamowienia_ibfk_5` FOREIGN KEY (`id_klienta`) REFERENCES `klienci` (`id_klienta`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
