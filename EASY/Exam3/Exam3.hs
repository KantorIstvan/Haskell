module Exam3 where

import Data.List (sort)

-- 1. doubleEvens - Feladat: Páros számok megszorzása
-- Ez a függvény kiválasztja a listából a páros számokat, majd mindegyiket megszorozza 2-vel.
-- A megoldás rekurzívan végigmegy a listán, és minden elemre ellenőrzi, hogy páros-e.
-- Ha igen, akkor megszorozza 2-vel és hozzáadja az eredménylistához, ha nem, akkor kihagyja.
doubleEvens :: [Int] -> [Int]
doubleEvens [] = []
doubleEvens (x:xs)
  | even x = x*2 : doubleEvens xs
  | otherwise = doubleEvens xs

-- 2. wordLengths - Feladat: Szavak hossza
-- Ez a függvény kiszámolja egy szövegben szereplő szavak hosszát.
-- A megoldás karakter-karakterre végigmegy a szövegen. Amíg nem talál szóközt,
-- növeli a számlálót. Amikor szóközt talál, hozzáadja az aktuális számlálót 
-- az eredménylistához, és újraindítja a számlálást a következő szóra.
wordLengths :: String -> [Int]
wordLengths "" = []
wordLengths s = go 0 s
  where
    go n "" = [n]
    go n (c:ss)
      | c == ' ' = n : go 0 ss
      | otherwise = go (n+1) ss

-- 3. splitPosNeg - Feladat: Lista szétválogatása
-- Ez a függvény egy listát két listára bont: az elsőben a pozitív számok, 
-- a másodikban a negatív számok vannak, mindkét lista rendezett.
-- A megoldás listakifejezéseket használ a pozitív és negatív számok kiszűrésére,
-- majd a sort függvénnyel rendezi őket.
splitPosNeg :: [Int] -> ([Int], [Int])
splitPosNeg xs = (sort [x | x <- xs, x > 0], sort [x | x <- xs, x < 0])

-- 4. reverseWords - Feladat: Szöveg visszafordítása
-- Ez a függvény megfordítja a szavak sorrendjét egy szövegben, de a szavakon belül
-- a karakterek sorrendjét nem változtatja meg.
-- A megoldás a words függvénnyel szavakra bontja a szöveget, 
-- a reverse függvénnyel megfordítja a szavak sorrendjét, 
-- majd az unwords függvénnyel újra összerakja őket szóközökkel.
reverseWords :: String -> String
reverseWords "" = ""
reverseWords xs = unwords (reverse (words xs))

-- 5. Book adattípus és getDetailedTitles - Feladat: Könyvtár
-- A Book adattípus két konstruktort definiál:
-- - SimpleBook: cím és szerző tárolására
-- - DetailedBook: cím, szerző és kiadási év tárolására
-- A getDetailedTitles függvény egy könyvlistából kiválogatja azoknak a könyveknek a címét,
-- amelyeknek ismert a kiadási éve (tehát a DetailedBook konstruktorral lettek létrehozva).
-- Listakifejezéssel mintaillesztést végzünk a DetailedBook konstruktorra.
data Book = SimpleBook String String | DetailedBook String String Int

getDetailedTitles :: [Book] -> [String]
getDetailedTitles [] = []
getDetailedTitles xs = [ c | DetailedBook c sz e <- xs]