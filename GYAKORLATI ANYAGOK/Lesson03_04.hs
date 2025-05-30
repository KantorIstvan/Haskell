module Lesson03 where
import Data.Char

-- UGYANAZ A BLOKK, MINT AZ ELŐZŐ ÓRA VÉGÉN:
{-
Korábban lehetett látni, hogy ezen típusokban ugyanúgy szerepelnek "a"-k és "b"-k:
(,) :: a -> b -> (a,b)
fst :: (a,b) -> a
snd :: (a,b) -> b

Ezek típusváltozók; arról lehet felismerni, hogy kisbetűvel van írva, nem naggyal.

Ez a típus így azt jelenti, hogy MINDEN "a" tetszőleges típusra és MINDEN "b" tetszőleges típusra működik a függvény.
Azonos kisbetű azonos típust jelöl. Különböző kisbetű nem feltétlenül jelent különböző típust egy ilyen függvény használatakor.
Pl.
f :: (Integer,Integer) -> Integer
f x = fst x
teljesen hibátlanul működik.

Ha *definiálunk* ilyen függvényt, akkor egy "a" típus teljesen más, mint egy "b" típus.
g :: (a,b) -> a
g (x,y) = y -- Fordítási hiba: Couldn't match expected type ‘a’ with actual type ‘b’

A típus azt mondja, hogy MINDEN ‘a,b’-re működnie kell a függvénynek.
Ha az első komponens egy karakter, a második komponens egy Bool, akkor eredményként karakter kéne, de mi Bool-t adnánk vissza,
nyilvánvalóan nem helyes működés.

-------

Ha belegondolunk, akkor pl. az fst függvény tetszőleges rendezett párral működik:

Mi lesz az alábbiak eredménye?
fst (1.2, True)
fst ('a',2)
fst (True,False)
fst (False,'g')

Megjegyzés: Természetesen a (,) és snd is tetszőleges típushelyes értékekkel működnek.

Megfigyelhető, hogy az fst függvény működése semmilyen módon nem függ attól, hogy milyen típusokat tartalmazó rendezett párt adunk át.
Ezt szokás parametrikus polimorfizmusnak nevezni.

Definíció:
-- Parametrikusan polimorf függvény: Olyan függvény, amely működése független a bemeneti paraméterek típusától.
⟶  Megállapítása a gyakorlatban: A függvény típusában nincs megkötés!

-}

-- Definiáld a fst3, snd3, és thr3 függvényeket rendezett hármasokra, amelyek visszaadják a rendezett hármas megfelelő elemét!

fst3 :: (a, b, c) -> a
--fst3 :: (a, a, a) -> a
fst3 (a, b, c) = a

snd3 :: (a, b, c) -> b
snd3 (x, y, z) = y

thr3 :: (a, b, c) -> c
thr3 (_, _, x) = x

-- Definiáld a swap függvényt, amely megcseréli egy rendezett pár elemeit!

swap :: (a, b) -> (b, a)
swap (x, y) = (y, x)

-- Definiáld a lasts függvényt, amely egy párokat tartalmazó rendezett hármasból kicsomagolja a második elemeket!

lastsOfPairs :: ((a, b), (c, d), (e, f)) -> (b, d, f)
-- lastsOfPairs ((_, b), (_, d), (_, f)) = (b, d, f)
lastsOfPairs (x, y, z) = (snd x, snd y, snd z)
-- lastsOfPairs x

