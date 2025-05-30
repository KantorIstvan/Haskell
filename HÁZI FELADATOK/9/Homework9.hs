module Homework9 where

--1. Feladat

type Rank = Int

data Suit = He | Di | Cl | Sp deriving Eq

data Card = C Suit Rank deriving Eq

--2. Feladat

pair :: Card -> Card -> Bool
pair (C _ r1) (C _ r2) = r1 == r2

--3. Feladat

flush :: [Card] -> Bool
flush [] = True
flush (c:cs) = checkSuit (suit c) cs
  where
    checkSuit _ [] = True
    checkSuit s (x:xs) = (s == suit x) && checkSuit s xs

    suit (C s _) = s

--4. Feladat

search :: (Suit, Rank) -> [Card] -> Maybe Card
search _ [] = Nothing
search (s, r) (c@(C s' r') : cs)
  | s == s' && r == r' = Just c
  | otherwise = search (s, r) cs