### 3. Minta vizsga

#### 1. Páros számok megszorzása (2 pont)

Definiálj egy függvényt, amely egy számok listáját kapja paraméterül, és visszaadja a páros számok kétszeresét tartalmazó listát. Ha nincs páros szám, üres listát adjon vissza.

```haskell
doubleEvens :: [Int] -> [Int]
doubleEvens [] == []
doubleEvens [1, 3, 5] == []
doubleEvens [2, 4, 6] == [4, 8, 12]
doubleEvens [1, 2, 3, 4] == [4, 8]
doubleEvens [10, 11, 12, 13] == [20, 24]
(doubleEvens [2*n | n <- [1..5]]) == [4,8,12,16,20]  -- Az első 5 páros szám duplázása
(doubleEvens $ filter even [1..20]) == [4,8,12,16,20,24,28,32,36,40]  -- 1-20 közötti páros számok duplázása
(doubleEvens $ take 5 [2,4..]) == [4,8,12,16,20]  -- Végtelen páros számok listájának első 5 eleme
(doubleEvens $ take 4 (cycle [1,2,3,4])) == [4,8]  -- Ciklikusan ismétlődő lista páros elemei duplázva
(doubleEvens $ take 8 (repeat 2)) == [4,4,4,4,4,4,4,4]  -- 8 db 2-es szám duplázva
```

#### 2. Szavak hossza (2 pont)

Definiálj egy függvényt, amely egy szöveget kap paraméterül, és visszaadja a szavak hosszát tartalmazó listát. A szavakat szóközök választják el.

```haskell
wordLengths :: String -> [Int]
wordLengths "" == []
wordLengths "hello" == [5]
wordLengths "hello world" == [5, 5]
wordLengths "a bb ccc" == [1, 2, 3]
wordLengths "haskell is fun" == [7, 2, 3]
(wordLengths $ unwords ["a", "bb", "ccc", "dddd"]) == [1,2,3,4]  -- Növekvő hosszú szavak
(wordLengths $ unwords (replicate 5 "hello")) == [5,5,5,5,5]  -- 5-ször ismételt "hello"
(wordLengths $ unwords (take 5 (repeat "hello"))) == [5,5,5,5,5]  -- Végtelen "hello" lista első 5 eleme
(wordLengths $ unwords (take 6 (cycle ["a", "bb", "ccc"]))) == [1,2,3,1,2,3]  -- Ciklikusan ismétlődő szavak
(wordLengths $ unwords (take 4 ["a" ++ replicate n 'b' | n <- [1..]])) == [2,3,4,5]  -- Növekvő hosszú szavak
```

#### 3. Lista szétválogatása (2 pont)

Definiálj egy függvényt, amely egy számok listáját kapja paraméterül, és visszaad egy rendezett párt, ahol az első lista a pozitív számokat, a második pedig a negatív számokat tartalmazza, rendezett sorrendben.

```haskell
splitPosNeg :: [Int] -> ([Int], [Int])
splitPosNeg [] == ([], [])
splitPosNeg [1, -2, 3, -4] == ([1, 3], [-4, -2])
splitPosNeg [-1, -2, -3] == ([], [-3, -2, -1])
splitPosNeg [1, 2, 3] == ([1, 2, 3], [])
splitPosNeg [0, -1, 2] == ([2], [-1])
(splitPosNeg $ take 6 (cycle [1,-2,3])) == ([1,1,3,3],[-2,-2])  -- Ciklikusan ismétlődő pozitív/negatív számok
(splitPosNeg $ take 8 (zipWith (*) [1..] (cycle [1,-1]))) == ([1,3,5,7],[-8,-6,-4,-2])  -- Váltakozó előjelű sorszámok
(splitPosNeg $ take 5 [n^2 * signum n | n <- cycle [1..3] ++ cycle [-1,-2]]) == ([1,1,4,4,9],[])  -- Komplex lista kifejezés
```

#### 4. Szöveg visszafordítása (2 pont)

Definiálj egy függvényt, amely egy szöveget kap paraméterül, és visszaadja a szöveg szavait fordított sorrendben, de a szavakon belüli karakterek sorrendje nem változik.

```haskell
reverseWords :: String -> String
reverseWords "" == ""
reverseWords "hello" == "hello"
reverseWords "hello world" == "world hello"
reverseWords "a b c" == "c b a"
reverseWords "haskell is fun" == "fun is haskell"
(reverseWords $ unwords ["first", "second", "third"]) == "third second first"  -- Lista megfordítása
(reverseWords $ unwords (reverse (words "hello world"))) == "hello world"  -- Már megfordított lista
(reverseWords $ unwords (take 5 (repeat "same"))) == "same same same same same"  -- 5 azonos szó megfordítva is ugyanaz
(reverseWords $ unwords (take 4 ["word" ++ show n | n <- [1..]])) == "word4 word3 word2 word1"  -- Sorszámozott szavak megfordítva
(reverseWords $ unwords (take 5 (cycle ["a","b","c"]))) == "b a c b a"  -- Ciklikus szólista megfordítva
```

#### 5. Könyvtár (3 pont)

Definiálj egy `Book` algebrai adattípust, amely könyveket reprezentál. Egy könyvnek lehet címe és szerzője (`SimpleBook`), vagy címe, szerzője és kiadási éve (`DetailedBook`). Ezután definiálj egy függvényt, amely egy könyvek listáját kapja, és visszaadja azoknak a címét, amelyeknek ismert a kiadási éve.

```haskell
data Book = SimpleBook String String | DetailedBook String String Int
getDetailedTitles :: [Book] -> [String]
getDetailedTitles [] == []
getDetailedTitles [SimpleBook "Cím1" "Szerző1"] == []
getDetailedTitles [DetailedBook "Cím2" "Szerző2" 2020] == ["Cím2"]
getDetailedTitles [SimpleBook "Cím1" "Szerző1", DetailedBook "Cím2" "Szerző2" 2020] == ["Cím2"]
getDetailedTitles [DetailedBook "Cím1" "Szerző1" 2019, DetailedBook "Cím2" "Szerző2" 2020] == ["Cím1", "Cím2"]
(getDetailedTitles $ zipWith (\t y -> DetailedBook t "Author" y) ["Book" ++ show n | n <- [1..5]] [2000..2004]) == ["Book1","Book2","Book3","Book4","Book5"]
(getDetailedTitles $ take 5 [DetailedBook ("Book" ++ show n) "Author" (2000+n) | n <- [1..]]) == ["Book1","Book2","Book3","Book4","Book5"]
(getDetailedTitles $ take 4 (cycle [SimpleBook "S1" "A1", DetailedBook "D1" "A1" 2020])) == ["D1","D1"]
```
