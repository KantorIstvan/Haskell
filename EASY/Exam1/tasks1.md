### 1. Minta vizsga

#### 1. Számok összege (2 pont)

Definiálj egy függvényt, amely egy számok listáját kapja paraméterül, és visszaadja a 7-tel osztható számok összegét.

```haskell
sumSevens :: [Int] -> Int
```

```haskell
sumSevens [] == 0
sumSevens [1, 2, 3] == 0
sumSevens [7, 14, 21] == 42
sumSevens [5, 7, 10] == 7
sumSevens [14, 28, 3] == 42
```

#### 2. Szöveg nagybetűsítése (2 pont)

Definiálj egy függvényt, amely egy szöveget kap paraméterül, és visszaadja a szöveget úgy, hogy minden szó utolsó karaktere nagybetűs lesz.

```haskell
capitalizeLast :: String -> String
```

```haskell
capitalizeLast "" == ""
capitalizeLast "hello" == "hellO"
capitalizeLast "hello world" == "hellO worlD"
capitalizeLast "a b" == "A B"
capitalizeLast "haskell is fun" == "haskelL iS fuN"
```

#### 3. Lista szétválasztása (2 pont)

Definiálj egy függvényt, amely egy számok listáját kapja paraméterül, és visszaad egy rendezett párt, ahol az első lista az 5-nél kisebb, a második az 5-nél nagyobb számokat tartalmazza.

```haskell
splitFive :: [Int] -> ([Int], [Int])
```

```haskell
splitFive [] == ([], [])
splitFive [1, 6, 3] == ([1, 3], [6])
splitFive [5, 2, 8] == ([2], [8])
splitFive [4, 3, 2] == ([4, 3, 2], [])
splitFive [6, 7, 8] == ([], [6, 7, 8])
```

#### 4. Szöveg páros karakterei (2 pont)

Definiálj egy függvényt, amely egy szöveget kap paraméterül, és visszaadja a páros indexű karaktereket (0-tól kezdődik az indexelés).

```haskell
evenChars :: String -> String
```

```haskell
evenChars "" == ""
evenChars "hello" == "hlo"
evenChars "alma" == "am"
evenChars "haskell" == "hsel"
evenChars "a" == "a"
```

#### 5. Üzletek (3 pont)

Definiálj egy `Shop` algebrai adattípust, amely üzleteket reprezentál. Egy üzlet lehet élelmiszerbolt (`Grocery`) névvel és termékek számával, vagy ruhabolt (`Clothing`) névvel és nyitvatartási idővel. Definiálj egy függvényt, amely egy üzletek listáját kapja, és visszaadja az élelmiszerboltokban lévő termékek teljes számát.

```haskell
data Shop = Grocery String Int | Clothing String String
totalProducts :: [Shop] -> Int
```

```haskell
totalProducts [] == 0
totalProducts [Grocery "ABC" 50] == 50
totalProducts [Clothing "Fashion" "9-18"] == 0
totalProducts [Grocery "XYZ" 30, Clothing "Style" "10-20"] == 30
totalProducts [Grocery "Big" 100, Grocery "Small" 20] == 120
```
