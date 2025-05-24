### 4. Minta vizsga

#### 1. Számok négyzete (2 pont)

Definiálj egy függvényt, amely egy számok listáját kapja paraméterül, és visszaadja a 10-nél kisebb számok négyzetét tartalmazó listát.

```haskell
squareSmall :: [Int] -> [Int]
```

```haskell
squareSmall [] == []
squareSmall [1, 2, 3] == [1, 4, 9]
squareSmall [10, 5, 15] == [25]
squareSmall [4, 6, 8] == [16, 36, 64]
squareSmall [11, 12, 13] == []
```

#### 2. Szöveg megszámlálása (2 pont)

Definiálj egy függvényt, amely egy szöveget kap paraméterül, és visszaadja, hány szóból áll.

```haskell
countWords :: String -> Int
```

```haskell
countWords "" == 0
countWords "hello" == 1
countWords "hello world" == 2
countWords "a b c" == 3
countWords "haskell is fun" == 3
```

#### 3. Lista páros elemei (2 pont)

Definiálj egy függvényt, amely egy számok listáját kapja paraméterül, és visszaadja a páros indexű elemeket (az indexelés 0-tól kezdődik).

```haskell
evenIndices :: [Int] -> [Int]
```

```haskell
evenIndices [] == []
evenIndices [1] == [1]
evenIndices [1, 2, 3] == [1, 3]
evenIndices [2, 4, 6, 8] == [2, 6]
evenIndices [10, 11, 12, 13] == [10, 12]
```

#### 4. Szöveg csere (2 pont)

Definiálj egy függvényt, amely egy szöveget kap paraméterül, és minden 'a' karaktert 'e'-re cserél.

```haskell
replaceA :: String -> String
```

```haskell
replaceA "" == ""
replaceA "alma" == "elme"
replaceA "hello" == "hello"
replaceA "banana" == "benene"
replaceA "cat" == "cet"
```

#### 5. Járművek (3 pont)

Definiálj egy `Vehicle` algebrai adattípust, amely járműveket reprezentál. Egy jármű lehet autó (`Car`) típussal és sebességgel, vagy motor (`Bike`) típussal és színnel. Definiálj egy függvényt, amely egy járművek listáját kapja, és visszaadja az autók sebességének összegét.

```haskell
data Vehicle = Car String Int | Bike String String
carSpeedSum :: [Vehicle] -> Int
```

```haskell
carSpeedSum [] == 0
carSpeedSum [Car "Sedan" 120] == 120
carSpeedSum [Bike "Sport" "Red"] == 0
carSpeedSum [Car "SUV" 100, Bike "Touring" "Blue"] == 100
carSpeedSum [Car "Hatchback" 80, Car "Sedan" 120] == 200
```
