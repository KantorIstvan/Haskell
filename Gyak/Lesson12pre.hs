module Lesson12 where

-- Új ötlet, további általánosítások:

-- Emlékezzünk vissza az alábbi korábban definiált függvényekre:
-- sum, product, elem, (++), concat, any
{-
sum []     = 0
sum (x:xs) = x + sum xs

product []     = 1
product (x:xs) = x * product xs

elem _ []     = False
elem e (x:xs) = e == x || elem e xs

[]     ++ ys = ys
(x:xs) ++ ys = x : xs ++ ys
-}

-- Definiáld az any' függvényt, amely ellenőrzi, hogy létezik-e egy elem egy listában, amelyre egy adott tulajdonság teljesül.
any' :: (a -> Bool) -> [a] -> Bool
any' _ [] = False
any' p (x:xs) = p x || any' p xs

-- Megjegyzés: Hogy lehetne az elem-et megírni az any-vel? (Remélhetőleg egyértelműen látszódik, hogy erősen hasonlítanak egymásra.)
elemViaAny :: Eq a => a -> [a] -> Bool
elemViaAny e = any' (== e)

-- Definiáld az all' függvényt, amely ellenőrzi, hogy egy adott tulajdonság az összes listaelemre teljesül-e.
all' :: (a -> Bool) -> [a] -> Bool
all' _ [] = True
all' p (x:xs) = p x && all' p xs

-- Definiáld az or' függvényt, amely egy listányi Bool-t összevagyol.
or' :: [Bool] -> Bool
or' [] = False
or' (x:xs) = x || or' xs

-- Definiáld az and' függvényt, amely egy listányi Bool-t összeésel.
and' :: [Bool] -> Bool
and' [] = True
and' (x:xs) = x && and' xs

-- Mindegyik függvény definíciója gyakorlatilag ugyanúgy néz ki.
-- Valami az üres listára, meg valami a legalább egy elemre. A rekurzió mindegyikben mindig az egy elemmel kevesebb maradék lista.
-- Hogyan lehetne általánosítani ezt az ötletet?
-- Megj.: Emlékezzünk vissza rá, hogy ilyen fajta rekurzió esetén merre zárójeleződött az eredménykifejezés!

-- Próbáljuk meg lépésenként általánosítani.
-- Amikor hiányzik valami, akkor vegyük hozzá a típushoz, meg a definícióhoz.
generalisedIdeaR :: (a -> b -> b) -> b -> [a] -> b
generalisedIdeaR _ v [] = v
generalisedIdeaR f v (x:xs) = f x (generalisedIdeaR f v xs)

-- Ezt a függvényt hívják foldr-nek!
-- Létezik a foldr' függvény is, amely a foldr-nek a mohó változata és amely a Data.Foldable modulban található.
-- A foldr' NEM MŰKÖDIK végtelen listával!

-- Természetesen nem csak ilyen fajta rekurziónk volt.
-- Emlékezzünk vissza a reverse-re.
{-
reverse = reverseAcc [] where
  reverseAcc acc []     = acc
  reverseAcc acc (x:xs) = reverseAcc (x:acc) xs

Az ötlet használható sum-mal is:
sum' = sumAcc 0 where
  sumAcc acc []     = acc
  sumAcc acc (x:xs) = sumAcc (acc + x) xs

Emlékezzünk, hogy ilyenkor az eredménykifejezés merre van zárójelezve!
Látszik a hasonlóság a függvények között?

Általánosítsuk ennek az ötletét is!
-}
generalisedIdeaL :: (b -> a -> b) -> b -> [a] -> b
generalisedIdeaL _ acc [] = acc
generalisedIdeaL f acc (x:xs) = generalisedIdeaL f (f acc x) xs

-- Ezt a függvényt hívják foldl-nek.
-- Létezik a foldl' függvény is, amely a foldl-nek a mohó változata és amely a Data.Foldable modulban található.
-- foldl helyett a foldl'-t érdemes használni!
-- pl. foldr  (+) 0 [1..100000000] futásidejű hibát okoz, mert túl nagy a kiértékeletlen kifejezés a lustaság miatt.
--     foldl  (+) 0 [1..100000000] szintén.
--     foldl' (+) 0 [1..100000000] viszont kiszámítható lesz, mert az akkumulált paramétert mohón kezeli, kiértékeli,
--                                 nem gyűjtögeti a kiértékeletlen kifejezéseket.

-- Ha megnézzük mindkét fold-ot, akkor lényegében mindkettő listát dolgoz fel.
-- Ha úgy tetszik, akkor ez a lista destruktora (más szavakkal iterátora, rekurzora, eleiminátora; mindegyik (kb) ugyanazt jelenti ebben a világban),
-- mert a függvény feldolgozza a lista összes elemét, szintaktikailag megkülönbözteti az összes listát egymástól.

