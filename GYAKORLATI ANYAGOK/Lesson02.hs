module Lesson02 where

------------------------------------
-- Fixitás
------------------------------------

{-
Mivel minden függvény használható prefixen és infixen is, megadható nekik egy fixitási deklaráció,
tehát meg lehet adni, hogy egy adott függvény milyen erősséggel milyen irányba kössön.

Ezt úgy lehet megadni, hogy a fájlban, ahol a függvény definíciója található, meg kell adni egy

infix[l/r] <0-9-ig szám> <függvény INFIX jelölése>

formátumú sort.

Pl.
-}
alma :: Integer -> Integer -> Integer
alma x y = 2 * x + y

infixl 7 `alma`

-- Így az "alma" függvényt ha infixen használjuk, akkor az egy balra kötő függvény 7-es erősséggel.

(*+) :: Integer -> Integer -> Integer
x *+ y = 2 * x + y

infixl 7 *+

-- Természetesen operátorokkal ugyanúgy működik.

{-
Létező operátorok/függvények kötési erősségét GHCi-ben a :i <operátor/függvénynév> beírásával lehet megnézni.
Megjegyzés: A :i a :info rövidítése, a :i után bármilyen szimbólum beírható és az összes elérhető információt ki fogja írni róla.

Ha nincs megadva az operátornak/függvénynek fixitása, akkor az alapértelmezetten infixl 9 lesz.
-}

------------------------------------
-- Konvertáló függvények
------------------------------------

{-
Az előző órán kiderítettük, hogy "one + three" nem igazán működik, mert nem típushelyes. Hogy lehet mégis összeadni ezen számokat?
Explicit módon át kell alakítani egyik típusú értéket egy másik típusúra.
-- Explicit == Ki kell írni, nincs más módja.

Számok lényegében pontos átalakítására két függvény alkalmas:
-- fromIntegral :: (Integral a, Num b) => a -> b
-- realToFrac :: (Real a, Fractional b) => a -> b

Egyelőre még nem kell nagyon érteni a betűket, a lényeg, hogy a => előtt látni két megjelenő TÍPUSOSZTÁLYT,
amely megköti az egyes értékekről, hogy mik lehetnek.
Majd az óra végén lesz ezekről az "a"-król és "b"-kről szó.

A fromIntegral-ban látni, hogy valami "a" a paraméter és valami "b" az eredmény, az "a"-ról, mint paraméterről azt tudjuk, hogy valamilyen EGÉSZ szám lehet és ennyi.
Tört nem lehet. Míg az eredményről azt tudjuk megállapítani, hogy tetszőleges számmá át tudja alakítani az egész számot.
Az Integral-ba az Int és az Integer típus tartozik bele (meg még egy pár, ami nem fontos, de ez mindig megnézhető a :i-vel).
A Num-ba az Int, Integer, Double, Float is beletartozik (meg még egy pár, szintén :i segít).

A realToFrac esetén hasonló a helyzet, csak "a"-ról most azt tudjuk, hogy valamilyen "valós" (Haskell világában inkább racionálissá alakítható) számról képez,
és az eredmény valamilyen tört lesz.
A Real-be az Int, Integer, Double, Float is beletartozik.
A Fractional-be pedig a Double és a Float tartozik bele.

Vegyük elő megint a one-t és a three-t.
-}

one :: Int
one = 1

three :: Integer
three = 3

-- Hogyan csináljunk 4-et a one és a three felhasználásával? (one + three) kéne, csak az nem típushelyes.
four :: Integer
four = fromIntegral one + three
-- Mi lesz a típusa a four-nak?

{-
Ellenőrző kérdés, az alábbi átalakítások közül melyiket melyik függvény tudja elvégezni?

Int -> Integer
Integer -> Double
Float -> Double
Double -> Double
Double -> Integer
-}

