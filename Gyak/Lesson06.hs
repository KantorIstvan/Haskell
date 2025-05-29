module Lesson06 where

--------------------------------------------------------------------------
-- Lokális definíciók (where és let ... in)
--------------------------------------------------------------------------

{-
Előfordulhat, hogy egy kifejezés többször is megjelenik. Ekkor érdemes azt kiemelni egy külön lokális definícióba,
így az a kifejezés csak egyszer lesz kiszámolva és azt fel lehet használni.

Vegyük az alábbi erőltetett példát.
-}

pl :: Integer -> Integer -> Bool
pl x y = even (x + y) && (x + y) `mod` 3 == 0

{-
Látni, hogy az x + y kétszer is megjelenik.
(Most tekintsünk el attól, hogy ki lehet matekozni, hogy ez a 6-tal osztható összeget vizsgálja.)
Az x + y kifejezést így a számítógép kétszer számolja ki teljesen feleslegesen,
hiszen a nyelv tiszta, az összeadás egy tiszta művelet, "x + y"-t akárhányszor ki lehet számolni, az eredmény mindig ugyanaz lesz.
Emeljük ki, hogy csak egyszer számolja ki és helyette az eredményt használja fel kétszer.
Ezt az alábbi módon lehet megtenni.
-}


---------------- where
pl1 :: Integer -> Integer -> Bool
pl1 x y = even z && z `mod` 3 == 0
  where
    z = x + y
{-
A where egy lokális scope-ot hoz létre, amelyben definiálhatunk függvényeket, konstansokat.
Ebben a blokkban definiáljuk a "z" változót, ami az "x + y"-t jelöli. A példában is látni, hogy a where blokkban a felvett paraméterek látszódnak és használhatók.

Amire vigyázni kell a where-ben, hogy a where blokk MINTAILLESZTÉSENKÉNT működik.
Például az alábbi kód helytelen:

pl2 :: Integer -> Integer
pl2 0 = x      -- Variable not in scope: x
pl2 n = x + n
  where
    x = n + 2

Továbbá figyelni kell rá, hogy a where blokkot bentebb kell kezdeni, nem szabad az első oszlopban.
Haskell-ben játszik az ún. margószabály, ez azt jelenti, hogy a kódblokkokat a kód elhelyezése határozza meg, nem valami más jel (általában '{', '}').
Épp ezért figyelni kell rá, hogy az azonos blokkba tartozó kódok azonos oszlopban kezdődjenek.
Még egy FONTOS dolog, hogy a kódok elhelyezését SZIGORÚAN SZÓKÖZZEL oldjuk meg, kifejezetten nem ajánlott a tabulátor használata, mert a legsűrűbb esetben érthetetlen hibát okoz.
-}

---------------- let ... in
-- Hasonlóképpen működik, mint a where blokk, ugyanúgy lehet függvényeket, konstansokat benne definiálni.

pl3 :: Integer -> Integer -> Bool
pl3 x y = let z = x + y      in even z && z `mod` 3 == 0
{-        ^^^^^^^^^^^^^      ^^
     Létrehozzuk           | Az "in" utáni részen használható
     a lokális definíciót, | a "z" változó is. (Ami eddig is
     most éppen z a neve a | használható volt, az utána is
     változónak.           | használható marad.)

A let ... in forma egy egész kifejezésként működik és akár egymásba is ágyazhatók.
A where-hez képesti különbség az, hogy mivel kifejezésként működik, ez egyértelműen meghatározza, hogy mi a lokális scope,
abból nem szabadul ki semmi sehova.
-}

pl4 :: Integer -> Integer
pl4 x = (let z = x + 1 in z + z) + (let y = 3 in y + x)
{-                                 ^^^^^^^^^^^^^^^^^^^^
                                   Itt nem használható a "z" változó,
                                   fordítási hibát kapnánk: "Variable not in scope: z"
-}

-- Mind a where-ben, mint a let ... in-ben lehet mintailleszteni, melyet az alábbi példa szemléltet.
pl5 :: (Integer,Integer) -> Integer
pl5 x = y + z
  where
    (y,z) = x

pl5' :: (Integer,Integer) -> Integer
pl5' x = let (y,z) = x in y + z

-- előző óráról
-- Feladat:
-- Számozzuk meg egy szövegnek az egyes szavait 1-től kezdve. Az eredmény legyen egy rendezett párokból álló lista, az első komponens a szó száma, a második maga a szó.
-- words, zip
numberWords :: String -> [(Integer, String)]
numberWords xs = zip [1..] (words xs)

