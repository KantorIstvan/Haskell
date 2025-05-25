module Exam3 where

--1. 

reversedTriplets :: [a] -> [b] -> [c] -> [(c, b, a)]
reversedTriplets [] [] [] = []
reversedTriplets _ _ [] = []
reversedTriplets _ [] _ = []
reversedTriplets [] _ _ = []
reversedTriplets (x:xs) (y:ys) (z:zs) = (z,y,x) : reversedTriplets xs ys zs

--2. 

byZero :: (Num a, Ord a) => [a] -> [(a,a)]
byZero [] = []
byZero (x:xs)
  | x > 0 = (0,x) : byZero xs
  | otherwise = (x,0) : byZero xs

--3. 

late :: [(Int,Int,[Int])] -> [(Int,Int,[Int])]
late [] = []
late ((line, min, lines):xss)
  | line == 100 || 100 `elem` lines = (line, min + 10, lines) : late xss
  | otherwise = (line, min, lines) : late xss

--4. 

strangeSum :: Integral a => [a] -> a
strangeSum xs = go 0 xs
  where
    go _ [] = 0
    go n (x:xs)
      | even n = (-x) + go (n+1) xs
      | otherwise = x + go (n+1) xs

--5. 

applyNTimes :: Integer -> (a -> a) -> a -> a
applyNTimes n f e
  | n <= 0    = e
  | otherwise = applyNTimes (n - 1) f (f e)

--6. 

data Arms = Sword Int | Spear Int | Bow Int deriving (Show, Eq)

data Province = Pannonia Int | Dacia Int | Italia Int | Gallia Int | Germania Int deriving (Show, Eq)

armySize :: Province -> Int
armySize x = getSize x
  where
    getSize (Pannonia x) = x
    getSize (Dacia x) = x
    getSize (Italia x) = x
    getSize (Gallia x) = x
    getSize (Germania x) = x

armsNum :: Arms -> Int
armsNum x = getAmount x
  where
    getAmount (Sword x) = x
    getAmount (Spear x) = x
    getAmount (Bow x) = x

totalArms :: [Arms] -> Int
totalArms [] = 0
totalArms (x:xs) = armsNum x + totalArms xs

deficiency :: [(Province, [Arms])] -> [(Province, Int)]
deficiency [] = []
deficiency ((prov, arms):xs)
  | totalArms arms < armySize prov = (prov, armySize prov - totalArms arms) : deficiency xs
  | otherwise = deficiency xs

--7. 
--Elképesztően alpári megoldás de működik

decimalPlaces :: (Integral a, Show a) => a -> String
decimalPlaces n 
  | n == 0 = show n
  | otherwise = deldot (reverse (dots (reverse (show n))))
    where
      dots xs = go 1 xs
        where
          go _ [x] = [x]
          go n (x:xs) -- (x:xs) == "654321-"
            | n `mod` 3 == 0 = x : '.' : go (n+1) xs
            | otherwise = x : go (n+1) xs 
      deldot [x] = [x]
      deldot (x:y:xs)
        | x == '-' && y == '.' = x:xs
        | otherwise = x:y:xs
