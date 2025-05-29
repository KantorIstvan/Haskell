
module Exam3 where
import Data.ByteString (sort)

--1. 

longStrings :: [String] -> [(String, Int)]
longStrings [] = []
longStrings xs = [ (x, length x) | x <- xs, length x > 3 ]

--2. 

productPositives :: [Int] -> Int
productPositives [] = 1
productPositives (x:xs)
  | x > 0 = x * productPositives xs
  | otherwise = productPositives xs

--3. 

removeDuplicates :: Eq a => [a] -> [a]
removeDuplicates [] = []
removeDuplicates (x:xs)
  | x `notElem` xs = x : removeDuplicates xs
  | otherwise = removeDuplicates xs

--4. 

diffIfGreater :: [Int] -> [Int] -> [Int]
diffIfGreater xs [] = [] 
diffIfGreater [] ys = []
diffIfGreater (x:xs) (y:ys)
  | x > y = (x-y) : diffIfGreater xs ys
  | otherwise = diffIfGreater xs ys

--5. 

data Author = Author String Int
data Book = Fiction Author String Int | NonFiction Author String String

fictionTitlesByAuthorsBornAfter :: Int -> [Book] -> [String]
fictionTitlesByAuthorsBornAfter n xs = [ title | Fiction (Author name born) title release <- xs, born > n ]