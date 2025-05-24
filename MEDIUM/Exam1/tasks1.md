### 1. Minta Vizsga

#### 1. Nevek szűrése pontszám és kezdőbetű alapján (2 pont)

Definiálj egy függvényt, amely egy (név mint `String`, pontszám mint `Int`) párok listáját, egy karaktert és egy egész szám küszöböt kap. Adja vissza azon nevek listáját, amelyek a megadott karakterrel kezdődnek és a pontszámuk legalább akkora, mint a küszöb.

```haskell
filterNames :: [(String, Int)] -> Char -> Int -> [String]
filterNames [("Alice", 85), ("Bob", 90), ("Charlie", 70)] 'A' 80 == ["Alice"]
filterNames [("David", 60), ("Eve", 95), ("Frank", 80)] 'E' 90 == ["Eve"]
filterNames [] 'A' 50 == []
filterNames [("Anna", 75), ("Amy", 95)] 'A' 80 == ["Amy"]
```

#### 2. Függvények alkalmazása páros és páratlan számokra (2 pont)

Definiálj egy függvényt, amely egy egész számok listáját és két függvényt kap: egyet a páros számokra és egyet a páratlan számokra való alkalmazásra. Adja vissza az új listát, amelyben az egyes elemekre a megfelelő függvény lett alkalmazva.

```haskell
applyEvenOdd :: [Int] -> (Int -> Int) -> (Int -> Int) -> [Int]
applyEvenOdd [1, 3, 4] (*2) (+1) == [2, 4, 8]
applyEvenOdd [] (*2) (+1) == []
applyEvenOdd [5, 7, 9] (*2) (+1) == [6, 8, 10]
applyEvenOdd [2, 4, 6] (*2) (+1) == [4, 8, 12]
```

#### 3. Két lista összefésülése (2 pont)

Definiálj egy függvényt, amely két listát kap és összefésüli az elemeiket. Ha az egyik lista hosszabb, fűzze hozzá a maradék elemeket az eredményhez.

```haskell
interleave :: [a] -> [a] -> [a]
interleave [1, 2, 3] [4, 5, 6] == [1, 4, 2, 5, 3, 6]
interleave [1, 2] [3, 4, 5, 6] == [1, 3, 2, 4, 5, 6]
interleave [] [1, 2, 3] == [1, 2, 3]
interleave [1, 2, 3] [] == [1, 2, 3]
```

#### 4. Karakterek szűrése sztringből (2 pont)

Definiálj egy függvényt, amely egy sztringet és egy karakterek listáját kapja, és visszaad egy sztringet, amely csak azokat a karaktereket tartalmazza az eredeti sztringből, amelyek a megadott listában vannak, az eredeti sorrendben.

```haskell
filterChars :: String -> [Char] -> String
filterChars "hello" ['h', 'e', 'l'] == "hell"
filterChars "abcde" ['b', 'd'] == "bd"
filterChars "12345" ['1', '3', '5'] == "135"
filterChars "" ['a'] == ""
```

#### 5. Naptári események (4 pont)

Definiálj egy CalendarEvent algebrai adattípust az események reprezentálására: egy Meeting cím (String) és időtartam (Int, percekben), egy RecurringMeeting cím (String), időtartam (Int, percekben) és ismétlések száma (Int), vagy egy Task cím (String) és prioritás (Int, 1-5). Ezután definiálj egy totalMeetingTime függvényt, amely egy CalendarEvent lista esetén visszaadja az összes meeting és recurring meeting időtartamának összegét, figyelembe véve az ismétléseket.

```haskell
totalMeetingTime :: [CalendarEvent] -> Int
```

```haskell
totalMeetingTime [] == 0
totalMeetingTime [Meeting "Team" 60] == 60
totalMeetingTime [RecurringMeeting "Weekly Sync" 30 4] == 120
totalMeetingTime [Task "Report" 3] == 0
totalMeetingTime [Meeting "Planning" 90, RecurringMeeting "Daily Standup" 15 5, Task "Email" 2] == 165
```
