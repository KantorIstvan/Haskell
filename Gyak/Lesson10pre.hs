module Lesson10 where

-----------------------------------------------------
-- Magasabb rendű függvények (Higher order functions)
-----------------------------------------------------

-- Motivációként csináld meg az alábbi feladatokat:
-- Definiáld az add2 függvényt, amely egy lista minden eleméhez hozzáad 2-t.

-- Definiáld a mul2 függvényt, amely egy lista minden elemét megszorozza 2-vel.

-- Definiáld a toUpperAll függvényt, amely egy szöveg minden karakterét nagybetűsíti.

-- Definiáld a negateAll függvényt, amely egy Bool-ok listájának minden elemét negálja.

-- Legyen adott egy h függvényt:
h :: Num a => Bool -> a
h True = 1
h False = 0

-- Definiáld a hAll függvényt, amely egy Bool-ok listáját átalakítja számok listájává.



-- Aki esetleg unja már, mi lenne jó, ha mit tudnánk ezek helyett csinálni?
-- Aki még nem unja, van még ∞+1 ilyen feladat.

-- Általánosítsuk az ötletet!
-- Mi lesz a típusa? Hogyan fog a típusban meglátszódni, hogy mi kell nekünk?
map' :: undefined
map' = undefined

-- Definíció:
-- Magasabb rendű függvény: Olyan függvény, amely függvényt vár paraéterül.
-- Megj.: ...vagy függvényt ad eredményül, ezt is hozzá szokták tenni,
--        de ebben a nyelvben az teljesen felesleges, mert akkor minden függvény magasabb rendűnek számítana.

