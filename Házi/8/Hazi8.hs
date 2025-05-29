module Hazi8 where

--1. Feladat

data Base = A | T | G | C deriving (Eq, Show)

--2. feladat

isComplement :: [Base] -> [Base] -> Bool
isComplement [] [] = True
isComplement (x:xs) (y:ys) = (x == complementBase y) && isComplement xs ys
  where
    complementBase A = T
    complementBase T = A
    complementBase C = G
    complementBase G = C
isComplement _ _ = False

--3. Feladat

data Transaction = Transfer Int Int | Purchase Int | Receive Int Int String deriving Show

--4. Feladat

netGain :: [Transaction] -> Int
netGain [] = 0
netGain (x:xs) = getValue x + netGain xs
  where
    getValue (Purchase n) = -n
    getValue (Transfer n _) = -n
    getValue (Receive n _ _) = n

--5. Feladat

wasNegative :: [Transaction] -> Bool
wasNegative xs = helper 0 xs
  where
    helper _ [] = False
    helper balance (x:xs) = (balance + getValue x < 0) || helper (balance + getValue x) xs
    getValue (Purchase n) = -n
    getValue (Transfer n _) = -n
    getValue (Receive n _ _) = n