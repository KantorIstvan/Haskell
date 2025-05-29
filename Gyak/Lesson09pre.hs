module Lesson08 where

------------------------------
-- Saját típus: data
------------------------------

-- Hőmérséklet adattípus

{--
Készíts egy új adattípust `Temperature` néven, aminek két konstruktora van `C` és `F`, mindkettő egy-egy `Double`-t vár paraméterként. Kérd az `Eq` és a `Show` típusosztályok automatikus példányosítását! A típusban hőmérsékleti adatokat lehet tárolni Celsius illetve Fahrenheit formátumban. 

Feladat: Átváltás 

Készítsd el a `convertTemp :: Temperature -> Temperature` egy konverziós függvényt, amivel a két reprezentáció között lehet konvertálni.

hőmérséklet Fahrenheitben = 1,8*(hőmérséklet Celsiusban) + 32
--}

data Temperature = C Double | F Double deriving (Eq, Show)

convertTemp :: Temperature -> Temperature
convertTemp (C celsius) = F (1.8 * celsius + 32)
convertTemp (F fahrenheit) = C ((fahrenheit - 32) / 1.8)

instance Num Temperature where
    (C a) + (C b) = C (a + b)
    (F a) + (F b) = F (a + b)
    (F a) + (C b) = C ((a - 32) / 1.8 + b)
    (C a) + (F b) = C (a + (b - 32) / 1.8)
    
    (C a) - (C b) = C (a - b)
    (F a) - (F b) = F (a - b)
    (F a) - (C b) = C ((a - 32) / 1.8 - b)
    (C a) - (F b) = C (a - (b - 32) / 1.8)
    
    (C a) * (C b) = C (a * b)
    (F a) * (F b) = F (a * b)
    (F a) * (C b) = C ((a - 32) / 1.8 * b)
    (C a) * (F b) = C (a * (b - 32) / 1.8)
    
    negate (C a) = C (negate a)
    negate (F a) = F (negate a)
    
    abs (C a) = C (abs a)
    abs (F a) = F (abs a)
    
    signum (C a) = C (signum a)
    signum (F a) = F (signum a)
    
    fromInteger n = C (fromInteger n)

-----------------------------
-- Paraméteres típusok
-----------------------------

-- Motiváció:
{-
Emlékezzünk vissza, hogy léteznek a parciális függvények: head, tail, div, mod, stb.
Továbbá emlékezzünk arra is, hogy a parciális függvények nem működnek minden lehetséges bemeneti értékkel, melynek a következménye, hogy
olyan csúnya értékek átadásakor a program menthetetlenül elszáll (tiszta világban nincs try, nincs catch, nincs semmi, mert a kivétel elkapása nem egy tiszta dolog).

Ezért az ötlet az volna, hogy próbáljuk meg valahogy az előbb említett függvényeket totálissá tenni.
Szerencsére vannak saját típusaink, azokat valahogy megpróbálhatjuk használni.
-}

-- Definiáld a safeHead' függvényt, amely ha van legalább egy elemünk a listában, akkor visszaadja azt, üres lista esetén pedig "semmit" ad vissza.
-- Segítség: Természetesen ezt a "semmit" valahogy reprezentálni kell. Az év elején megbeszéltük, hogy olyan nincs, hogy egy függvény csak csinál valamit,
--           de nincs eredménye. Definiáljunk pl. egy típust, ami Int-et tárol magában és definiáljuk úgy a safeHead'-et.



-- Definiáld a safeHead''-t most Char-ra.