{-
Nem mindegyik fajta átalakítás veszteségmentes (már az előző esetben is probléma van, ha Integer-ről alakítunk Int-re vagy Double-ről Float-ra),
ha törtről alakítunk egészre, akkor a törtrésszel nem tudunk kezdeni semmit, csak elfelejteni lehet. Épp ezért ezeknek muszáj külön függvényt definiálni,
amelyekkel a törtértékeket kerekíteni tudjuk bizonyos módon egészre.

A RealFrac osztályban a Float és a Double van.

floor :: (RealFrac a, Integral b) => a -> b
A floor függvény egy törtszámot a tőle kisebbegyenlő legnagyobb egész számra kerekíti.
pl. floor 2.5 == 2; floor 4 == 4; floor 6.99 == 6
Mennyi lesz floor (-4.89)?

ceiling :: (RealFrac a, Integral b) => a -> b
A ceiling függvény egy törtszámot a tőle nagyobbegyenlő legkisebb egész számra kerekíti.
pl. ceiling 2.5 == 3; ceiling 3 == 3; ceiling 5.001 == 6
Mennyi lesz ceiling (-3.45)?

truncate :: (RealFrac a, Integral b) => a -> b
A truncate függvény egy törtszámnak elhagyja a törtrészét.
pl. truncate 2.5 == 2; truncate (-2.5) == (-2); truncate 2.99 == 2; truncate 2.0001 == 2; truncate (-2.0001) == (-2)
Mennyi lesz truncate 5?

round :: (RealFrac a, Integral b) => a -> b
"Megszokott" kerekítés, nem pontosan a matematikai, hanem az informatikai.
pl. round 0.25 == 0; round 3.4 == 3; round 3.5 == 4; round (-3.9) == (-4)
Mennyi lesz round 2.5?
-}

----------------------------------------
-- Mintaillesztés
----------------------------------------

{-
A mintaillesztés a funkcionális programozás egyik leghasznosabb, leghasználtabb és leggyakoribb eszköze.

A mintaillesztés lényegében úgy néz ki, hogy amikor a függvényt definiáljuk, akkor a paraméter helyére konkrét értéket írunk és utána definiáljuk,
hogy mi legyen a függvény eredménye.

Vegyük az alábbi példát:

not :: Bool -> Bool

A függvény egy Bool (igaz-hamis) értéket szeretne negálni. Tehát igazra hamisat, hamisra pedig igazat kéne visszaadnia.
Hogyan definiáljuk? Lényegében a kód pontosan ugyanúgy fog kinézni, ahogy az előző mondatban lévő leírás.
-}

not' :: Bool -> Bool
not' True = False
not' False = True

{-
FONTOS! A minta illeszkedésének ellenőrzése FENTRŐL LEFELÉ sorrendben történik.
Mik minősülnek mintának? Lényegében 3 kategóriáról tudunk beszélni mintaként:
-- Konkrét értékek: Ilyen pl. True, False, 0, 1, 2, 'a', 'B', stb.
-- Változók: x, y, z, stb. Egy változó a TÍPUSNAK MEGFELELŐ BÁRMILYEN értékére illeszkedik. Egy adott változó az illesztéskor csak egyszer szerepelhet!
-- Joker: _ , amely azt jelenti, hogy "tudom, hogy ott van egy paraméterem, de annak az értékét nem szeretném használni". Egy függvénydefinícióban több _ is használható az = bal oldalán.

Egy kicsit pontosítsuk azt, hogy mire mintaillesztünk.

A Bool nem egy beépített, beégetett típus a nyelvben (nagyon kevés típus van, ami beégetett), hanem saját általunk definiálható típus, amely az alábbi módon néz ki Haskell-ben:

data Bool = False | True

A saját típusokról fogunk még beszélni részletesebben a 7. óra környékén. Jelen pillanatban elég annyi, hogy a Bool a típus neve,
majd az egyenlőségjel után a típusnak a KONSTRUKTORai szerepelnek, amelyek Bool esetén a False és a True.
A konstruktor egy olyan függvény, amely az adott típus értékét reprezentálja/építi fel.

Mintailleszteni ezekre és csak ezekre lehet Haskell-ben!
(Eltekintve a ténytől, hogy a számok és karakterek mintaillesztése egy csöppet másképp működik a háttérben, de az nem igazán lesz érdekes a tárgy keretében.
Akit jobban érdekel, természetesen utána tud nézni vagy konzultáción lehet róla beszélgetni.)

SZÉP KÓD: Ha tehetjük, akkor mindig illesszünk mintát az összes lehetséges módon egy adott paraméteren, így a kódsorok, az illesztések sorrendje nem fog számítani.
Pl.
Fenti not' függvény:

not' False = True      vs.     not' True  = False
not' True  = False             not' False = True

Ezen két esetben teljesen mindegy, hogy hogyan van a függvény definiálva, ugyanúgy fog viselkedni.

Ezzel szemben:

not' False = True      vs.     not' _     = False
not' _     = False             not' False = True

Hogy viselkedik a bal oldali függvény és hogyan viselkedik a jobb oldali?

A különbség abból adódik, hogy átfedés van az ágak között. Sűrű hibák forrása pedig abból születik, hogy nincsenek az átfedő esetek figyelembe véve.
A _ mintára illeszkedik a True és a False is, míg a False-ra csak a False.
Ha előbb van az a minta, ami több mindenre illeszkedik (általánosabb), akkor a függvény nem úgy fog viselkedni, mint ahogy elsőre gondoljuk.
-}

