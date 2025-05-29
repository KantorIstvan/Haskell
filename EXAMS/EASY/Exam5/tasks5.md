### 5. Minta vizsga

#### 1. Számok szűrése (2 pont)

Definiálj egy függvényt, amely egy számok listáját kapja paraméterül, és visszaadja azokat a számokat, amelyek oszthatóak 3-mal és kisebbek, mint 20.

```haskell
filterThrees :: [Int] -> [Int]
```

```haskell
filterThrees [] == []
filterThrees [3, 6, 9] == [3, 6, 9]
filterThrees [1, 2, 3, 21] == [3]
filterThrees [15, 18, 20] == [15, 18]
filterThrees [4, 5, 6] == [6]
filterThrees (take 30 (cycle [4,5,6,7,8,9])) == [6,9,6,9,6,9,6,9,6,9]  -- Ciklikus lista szűrése
filterThrees [3*n | n <- [1..10]] == [3,6,9,12,15,18]  -- Az első hat 3-mal osztható szám
filterThrees (filter (<20) $ filter (\x -> x `mod` 3 == 0) [1..100]) == [3,6,9,12,15,18]
filterThrees [1..100] == [3,6,9,12,15,18]  -- Az összes megfelelő szám 1 és 100 között
filterThrees (take 50 [3,6..]) == [3,6,9,12,15,18]  -- Végtelen lista 3-mal osztható számokból
```

#### 2. Szöveg rövidítése (2 pont)

Definiálj egy függvényt, amely egy szöveget kap paraméterül, és visszaadja a szöveget úgy, hogy minden szóból csak az első karaktert tartja meg.

```haskell
shorten :: String -> String
```

```haskell
shorten "" == ""
shorten "hello" == "h"
shorten "hello world" == "hw"
shorten "fiatalok a szervezett zsongásért" == "fasz"
shorten "haskell is garbage" == "hig"
shorten (unwords (replicate 5 "hello")) == "hhhhh"  -- 5-ször ismételt "hello"
shorten (unwords $ map (\c -> [c]) "haskell") == "haskell"  -- Különálló betűk rövidítése
shorten (unwords (take 10 (repeat "hello"))) == "hhhhhhhhhh"  -- Végtelen "hello" lista első 10 eleme
shorten (unwords (take 5 (cycle ["abc", "def", "ghi"]))) == "adgad"  -- Ciklikusan ismétlődő szavak
shorten (unwords (take 6 ["word" ++ show n | n <- [1..]])) == "wwwwww"  -- Sorszámozott szavak rövidítése
shorten (unwords (take 4 (zipWith (\n c -> [c] ++ show n) [1..] (cycle "abcd")))) == "abcd"  -- Komplex szógenerálás
```

#### 3. Lista maximuma (2 pont)

Definiálj egy függvényt, amely egy számok listáját kapja paraméterül, és visszaadja a legnagyobb elemet. Ha a lista üres, adjon vissza `Nothing`-ot.

```haskell
maxNumber :: [Int] -> Maybe Int
```

```haskell
maxNumber [] == Nothing
maxNumber [1] == Just 1
maxNumber [1, 3, 2] == Just 3
maxNumber [5, 2, 8, 1] == Just 8
maxNumber [-1, -2, -3] == Just (-1)
maxNumber (map (*(-1)) [1..10]) == Just (-1)  -- Negatív számok maximuma
maxNumber [x^2 | x <- [-5..5], x /= 0] == Just 25  -- Négyzetek maximuma (kivéve 0)
maxNumber (take 100 [1..]) == Just 100  -- Végtelen lista első 100 eleme
maxNumber (take 50 (cycle [1,5,3,2])) == Just 5  -- Ciklikusan ismétlődő lista maximuma
maxNumber (take 30 [(-n) | n <- [1..]]) == Just (-1)  -- Végtelen negatív számsor maximuma
```

#### 4. Szöveg ellenőrzése (2 pont)

Definiálj egy függvényt, amely egy szöveget kap paraméterül, és eldönti, hogy minden szava legalább 3 karakter hosszú-e.

```haskell
allLong :: String -> Bool
```

```haskell
allLong "" == True
allLong "hello" == True
allLong "hi world" == False
allLong "cat dog fish" == True
allLong "a b c" == False
allLong (unwords $ map (replicate 3) ['a'..'z']) == True  -- 3 hosszú szavak az ábécéből
allLong (unwords $ filter ((>=3) . length) (words "a bb ccc dddd")) == True  -- Előszűrt 3+ karakteres szavak
allLong (unwords (take 10 (repeat "hello"))) == True  -- Végtelen "hello" lista első 10 eleme
allLong (unwords (take 5 (cycle ["abc", "defg", "hi"]))) == False  -- Ciklikus lista "hi" szóval
allLong (unwords (take 8 ["word" ++ show n | n <- [100..]])) == True  -- Számozott szavak (mind legalább 3 karakter)
allLong (unwords (take 10 (zipWith (\n s -> s ++ show n) [1..] (cycle ["test", "x"])))) == False  -- "x1", "test2" váltakozása
```

#### 5. Rendezvények (3 pont)

Definiálj egy `Event` algebrai adattípust, amely rendezvényeket reprezentál. Egy rendezvény lehet koncert (`Concert`) névvel és jegyárral, vagy előadás (`Lecture`) névvel és ingyenes-e. Definiálj egy függvényt, amely egy rendezvények listáját kapja, és visszaadja az összes jegyár összegét.

```haskell
data Event = Concert String Int | Lecture String Bool
totalCost :: [Event] -> Int
```

```haskell
totalCost [] == 0
totalCost [Concert "Rock" 5000] == 5000
totalCost [Lecture "Math" True] == 0
totalCost [Concert "Pop" 3000, Lecture "Science" False] == 3000
totalCost [Concert "Jazz" 2000, Concert "Blues" 2500] == 4500
totalCost (zipWith Concert (replicate 5 "Rock") [1000,2000..5000]) == 15000  -- 1000+2000+3000+4000+5000
totalCost ([Concert "C1" 100, Lecture "L1" True] ++ [Concert "C2" 200, Lecture "L2" False]) == 300
totalCost (take 5 [Concert ("Concert" ++ show n) (n*1000) | n <- [1..]]) == 15000  -- Végtelen lista első 5 eleme
totalCost (take 10 (cycle [Concert "Rock" 500, Lecture "Math" True])) == 2500  -- Ciklikusan ismétlődő események
totalCost (take 6 [if even n then Concert ("C" ++ show n) (n*100) else Lecture ("L" ++ show n) (n `mod` 3 == 0) | n <- [1..]]) == 1200  -- Váltakozó események
```
