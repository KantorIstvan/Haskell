### 4. Minta vizsga

#### 1. Számok szorzata (2 pont)

Definiálj egy függvényt, amely egy számok listáját kapja paraméterül, és visszaadja a 5-nél nagyobb számok szorzatát. Ha nincs ilyen szám, adjon vissza 1-et.

```haskell
productOverFive :: [Int] -> Int
productOverFive [] == 1
productOverFive [1, 2, 3] == 1
productOverFive [6, 7, 8] == 336
productOverFive [4, 5, 6] == 6
productOverFive [10, 2, 15] == 150
productOverFive [x | x <- [1..20], even x && x > 5] == 464486400 -- 6*8*10*12*14*16*18*20
productOverFive (filter (>5) $ map (^2) [1..5]) == 3600  -- 9*16*25 = 3600
productOverFive (take 3 [6,7..]) == 336  -- Végtelen lista első három 6-nál nagyobb eleme
productOverFive (take 4 (filter (>5) [1..])) == 3024  -- Végtelen listából szűrt elemek
productOverFive (take 5 (cycle [3,6,9])) == 324  -- Ciklikus lista, csak a 6 és 9 számít
productOverFive (take 10 (repeat 5)) == 1  -- Csupa 5-ös, egyik sem nagyobb 5-nél
```

#### 2. Szöveg duplázása (2 pont)

Definiálj egy függvényt, amely egy szöveget kap paraméterül, és visszaadja a szöveget úgy, hogy minden szó kétszer szerepel egymás után.

```haskell
doubleWords :: String -> String
doubleWords "" == ""
doubleWords "hello" == "hello hello"
doubleWords "hello world" == "hello hello world world"
doubleWords "a b" == "a a b b"
doubleWords "haskell is fun" == "haskell haskell is is fun fun"
doubleWords (unwords (words "functional programming")) == "functional functional programming programming"
doubleWords (unwords (take 5 (repeat "hello"))) == "hello hello hello hello hello hello hello hello hello hello"
doubleWords (unwords (take 3 (zipWith (\n c -> [c] ++ show n) [1..] (cycle "abc")))) == "a1 a1 b2 b2 c3 c3"
```

#### 3. Lista párosítása (2 pont)

Definiálj egy függvényt, amely két számok listáját kapja paraméterül, és visszaadja a páronkénti összegeket tartalmazó listát. Ha a listák hossza eltér, a rövidebb lista végéig számoljon.

```haskell
pairSum :: [Int] -> [Int] -> [Int]
pairSum [] [] == []
pairSum [1, 2] [3, 4] == [4, 6]
pairSum [1, 2, 3] [4, 5] == [5, 7]
pairSum [5] [1, 2, 3] == [6]
pairSum [1..5] (take 5 [1..]) == [2,4,6,8,10]  -- Végtelen növekvő lista az első 5 eleme
pairSum (take 4 [1..]) (take 4 (repeat 10)) == [11,12,13,14]  -- Véges és végtelen lista összeadása
pairSum (take 3 (cycle [1,2,3])) [10,20..] == [11,22,33]  -- Ciklikus lista és számtani sorozat
pairSum (take 5 [n^2 | n <- [1..]]) (take 5 [1,3..]) == [2,7,14,23,34]  -- Négyzetek és páratlan számok
```

#### 4. Karakter keresése (2 pont)

Definiálj egy függvényt, amely egy karaktert és egy szöveget kap paraméterül, és visszaadja, hogy a karakter hányszor fordul elő a szövegben.

```haskell
countChar :: Char -> String -> Int
countChar 'a' "" == 0
countChar ' ' "hello world" == 1
countChar 'i' "mississippi" == 4
countChar 'p' "apple pear plum" == 4
countChar '.' "www.example.com" == 2
countChar 'a' (take 50 (cycle "abc")) == 17  -- Ciklikusan ismétlődő karakterek
countChar 'x' (take 100 (repeat 'x')) == 100  -- 100 db 'x' karakter
countChar '1' (concat (take 30 ["1" ++ replicate n '0' | n <- [0..]])) == 30  -- Számok "10", "100", "1000", stb.
```

#### 5. Diákok (3 pont)

Definiálj egy `Student` algebrai adattípust, amely diákokat reprezentál. Egy diáknak lehet neve és jegye (`Graded`), vagy csak neve (`Ungraded`). Definiálj egy függvényt, amely egy diákok listáját kapja, és visszaadja a jegyek átlagát (egész számra kerekítve). Ha nincs jegy, adjon vissza 0-t.

```haskell
data Student = Graded String Int | Ungraded String
averageGrade :: [Student] -> Int
averageGrade [] == 0
averageGrade [Ungraded "Anna"] == 0
averageGrade [Graded "Béla" 4] == 4
averageGrade [Graded "Anna" 5, Graded "Béla" 3] == 4
averageGrade [Ungraded "Kata", Ungraded "Lajos", Ungraded "Márton"] == 0
averageGrade (take 10 [Graded ("Student" ++ show n) 5 | n <- [1..]]) == 5  -- Végtelen lista csupa 5-ös jeggyel
averageGrade (take 8 (cycle [Graded "A" 4, Graded "B" 2])) == 3  -- Ciklikusan ismétlődő 4-es és 2-es jegyek
averageGrade (take 5 (zipWith (\n s -> Graded s (1 + n `mod` 5)) [1..] (cycle ["A","B","C"]))) == 3  -- Komplex lista kifejezés
```