-- Gyakorlás, ötletelés:
-- Definiáld az (&&&) függvényt mintaillesztéssel, amely a logikai és műveletét végzi el két Bool értéken!

(&&&) :: Bool -> Bool -> Bool
(&&&) True True = True
(&&&) _ _ = False

(|||) :: Bool -> Bool -> Bool
(|||) False False = False
(|||) _ _ = True

{-
Ezen fenti függvényeket sokféleképpen lehet definiálni.
Nézzük meg, hogy mi történik, ha kiértékeljük az alábbiakat ebben a sorrendben:
-- 1 `div` 0
-- 1 `div` 0 == 0
-- 1 `div` 0 == 0 && 1 == 0

Tippelés: Mi fog történni az alábbi esetben?
-- 1 == 0 && 1 `div` 0 == 0

Nézzük meg, hogy a fent definiált függvényekkel mi fog történni!
Definiáljuk az egyik logikai műveletet az "összes értelmes" lehetséges módon és azokkal is nézzük meg, hogy mi történik!
-}

{-
A fentiekből megállapítható, hogy valamikor kivételt kapunk, valamikor nem. Ha jobban odafigyelünk, akkor kideríthető egyértelműen, hogy mely esetekben kapunk kivételt és mikor nem.
Észrevehetjük, hogy ha nem muszáj, akkor Haskell nem értékel ki feleslegesen kifejezéseket. Ezt a kiértékelési stratégiát hívjuk LUSTA kiértékelésnek.

Mohó kiértékelés: Olyan kiértékelési módszer, amely során egy kifejezés minden része kiértékelésre kerül az eredmény kiszámítása előtt.
-- Pl.
-- Legyen f a b = 2 * a + b; g y = y + 2
-- f (g 3) (g 2) levezetése a következő lesz mohó módszerrel:
   f (g 3) (g 2)
 → f (3 + 2) (g 2)
 → f 5 (g 2)
 → f 5 (2 + 2)
 → f 5 4
 → 2 * 5 + 4 → 10 + 4 → 14

Lusta kiértékelés: Olyan kiértékelési módszer, amely során egy kifejezés csak akkor értékelődik ki, ha muszáj.
-- Pl.
-- Legyen f a b = 2 * a + b; g y = y + 2
-- f (g 3) (g 2) levezetése a következő lesz lusta módszerrel:
   f (g 3) (g 2)
 → 2 * g 3 + g 2
 → 2 * (3 + 2) + g 2
 → 2 * 5 + g 2
 → 10 + g 2
 → 10 + (2 + 2)
 → 10 + 4
 → 14

-- Az alábbi példában előjön a lustaság szerepe; ha az alábbi kifejezést mohón értékeljük ki:
   1 == 0 && (3 == 3 && 1 `div` 0 == 1)
 → False && (3 == 3 && 1 `div` 0 == 1)
 → False && (True && 1 `div` 0 == 1)
 → ...               ^^^^^^^^^^^^^^ 0-val való osztás kivétel.

-- Ha azonban lustán értékeljük ki:
   1 == 0 && (3 == 3 && 1 `div` 0 == 1)
 → False && (3 == 3 && 1 `div` 0 == 1)
 → False
A lustaság miatt a kifejezés maradék részére rá se kell nézni, az (&&) definíciója miatt ha tudjuk, hogy az első paraméter False, akkor az eredmény is az mindenképpen.
-}

