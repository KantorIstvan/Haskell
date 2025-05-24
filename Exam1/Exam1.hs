module Exam1 where
import Data.Char (toUpper)

--1. 

sumSevens :: [Int] -> Int
sumSevens xs = sum[ x | x <- xs, x `mod` 7 == 0]

--2. 

capitalizeLast :: String -> String
capitalizeLast "" = ""
capitalizeLast [x] = [toUpper x]
capitalizeLast (x:y:xs)
 | y == ' ' = toUpper x : capitalizeLast (y:xs)
 | otherwise = x : capitalizeLast (y:xs)

--3. 

splitFive :: [Int] -> ([Int], [Int])
splitFive xs = ([x | x <- xs, x < 5],[x | x <- xs, x > 5])

--4. 

evenChars :: String -> String
evenChars xs = go 0 xs
  where
    go n "" = ""
    go n (x:xs)
      | even n = x : go (n+1) xs
      | otherwise = go (n+1) xs 

--5. 

data Shop = Grocery String Int | Clothing String String

totalProducts :: [Shop] -> Int
totalProducts xs = sum[ x | Grocery name x <- xs]