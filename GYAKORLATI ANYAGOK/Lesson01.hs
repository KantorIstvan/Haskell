module Lesson01 where

{-
Tárgy honlapja: lambda.inf.elte.hu
Erdei Zsófia, zsanart@inf.elte.hu
-- Feladatok, gyakorlási lehetőség
-- A félévben azon megyünk végig.

Követelmények: lambda.inf.elte.hu/Requirements.xml

- gyakorlatok látogatása kötelező (max. 3 hiányzás),
- röpdolgozatok a gyakorlatokon (> 50%),
- heti szinten házi feladatok - önálló munkát várunk, lehet be kell mutatni párat közülük,
- félévközi évfolyam zárthelyi,
- a félév vége felé egy nagyobb házi feladat várható

Kötelező irodalom:
-- Miran Lipovača: Learn You a Haskell for Great Good! A Beginner’s Guide; 8. fejezet végéig
   -- learnyouahaskell.com/chapters
-- Christopher Allen: Haskell Programming from First Principles; 12. fejezet végéig

A vizsgán az alábbiakból lesznek kérdések:
-- a kötelező irodalomban a megjelölt fejezetekig található anyagból
-- ami elhangzott előadáson
-- ami elhangzott gyakorlaton

Elvárás: Nem fogunk tudni minden függvényen is keresztülmenni a tárgy folyamán,
         a függvényeknek való utánanézés önállóan egy elvárt tevékenység.
-}

------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Funkcionális programozás:
-- Függvényeket írunk benne.
-- MINDIG van eredmény; olyan nincs, hogy "csak csinálunk valamit", egy függvénynek mindig van eredménye.
-- Általában deklaratív stílusúak.
   -- Azt mondjuk meg, hogy MIT szeretnénk eredményül; nem azt, hogy hogyan kapjuk meg az eredményt.

{-
Haskell kinézete, felépítése:
-- Mindenki örömére erősen hasonlít a matematikához.
-- Modulokból épül fel
   -- Egy modul egy darab fordítási egység
-- Modulnév nagybetűvel kezdődik
   -- Modulnév legyen azonos a fájl nevével a kiterjesztés nélkül!
-- Függvények nevei kisbetűvel kezdődnek.
-}

{-
Mint ahogy a sok szövegből látható, Haskellben kétfajta módon lehet kommentet írni a kódba:
- "--" karakterrel kezdve, ekkor a sor végéig tart a komment
- {- -} karakterek között, ekkor a köztes tartalom a komment
  Ez a fajta komment egymásba ágyazódik, mindig a legközelebbi záró mínusz kapcsos zárja a kommentet.
-}

-------------------------------------
-- Alaptípusok
-------------------------------------

-- Konkrét típusok neveit NAGYBETŰVEL kezdjük.

-- Az alábbi alaptípusokkal ismerkedünk meg az első órán:
-- Int, Integer, Float, Double, Char, Bool, függvények

------------------------------
-- Int és Integer
------------------------------

one :: Int -- egész számok típusa (architektúra-függő: 32 biten 32 bit méretű, 64 biten 64 bit méretű)
one = 1

three :: Integer -- Szintén egész számokat ábrázol, de ez a végtelenségig; gyakorlatilag a RAM a határ.
three = 3

{-
Fájl betöltése:
- ghci-ben :load <fájlnév> vagy :l <fájlnév>
- :reload vagy :r; újratölti a legutoljára betölteni próbált fájlt
- Kérdezzük meg ghci-től, hogy mi a "three" kifejezés típusa: Ezt a :t <kifejezés> formában tehetjük meg a ghci-ben.
-}

-- Nézzük meg, hogy mi történik, ha definiáljuk a következőt úgy, hogy a korábbi definíciókat meghagyjuk:
--one :: Integer
--one = 1

-- Alapvető műveletek számokon:
-- (+), (-), (*), ghci-ben kipróbálni
-- Matematikai szabályok érvényesek; hatványozás > szorzás > összeadás; balról-jobbra kiértékelés
   -- Részletesebben, hogy ez ténylegesen honnan állapítható meg, következő órán!

-- VIGYÁZAT! Negatív számok/literálok NEM LÉTEZNEK Haskellben!
-- Valamikor úgy működik, ahogy gondoljuk
negativeOne :: Integer
negativeOne = -1

-- De nem mindig!
-- oops :: Integer
-- oops = 3 + -4
-- Zárójelben a -4, mint matekban szokás, már helyesen működik.
negativeOne' :: Integer
negativeOne' = 3 + (-4)

-- Nézzük meg, hogy mi történik 'one + three' esetén!

