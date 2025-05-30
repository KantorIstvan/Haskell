module Hazi7 where

--1. Feladat

alternatingSum :: [Int] -> Int
alternatingSum xs = helper xs 0
  where
    helper [] _ = 0
    helper (x:xs) n
      | even n  = x + helper xs (n + 1)
      | otherwise = -x + helper xs (n + 1)

--2. Feladat

onlyEmpties :: [[[a]]] -> Bool
onlyEmpties [] = True
onlyEmpties (x:xs)
  | null x = onlyEmpties xs
  | allNull x = onlyEmpties xs
  | otherwise = False
    where
      allNull [] = True
      allNull (y:ys) = null y && allNull ys

--3. Feladat

changeYear :: String -> String
changeYear ('2':'0':'2':'4':xs) = '2' : '0' : '2' : '5' : changeYear xs
changeYear (x:xs) = x : changeYear xs
changeYear [] = []

--4. Feladat
{- Random nevetségesen nehéz feladat, hogy megbizonyosodjanak, hogy mindenki
AI-al csinálja a házikat xdd -}
compress :: String -> String
compress s = compress' (words s)
  where
    compress' [] = ""
    compress' xs = result
      where
        word = head xs
        (n, rest) = count word xs
        result
          | n > 1 = "("++ show n ++")" ++ word ++ next
          | otherwise = word ++ next
        next
          | null rest = ""
          | otherwise = " " ++ compress' rest
    count _ [] = (0, [])
    count w (x:xs)
      | w == x = (n + 1, rest)
      | otherwise = (0, x : xs)
      where
        (n, rest) = count w xs 