-- A végtelen listás szabályok ugyanúgy érvényesek foldr és foldl-re is,
-- tehát a foldr tud működni végtelen listán, mert előbb használjuk a műveletet, mint a rekurziót,
-- a foldl nem tud működni végtelen listán, mert akkumulál, gyűjtöget.

-- Definiáljuk újra a fenti függvényeket foldr-et vagy foldl-et használva.

sumViaFold :: Num a => [a] -> a
sumViaFold = foldr (+) 0

productViaFold :: Num a => [a] -> a
productViaFold = foldr (*) 1

(+++) :: [a] -> [a] -> [a]
xs +++ ys = foldr (:) ys xs

concatViaFold :: [[a]] -> [a]
concatViaFold = foldr (++) []

reverseViaFold :: [a] -> [a]
reverseViaFold = foldl (flip (:)) []

elemViaFold :: Eq a => a -> [a] -> Bool
elemViaFold e = foldr (\x acc -> x == e || acc) False

orViaFold :: [Bool] -> Bool
orViaFold = foldr (||) False

andViaFold :: [Bool] -> Bool
andViaFold = foldr (&&) True

anyViaFoldr :: (a -> Bool) -> [a] -> Bool
anyViaFoldr p = foldr (\x acc -> p x || acc) False

allViaFold :: (a -> Bool) -> [a] -> Bool
allViaFold p = foldr (\x acc -> p x && acc) True

-- Definiáljuk a foldr1' függvényt, amely ugyanazt csinálja, mint a foldr,
-- csak a kezdőértéke a lista első eleme lesz.
-- Ez természetesen feltételezi, hogy a lista nem üres.
foldr1' :: (a -> a -> a) -> [a] -> a
foldr1' _ [x] = x
foldr1' f (x:xs) = f x (foldr1' f xs)
foldr1' _ [] = error "foldr1' applied to empty list"

-- Ugyanígy létezik foldl1 is.
foldl1' :: (a -> a -> a) -> [a] -> a
foldl1' f (x:xs) = foldl f x xs
foldl1' _ [] = error "foldl1' applied to empty list"

-- Ezekkel érdemes definiálni például az alábbi függvényt:
-- Definiáld a maximum' függvényt, amely egy visszaadja egy lista legnagyobb elemét.
-- Feltehető, hogy a lista nem üres és véges.
maximum' :: Ord a => [a] -> a
maximum' = foldr1' max
-- Megj.: minimum hasonlóan definiálható.

-- Létezik olyan fajta hajtogatás is, amely az egyes részeredményeket is visszaadja eredményként.
-- Ezt magyarul pásztázásnak hívjuk (bár az angol neve (scanning) sokkal értelmesebb).

-- Definiáljuk a jobbról való pásztázást!
-- scanr'' (:) [] "pásztáznivaló" == ["pásztáznivaló", "ásztáznivaló", "sztáznivaló", "ztáznivaló", "táznivaló", "áznivaló", "znivaló", "nivaló", "ivaló", "való", "aló", "ló", "ó", []]
-- scanr'' (+) 0 [1..10] == [55, 54, 52, 49, 45, 40, 34, 27, 19, 10, 0]

scanr'' :: (a -> b -> b) -> b -> [a] -> [b]
scanr'' f v [] = [v]
scanr'' f v (x:xs) = let rest = scanr'' f v xs in f x (head rest) : rest

-- Az eredeti függvény a scanr.
-- A scanr NEM MŰKÖDIK végtelen listával!

-- A scanr-ből hogyan kaphatjuk vissza a foldr műveletét?
-- Válasz:

-- Definiáljuk a balról való pásztázást!
-- scanl'' (\acc x -> x : acc) [] "pásztáznivaló" == [[], "p", "áp", "sáp", "zsáp", "tzsáp", "átzsáp", "zátzsáp", "nzátzsáp", "inzátzsáp", "vinzátzsáp", "avinzátzsáp", "lavinzátzsáp", "ólavinzátzsáp"]
-- scanl'' (+) 0 [1..10] == [0, 1, 3, 6, 10, 15, 21, 28, 36, 45, 55]
scanl'' :: (b -> a -> b) -> b -> [a] -> [b]
scanl'' f acc [] = [acc]
scanl'' f acc (x:xs) = acc : scanl'' f (f acc x) xs

-- Az eredeti függvény a scanl, de létezik scanl' is, amely a mohó változata a scanr-nek.
-- Meglepő módon a scanl működik végtelen listával!
-- A mohó változat is!

-- Magasabbrendű függvények gyakorlás