{-
Haskell nyelv:

Definíció:
-- Statikusan típusos: Minden kifejezésnek van fordítási időben típusa.


-- Erősen típusos: A megadott típusokat be kell tartani!
   -- Nincs implicit konverzió szám és szám között (se semmilyen más típus között)!
      -- Implicit == "magában foglalt", itt "magától történő"
      -- Az Int az nem Integer és az Integer az nem Int. -> Sok butaságtól ment meg minket.
→ Szubjektív, hogy kinek mi számít erősnek.
  Valaki azt mondja, hogy a C#, meg a Java erősen típusos nyelvek.
  Valakinek meg a Haskell is gyengén típusos.

Definíció:
-- Tiszta nyelv: Nincsenek benne mellékhatások.
   -- pl. 1 + 3 esetén az eredmény mindig 4 lesz és semmi más nem fog történni a háttérben sem.

Összetettebb példa mellékhatásra:

--------- C# nyelvbeli kód ---------

public class Proba
{
  public static int a = 0;

  public static int f(int x)
  {
    if(a == 0)
    {
      a = 1;
      return x + 1;
    }
    else
    {
      a = 0;
      return x * 2;
    }
  }

  public static void Main(string[] args)
  {
    Console.WriteLine(f(1));
    Console.WriteLine(f(1));
    Console.WriteLine(f(3));
    Console.WriteLine(f(3));
  }
}

-------------------------------------

Mit várnánk el természetes módon az azonos függvényhívásoktól?
Milyeneknek kéne az eredményeknek lenniük?
Válasz:

Mit fog a C# kód kiírni?
Válasz:

-}

----------------------------
-- Float és Double
----------------------------

-- A számokban tizedesPONT van, nem vessző!

half :: Float
half = 0.5

quarter :: Double
quarter = 0.25

-- Trükkösebb műveletek:
-- (/), div, mod

-- (/) csak törtszámokon működik.
-- div, mod csak egész számokon működik.
-- div: Egész osztás
-- mod: Maradékos osztás

-- Megjegyzés: A div-nek és a mod-nak a paramétereit SZÓKÖZZEL ELVÁLASZTVA adjuk át.
--             Ez általánosan igaz bármely függvényre Haskell-ben.

-- Mi lesz az eredmény 1 / 0 esetén?
-- Mi lesz az eredmény div 1 0 esetén?

-- Fordítás idejű hiba (compilation/compile-time error): A forráskód kritikus hibát tartalmaz, amely nem engedi a program létrehozását, generálását.
   -- típushibák ilyenek (leggyakoribb hiba ez lesz, amivel fogtok találkozni)
   -- szintaktikus hiba (parse error)
   -- Felismerése: GHCi-ben piros "error" szöveggel kezdődő üzenetek.

-- Futás idejű hiba (runtime error): A program létrejött és futtatható, azonban futás közben történik valamilyen kritikus hiba, ami miatt leállásra kényszerül a program.
   -- 0-val való osztás, pl 1 `div` 0.
   -- Hiányzó programág, hiányzó mintaillesztés (2. órán lesz róla szó).
   -- Felismerése: *** Exception-nel kezdődő szöveg kerül kiírásra.

