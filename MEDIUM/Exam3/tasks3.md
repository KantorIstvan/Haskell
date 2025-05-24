### 3. Minta Vizsga

#### 1. Hosszú sztringek hosszukkal (2 pont)

Definiálj egy függvényt, amely egy sztringek listáját kapja, és visszaadja a 3-nál hosszabb sztringek (sztring, hossz) párok listáját.

```haskell
longStrings :: [String] -> [(String, Int)]
longStrings ["hi", "hello", "world", "ok"] == [("hello", 5), ("world", 5)]
longStrings ["a", "b", "c"] == []
longStrings [] == []
longStrings ["haskell", "is", "fun"] == [("haskell", 7)]
```

#### 2. Pozitív számok szorzata (2 pont)

Definiálj egy függvényt, amely egy egész számok listáját kapja, és visszaadja a pozitív számok szorzatát. Ha nincsenek pozitív számok, adjon vissza 1-et.

```haskell
productPositives :: [Int] -> Int
productPositives [1, 2, 3] == 6
productPositives [-1, 2, 3] == 6
productPositives [-1, -2, -3] == 1
productPositives [] == 1
```

#### 3. Duplikátumok eltávolítása (2 pont)

Definiálj egy függvényt, amely egy listát kap, és visszaad egy új listát, amelyből a duplikátumok eltávolításra kerültek, megőrizve az eredeti sorrendet az első előfordulások alapján. (Ne használd a `nub` könyvtári függvényt.)

```haskell
removeDuplicates :: Eq a => [a] -> [a]
removeDuplicates [1, 2, 2, 3, 4, 4, 5] == [1, 2, 3, 4, 5]
removeDuplicates "hello" == "helo"
removeDuplicates [] == []
removeDuplicates [1, 1, 1] == [1]
```

#### 4. Különbségek, ha nagyobb (2 pont)

Definiálj egy függvényt, amely két egész számok listáját kapja, és visszaadja a megfelelő elemek közötti különbségek listáját, de csak azokat a különbségeket tartalmazza, ahol az első elem nagyobb, mint a második. Álljon meg a rövidebb lista végén.

```haskell
diffIfGreater :: [Int] -> [Int] -> [Int]
diffIfGreater [5, 3, 7] [2, 4, 6] == [3, 1]  -- 5-2=3, 7-6=1
diffIfGreater [1, 2, 3] [4, 5, 6] == []  -- nincs különbség
diffIfGreater [] [1, 2, 3] == []
diffIfGreater [10, 8] [5] == [5]
```

#### 5. Könyvek (3 pont)

Definiálj egy Author algebrai adattípust a szerzők reprezentálására, amely tartalmazza a szerző nevét (egy String) és születési évét (egy Int). Ezután definiálj egy Book algebrai adattípust a könyvek reprezentálására, amely lehet:

Fiction: egy szerző (típus: Author), a könyv címe (típus: String), és a kiadás éve (típus: Int),
NonFiction: egy szerző (típus: Author), a könyv címe (típus: String), és a téma (típus: String).
Végül, definiálj egy fictionTitlesByAuthorsBornAfter függvényt, amely egy évszámot (Int) és egy Book listát ([Book]) kap, és visszaadja az összes olyan fikciós könyv címét ([String]), amelyeknek a szerzője az adott évszám után született. A címeket a listában való megjelenési sorrendben kell visszaadni.

```haskell
data Author = Author String Int
data Book = Fiction Author String Int | NonFiction Author String String
fictionTitlesByAuthorsBornAfter :: Int -> [Book] -> [String]
fictionTitlesByAuthorsBornAfter 1900 [Fiction (Author "Orwell" 1903) "1984" 1949, NonFiction (Author "Harari" 1976) "Sapiens" "History", Fiction (Author "Herbert" 1920) "Dune" 1965] == ["1984", "Dune"]
fictionTitlesByAuthorsBornAfter 2000 [] == []
fictionTitlesByAuthorsBornAfter 1800 [NonFiction (Author "Dawkins" 1941) "The Selfish Gene" "Biology"] == []
fictionTitlesByAuthorsBornAfter 1900 [Fiction (Author "Orwell" 1903) "1984" 1949, Fiction (Author "Herbert" 1920) "Dune" 1965, Fiction (Author "Dickens" 1812) "A Tale of Two Cities" 1859] == ["1984", "Dune"]
```
