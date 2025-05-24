### 4. Minta Vizsga

#### 1. Just értékek összege (2 pont)

Definiálj egy függvényt, amely egy `Maybe Int` értékek listáját kapja, és visszaadja a `Just`-ban lévő összes egész szám összegét. Hagyja figyelmen kívül a `Nothing` értékeket.

```haskell
sumJust :: [Maybe Int] -> Int
```

```haskell
sumJust [Just 1, Nothing, Just 3] == 4
sumJust [] == 0
sumJust [Nothing, Nothing] == 0
sumJust [Just 5, Just 2] == 7
```

#### 2. Páros párok szétválasztása (2 pont)

Definiálj egy függvényt, amely egy párok listáját kapja, ahol az első elem egy egész szám, és visszaad egy listapárt: az első lista a páros egész számokat tartalmazza az első elemekből, a második lista pedig a megfelelő második elemeket.

```haskell
splitEvenPairs :: [(Int, b)] -> ([Int], [b])
```

```haskell
splitEvenPairs [(2, 'a'), (3, 'b'), (4, 'c')] == ([2, 4], ['a', 'c'])
splitEvenPairs [(1, 'x'), (5, 'y')] == ([], [])
splitEvenPairs [] == ([], [])
splitEvenPairs [(6, 1)] == ([6], [1])
```

#### 3. Indexek, ahol a predikátum teljesül (2 pont)

Definiálj egy függvényt, amely egy predikátumot és egy listát kap, és visszaadja azon indexek listáját, ahol a predikátum igaz a megfelelő elemekre (az indexelés 0-tól kezdődik).

```haskell
indicesWhere :: (a -> Bool) -> [a] -> [Int]
```

```haskell
indicesWhere even [1, 2, 3, 4, 5] == [1, 3]
indicesWhere null ["a", "", "b", ""] == [1, 3]
indicesWhere (>0) [-1, 0, 1] == [2]
indicesWhere (const False) [1, 2, 3] == []
```

#### 4. Magánhangzók cseréje (2 pont)

Definiálj egy függvényt, amely egy sztringet kap, és visszaad egy új sztringet, ahol az összes magánhangzó ('a', 'e', 'i', 'o', 'u', kis- és nagybetűs) '\*' karakterrel van helyettesítve.

```haskell
replaceVowels :: String -> String
```

```haskell
replaceVowels "hello" == "h*ll*"
replaceVowels "haskell" == "h*sk*ll"
replaceVowels "xyz" == "xyz"
replaceVowels "AeIoU" == "*****"
```

#### 5. Kurzusok kreditértékkel (3 pont)

Definiálj egy Course algebrai adattípust, amely reprezentálhat egy Lecture-t névvel, hallgatók számával és kreditértékkel; egy Lab-ot névvel, felszerelések listájával [String] és kreditértékkel; vagy egy Composite kurzust, amely több Course-t foglalhat magába.

Ezután definiálj egy függvényt, amely egy Course listát kap, és visszaadja a hallgatók által összesen megszerzett kreditmennyiséget (csak a Lecture és Lab kurzusokat számolva, a Composite kurzusokat rekurzívan bontva le).

```haskell
data Course = Lecture String Int Int | Lab String [String] Int | Composite [Course]
totalCredits :: [Course] -> Int
```

```haskell
totalCredits [Lecture "Math" 100 3] == 300
totalCredits [Lab "Zabhegyezes" ["zab", "hegyezo"] 2] == 0
totalCredits [Composite [Lecture "CS" 50 4, Lab "AI Lab" ["GPU"] 2, Lecture "Stats" 30 3]] == 290
totalCredits [] == 0
totalCredits [Composite [Lecture "Bio" 20 3,Composite [Lab "Chem Lab" ["microscope"] 1,Lecture "Math" 40 5]]] == 260
```