-- Feladatok:
-- Definiáljuk újra a numberWords függvényt egy általánosabb típussal.
-- Segítség: A where/let-in arra kell, hogy egy lokális függvényt definiáljunk (lehetne publikus is ez a függvény).
--           Lényegében repeat jellegű dolgot kell művelni a segédfüggvényben, de mivel megszámozni szeretnénk a szavakat,
--           a számokat valahogy növelni is kell.
numberWords' :: Num a => String -> [(a, String)]
numberWords' xs = numberHelper 1 (words xs)
 where
    numberHelper _ [] = []
    numberHelper n (x:xs) = (n, x) : numberHelper (n + 1) xs

-- Definiáld az intersperse' függvényt, amely egy adott elemet beszúr minden elem közé.
-- intersperse' 0 [1,2,3] == [1,0,2,0,3]
-- intersperse' 'a' [] == []
-- intersperse' 'a' "b" == "b"
-- intersperse' 'a' "bb" == "bab"
-- intersperse' True [False,False,False,True] == [False,True,False,True,False,True,True]

-- Segítség: a where vagy let-in itt arra fog kelleni, hogy jól tudjuk az elemet beszúrni az elemek közé.
--           Ez azt jelenti, hogy fel kell ismerni, hogy a függvény működése két állapotból áll.
--           (Vagy egy lépésből átmegyünk a másikba és a végéig rekurzív; vagy az elején rekurzív, kivéve a legutolsó lépést.)
intersperse' :: a -> [a] -> [a]
intersperse' _ [] = []
intersperse' e (x:xs) = x : interHelper xs where
    interHelper [] = []
    interHelper (x:xs) = e : x : interHelper xs

-- Definiáld a showList' függvényt, amely egy listát szépen megjelenít; lényegében ahogy ki kéne írnia a ghci-be.
-- showList' [1,2,3] == "[1,2,3]"
-- showList' [] == "[]"
-- showList' [True] == "[True]"

-- Segítség: A where/let-in itt arra kell, hogy két alapesetet különböztessünk meg, lényegében hasonló az intersperse-hez.
showList' :: Show a => [a] -> String
showList' [] = "[]"
showList' (x:xs) = "[" ++ show x ++ showHelper xs where
    showHelper [] = "]"
    showHelper (x:xs) = "," ++ show x ++ showHelper xs

-- Definiáld az unzip' függvényt, amely egy párok listáját szétszed listák párjává úgy,
-- hogy a rendezett párok első fele az eredmény pár első listája lesz, a rendezett párok második fele
-- az eredmény pár második listája lesz.
-- unzip' [(0,'0'),(1,'1'),(2,'2')] == ([0,1,2],"012")
-- unzip' [] == ([],[])
-- unzip' [(3,0),(4,1),(0,2),(9,9),(8,10)] == ([3,4,0,9,8],[0,1,2,9,10])

-- Segítség: Most a where/let-in mintaillesztésre fog kelleni.
unzip' :: [(a, b)] -> ([a], [b])
unzip' xs = (map fst xs, map snd xs)
-- Alternatively, with explicit recursion and where clause:
-- unzip' [] = ([], [])
-- unzip' ((a, b):xs) = (a:as, b:bs)
--   where
--     (as, bs) = unzip' xs

---------------------------------------
-- Gyűjtögető rekurzió
---------------------------------------

-- Definiáld a reverse' függvényt, amely megfordítja egy lista elemeinek sorrendjét.
-- A listáról feltehető, hogy véges.
-- Segítség: A where/let-in arra kell, hogy egy olyan segédfüggvényt definiáljunk, ami egy paraméterben akkumulálja, gyűjtögeti az elemeket, a részeredményt tartalmazza.
reverse' :: [a] -> [a]
reverse' xs = revHelper xs [] where
    revHelper [] ys = ys
    revHelper (x:xs) ys = revHelper xs (x:ys)

{-
Észrevételek:
-- Végtelen listára NEM MŰKÖDIK!!!
-- 4 különböző fajta rekurzió lehetséges így.
-- A végeredmény kifejezés zárójelezése attól függ, hogy hol van a rekurzió vagy épp milyen fajta rekurziónk van.
   pl.
   sum [] = 0
   sum (x:xs) = x + sum xs

   sum [1,2,3] =
   1 + sum [2,3] =
   1 + (2 + sum [3]) =
   1 + (2 + (3 + sum [])) =
   1 + (2 + (3 + 0))
   -----------------------------------------
   sum [] = 0
   sum (x:xs) = sum xs + x

   sum [1,2,3] =
   sum [2,3] + 1 =
   (sum [3] + 2) + 1 =
   ((sum [] + 3) + 2) + 1 =
   ((0 + 3) + 2) + 1
   -----------------------------------------
   sum xs = sumAcc 0 xs where
    sumAcc acc [] = acc
    sumAcc acc (x:xs) = sumAcc (acc + x) xs

   sum [1,2,3] = sumAcc 0 [1,2,3] =
   sumAcc (0 + 1) [2,3] =
   sumAcc ((0 + 1) + 2) [3] =
   sumAcc (((0 + 1) + 2) + 3) [] =
   ((0 + 1) + 2) + 3
   -----------------------------------------
   sum xs = sumAcc 0 xs where
    sumAcc acc [] = acc
    sumAcc acc (x:xs) = sumAcc (x + acc) xs

   sum [1,2,3] = sumAcc 0 [1,2,3] =
   sumAcc (1 + 0) [2,3] =
   sumAcc (2 + (1 + 0)) [3] =
   sumAcc (3 + (2 + (1 + 0))) [] =
   3 + (2 + (1 + 0))

Ha olyan a függvény, hogy a paraméterek típusai különböznek, akkor ezen 4 fajta rekurzióból 2 használható értelmesen.
-}

