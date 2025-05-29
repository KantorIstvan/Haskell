module Lesson11 where

-- Sok függvény (magasabb rendűek is) hasznos a parciális applikálással, vegyük például az alábbiakat.

-- Definiáld az id' függvényt, amely a paraméterét csak visszaadja eredményül.
id' :: a -> a
id' x = x

-- Definiáld a const' függvényt, amely egy két paraméteres függvény első paraméterét adja vissza eredményül mindig.
const' :: a -> b -> a
const' x _ = x

-- Definiáld a flip' függvényt, amely egy két paraméteres függvényt paramétereit felcseréli!
flip' :: (a -> b -> c) -> b -> a -> c
flip' f b a = f a b

-- Definiáld az iterate' függvényt, amely egy végtelen listát állít elő úgy, hogy folyamatosan alkalmaz egy függvényt egy értéken,
-- és az egyes részeredményeket adjuk vissza a listában.
-- take 10 (iterate' (+1) 0) == [0,1,2,3,4,5,6,7,8,9]
-- take 10 (iterate' not True) == [True,False,True,False,True,False,True,False,True,False]
iterate' :: (a -> a) -> a -> [a]
iterate' f x = x : iterate' f (f x)

-- Definiáld a repeat' függvényt az iterate' felhasználásával!
repeat' :: a -> [a]
repeat' x = iterate' id x

-- Definiáld a ($$) függvényt, amely egy függvényt alkalmaz egy értékre.
infixr 0 $$
($$) :: (a -> b) -> a -> b
f $$ a = f a
-- Az eredeti függvény a ($).

{-
Azt már az év elején megbeszéltük, hogy a prefixen használt függvények kötési erőssége a legerősebb.
Ez a mondat ebben a formában nem teljesen igaz.
Korábban láthattuk, hogy teljesen nyugodtan zárójelezhetek balra egy kifejezést, az nem változtat semmin, pl.
mod 3 2 == (mod 3) 2
Ami valójában itt kiderül, hogy maga a függvényalkalmazás művelete egy legerősebben balra kötő operátor.
Mivel funkcionális programozásban a leggyakoribb művelet a függvényalkalmazás, ezért ez egy láthatatlan operátor, így a lehető legkevesebb karaktert igényli (0 db-ot egészen pontosan).
Azzal, hogy ez az operátor jobbra köt leggyengébben, de ugyanúgy a függvényalkalmazást csinálja, ennek van egy következménye,
még pedig az, hogy a jobbra zárójelezett kifejezésekről elhagyhatom a zárójelet, ha helyette használom a ($)-t.

Példa:
Előző órán volt az add függvény, amely az alábbi módon lett definiálva.

add :: Num a => Maybe a -> Maybe a -> Maybe a
add (Just x) (Just y) = Just (x + y)
add _        _        = Nothing

Látjuk, hogy a Just-os ágon az eredménykifejezés jobbra van zárójelezve. Ez azt jelenti, hogy a zárójelet elhagyhatom (ha kiteszem a ($)-t) azon a ponton,
ahonnan a kifejezés jobbra van zárójelezve, tehát:

add :: Num a => Maybe a -> Maybe a -> Maybe a
add (Just x) (Just y) = Just $ x + y
add _        _        = Nothing

És pontosan ugyanúgy működik.

A másik haszna ennek az operátornak, hogy tudok hivatkozni magára a függvényalkalmazás operátorára (0 karakterrel nehéz bármire is hivatkozni, nincs neve),
így lehet olyan kifejezéseket definiálni, amik például egy adott értéket adnak át egy-egy függvénynek.
-}

-- Definiáld az app2ToFunctions függvényt magasabb rendű függvényeket használva rekurzió nélkül, amely alkalmazza a 2-es értéket egy függvényeket tartalmazó lista minden függvényén.
app2ToFunctions :: Num a => [a -> b] -> [b]
app2ToFunctions fs = map ($ 2) fs

{-
A funkcionális programozás erőssége a függvények komponálhatósága, egymás utáni alkalmazása.
Ehhez azonban szükségünk van magára erre a függvényre, amely két függvényt komponál ezzel létrehozva egy új függvényt.
A definíciója ugyanaz, mint matematikában, analízisben.
-}
(¤) :: (b -> c) -> (a -> b) -> a -> c
(f ¤ g) x = f (g x)
infixr 9 ¤
-- Az eredeti függvény neve (.)

-- Az alábbi feladatokban használjunk függvénykompozíciót!

-- Definiáld azt a függvényt, amely az [1,11,111,1111,11111,...] végtelen listát állítja elő.
numbersMadeOfOnes :: [Integer]
numbersMadeOfOnes = iterate' ((*10) . (+1)) 1

-- Definiáld azt a függvényt, amely a [3,33,333,3333,33333,...] végtelen listát állítja elő.
numbersMadeOfThrees :: [Integer]
numbersMadeOfThrees = iterate' ((*10) . (+3)) 3

-- Definiáld azt a függvényt, amely az [1,31,331,3331,33331,...] végtelen listát állítja elő.
numbersMadeOfThreesAndOne :: [Integer]
numbersMadeOfThreesAndOne = iterate' ((*10) . (+1)) 31

{-
Mivel Haskellben lehetséges a parciális applikálás, lehetséges, hogy a függvényeinket kompozíciókként adjuk meg a paraméterek felvétele nélkül.
pl.

times2plus1 :: Num a => a -> a
times2plus1 x = 2 * x + 1

helyett tudjuk azt, hogy ez a művelet valójában csak két függvény kompozíciójából áll és tudjuk úgy definiálni, hogy:

times2plus1 = (+1) . (2*)
és a két függvény teljesen ugyanaz.

Először a számot meg kell szorozni kettővel, majd utána hozzá kell adni egyet.
A kompozíció matematikai érdekessége, hogy míg mi természetes módon balról jobbra olvasunk, addig a kompozíciókat jobbról balra kell olvasni
annak tekintetében, hogy mit csinál először és mit csinál utána. (Tehát a kompozíció művelete jobbra köt.)

Amikor nem veszünk fel paramétereket és úgy definiálunk függvényeket, azt szokás pointfree stílusnak nevezni.
-- SZÉP KÓD: Addig, amíg nem kell függvénykompozíciókat hegyén hátán használni, próbáljuk meg definiálni a függvényeket minél kevesebb paraméterfelvétellel.
             Meglepően tisztább és olvashatóbb lesz a kód.
Ezt egy példán keresztül megmutatva:
-}
-- Definiáld az any függvényt háromféleképpen. Az any ellenőrzi, hogy egy adott tulajdonságú elem megtalálható-e egy listában.
-- Segítség: Használd az or és a map függvényt a rövid definíció érdekében. Ne használj rekurziót és elágazást.
--           Az or függvény egy listányi Bool-t összevagyol.

-- Vegyük fel az összes paramétert!
any' :: (a -> Bool) -> [a] -> Bool
any' = undefined

-- Csak az első paramétert vegyük fel! (Megj.: Olyan nincs, hogy csak a második paramétert vegyük fel.)
any'' :: (a -> Bool) -> [a] -> Bool
any'' = undefined


-- Feladatok:

-- Definiáld a takeWhile' függvényt, amely egy lista elejéről addig tartja meg az elemeket, amíg egy adott tulajdonság folyamatosan teljesül.
takeWhile' :: (a -> Bool) -> [a] -> [a]
takeWhile' _ [] = []
takeWhile' p (x:xs)
    | p x       = x : takeWhile' p xs
    | otherwise = []

-- Definiáld a dropWhile' függvényt, amely egy lista elejéről addig dobálja el az elemeket, amíg egy adott tulajdonság folyamatosan teljesül.
dropWhile' :: (a -> Bool) -> [a] -> [a]
dropWhile' _ [] = []
dropWhile' p (x:xs)
    | p x       = dropWhile' p xs
    | otherwise = x:xs

-- Definiáld a find' függvényt, amely visszaadja az első adott tulajdonságú elemet egy listából, ha létezik olyan.
find' :: (a -> Bool) -> [a] -> Maybe a
find' _ [] = Nothing
find' p (x:xs)
    | p x       = Just x
    | otherwise = find' p xs
-- Az eredeti függvény a Data.List-ben található.

-- Definiáld az findIndex' függvényt, amely visszaadja az első adott tulajdonságú elem indexét egy listából, ha létezik olyan.
-- Megj.: Ugyan fel lehet használni az előző függvényt erre, de nem célszerű.
findIndex' :: (a -> Bool) -> [a] -> Maybe Int
findIndex' p = findIndex'Helper 0
  where
    findIndex'Helper _ [] = Nothing
    findIndex'Helper i (x:xs)
        | p x       = Just i
        | otherwise = findIndex'Helper (i+1) xs
-- Megj.: Az eredeti függvény a Data.List-ben van, de csak Int-et ad vissza tetszőleges szám helyett, így a használata nem javallott.


-- Definiáljunk egy másik fajta kompozíciót (pipeline), amely megoldja nekünk, hogy balról jobbra olvassunk,
-- tehát lényegében csak cseréljük meg a kompozíció olvasási irányát.
(|>) :: a -> (a -> b) -> b
x |> f = f x

infixl 9 |>
-- Ez a függvény nem létezik, így aki használni szeretné, annak másolgatnia kell a definícióját.

-- Definiáld a dropSpaces függvényt, amely eldobja csak a szóközöket egy szöveg elejéről.
dropSpaces :: String -> String
dropSpaces = dropWhile' (== ' ')

-- Definiáld a trim függvényt, amely eldobja csak a szóközöket egy szöveg elejéről és végéről.
-- Feltehető, hogy a szöveg véges.
trim :: String -> String
trim = dropSpaces . reverse . dropSpaces . reverse

-- Definiáld a maximumOfMinimums függvényt! Adott egy listák listája. Keressük meg a legnagyobb elemet a legkisebbek közül.
-- Feltehető, hogy a lista, továbbá egyetlen eleme sem üres lista.
maximumOfMinimums :: Ord a => [[a]] -> a
maximumOfMinimums = maximum . map minimum

-- Definiáld a mapMap függvényt, amely alkalmaz egy függvényt listák listájában levő elemekre!
mapMap :: (a -> b) -> [[a]] -> [[b]]
mapMap = map . map

-- Adjuk meg egy névnek a kezdőbetűit, azokat szóközökkel elválasztva!
firstLetters :: String -> String
firstLetters = unwords . map (take 1) . words

-- Adjuk meg egy név monogramját! A monogram abban különbözik, hogy pont is van a kezdőbetűk után; minden más része ugyanaz, mint az előző feladatnak!
monogram :: String -> String
monogram = concat . map (\(c:_) -> [c, '.']) . words

