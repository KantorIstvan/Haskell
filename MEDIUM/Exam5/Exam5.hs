module Exam5 where
import Data.Char


--1.

maxDiff :: [Int] -> Int
maxDiff [] = 0
maxDiff [x] = 0
maxDiff xs = maximum (diffs xs)
  where
    diffs [] = []
    diffs [x] = []
    diffs (x:y:xs) = abs(x-y) : diffs (y:xs)

--2. 

firstTwo :: [a] -> Maybe (a, a)
firstTwo [] = Nothing
firstTwo [x] = Nothing
firstTwo (x:y:xs) = Just (x , y)

--3. 

flatten :: [[a]] -> [a]
flatten xss = [ x | xs <- xss, x <- xs]

--4. 

swapCase :: String -> String
swapCase "" = ""
swapCase (x:xs)
  | isLetter x && isLower x = toUpper x : swapCase xs
  | isLetter x && isUpper x = toLower x : swapCase xs
  | isSpace x = ' ' : swapCase xs
  | otherwise = x : swapCase xs

--5. 

data Transaction = Deposit Int | Withdrawal Int

finalBalance :: [Transaction] -> Int
finalBalance [] = 0
finalBalance (x:xs) = getTrans x + finalBalance xs
  where
    getTrans (Deposit x) = x
    getTrans (Withdrawal x) = -x