{-
Prefix-Infix írásmód:
-- A latin karakterekkel írott nevű függvények általában prefix helyen használatosak.
-- Pl. div 5 2; mod 487 34; legelöl van a függvény és utána annyi paraméter, amennyi kell neki.

-- A nem latin karakterekkel írott nevű függvényeket operátoroknak szokás hívni ((+),(-),(*)) és általában infix helyen használatosak, tehát a paraméterek KÖZÖTT van az operátor
-- Pl. 2 + 3; 2 * 2

-- FONTOS! Az operátorok pontosan ugyanolyan függvények, mint a többi!

A függvények használati helye módosítható:
-- Ha a függvény neve betűkből áll, akkor a backtick (`, AltGr+7) karakterek közé rakva a függvény nevét lehet használni azt infixen.
-- Pl. 7 `div` 2; 345 `mod` 12

-- Ha a függvény egy operátor, akkor az operátort kerek zárójelek közé rakva lehet használni azt prefixen.
-- Pl. (+) 4 5, (*) 2 3

-- FONTOS! A prefixen írt függvény kötési erőssége MINDIG A LEGERŐSEBB!

Ellenőrző kérdések:
Az alábbiak közül melyik kifejezés helyes? Amelyik helyes, mennyi lesz az értéke?
3 + (*) 4 5
3 * (+) 4 5
(*) 3 4 + 5
(+) 3 4 * 5
(*) 3 (+) 4 5
(+) 3 (*) 4 5
-}

----------------------------
-- Char
----------------------------

-- Karakterliterálokat aposztróffal írunk, azok között egy karakter jelöl egy karaktert.

a :: Char
a = 'a'

-- Nincs igazán érdekes függvény jelenleg Char-hoz.
-- Jelenleg használható példaként a succ, pred, toEnum, fromEnum függvények lehetnek.
-- Ezek a függvények minden felsorolható típuson működnek. Ilyen például az Int, Char, Bool.
-- succ: egy karakter rákövetkezőjét adja vissza. A program elszáll, ha nincs következő.
-- pred: egy karakter megelőzőjét adja vissza. A program elszáll, ha nincs előző.
-- toEnum: karakterkódót (Int) átalakítja karakterré.
-- fromEnum: karaktert átalakítja annak a kódjává.

-- Léteznek más függvények, pl. toUpper, toLower, melyek rendre egy adott karakter nagy, illetve kicsi változatát adják vissza,
-- de ezek más könyvtárakban, modulokban vannak, jelenlegi eszközeinkkel azok még nem használhatók.

----------------------------
-- Bool
----------------------------

-- Két értéke van: True és False (igaz és hamis értéket reprezentál)
   --              ^^^^    ^^^^^
   --              NAGYBETŰVEL kell írni az elsőt!

true :: Bool
true = True

false :: Bool
false = False

-- Műveletek:
   -- not: Bool típusú értéket negál, True → False, False → True
   -- (&&): Két Bool-t összeésel, logikai konjunkció, csak akkor igaz, ha mindkét bemenete True, máskor False.
   -- (||): Két Bool-t összevagyol, logikai diszjunkció, akkor igaz, ha bármelyik paraméter True, egyébként False.

----------------------------
-- Függvények: (->) típus
----------------------------

-- A paramétereket a típusban nyilakkal (->) választjuk el egymástól és az eredménytől.
-- Az utolsó nyíl utáni típus az eredménynek a típusa.

inc :: Int -> Int
--     ^^^    ^^^
--  paraméter |
--   típusa   ⌞ eredmény típusa
inc x = x + 1

-- A paraméter neve kisbetűvel kell kezdődjön, utána állhat nagybetű, szám, és aposztróf.
-- Megjegyzés: Haskell-ben a paraméter neve nem kell, hogy nagyon beszédes legyen.
--             Az olvashatóságot legnagyobb részt a típusok adják, így a paraméterek nevei általában 1-2 betűsek vagy esetleg egy hosszú nevű típus rövidítése szoktak lenni.

-- SZÉP KÓD: Függvények használatakor a paramétereket szóközzel választjuk el egymástól; felesleges zárójeleket ne használjunk!
-- Pl. szép: inc 1
--   csúnya: inc(1) -- amely házi feladat megloldásban ilyen lesz, az el lesz utasítva!

-- Próbáljuk ki, hogy mi történik, ha definiálom még egyszer ugyanezt a függvényt egy másik típussal:
-- inc :: Integer -> Integer
-- inc x = x + 1

double :: Int -> Int
double x = x * 2

-- Összead 3 Int értéket
add3 :: Int -> Int -> Int -> Int
add3 x y z = x + y + z

areTriangleSides :: Double -> Double -> Double -> Bool
areTriangleSides a b c = a + b > c && a + c > b && b + c > a

-- SZÉP KÓD: Operátorok és függvények definiálásakor és használatakor használjuk a szóközt bőven és nyugodtan, nem harapnak.
-- Pl. x+1 helyett írjuk azt, hogy x + 1, sokkal olvashatóbb, átláthatóbb.
-- Két különböző függvény definiálása között hagyjunk üres sort, hogy elkülönüljenek vizuálisan egymástól.

-- 2 paraméteres függvényt hogy definiálunk? Mi lesz a típusa?

-- SZÉP KÓD: Ugyan Haskell képes kitalálni a függvények típusait, de a kódban legyen ott minden függvénynek a típusa, hiszen az adja az olvashatóság legnagyobb részét,
--           továbbá megóv minket, programozókat a hülyeségek írásától.
{-
Pl.
Ha csak ennyit írok, hogy f x = x + 1, akkor Haskell boldogan kitalálja, hogy x egy szám és elfogadja a definíciót.
Ha tudom, hogy a paraméter Integer, az eredmény pedig Double kell legyen, akkor ha leírom, hogy:

f :: Integer -> Double
f x = x + 1

akkor máris fordítási időben megfogja Haskell, detektálja, hogy butaságot szeretnénk csinálni.
-}

-- mod segítségével
even' :: Integer -> Bool
even' x = x `mod` 2 == 0

-- Definiáld az even' függvény segítségével!
odd' :: Integer -> Bool
odd' x = not (even' x)