{-
Magasabb rendű függvények használata:
Megpróbálhatnánk úgy használni, ahogy eddig tettük, pl.

l = map' f [1,2,3] where
  f x = x + 1

de azért azt elkezdjük látni, hogy:
1. A where-ben/let-in-ben csak ezért egy függvényt definiálni nem igazán karakterhatékony, nem is idiomatikus.
2. Elég sűrűn előfordul, hogy ugyanazt a függvényt kéne többször a where-ben definiálni, az meg csak simán kódduplikáció; az meg egy nyelvben sem szép.

Milyen jó lenne, ha lennének ilyen egyszer használatos függvények, amiket csak odaírok és működik!
Szerencsénk van, ilyenek egy funkcionális nyelvben léteznek, ezeket szokás lambda függvényeknek nevezni.

-- Definíció:
-- Lambda-függvény: Névtelen függvény.

Szintaxisa: (\ <1. paraméter neve> <2. paraméter neve> ... <n. paraméter neve> -> <kifejezés>)
ahol a paraméterek neveire ugyanaz a szabály vonatkozik, mint a sima függvényekben, tehát kisbetűvel kezdődnek.

Ezzel az új eszközzel felvértezve magunkat tudunk egyszer használatos, névtelen függvényeket megadni paraméterül a magasabb rendű függvényeknek.

l = map' (\x -> x + 1) [1,2,3]

Sokkal rövidebb, átláthatóbb, hogy mit szeretnénk kifejezni.

--------------------

Természetesen ezen névtelen függvények használhatók magasabb rendű függvények nélkül is.
pl. (\x -> x + 1) 2, pontosan ugyanúgy működnek, mint a megszokott, névvel rendelkező függvények.
    ^^^^^^^^^^^^^^^ -- Mennyi lesz az eredménye ennek a kifejezésnek?

A lambdákban ugyanúgy lehet mintailleszteni, azonban nem totálisan, csak maximum egy minta van megengedve.
(\True -> False) True == False

-- SZÉP KÓD: Éppen a fenti miatt csak azon értékeket mintaillesszük, amiknek pontosan egy konstruktora van,
             de azt mintaillesszük is (ha csak nem valami nagyon-nagyon triviális dolgot művelünk)! (pl. rendezett n-es)

Mi történik (\False -> True) True esetén?

Két paraméter esetén az alábbi módon néz ki:
(\x y -> 2 * x + 3 * y) 9 10

Mi történik akkor, ha a függvényt bezárójelezzük az első paraméterrel?
((\x y -> 2 * x + 3 * y) 9) 10

Hiba lesz vagy teljesen helyes?
Ha futtatjuk mindkettőt, akkor láthatjuk, hogy mind a kettő ugyanazt az eredményt adta vissza.
Pedig tisztán látható, hogy a második esetben csak egy paramétert adtam át a függvénynek és azt kellett kiértékelnie a zárójelezés miatt.
Ezt Haskell meg is tette, a köztes eredmény egy új függvény lesz, egészen pontosan a (\y -> 2 * 9 + 3 * y) függvény, amelyben az x helyére már be lett helyettesítve
a 9-es érték, és amely függvény már csak egy paramétert vár még. Ezt az úgy nevezett parciális applikálás/függvényalkalmazás teszi lehetővé.

-- Definíció:
-- Parciális applikálás/függvényalkalmazás: A függvénynek átadok legalább egy paramétert, de nem az összeset, így az alkalmazás eredménye egy másik függvény lesz.
-- Totális applikálás/függvényalkalmazás: A függvénynek átadjuk az összes szükséges paraméterét, hogy az eredménye egy konkrét érték legyen, amely nem függvény.

Ez nem egy beépített nyelvi jellemző, hanem matematikai következmény. A típusrendszer mondja meg, hogy pontosan mit csinálhatunk mivel.
Ez azt jelenti, hogy valahol a típusrendszerben meg kéne látszódnia, hogy ezt megtehetjük.
Hol látszódhat? Magának a függvénynek a típusában; azon belül? Mi az a szimbólum a típusban, amivel eddig keveset foglalkoztunk (és nem a =>)?
ghci-ben nézzük meg: :i ->
Mit látunk? A (->) pontosan ugyanolyan típuskonstruktor, mint az Either vagy a Maybe és még sok más. Emellett a nyílnak meg van adva a fixitása is,
amelyből megtudjuk, hogy a (->) infixen használva jobbra köt a lehető leggyengébben.

Ez azt jelenti, hogy ha leírom azt, hogy a -> b -> a vagy azt, hogy a -> (b -> a), ez a két típus teljesen ugyanazt jelenti.
Amely meg azt vonja maga után, hogy pl.
f :: a -> b -> a
f x y = x
és
g :: a -> (b -> a)
g x = \y -> x
teljesen ugyanazok, ahol az f függvényben felvettem mindkét paramétert, a g-ben pedig felvettem egyet és eredményként egy függvényt adok vissza, ahogy a típus leírja.
Továbbá:
h :: (a -> (b -> a))
h = \x -> \y -> x
szintén ugyanaz.

Ezt a folyamatot (f → g → h) szokás curry-zésnek nevezni.
Megjegyzés: Ugyan ez a curry-zés, de a tárgy keretében ha valamilyen számonkérés formájában megkérdezik, hogy "mi a curry-zés lényege?" vagy valami hasonló módon,
            ahol a curry-zésre kérdez rá a kérdés, akkor az a válasz, hogy "Minden függvény egyparaméteres" annak ellenére, hogy ez a curry-zésnek egy következménye.

Hogy tudjuk a parciális applikálást kihasználni?
Vegyük a korábbi példát.

l = map' (\x -> x + 1) [1,2,3]

Ez a felírás még mindig hosszúnak érződik.
Hol lehet rajta még rövidíteni?
A map' függvénynek az a neve, azzal nem lehet csinálni többet.
A lista az meg attól függ, hogy mi mit szeretnénk, azon se lehet igazán rövidíteni.
Akkor csak a lambdában lehet.
Láthatjuk, hogy a (+) első paramétere maga a függvény paramétere; a másik pedig egy 1-es érték.
Tehát lényegében csak egy olyan függvényt kell leírnunk, amelynek az eredménye egy olyan függvény, amely egy számhoz 1-et hozzáad.

Ezt parciális applikálással le tudjuk írni a (+) függvényt használva úgy, hogy (+ 1). (Mivel az összeadás kommutatív, az (1 +) is ugyanezt az eredményt éri el.)
Mi lesz a különbség a (+ 1) és a (+) 1 kifejezések között?

Így összességében a fenti felírást úgy tudjuk tovább rövidíteni, hogy:
l = map' (+ 1) [1,2,3]

Így már sokkal rövidebb, olvashatóbb, érthetőbb, hogy mit csinálunk a listával.
-}

-- Definiáld a map'' függvényt listagenerátorral!

