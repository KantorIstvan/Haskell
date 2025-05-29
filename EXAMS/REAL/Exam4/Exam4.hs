module Exam4 where
import Data.Maybe (isNothing)
import Data.List

-- 1. | Hatványozás másként

weirdoPow :: Integral a => [a] -> [a]
weirdoPow [x] = [x]
weirdoPow (x:y:xs) = x^y : weirdoPow (y:xs)

-- 2. | Elemek cseréje

replacePunctuation :: String -> Char -> String
replacePunctuation [] _ = ""
replacePunctuation (x:xs) c
 | x == ',' || x == ';' || x == '?' || x == '.' || x == '!' = c : replacePunctuation xs c
 | otherwise = x : replacePunctuation xs c

-- 3. | Átlagos szóhossz

avgWordLength :: String -> Int
avgWordLength s
  | null (words s) = 0
  | otherwise = floor (fromIntegral (countChars s `div` length (words s)))
  where
    countChars "" = 0
    countChars (x:xs)
      | x /= ' ' = 1 + countChars xs
      | otherwise = countChars xs

-- 4. | Sorszámok

indecesOfNothings :: Integral b => [Maybe a] -> [b]
indecesOfNothings xs = go 0 xs
  where
    go _ [] = []
    go n (x:xs)
     | isNothing x = n : go (n + 1) xs
     | otherwise = go (n + 1) xs

-- 5. | Sorozatok összehasonlítása

juxtapose :: Eq a => [a] -> [a] -> Maybe [a]
juxtapose [] [] = Nothing
juxtapose [] _  = Nothing
juxtapose (x:xs) (y:ys)
  | (x:xs) `isPrefixOf` (y:ys) = Nothing
  | otherwise = Just xs

-- 6. | Több függvény szerinti szűrés

strictFilter :: [a -> Bool] -> [a] -> [a]
strictFilter _ [] = []
strictFilter fs (x:xs)
  | allTrue fs x = x : strictFilter fs xs
  | otherwise    = strictFilter fs xs
  where
    allTrue [] _ = True
    allTrue (f:fs) x = f x && allTrue fs x

-- 7. | Park

data TreeType = Birch | Oak | Beech | Maple deriving (Show, Eq)

data Tree = Alive TreeType Age | Dead TreeType Age deriving (Show, Eq)

type Age = Integer

updateTreeAges :: [Tree] -> [Tree]
updateTreeAges xs = [ getTree x | x <- xs]
  where
    getTree (Alive t x) = Alive t (x + 1)
    getTree (Dead t x) = Dead t x

-- 8. | Lokális minimum 0/3

{- localMin :: Ord a => [a] -> Maybe a
localMin [] = Nothing
localMin [x] = Nothing
localMin [x,y] = Nothing
localMin (x:y:z:xs)
  | y < x && y < z = maximum (Just y : localMin (drop 1 xs))
  | otherwise = localMin (y:z:xs) -}