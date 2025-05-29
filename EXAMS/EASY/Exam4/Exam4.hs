module Exam4 where

-- 1. productOverFive - Feladat: Számok szorzata
-- Ez a függvény kiszámolja az 5-nél nagyobb számok szorzatát egy listában.
-- Ha nincs 5-nél nagyobb szám, akkor 1-et ad vissza (a szorzás egységeleme).
-- A megoldás rekurzívan végigmegy a listán, és ha az aktuális elem > 5,
-- akkor beszorzunk vele, egyébként pedig kihagyjuk az elemet a szorzásból.
productOverFive :: [Int] -> Int
productOverFive [] = 1
productOverFive (x:xs)
  | x > 5 = x * productOverFive xs
  | otherwise = productOverFive xs

-- 2. doubleWords - Feladat: Szöveg duplázása
-- Ez a függvény minden szót megdupláz egy szövegben.
-- Először szavakra bontjuk a szöveget a words függvénnyel, majd
-- a double' segédfüggvény minden szót duplán tesz az eredménylistába.
-- Végül az unwords függvénnyel újra összerakjuk a szavakat szóközökkel.
doubleWords :: String -> String
doubleWords "" = ""
doubleWords xs = unwords (double' (words xs))
  where
    double' [] = []
    double' (x:xs) = x : x : double' xs

-- 3. pairSum - Feladat: Lista párosítása
-- Ez a függvény két lista páronkénti összegeit számolja ki.
-- Ha a listák hossza eltér, csak a rövidebb lista végéig számol.
-- A megoldás rekurzívan, egyszerre halad végig a két listán, és
-- minden lépésben összeadja az aktuális elemeket, majd folytatja a rekurziót.
-- Ha bármelyik lista elfogy, üres listát ad vissza.
pairSum :: [Int] -> [Int] -> [Int]
pairSum _ [] = []
pairSum [] _ = []
pairSum (x:xs) (y:ys) = x + y : pairSum xs ys

-- 4. countChar - Feladat: Karakter keresése
-- Ez a függvény megszámolja, hogy egy adott karakter hányszor fordul elő egy szövegben.
-- A megoldás karakterenként halad végig a szövegen, és
-- minden alkalommal, amikor egyezést talál, növeli a számlálót.
countChar :: Char -> String -> Int
countChar _ "" = 0
countChar c (x:xs)
 | c == x = 1 + countChar c xs
 | otherwise = countChar c xs

-- 5. Student adattípus és averageGrade - Feladat: Diákok
-- A Student adattípus két konstruktort definiál:
-- - Graded: névvel és jeggyel rendelkező diák
-- - Ungraded: csak névvel rendelkező diák (nincs jegye)
-- Az averageGrade függvény kiszámolja a diákok jegyeinek átlagát.
-- A megoldás két listakifejezést használ:
-- - Az első a jegyek összegét számolja ki, csak a Graded diákokra
-- - A második megszámolja, hány Graded diák van
-- Majd elosztja a jegyek összegét a Graded diákok számával.
-- Ha nincs Graded diák, 0-t ad vissza.
data Student = Graded String Int | Ungraded String

averageGrade :: [Student] -> Int
averageGrade [] = 0
averageGrade xs
 |isUngradedList xs = 0
 |otherwise = sum[ x | Graded n x <- xs ] `div` length[ x | Graded n x <- xs ]
 where
    isUngradedList [] = True
    isUngradedList (Ungraded _:xs) = isUngradedList xs
    isUngradedList (Graded _ _:_) = False