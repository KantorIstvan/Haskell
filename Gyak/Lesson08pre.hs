module Lesson08 where

-------------------------
-- Típusszinonimák
-------------------------

{-
Az első, amivel említés szintjén találkoztunk az az, hogy tudjuk, hogy Haskellben a String nem más, mint [Char].

Típusszinonimák szintaxisa az alábbiként néz ki Haskellben:

type <Típusnév> [típusparaméterek...] = <Létező típus>

pl. a String-et, ahogy korábban is láttuk, az alábbi módon lehet definiálni:
type String = [Char]

A típusszinonimák semmiben sem különböznek azon típusoktól, amelyekre a szinonima definiálva lett,
teljesen szabadon felcserélhetőek.
-}

-- Feladatok:
-- Definiáld a Point típusszinonimát, amely jelöljön egy Integer-ekből álló rendezett párt.


-- Definiáld a moveX függvényt, amely egy pontot az X-tengely mentén eltol egy adott értékkel.
-- Használjuk az előbb definiált Point típust.
moveX :: undefined
moveX = undefined

{-
Mire is jó a típusszinonima, ha teljesen ugyanúgy viselkedik, mint az eredeti típus, amire a szinonimát készítettük?
Nézzük az alábbi példát:
-}
person :: (String,String,String,String,Int)
{-
Mi szeretne lenni az a sok String? Mint programozók, egy-két ötletünk lehet, pl. illető neve, lakcím, telefonszám, ímélcím, stb.
Az Int-ről ki tudjuk találni, hogy az az illető életkora lesz.
Ember legyen a talpán, aki ennyiből megmondja, hogy most melyik String mit jelöl.
A félév elején arról volt szó, hogy Haskellben a típus beszél, nem a változók nevei. A változók itt ráadásul nehezen beszélnének, hiszen egy konstans értéket
reprezentál a típus.

Persze, hogy ha ezen komment alá tekintünk, kiderül, hogy melyik adat mi szeretne lenni.
Nagy általánosságban azonban csak a függvény típusához lesz hozzáférésünk, nem a definícióhoz.
-}
person = ("Én","Alma utca 10","06-20-nemmondommeg","alma@alma.hu",20)

------------------------------
-- Saját típus: data
------------------------------

-- Rögtön az elején leírom, hogy két módon lehet saját típust létrehozni. Vagy a "newtype" kulcsszóval vagy a "data" kulcsszóval.
-- Amilyen példák voltak eddig korábban, azok mind datával voltak megadva, továbbá a tárgy során a data lesz használva.
-- Amit csinál a newtype, azt meg tudja csinálni a data is.
-- Akit érdekel esetleg a különbség a kettő között, konzultáción tudunk beszélgetni róla.


{-
Eddig volt szó listáról, rendezett n-esről, Int-ről, Integer-ről, Char-ról, Float-ról, Double-ről, Bool-ról, mint konkrét típusokról.
Azonban ezekkel nem lehet mindent pontosan úgy elkódolni, ahogy mi szeretnénk; továbbá saját típussal sokkal olvashatóbban reprezentálhatók
egyes műveletek eredményei, pl. tegyük fel, hogy egy elemet feltételesen szeretnénk beilleszteni egy listába. Ezen függvény típusa nagyjából az lenne, hogy:

conditionalInsert :: Bool -> a -> [a] -> [a]

Most honnan tudjuk, hogy a False, meg a True ez esetben mit reprezentál? Abban a pillanatban, hogy megírjuk, még emlékszünk rá; nézzünk rá egy év múlva
csak a típusra és arra, ahol és ahogyan használjuk. Valahol kódban látunk egy olyat, hogy `conditionalInsert True 1 [2,3,4]`, nem hiszem, hogy
emlékeznénk rá csak olvasással.
Helyette tudunk egy saját típust definiálni:

data InsertFlag = Insert | DoNotInsert

conditionalInsert :: InsertFlag -> a -> [a] -> [a]

Így a típusból egyből látszódik, hogy mit szeretne a függvény, illetve ha használjuk: `conditionalInsert Insert 1 [2,3,4]`, olvasásra egyből látszódik,
hogy mit szeretnénk az értékkel csinálni.
Maga a saját típus lényegében egy Bool, de mégis egy sokkal olvashatóbb változatát adtuk meg.

----------------

Ahogy korábban is láttuk megadva, saját típust definiálni a "data" kulcsszóval lehet. Szintaxisa az alábbi:

data <Új típus neve> [típusváltozók...] = <Konstruktor1> [paraméterek...] | <Konstruktor2> [paraméterek...] | ...

Nem kötelező típusváltozót megadni (de lehet, arról is lesz szó), továbbá a konstruktoroknak lehet, hogy van paraméterük, lehet, hogy nincs.
-}

-- Feladatok:
-- Definiáld a Day típust, amelynek 7 paraméter nélküli konstruktora van: Mon, Tue, Wed, Thu, Fri, Sat, Sun.



