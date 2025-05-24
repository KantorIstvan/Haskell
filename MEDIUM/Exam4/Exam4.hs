module Exam4 where

--1. 

sumJust :: [Maybe Int] -> Int
sumJust [] = 0
sumJust xs = sum[ x | Just x <- xs]

--2. 

splitEvenPairs :: [(Int, b)] -> ([Int], [b])
splitEvenPairs xs = ([ x | (x,y) <- xs, even x], [y | (x,y) <- xs, even x])

--3. 

indicesWhere :: (a -> Bool) -> [a] -> [Int]
indicesWhere f xs = go 0 xs
  where
    go _ [] = []
    go n (x:xs)
      | f x = n : go (n+1) xs
      | otherwise = go (n+1) xs

--4. 

replaceVowels :: String -> String
replaceVowels (x:xs)
 | x `elem` ['a','e','i','o','u'] || x `elem` ['A','E','I','O','U'] = '*' : replaceVowels xs
 | otherwise = x : replaceVowels xs

--5. 

data Course = Lecture String Int Int | Lab String [String] Int | Composite [Course]

courseCredits :: Course -> Int
courseCredits (Lecture _ students credits) = students * credits
courseCredits (Lab _ _ _) = 0
courseCredits (Composite courses) = totalCredits courses

totalCredits :: [Course] -> Int
totalCredits [] = 0
totalCredits (x:xs) = courseCredits x + totalCredits xs
