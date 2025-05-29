module Exam5 where

-- 1. filterThrees - Feladat: Számok szűrése
-- Ez a függvény kiválogatja egy listából azokat a számokat, amelyek oszthatók 3-mal
-- és kisebbek, mint 20.
-- A megoldás listakifejezést használ, amely két feltételt ellenőriz: 
-- a szám osztható-e 3-mal (x `mod` 3 == 0) és kisebb-e, mint 20 (x < 20).
filterThrees :: [Int] -> [Int]
filterThrees [] = []
filterThrees xs = [ x | x <- xs, x `mod` 3 == 0, x < 20]

-- 2. shorten - Feladat: Szöveg rövidítése
-- Ez a függvény egy szöveget kap, és minden szóból csak az első karaktert tartja meg.
-- A megoldás a words függvénnyel szavakra bontja a szöveget,
-- majd a takeHeads segédfüggvény minden szó első betűjét (head) veszi ki.
-- Az eredmény egy olyan szöveg, amely az eredeti szavak kezdőbetűiből áll.
-- Megjegyzés: a kikommentezett sor egy rövidebb megoldást mutat map-pel.
shorten :: String -> String
shorten "" = ""
shorten s =  takeHeads (words s)
  where
    takeHeads [] = []
    takeHeads (x:xs) = head x : takeHeads xs
    {- takeHeads s = map head xs -}

-- 3. maxNumber - Feladat: Lista maximuma
-- Ez a függvény megkeresi a legnagyobb elemet egy számlistában.
-- Ha a lista üres, Nothing-ot ad vissza, egyébként Just-ba csomagolja a maximum értéket.
-- A megoldás a beépített maximum függvényt használja, amely a lista legnagyobb elemét adja vissza.
maxNumber :: [Int] -> Maybe Int
maxNumber [] = Nothing
maxNumber xs = Just (maximum xs)

-- 4. allLong - Feladat: Szöveg ellenőrzése
-- Ez a függvény ellenőrzi, hogy egy szöveg minden szava legalább 3 karakter hosszú-e.
-- Először szavakra bontja a szöveget a words függvénnyel, majd
-- a longEnough segédfüggvény rekurzívan ellenőrzi minden szó hosszát.
-- Ha bármelyik szó rövidebb mint 3 karakter, False-t ad vissza.
allLong :: String -> Bool
allLong "" = True
allLong xs = longEnough (words xs)
  where
    longEnough [] = True
    longEnough (x:xs)
     | length x >= 3 = longEnough xs
     | otherwise = False

-- 5. Event adattípus és totalCost - Feladat: Rendezvények
-- Az Event adattípus két konstruktort definiál:
-- - Concert: név és jegyár tárolására
-- - Lecture: név és ingyenesség jelző tárolására
-- A totalCost függvény kiszámolja az összes rendezvény jegyárainak összegét.
-- A megoldás listakifejezéssel kiválogatja a Concert típusú rendezvények jegyárait,
-- majd összeadja őket a sum függvénnyel.
data Event = Concert String Int | Lecture String Bool

totalCost :: [Event] -> Int
totalCost xs = sum[ x | Concert name x <- xs ]