{-

Láttuk az óra elején a konvertáló függvényeket:
fromIntegral :: (Integral a, Num b) => a -> b
realToFrac :: (Real a, Fractional b) => a -> b

Ezek nem működnek mindegyik típussal, illetve különböző típusok esetén mást kell csinálnia a függvénynek.
Pl. fromIntegral-lal lehet Integer-ről Integer-re alakítani, ekkor a függvénynek semmilyen teendője nincs.
    De lehet Integer-ről Double-re is alakítani, ekkor viszont a függvénynek át kell alakítania az egész számot egy lebegőpontos számra, meg kell változtatnia a reprezentációt.
Ezt a viselkedést szokás ad-hoc polimorfizmusnak nevezni.

Definíció:
-- Ad-hoc polimorf függvény: Olyan függvény, amely működése függ a bemeneti paraméterek típusától.
⟶  Megállapítása a gyakorlatban: A függvény típusában van megkötés!

Még több példa:
(+) :: Num a => a -> a -> a
Két Integer-t teljesen másképp kell összeadni, mint két Double-t. (Ez elsőre nem feltétlenül szembetűnő, numerikus módszerek órán fog kiderülni igazán, hogy így van.)

(==) :: Eq a => a -> a -> Bool
Két Integer-t másképp kell összehasonlítani, mint két Bool-t vagy két rendezett párt.

-- HELYES KÓD: Amikor polimorf függvényeket definiálunk, akkor figyeljünk arra, hogy a típus a lehető legáltalánosabb legyen.

               Paraméterek esetén olyan legyen a típus/típusmegkötés, amilyennel mi szeretnénk, hogy a függvény működjön.
               (pl. faktoriálisnak nincs értelme Num-nak lennie, törtszámokra nem igazán tud működni a függvény, jobb, ha a megkötés Integral, mert csak egész számokkal működik.)

               Eredmény esetén MINDIG a legáltalánosabb legyen az eredmény, ne kössük meg a felhasználó kezét teljesen feleslegesen!
               (pl. egy Fibonacci-sorozat soha nem fog törtszámot eredményül adni, ennek ellenére az eredmény Num legyen, a kiszámítása során mást úgyse használunk ki;
               továbbá lehet, hogy a felhasználó később Double-ként szeretné azt az értéket felhasználni.)
-}

-- Hány különböző féleképpen definiálható az alábbi függvény undefined nélkül? (Különböző viselkedések száma az érdekes)
f' :: Integer -> Integer
f' x = 42
--f' _ = 42
--f' x = x + 10
--f' x = x * 10 + 2
-- stb..

-- Hány különböző féleképpen definiálható az alábbi függvény undefined nélkül?
-- Különböző típusú értékeket nem lehet mintailleszteni egy függvényben!
id'' :: a -> a
-- id'' 'a' = 'b'      |
-- id'' 0 = 1          |-> ILYET NEM LEHET!
-- id'' "asd" = "alma" |
id'' x = x

-- Kicsit ellentmondásos lehet, de a tanulság az, hogy minél általánosabb egy függvény típusa, annál egyértelműbb definiálni (ha lehet).

-- Definiáld a sum3 függvényt, amely összeadja egy rendezett pár elemeit!

sum3 :: Num a => (a, a, a) -> a
sum3 (x, y, z) = x + y + z

-- Definiáld a sumPairs függvényt, amely páronként összeadja egy rendezett pár tagjait!

sumPairs :: (Num a, Num b) => (a, b) -> (a, b) -> (a, b)
--sumPairs :: Num a => (a, a) -> (a, a) -> (a, a)
sumPairs (x1, y1) (x2, y2) = (x1 + x2, y1 + y2)

---------------------------------------
-- Listák
---------------------------------------

-- Mai új típus az egyirányú láncolt lista (erről bővebben algoritmusok és adatszerkezetek órán).

{-
data [a] = [] | a : [a]
infixr 5 :

Két konstruktora van:
-- [] :: [a], üres lista
-- (:) :: a -> [a] -> [a], legalább egy elemű lista, a (:) hozzátesz egy elemet a lista elejére.

-- Tehát Haskellben a lista pl. így néz ki:   1 : 2 : 3 : []
-- Szerencsére a Haskell fejlesztők nagyon rendesek és a fenti lista felírható [1,2,3] formában is.
-- 1 : 2 : 3 : [] == [1,2,3]

Csak azonos típusú elemek szerepelhetnek egy listában:
pl. [1,'a',True] nem típushelyes, fordító is szólni fog érte.

Definíció:
-- Homogén adatszerkezet: Az adatszerkezetben csak azonos típusú elemek lehetnek. (pl. lista)
-- Heterogén adatszerkezet: Az adatszerkezetben lehetnek különböző típusú elemek is. (pl. rendezett n-esek)
-}

