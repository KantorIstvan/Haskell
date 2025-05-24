### 5. Minta Vizsga

#### 1. Maximális szomszédos különbség (2 pont)

Definiálj egy függvényt, amely egy egész számok listáját kapja, és visszaadja a szomszédos elemek közötti maximális különbséget. Ha a lista kevesebb mint 2 elemet tartalmaz, adjon vissza 0-t.

```haskell
maxDiff :: [Int] -> Int
maxDiff [1, 3, 2, 5] == 3  -- különbségek: 2, 1, 3
maxDiff [5] == 0
maxDiff [] == 0
maxDiff [1, 2, 3, 4] == 1
```

#### 2. Első két elem (2 pont)

Definiálj egy függvényt, amely egy listát kap, és visszaadja az első két elemet egy párban `Just`-ban, vagy `Nothing`-ot, ha kevesebb mint két elem van.

```haskell
firstTwo :: [a] -> Maybe (a, a)
firstTwo [1, 2, 3] == Just (1, 2)
firstTwo [1] == Nothing
firstTwo [] == Nothing
firstTwo ['a', 'b', 'c'] == Just ('a', 'b')
```

#### 3. Listák listájának lapítása (2 pont)

Definiálj egy függvényt, amely egy listák listáját kapja, és visszaad egy egyetlen lapított listát, amely az összes elemet tartalmazza sorrendben.

```haskell
flatten :: [[a]] -> [a]
flatten [[1, 2], [3, 4], [5]] == [1, 2, 3, 4, 5]
flatten [] == []
flatten [[], [1], [2, 3]] == [1, 2, 3]
flatten [[1], [], [2]] == [1, 2]
```

#### 4. Betűk kis- és nagybetűs cseréje (2 pont)

Definiálj egy függvényt, amely egy sztringet kap, és visszaad egy új sztringet, ahol az összes kisbetű nagybetűvé, és az összes nagybetű kisbetűvé van alakítva. A nem betű karakterek változatlanok maradnak. (Tipp: Használd az `isLower`, `isUpper`, `toUpper`, `toLower` függvényeket a `Data.Char` modulból.)

```haskell
swapCase :: String -> String
swapCase "Hello World" == "hELLO wORLD"
swapCase "123 ABC" == "123 abc"
swapCase "" == ""
swapCase "HaSkElL" == "hAsKeLl"
```

#### 5. Tranzakciók (3 pont)

Definiálj egy `Transaction` algebrai adattípust a pénzügyi tranzakciók reprezentálására: egy `Deposit` összeggel, vagy egy `Withdrawal` összeggel. Ezután definiálj egy függvényt, amely egy `Transaction` listát kap és visszaadja a végső egyenleget, kezdve 0-ról.

```haskell
data Transaction = Deposit Int | Withdrawal Int
finalBalance :: [Transaction] -> Int
finalBalance [Deposit 100, Withdrawal 50, Deposit 200] == 250
finalBalance [] == 0
finalBalance [Withdrawal 100] == -100
finalBalance [Deposit 50, Withdrawal 20] == 30
```