-- Kérdezzük meg ghci-től, hogy mi lesz a Fri konstruktor típusa!
-- A konstruktorok ugyanolyan értékek/függvények, mint a többi. Annyiban speciálisak a konstruktorok, hogy ezekre lehet mintailleszteni.

-- Definiáld a nextDay függvényt, amely egy adott napnak megadja, hogy mi a rákövetkező napja.
-- Segítség: Konstruktorokkal mit lehet csinálni?
nextDay :: undefined
nextDay = undefined

{-
Próbáljuk meg a ghci-ben meghívni a nextDay függvényt.
Mi lesz az eredménye annak, hogy `nextDay Sun`?

-----------------------------------

Ha kipróbáltuk, hogy mi történik, akkor azt tapasztaltuk, hogy hibát kaptunk.
A probléma az, hogy a GHCi nem tudja megjeleníteni a saját típusunkat, mert nem mondtuk meg neki, hogy hogyan kell vagy hogy meg lehet jeleníteni egyáltalán.
Ha szeretnénk, hogy a saját típusunk megjeleníthető legyen, akkor erről a tényről a fordítót is tájékoztatni kell a következő módon:
A saját típusunk definíciója után a "deriving" kulcsszót kell rakni, majd utána azt a típusosztályt odaírni, amelyik a megjelenítésért felelős; ez a Show.
-}

-- Módosítsd a Day típust úgy, hogy a ghci meg tudja jeleníteni azt.