{-
Eddig nem sok szó esett a String-ekről. A String-ek különböző programozási nyelvekben valamilyen szöveget ábrázolnak.
A szövegek pedig karakterekből állnak. Haskell-ben a String valójában nem más, mint karakterek listája.
Tehát ha azt írom típusba, hogy String vagy azt, hogy [Char], mindkettő teljesen ugyanaz és szabadon felcserélhető.
Típusegyenlőség jelölése a hullámjellel történik, pl. String ~ [Char]
Haskellben a következő módon lehet ezt megadni:
type String = [Char]
Típusszinonimákról még későbbi órákon lesz szó.
-}

-- Feladat:
-- Definiáld a null' függvényt MINTAILLESZTÉSSEL, amely egy listáról ellenőrzi, hogy üres-e.
null' :: [a] -> Bool
null' [] = True
null' _ = False

-- Definiáld a notNull függvényt MINTAILLESZTÉSSEL, amely egy listáról ellenőrzi, hogy nem üres-e.
notNull :: [a] -> Bool
notNull (_:_) = True
notNull _ = False

-- Definiáld a head' függvényt MINTAILLESZTÉSSEL, amely egy listának veszi az első elemét.
-- Mi lesz a típusa?
head' :: [a] -> a
--head' (a:b) = a
head' (a:_) = a

-- Definiáld a tail' függvényt MINTAILLESZTÉSSEL, amely egy listának eldobja az első elemét.
tail' :: [a] -> [a]
tail' (_:xs) = xs

-- Észrevehetjük, hogy a head' és a tail' üres lista esetén csúnyán viselkednek, futási hibát okoznak.
-- Az ilyen függvényeket szokás parciális függvényeknek nevezni.

{-
Definíció:
-- Parciális függvény: Olyan függvény, amely nem működik a bemeneti típus összes lehetséges értékével.
                       (Valamilyen értékre végtelenségig számol vagy futási hibát vált ki.)
                                           ^^^^^^^^^^^^^^^^^^^^
                                           ez később érthető lesz.
pl. head, tail (és még lesz egy pár.)

-- Totális függvény: Olyan függvény, amely a bemeneti típus összes lehetséges értékével működik.
   pl. null, id, (&&), (||), stb.

SZÉP KÓD: A parciális függvények használatát kerüljük el!! Túl egyszerű nem odafigyelni valamilyen esetre és azonnal elrontjuk a teljes programot!
          Használjunk helyette mintaillesztést és kezeljünk le minden esetet! Hagyjuk, hogy a fordító segítsen minket ezzel.
          (Ehhez természetesen olyan típusok is kellenek, így erre még nem minden esetben van lehetőségünk.)
-}

-- Definiáld azt a függvényt, amely egy legalább három elemű lista második elemét elhagyja, minden más esetben az eredeti listát adja vissza!
-- Minta: a:b:c => a, b elemek, c a lista maradéka
remove2nd :: [a] -> [a]
--remove2nd [] = []
--remove2nd (x:[]) = [x] 
--remove2nd (x:y:[]) = [x,y]
remove2nd (x:_:z:xs) = x:z:xs
remove2nd xs = xs
--Érdemes kipróbálni üres, 1 elemű, 2 elemű és 3+ elemű listákra

-- As pattern @ : A mintaillesztés egyes részeinek tudunk nevet adni például az alábbi formában:
alma :: [a] -> [a]
alma (_:_:ys@(_:_:xs)) = ys
-- (_:_:_:_:xs)

dupla :: [a] -> [a]
--dupla (x:xs) = x:x:xs
dupla xs@(x:_) = x:xs

-- Az "alma" függvényben mit tudunk ys-ről? Legalább hány elemű?
-- Legalább hány elemű lista esetén nem lesz probléma az "alma" függvény meghívása?

-- Előnye, hogy ha már van egy kész érték, akkor szegény számítógépnek nem kell szétszednie az összes részt, majd utána újra összetenni az eredményben.
-- Hanem csak felhasználja a már kész listát.

----------------------------------------
-- Lista .. kifejezések (range)
----------------------------------------