-- Definiáld a safeHead'''-t Bool-ra.



{-
Mi a probléma?
Emlékezzünk vissza a head függvény típusára. head :: [a] -> a
Tetszőleges értékekkel működik, lehet az String, Char, Integer, Float, Bool, másik lista, rendezett pár, stb.
Mindegyikre nem tudunk ezzel a módszerrel típust generálni, hiszen ezekből végtelen van.
Szerencsére meg tudjuk mi is oldani egy típusban, hogy tetszőleges típusokkal működjön.

Ehhez csak annyit kell tenni, hogy a típusnak egy típusváltozót fel kell venni paraméterül.
-}

-- Definiáld a Maybe' típuskonstruktort, amelynek legyen egy típusparamétere.
-- Legyen továbbá két konstruktora, egy Nothing' és egy Just', amelynek a paramétere legyen a felvett típusváltozó.

data Maybe' a = Nothing' | Just' a

-- Megjegyzés, "definíció": Ahogy az (érték)konstruktor egy bizonyos típusú értéket képes létrehozni, úgy a típuskonstruktor egy típust hoz létre.
-- Év elején volt róla szó, hogy a Haskell egy statikusan típusos nyelv. Ez azt jelenti, hogy mindennek van fordítási időben típusa. Még a Maybe'-nek is, meg az összes többi típusnak is.

-- Definiáljuk a `safeHead :: [a] -> Maybe a` függvényt, amely visszaadja egy lista első elemét `Just elem` formában. Ha a lista üres, adjon vissza `Nothing`-ot.

safeHead :: [a] -> Maybe a
safeHead [] = Nothing
safeHead (x:_) = Just x

-- Definiáljuk a `safeDiv :: Double -> Double -> Maybe Double` függvényt, amely megvalósítja a biztonságos osztás műveletét. Ha a második paraméter 0, adjon vissza a függvény `Nothing`-ot, egyébként pedig az osztás eredményét.

safeDiv :: Double -> Double -> Maybe Double
safeDiv _ 0 = Nothing
safeDiv a b = Just (a / b)

-- Definiáld a `safeIndex :: [a] -> Int -> Maybe a` függvényt, ami biztonságos módon adja vissza egy lista n-edik elemét. Ha az index túl kicsi vagy túl nagy az eredmény legyen `Nothing`, különben az eredmény legyen a lista n-edik eleme `Just`-ba csomagolva. Az indexelés kezdődjön 0-tól.

safeIndex :: [a] -> Int -> Maybe a
safeIndex [] _ = Nothing
safeIndex _ i | i < 0 = Nothing
safeIndex (x:_) 0 = Just x
safeIndex (_:xs) i = safeIndex xs (i-1)

{-
Tesztesetek:

safeIndex [] 3 == Nothing
safeIndex [1] 0 == Just 1
safeIndex [1,2,3,4] (-2) == Nothing
safeIndex [1,2,3] 2 == Just 3
safeIndex [1..10] 33 == Nothing
safeIndex "haskell" 4 == Just 'e'
safeIndex [1..] 9 == Just 10 
-}

--Adott egy `Maybe a` értékeket tartalmazó lista. Számold meg, hány `Nothing` szerepel a listában!

countNothings :: [Maybe a] -> Int
countNothings [] = 0
countNothings (Nothing:xs) = 1 + countNothings xs
countNothings (_:xs) = countNothings xs

{-
countNothings [] == 0
countNothings [Just 3, Just 5] == 0
countNothings [Just "Haskell", Just "Clean"] == 0
countNothings [Just "Haskell", Just "Clean", Nothing] == 1
countNothings [Nothing, Just "Haskell", Just "Clean", Nothing] == 2
countNothings [Nothing, Just "Haskell", Nothing, Just "Clean", Nothing] == 3
countNothings [Nothing, Just Nothing, Nothing, Just Nothing, Nothing] == 3
-}

-- Egy `Maybe`-be csomagolt elemet fűzz egy lista elejére! Ha az elem `Nothing`, az eredmény az eredeti lista legyen!

addBefore :: Maybe a -> [a] -> [a]
addBefore Nothing xs = xs
addBefore (Just x) xs = x:xs

{-
addBefore (Just 1) [2,3,4] == [1,2,3,4]
addBefore (Just 'E') "LTE" == "ELTE"
addBefore Nothing [True, False] == [True, False]
-}

-- Definiáld a lookup' függvényt, amely egy adott kulcsú értéket megkeres egy listában. A lista rendezett párokból áll, amelyeknek az első komponensét tekintjük
-- a kulcsnak, a másodikat pedig az értéknek. Előfordulhat, hogy nincs a listában a kulcs, ekkor Nothing legyen az eredmény.

lookup' :: Eq a => a -> [(a, b)] -> Maybe b
lookup' _ [] = Nothing
lookup' key ((k,v):xs) = if key == k then Just v else lookup' key xs

-- Definiáld az elemIndex' függvényt, amely visszaadja az első adott elem indexét egy listából, ha létezik olyan.
-- A típusa legyen minél általánosabb.

elemIndex' :: Eq a => a -> [a] -> Maybe Int
elemIndex' _ [] = Nothing
elemIndex' x (y:ys) 
    | x == y    = Just 0
    | otherwise = case elemIndex' x ys of
                    Nothing -> Nothing
                    Just i  -> Just (i + 1)
-- Megj.: Az eredeti függvény a Data.List-ben van, de csak Int-et ad vissza tetszőleges szám helyett, így a használata nem javallott.