{-
A deriving után legfeljebb 7 típusosztály írható rendezett n-es stílusban (alapból, mindenféle mágiázás nélkül), ezek a következők:
- Show: értéket alakít String-gé
- Read: String-et alakít értékké, ha tudja
- Eq: egyenlőségvizsgálat
- Ord: rendezhetőség
- Enum: felsorolhatóság
- Bounded: korlátos
- Ix: indexelésre használt típus

Most próbáljuk meg a `nextDay Sun` kifejezést kiértékelni!
-------------------------
Saját típusokkal is természetesen tudjuk példányosítani a típusosztályokat. Ehhez nem kell mást tenni, mint:

instance <Típusosztály> <Típus> where
  <bentebb húzva megírni a szükséges függvényeket>

Hogy melyik típusosztálynak milyen függvényei vannak, azt a :i-vel meg lehet nézni.

pl.
> :i Eq
type Eq :: Type -> Constraint
class Eq a where
  (==) :: a -> a -> Bool
  (/=) :: a -> a -> Bool
  {-# MINIMAL (==) | (/=) #-}
  	-- Defined in ‘GHC.Classes’
instance forall a. Eq a => Eq (Maybe a) -- Defined in ‘GHC.Maybe’
instance Eq Integer -- Defined in ‘GHC.Num.Integer’
instance Eq () -- Defined in ‘GHC.Classes’
instance Eq Bool -- Defined in ‘GHC.Classes’
instance Eq Char -- Defined in ‘GHC.Classes’
instance Eq Double -- Defined in ‘GHC.Classes’
instance Eq Float -- Defined in ‘GHC.Classes’
instance Eq Int -- Defined in ‘GHC.Classes’
instance forall a. Eq a => Eq [a] -- Defined in ‘GHC.Classes’
instance Eq Ordering -- Defined in ‘GHC.Classes’
instance forall a. Eq a => Eq (Solo a) -- Defined in ‘GHC.Classes’
instance Eq Word -- Defined in ‘GHC.Classes’
instance forall a b. (Eq a, Eq b) => Eq (Either a b) -- Defined in ‘Data.Either’

Ebből két dolgot is látni:
- Az Eq osztályba az (==) és a (/=) tartozik.
- A MINIMAL sor megmondja, hogy melyik függvényeket KELL implementálni. A vesszővel való elválasztás és kapcsolatot, a |-pal való elválasztás pedig egy vagy kapcsolatot jelöl.
  Eq esetén ez azt jelenti, hogy VAGY az (==)-t VAGY a (/=)-t kell implementálni.

-- SZÉP KÓD: Ugyan a vagy kapcsolat nem zárja ki, hogy mindkét függvényt implementáljuk,
             de a legsűrűbb esetben nem érdemes vaggyal elválasztott függvény mindkét felét implementálni.
-}

-- Példányosítsuk kézzel az Eq osztályt a Day típusra!

-- Binárisok

-- Definiáld a `Binary` adattípust, melynek két paraméternélküli adatkonstruktora van: `On` és `Off`. Kérjük az `Eq` és a `Show` típusosztályok automatikus példányosítását! 

--Definiálj  függvényt, amely az `On` értéket `Off`, az `Off` értéket `On` értékre állítja!


--switch :: Binary -> Binary
switch = undefined

{-
switch (switch On) == On
switch (switch (switch Off)) == On
-}

-- Definiáld a `bxor :: [Binary] -> [Binary] -> [Binary]` függvényt, amely visszaad egy listát, amely az `i`-edik pozíción `On` értéket tartalmaz, ha az `i`-edik pozíción mindkét paraméterben kapott listában egyaránt `On` vagy egyaránt `Off` érték szerepel. 

-- Amennyiben adott pozíción különböző értékeket tartalmaz a két lista, az eredménylistában adjunk vissza `Off` értékeket. Feltehetjük, hogy a listák egyenlő hosszúak. 


--bxor :: [Binary] -> [Binary] -> [Binary]
bxor = undefined

{-
bxor [On] [On]             == [On]
bxor [Off] [Off]           == [On]
bxor [On] [Off]            == [Off]
bxor [Off] [On]            == [Off]
bxor [On, Off] [On, Off]   == [On, On]
bxor [Off, Off] [Off, Off] == [On, On]
bxor [On, On] [On, On]     == [On, On]
bxor [Off, On] [Off, On]   == [On, On]
bxor [On, Off] [Off, Off]  == [Off, On]
bxor [On, Off, On, Off] [Off, On, Off, On] == [Off, Off, Off, Off]
bxor [] [] == []
-}

-- Színek

-- Definiáljuk a `Colour` adattípust, amely segítségével színeket reprezentálhatunk RGB (piros, zöld, kék) formátumban. 

{-
data Colour = RGB Int Int Int --deriving (Show, Eq)

red :: Colour
red = RGB 255 0 0

green :: Colour
green = RGB 0 255 0

blue :: Colour
blue = RGB 0 0 255

instance Show Colour where
    show (RGB r g b) = "R = " ++ show r ++ " G = " ++ show g ++ " B = " ++ show b

instance Eq Colour where
    (==) (RGB r1 g1 b1) (RGB r2 g2 b2) = r1 == r2 && g1 == g2 && b1 == b2
-}  

-- Definiáljuk az `isGray :: Colour -> Bool` függvényt, amely eldönti, hogy a paraméterként megadott szín a szürke egy árnyalata-e! Ez akkor teljesül, ha a szín három komponense egyenlő, de nem a fehér (rgb = (255, 255, 255)) illetve nem a fekete (rgb = (0, 0, 0)).    

-- Időjárás adattípus

-- Készíts egy `Weather` adattípust, amely az időjárást reprezentálja! Rendelkezzen a következő négy adatkonstruktorral: Sunny, Cloudy, Rainy, Snowy. Az utóbbi kettő adatkonstruktornak legyen egy Int paramétere, amely a csapadék mennyiségét ábrázolja miliméterben. Kérd az `Eq` és a `Show` típusosztályok automatikus példányosítását! 

-- Definiáld a `niceDayForHiking` függvényt, amely segít eldönteni, hogy egy adott napon az időjárás kellemes lesz-e kiránduláshoz. Ha süt a nap vagy felhős az ég adjon vissza igazat, egyébként pedig hamisat.


--niceDayForHiking :: Weather -> Bool
niceDayForHiking = undefined

{-
niceDayForHiking Sunny == True
niceDayForHiking (Rainy 1) == False
-}


-- Hőmérséklet

{-
Definiálj egy `Temperature` adatszerkezetet a levegő hőmérséklet mérésekhez! A hőmérsékletet mérjük nappal és éjszaka, ezért az alábbi konstruktorokat vegyük fel:

- `Night`: a mérést éjszaka történt, egy `Double` paramétere legyen,
- `Daytime` : a mérést nappal történt, egy `Double` paramétere legyen.

Kérjünk a fordítótól automatikus példányosítást a `Show` és `Eq` típusosztályokra!
-}

-- Nappali mérés

-- Döntsd el egy mérésről, hogy nappal történt-e!


--isDaytime :: Temperature -> Bool
isDaytime = undefined

{-
isDaytime (Daytime 15)
isDaytime (Daytime 0)
isDaytime (Daytime (-2))
not (isDaytime (Night (-4)))
not (isDaytime (Night 0))
not (isDaytime (Night 2))
-}

-- Átlaghőmérséklet

-- Adott egy méréssorozat. Állapítsd meg a nappal mért hőmérsékletek átlagát!

-- Feltesszük, hogy van legalább egy nappali mérés a listában és a lista véges.


-- daytimeAvg :: [Temperature] -> Double


{-
daytimeAvg [Night (-5), Night (-6), Daytime 0, Daytime 3, Daytime 5, Daytime 1, Night (-7)] == 2.25
daytimeAvg [Night 5, Night 0, Daytime 1, Daytime 10, Daytime 8, Daytime 5, Night 2] == 6.0
daytimeAvg [Night 3, Night 0, Daytime 1, Daytime 10, Daytime 8, Daytime 15, Night 7] == 8.5
daytimeAvg [Daytime (-4), Night 0] == -4.0
-}