-- [1..10] == [1,2,3,4,5,6,7,8,9,10], +1-esével lépked a megadott értékig (inklúzív)
-- [1,3..10] == [1,3,5,7,9], a második és első elem közti különbséggel lépked a megadott értékig. (Ebben a példában ez most +2.)
-- [1..] : 1-től +1-esével lépkedve végtelen lista
-- [2,4..] : 2-től +2-esével lépkedve végtelen lista

-- Nézzük meg, mi történik, ha [10..1]-et próbáljuk kiértékelni. Mi lesz az eredmény?
-- Hogyan tudjuk megoldani, hogy "elvárt" eredményt kapjuk?

-- Megjegyzés: Törtekkel nem igazán érdemes ezt használni, mert nagyon mókás eredményt tudnak produkálni.
-- Pl. [0,0.5..2.75] == [0.0,0.5,1.0,1.5,2.0,2.5,3.0]
--                                               ^^^ ez már a range-en kívül van.

-- Ez működik minden olyan típussal, aminek van Enum példánya, pl. Bool, Char is megy.
-- ['a'..'e'] == "abcde"

-- Ellenőrző/Gondolkodós kérdések:
-- Mik lesznek a következő range-eknek az értékei?
-- E: [(-3)..2] == ?
-- E: [5,10..30] == ?
-- E: [0..(-2)] == ?
-- E: ['b','e'..'p'] == ?

-- G: [0,0..] == ?
-- G: ([1..] :: [Int]) == ?
-- G: [False..] == ?


-- FONTOS! Mivel Haskell-ben természetes dolog a végtelen lista, a feladatokat úgy kell megoldani, hogy azok végtelen listára is menjenek, ez az alapértelmezett elvárás.
--         A feladatban jelölve lesz, ha a listáról feltehető, hogy véges.

----------------------------------------
-- Listagenerátor (List comprehension)
----------------------------------------

-- Lényegében a matematikából ismert halmazkifejezést szeretné utánozni.
-- {x^2 | x ∈ {0,1,2,3,4,5} } == {0,1,4,9,16,25}
-- Ezt Haskell-re egészen egyszerű átfordítani.
squares :: [Integer]
squares = [x^2 | x <- [0..5]]
--         ^^^   ^^^^^^^^^^^
-- Mit csinálunk | Végig megyünk a <- jobb oldalán lévő listán
-- az értékkel   | minden egyes értéken egyenként sorban.
-- egyenként     |

-- Mi a helyzet, ha csak bizonyos elemek kellenek?
-- {x | x ∈ {0,1,2,3}, x páros}
-- Az átfordítás szintén hasonló.
evens :: Integral a => [a] -> [a]
evens xs = [x | x <- xs, even x]
-- A generátorokat, feltételeket egymástól vesszővel választjuk el.
-- Feltételek között a vesszővel való elválasztás logikai ést jelent,
-- tehát minden egyes feltételnek meg kell felelnie egy értéknek, hogy benne legyen az eredményben.
-- Pl. 10-nél kisebb nemnegatív párosok kellenek:
smallEvens :: Integral a => [a]
smallEvens = [x | x <- [0..20], even x, x < 10]
-- Ez természetesen úgy is megoldható, hogy [0,2..8], a bemutatás kedvéért lett megadva a fenti módon.

-- Arra azonban figyelni kell, hogy egy változó csak a generátor után látható a | jobb oldalán
-- pl. az alábbi nem helyes:
-- [x | even x, x <- xs] -- Not in scope 'x`

{-
Természetesen több feltétel és több generátor is megadható, ugyanúgy vesszővel elválasztva.
Nézzük meg, hogy mi lesz az eredménye a [(x,y) | x <- ['a'..'c'], y <- [False,True]] kifejezésnek.

A generátorok mindig balról jobbra sorrendben lépkednek, ez az előző kifejezésből is látszódik.
[(x,y) | x <- ['a'..'c'], y <- [False,True]] == [('a',False),('a',True),('b',False),('b',True),('c',False),('c',True)]
-}

-- Feladatok:

-- A lambdáról: http://lambda.inf.elte.hu/Comprehensions.xml

-- Állítsuk elő a 2 hatványait növekvő sorrendben 1-től 210-ig!
--[2^n | n <- [0..10]]

