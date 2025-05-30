module Hazi6 where

import Data.Char

--1. Feladat

toUpperThird :: String -> String
toUpperThird [] = []
toUpperThird [x] = [x]
toUpperThird (x:y:z:xs) = x : y : toUpper z : xs
toUpperThird (x:xs) = x : xs

--2. Feladat

isSorted :: Ord a => [a] -> Bool
isSorted [] = True
isSorted [x] = True
isSorted (x:y:xs)
  | y >= x = isSorted (y:xs)
  | y < x = False

 --Előző megoldásom | y >= x = isSorted xs volt, arra is lefutott sikeresen a tesztelő, viszont hibás volt a függvény pl.: isSorted [1,2,1,2,5,6,7,8,9,10] == True

--3. Feladat

cipher :: String -> String
cipher [] = ""
cipher [x] = ""
cipher (x:y:z:xs)
  | isNumber z = [x , y]
  | otherwise = cipher (y : z : xs)
cipher _ = ""

--4. Feladat

doubleElements :: [a] -> [a]
doubleElements [] = []
doubleElements (x:xs) = x : x : doubleElements xs 

--5. Feladat

deleteDuplicateSpaces :: String -> String
deleteDuplicateSpaces [] = []
deleteDuplicateSpaces xs = unwords(words xs)