------------------------------
-- Milyen más függvényeket lehet még így általánosítani?
-- Nézzünk ezekre is példát.

-- Definiáld a moreThan2 függvényt rekurzívan, amely egy számokat tartalmazó listából megtartja a 2-nél nagyobbakat.
moreThan2 :: undefined
moreThan2 = undefined

-- Definiáld az onlyLower függvényt rekurzívan, amely egy szövegből csak a kisbetűket tartja meg.
onlyLower :: undefined
onlyLower = undefined

-- Itt is lehetne még sok példafeladatot felírni, de az előzőek alapján remélhetőleg érthető, hogy mi a cél.

-- Definiáld a filter' függvényt, amely adott tulajdonsággal rendelkező elemeket tart meg a listából.
filter' :: undefined
filter' = undefined

-- Definiáld a filter'' függvényt listagenerátorral.
filter'' :: undefined
filter'' = undefined

-- Definiáld a mapFilter függvényt rekurzívan és listagenerátorral. Csak azon elemekre alkalmazzuk a map-ot, amelyek a szűrés után megmaradtak.
-- Melyiket kényelmesebb definiálni?
mapFilter :: undefined
mapFilter = undefined

mapFilter' :: undefined
mapFilter' = undefined

-- Definiáld a zipWith' függvényt, amely egy adott művelet alapján teszi össze az elemeket párhuzamosan haladva két listán.
-- A függvény a rövidebb lista hosszáig működik. Amelyikben több elem van, azokat eldobjuk.
zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith' = undefined
-- Hogy kapjuk vissza az eredeti zip függvényt ezzel a függvénnyel?

-- Definiáld az indexedZipWith függvényt, amely ugyanazt csinálja, mint a zipWith, csak a függvényparaméter paramétereként átvesszük az adott két elem indexét is.
indexedZipWith :: Integral i => (i -> a -> b -> c) -> [a] -> [b] -> [c]
indexedZipWith = undefined

-- Definiáld a ($$) függvényt, amely egy függvényt alkalmaz egy értékre.
infixr 0 $$
($$) :: (a -> b) -> a -> b
f $$ a = undefined
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
így lehet olyan kifejezéseket definiálni, amik például egy adott értéket adnak át egy-egy függvénynek, mint például az alábbi feladatban.
-}

-- Definiáld az app2ToFunctions függvényt magasabb rendű függvényeket használva rekurzió nélkül, amely alkalmazza a 2-es értéket egy függvényeket tartalmazó lista minden függvényén.
app2ToFunctions :: Num a => [a -> b] -> [b]
app2ToFunctions = undefined

-- Definiáld a span' függvényt, amely kettébont egy listát ott, ahol egy adott tulajdonság már nem teljesül.
-- span' even [2,4,6,1,2,3,4] == ([2,4,6],[1,2,3,4])
-- span' (> 0) [5,4,3,2,1,0,-1,-2,-3] == ([5,4,3,2,1],[0,-1,-2,-3])
-- span' (< 0) [1,2,3,4] == ([],[1,2,3,4])
-- span' (> 0) [1,2,3,4] == ([1,2,3,4],[])
span' :: undefined
span' = undefined

-- Definiáld a takeWhile' függvényt, amely egy lista elejéről addig tartja meg az elemeket, amíg egy adott tulajdonság folyamatosan teljesül.
takeWhile' :: undefined
takeWhile' = undefined

-- Definiáld a dropWhile' függvényt, amely egy lista elejéről addig dobálja el az elemeket, amíg egy adott tulajdonság folyamatosan teljesül.
dropWhile' :: undefined
dropWhile' = undefined

-- Definiáld a find' függvényt, amely visszaadja az első adott tulajdonságú elemet egy listából, ha létezik olyan.
find' :: undefined
find' = undefined
-- Az eredeti függvény a Data.List-ben található.

-- Definiáld az findIndex' függvényt, amely visszaadja az első adott tulajdonságú elem indexét egy listából, ha létezik olyan.
-- Megj.: Ugyan fel lehet használni az előző függvényt erre, de nem célszerű.
findIndex' :: undefined
findIndex' = undefined
-- Megj.: Az eredeti függvény a Data.List-ben van, de csak Int-et ad vissza tetszőleges szám helyett, így a használata nem javallott.
