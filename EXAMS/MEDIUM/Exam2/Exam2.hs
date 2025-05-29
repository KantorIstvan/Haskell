module Exam2 where
import Data.Char (toUpper)

--1. 

sumEvenSquares :: [Int] -> Int
sumEvenSquares xs = sum [ x ^ 2 | x <- xs, even x]

--2. 

capitalizeWords :: String -> String
capitalizeWords s = unwords (upFirsts (words s))
  where
    upFirsts [] = []
    upFirsts (x:xs) = (toUpper (head x) : tail x) : upFirsts xs

--3. 

cumulativeSum :: [Int] -> [Int]
cumulativeSum = go 0
  where
    go _ []     = []
    go n (x:xs) = (n + x) : go (n + x) xs

--4. 

applyAll :: [a -> b] -> a -> [b]
applyAll [] _ = []
applyAll (f:fs) x = f x : applyAll fs x

--5. 

data Animal = Dog String Int String [String] | Cat String String [String] deriving (Show, Eq)

oldVaccinatedDogsNames :: [Animal] -> Int -> String -> [String]
oldVaccinatedDogsNames xs n vacc = [ name | Dog name age breed vaccines <- xs, age > n, vacc `elem` vaccines ] 