---------------------------------------
-- Elágazások
---------------------------------------

{-
Az elágazás a programozás egyik hasznos eszköze, ha valamitől függ, hogy mit szeretnénk, hogy a kód csináljon.

Haskell-ben az elágazás szintaxisa hasonlít a matematikában használatosra.
Matek:
       { x * 2,     ha x páratlan és x ≥ 10
f(x) = { x * 3 + 1, ha x < 10
       { x * 5,     egyébként
       ^
 Nagy kapcsos szeretne lenni.

Haskell-ben a szintaxis úgy néz ki, hogy a nagy kapcsos zárójelet lecseréljük a 'pipe' (|, AltGr+w) karakterre.
FONTOS! Az ágakat szóközzel bentebb húzva kell kezdeni, itt is játszik a margószabály.
Továbbá a matematikához képesti különbség, hogy először van az elágazás, a feltételek, utána jön csak az egyenlőségjel és hogy mit adjunk vissza eredményként.
Az elágazások feltételei Bool típusú kifejezéseket fogadnak el. Az elágazások vizsgálata szintén fentről lefelé történik, mint ahogy a mintaillesztés is.
Az első olyan ág fog lefutni, ahol a feltétel True-ra értékelődik ki. Ugyanúgy, ahogy a mintaillesztésnél is, ha nincs olyan feltétel, ami True-ra értékelődne ki,
akkor egy Non-exhaustive pattern kivétellel elszáll a program futás időben. A kettő együtt kombinálható, ld. lentebbi feladat (f függvény).

Lássuk az alábbi példát, javítsuk ki a korábban látott faktoriális függvényt legalább annyira, hogy totális függvény legyen.
-}

fact :: Integer -> Integer
fact n
  -- Ha n ≤ 0, akkor az eredmény legyen 1; 0! = 1, a többi negatív szám meg nem izgat minket, most az összes negatívra 1 az eredmény.
  | n <= 0    = 1
  -- Egyébként n! = n * (n - 1)!
  | otherwise = n * fact (n - 1)

{-
Megjelenik a definícióban egy új dolog, az otherwise.
Az otherwise nem kulcsszó; pontosan ugyanolyan függvény, mint a többi.

otherwise :: Bool
otherwise = True
-}

{-
SZÉP KÓD: Néhányan már felfedezhették, hogy Haskell-ben van if-then-else konstrukció. Ezt a tárgy keretein belül SZIGORÚAN TILOS használni.
          Szokjuk meg a rendes elágazást. Ha valaki háziban használja, annak el lesz utasítva a megoldása kérdés nélkül.

SZÉP KÓD: Ugyan az otherwise-ot magát lehetne helyettesíteni a True-val, olvashatóság miatt azonban használjuk az otherwise-ot.

SZÉP KÓD: Elágazás feltételben == True-t és == False-ot SZIGORÚAN TILOS HASZNÁLNI! Eleve egy Bool kifejezés van ott, ha az == True vagy == False kéne.

SZÉP KÓD: Ha egy függvény eredménye Bool típusú érték lenne (pl. elem függvény), akkor elágazást felesleges és TILOS használni! Ott vannak a logikai műveletek,
          tessék azokat használni.
-}

-- Adott az alábbi függvény:
f :: [Integer] -> Integer
f [2,4,6,x]
    | x > 10 = 0
    | x < 0  = 1
f [x,y]
    | x + y > 10 = x * y
    | x - y < 10 = 2
f (x:xs)
    | x > 0 || x < 0 = f xs
f [] = -100
-- GHCi-ben való futtatás nélkül az alábbi kifejezéseknek mi lesz az eredményük?
-- f [2,4,6,11] == ?
-- f [2,4,6,-8] == ?
-- f [2,4,6,8] == ?
-- f [1,2,4,6,11] == ?
-- f [1,2,3,4] == ?
-- f [-3,-2,9] == ?
-- f [0,11] == ?
-- f [0,11,15,-2] == ?
-- f [2] == ?
-- f [0] == ?

-- Ezen f függvény parciális vagy totális?

-- Feladatok:
-- Definiáld a take' függvényt, amely adott darabszámú elemet megtart egy lista elejéről.
-- Ha több elemet kéne megtartani, mint amennyi van, akkor tartsuk meg az összeset.
-- Ha a szám negatív, kezeljük úgy, mintha 0 lenne.
-- Mi lesz a függvény legáltalánosabb típusa?
take' :: (Num a, Ord a) => a -> [b] -> [b]
take' _ [] = []
take' n (x:xs)
    | n <= 0 = []
    | otherwise = x : take' (n - 1) xs
-- Az eredeti függvény a genericTake.
-- A ' nélküli nevű függvény csak Int-ekkel működik!

{-
SZÉP KÓD: Ha egy mintaillesztésen belül csak egy feltétel van, egy ág van,
          akkor azt egy sorba szokás írni a mintával. Ellenkező esetben új sorban szokás kezdeni az elágazást.
          Új sorban kezdeni azonban sosem probléma, létezik az a stílus is.
-}

-- Definiáld a drop' függvényt, amely adott darabszámú elemet eldob egy lista elejéről.
-- Ha több elemet kéne eldobni, mint amennyi van, akkor dobjuk el az összeset.
-- Ha a szám negatív, kezeljük úgy, mintha 0 lenne.
-- Mi lesz a függvény legáltalánosabb típusa?
drop' :: (Num a, Ord a) => a -> [b] -> [b]
drop' _ [] = []
drop' n xs
    | n <= 0 = xs
drop' n (_:xs) = drop' (n - 1) xs
-- Az eredeti függvény a genericDrop.
-- A ' nélküli nevű függvény csak Int-ekkel működik!

-- Definiáld a splitAt' függvényt, amely egy adott pozíción kettéválaszt egy listát.
-- Az eredmény egy rendezett pár lesz, az első komponense annyi elemű lista, amennyi a szám volt,
-- a második komponens pedig a fennmaradó lista.
-- Ha a pozíció negatív, akkor a lista előtt akarnánk bontani, tehát előtte üres lista van, utána meg az egész lista.
-- Ha a pozíció nagyobb, mint ahány elemünk van, akkor utána akarnánk bontani, tehát előtte van a teljes lista, utána meg semmi.
-- Mi lesz a függvény legáltalánosabb típusa?
-- splitAt' 0 [1,2,3] == ([],[1,2,3])
-- splitAt' 1 [1,2,3] == ([1],[2,3])
-- splitAt' 2 [1,2,3] == ([1,2],[3])
-- splitAt' 3 [1,2,3] == ([1,2,3],[])
splitAt' :: (Num a, Ord a) => a -> [b] -> ([b], [b])
splitAt' n xs
    | n <= 0 = ([], xs)
splitAt' _ [] = ([], [])
splitAt' n (x:xs) = (x:ys, zs)
  where
    (ys, zs) = splitAt' (n - 1) xs
-- Az eredeti függvény a genericSplitAt.
-- A ' nélküli nevű függvény csak Int-ekkel működik!

-- Definiáld az insertAt függvényt, amely egy adott pozícióra beszúr egy elemet egy listába.
-- Ha az index negatív, akkor kezeljük úgy, mintha 0 lenne.
-- Ha az index nagyobb, mint ahány elemű a lista, akkor az utolsó helyre szúrjuk be az elemet.
-- insertAt (-2) 'a' "lma" == "alma"
-- insertAt 0 'a' "lma" == "alma"
-- insertAt 2 'b' "lma" == "lmba"
-- insertAt 10 'b' "lma" == "lmab"
insertAt :: (Num a, Ord a) => a -> b -> [b] -> [b]
insertAt n x xs
    | n <= 0 = x:xs
insertAt _ x [] = [x]
insertAt n x (y:ys) = y : insertAt (n - 1) x ys
-- Megj.: Nincs insertAt függvény a Data.List-ben, ezért nincs is aposztróffal ellátva a neve.

-- Definiáld a replicate' függvényt, amely adott darabszámú azonos elemet generál.
-- Ha a szám negatív, azt kezeljük úgy, mintha 0 lenne.
-- Mi lesz a függvény legáltalánosabb típusa?
replicate' :: (Num a, Ord a) => a -> b -> [b]
replicate' n x
    | n <= 0 = []
    | otherwise = x : replicate' (n - 1) x
-- Az eredeti függvény a genericReplicate.
-- A ' nélküli nevű függvény csak Int-ekkel működik!