-- Soroljuk fel az első 10 négyzetszám kétszeresét!
-- [n ^ 2 * 2 | n <- [0..9]] 

-- Állítsunk elő olyan 10 hosszúságú listát, amely váltakozva tartalmazza a False és True értékeket!
-- [even x | x <- [1..10]]
-- [y | _ <- [1..5], y <- [False, True]]

-- Melyik legkisebb 2 hatvány nagyobb, mint 10^20?
-- head [2^n | n <- [1..], 2^n > 10^20 ]



-- Definiáld az add1 függvényt, amely egy lista minden számához hozzáad 1-et.
add1 :: Num a => [a] -> [a]
add1 xs = [ x + 1 | x <- xs] 

-- Definiáld a rep függvényt, amely egy adott elemszámú azonos elemekből álló listát készít.
rep :: Integer -> a -> [a]
rep n x = [ x | _ <- [1..n] ]
-- Az eredeti függvénye a replicate, azonban az historical reasons miatt csak Int-tel működik, nem jó ötlet használni.

-- Definiáld az onlyUpper függvényt, amely egy szövegből csak a nagybetűket tartja meg.
-- Segítség: ÚJ DOLOG kell! Az isUpper függvény egy karakterről megállapítja, hogy nagybetű-e. Ez a függvény azonban a Data.Char nevű modulban található.
-- Importálni csomagokat az "import <csomag>" módon lehet a MODULDEKLARÁCIÓ UTÁN KÖZVETLEN
-- -- Ezen modulban a "module Lesson03 where" után kell rakni az első függvénydefiníció előtt.
onlyUpper :: String -> [Char]
onlyUpper xs = [ x | x <- xs, isUpper x]

-- Nehezebb: Definiáld a concat' függvényt, amely egy listák listáját összefűzi egybe.
concat' :: [[a]] -> [a]
concat' xss = [x | xs <- xss, x <- xs]

{-
A listagenerátorban tudunk ugyanúgy mintailleszteni a <- bal oldalán.
Csak azon elemeket fogja megtartani, amelyekre teljesül az illesztés, a többit eldobja.
-}

-- Definiáld az onlyAs függvényt, amely egy szöveg szavai közül az "a" szavakat tartja meg!
-- words függvény
onlyAs :: String -> [String]
--onlyAs xs = [x | x <- words xs, x == "a"]
--onlyAs xs = ["a" | "a" <- words xs]
onlyAs xs = [x | x@"a" <- words xs]

-- Definiáld a firstIsA függvényt, amely megtartja az összes olyan String-et a listából, amelyek az 'a' karakterrel kezdődnek.
-- Tipp: Definiálható egy segédfüggvény annak az eldöntésére, hogy a szó 'a'-val kezdődik-e
firstIsA :: [String] -> [String]
--firstIsA xs = [ x | x <- xs, startsA x]
--firstIsA xs = [ x | x <- xs, not (null x), head x == 'a']
firstIsA xs = [ x | x@('a':_) <- xs]

startsA :: String -> Bool
startsA ('a':_) = True
startsA _ = False

-- Definiáld az initials függvényt, amely egy név kezdőbetűit adja vissza.
-- words, unwords
initials :: String -> String
initials name = [head w | w <- words name, not (null w)]

-- SZÉP KÓD: Indexelés Haskell-ben sok más nyelvvel ellentétben nem azonnali, hanem lineáris idejű,
--           tehát ha pl. egy lista 10. eleme kell, akkor mind a 10 elemen végig kell menni.
--           Ebből következően listagenerátorban az indexeket SOHA SE generáljuk, mert négyzetes viselkedést kapunk,
--           tehát a 10. elemet 100 lépésben kapjuk meg 10 helyett, ez 90-nel több, mint kéne.

-- SZÉP KÓD: Ahogy a korábbiakban látható volt, a függvények elnevezései a camelCase stílust követik,
--           amely azt jelenti, hogy ha egy függvény több szóból állnak, akkor a szavak határánál
--           a következő szót nagybetűvel kezdjük.

-- snake_case, hyphen-case használata nem szokványos ebben a nyelvben.
