module Exam2 where

--1. 

squareSmall :: [Int] -> [Int]
squareSmall xs = [x^2 | x <- xs, x < 10]

--2. 

countWords :: String -> Int
countWords xs = length (words xs)

--3. 

evenIndices :: [Int] -> [Int]
evenIndices xs = go 0 xs
  where
    go n [] = []
    go n (x:xs)
     | even n = x : go (n+1) xs
     | otherwise = go (n+1) xs

--4. 

replaceA :: String -> String
replaceA = toE
 where
  toE "" = ""
  toE (x:xs)
   | x == 'a' = 'e' : toE xs
   | otherwise = x : toE xs

--5. 

data Vehicle = Car String Int | Bike String String

carSpeedSum :: [Vehicle] -> Int
carSpeedSum xs = sum[ x | Car s x <- xs]