-- Mintaillesztés más típuson:

-- Definiáld az isZero függvényt mintaillesztéssel, amely egy számról ellenőrzi, hogy 0-e.
isZero :: Integer -> Bool
isZero 0 = True
isZero _ = False

--Definiáld a `singleDigitPrime` függvényt, amely eldönti egy paraméterként kapott egész számról, hogy egy számjegyű prím-e!

oneDigitPrime :: Int -> Bool 
oneDigitPrime 2 = True
oneDigitPrime 3 = True
oneDigitPrime 5 = True
oneDigitPrime 7 = True
oneDigitPrime _ = False

-- Definiáld az isAorB függvényt mintaillesztéssel, amely egy karakterről eldönti, hogy az a nagy A vagy a nagy B-e.
isAorB :: Char -> Bool
isAorB 'A' = True
isAorB 'B' = True
isAorB _ = False

---------------------------------------
-- Rendezett pár (rendezett n-es)
---------------------------------------

-- Legyen egy új típusunk mára, ez legyen a rendezett pár (tuple, pair).
-- Előnye, hogy ha "több értéket kell visszaadni", akkor ezzel meg lehet tenni.
-- Akár több különböző típusú érték is lehet benne.

{-
A rendezett párok típusa az alábbi módon néz ki

data (a,b) = (a,b)

Konstruktor: (,) :: a -> b -> (a,b)
Párok komponenseinek elérése:
fst :: (a,b) -> a; ez a függvény a pár első komponensét adja vissza
snd :: (a,b) -> b; ez a függvény a pár második komponensét adja vissza

FIGYELEM! Az fst és snd CSAK RENDEZETT PÁROKON működik, rendezett 3-ason, 4-esen, stb. nem! (Ahogy a típusa is mondja.)

Rendezett 3-as típusa:
data (a,b,c) = (a,b,c)

Rendezett 4-es típusa:
data (a,b,c,d) = (a,b,c,d)

A többit ez alapján ki lehet találni.

Mintailleszteni természetesen ugyanúgy a konstruktorra lehet, tehát a pár esetén a (,)-re.
                                                                    a 3-as esetén a (,,)-re.
                                                                    stb.

Pl.
sum2 :: (Integer,Integer) -> Integer
sum2 (x,y) = x + y

sum3 :: (Integer,Integer,Integer) -> Integer
sum3 (x,y,z) = x + y + z
-}

-- Feladat:

-- Definiáld az incBoth függvényt, amely egy rendezett pár mindkét elemét megnöveli 1-gyel!
-- Definiáld az fst és snd-vel, illetve definiáld mintaillesztéssel is.

-- Using fst and snd
incBoth :: (Integer,Double) -> (Integer,Double)
incBoth p = (fst p + 1, snd p + 1.0)

-- Using pattern matching
incBoth' :: (Integer,Double) -> (Integer,Double)
incBoth' (x, y) = (x + 1, y + 1.0)

-- Definiáld az isOrigo függvényt, amely meghatározza egy 3 dimenziós Descartes-féle koordináta-rendszerben ábrázolt pontról, hogy az az origó-e.
isOrigo :: (Integer,Integer,Integer) -> Bool
isOrigo (0,0,0) = True
isOrigo _ = False

-- Definiáld az x0 függvényt, amely azt csinálja, hogy ha egy rendezett pár első komponense 0, akkor a másodikhoz hozzáad 1-et,
-- egyébként pedig kivon 1-et a második komponensből.

x0 :: (Integer,Integer) -> (Integer,Integer)
x0 (0, y) = (0, y + 1)
x0 (x, y) = (x, y - 1)

-- SZÉP KÓD: Amikor tehetjük, mindig használjunk mintaillesztést. Sokkal szebb és olvashatóbb. Ez később még inkább igaz lesz, amikor több eszközünk lesz.
--           (Karakterek és számok mintaillesztése macerás, ott nem igazán elvárt azon értékek mintaillesztése. Bármi más viszont jól illeszthető.)

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
