### 2. Minta Vizsga

#### 1. Páros számok négyzeteinek összege (2 pont)

Definiálj egy függvényt, amely egy egész számok listáját kapja, és visszaadja a páros számok négyzeteinek összegét.

```haskell
sumEvenSquares :: [Int] -> Int
```

```haskell
sumEvenSquares [] == 0
sumEvenSquares [1, 2, 3, 4] == 20  -- 2^2 + 4^2 = 20
sumEvenSquares [2, 4, 6] == 56  -- 2^2 + 4^2 + 6^2 = 56
sumEvenSquares [1, 3, 5] == 0
```

#### 2. Szavak nagybetűsítése (2 pont)

Definiálj egy függvényt, amely egy sztringet kap, és visszaad egy új sztringet, ahol minden szó első betűje nagybetűs. A szavakat szóközök választják el. (Tipp: Használd a `toUpper` függvényt a `Data.Char` modulból.)

```haskell
capitalizeWords :: String -> String
```

```haskell
capitalizeWords "hello world" == "Hello World"
capitalizeWords "a b c" == "A B C"
capitalizeWords "haskell" == "Haskell"
capitalizeWords "" == ""
```

#### 3. Kumulatív összeg (2 pont)

Definiálj egy függvényt, amely egy egész számok listáját kapja, és visszaadja a kumulatív összegek listáját (minden elem az addigi elemek összegét tartalmazza, beleértve önmagát).

```haskell
cumulativeSum :: [Int] -> [Int]
```

```haskell
cumulativeSum [] == []
cumulativeSum [1] == [1]
cumulativeSum [1, 2, 3] == [1, 3, 6]
cumulativeSum [4, 2, 1] == [4, 6, 7]
```

#### 4. Minden függvény alkalmazása (2 pont)

Definiálj egy függvényt, amely egy függvények listáját (típus: `a -> b`) és egy `a` típusú értéket kap, és visszaadja az összes függvény alkalmazásának eredményét az adott értéken.

```haskell
applyAll :: [a -> b] -> a -> [b]
```

```haskell
applyAll [(+1), (*2)] 3 == [4, 6]
applyAll [length, sum] [1, 2, 3] == [3, 6]
applyAll [] 5 == []
applyAll [(^2), (+3)] 4 == [16, 7]
```

#### 5. Állatok (3 pont)

Definiálj egy Animal algebrai adattípust az állatok reprezentálására. Egy Dog tartalmazzon egy nevet (String), egy életkort (Int), egy fajtát (String) és egy listát az oltásairól ([String]). Egy Cat tartalmazzon egy nevet (String), egy színt (String) és egy listát a kedvenc játékairól ([String]).

Ezután definiálj egy oldVaccinatedDogNames nevű függvényt, amely egy Animal listát, egy korhatárt (Int) és egy oltás nevét (String) kap paraméterül. A függvény adja vissza azoknak a kutyáknak a neveit, amelyek idősebbek a megadott korhatárnál, és rendelkeznek a megadott oltással.

```haskell
data Animal = Dog String Int String [String] | Cat String String [String]
oldVaccinatedDogsNames :: [Animal] -> Int -> String -> [String]
```

```haskell
oldVaccinatedDogsNames[ Dog "Rex" 5 "Labrador" ["Rabies", "Distemper"], Cat "Whiskers" "Black" ["Ball"], Dog "Buddy" 3 "Beagle" ["Rabies"]] 4 "Rabies" == ["Rex"]
oldVaccinatedDogsNames [] 10 "Rabies" == []
oldVaccinatedDogsNames[ Cat "Mittens" "White" ["Laser Pointer"], Cat "Snowball" "Gray" ["Feather"]] 5 "Rabies" == []
oldVaccinatedDogsNames[ Dog "Max" 7 "Shepherd" ["Rabies"], Dog "Luna" 2 "Poodle" ["Rabies"]] 5 "Rabies" == ["Max"]
oldVaccinatedDogsNames [ Dog "Fido" 6 "Bulldog" ["Distemper"], Dog "Bolt" 8 "Husky" ["Rabies", "Distemper"]] 5 "Distemper" == ["Fido", "Bolt"]
```
