module Exam1 where

import Data.Char
import Data.List
--1.

splitQuadruple :: (a,b,c,d) -> ((a,b),(c,d))
splitQuadruple (a,b,c,d) = ((a,b),(c,d))

--2.

dist1 :: Num a => a -> a -> a
dist1 x y = abs (x - y)

--3.

kroeneckerDelta :: Eq a => a -> a -> Int
kroeneckerDelta x y
 | x == y = 1
 | otherwise = 0

--4. 

freq :: Eq a => a -> [a] -> Int
freq _ [] = 0
freq e (x:xs)
  | e == x = 1 + freq e xs
  | otherwise = freq e xs

--5. 

hasUpperCase :: String -> Bool
hasUpperCase [] = False
hasUpperCase (x:xs)
  | isUpper x = True
  | otherwise = hasUpperCase xs

--6. 

identifier :: String -> Bool
identifier "" = False
identifier (x:xs)
  | not (isLetter x) || ' ' `elem` (x:xs) = False
  | otherwise = True

--7. 

replace :: Int -> a -> [a] -> [a]
replace p e xs
  | p < 0     = e : xs
  | otherwise = go p xs
  where
    go _ []     = [e]
    go 0 (_:xs) = e : xs
    go p (x:xs) = x : go (p-1) xs

-- 8. 

paripos :: [Int] -> Bool
paripos xs = check 0 xs
  where
    check :: Int -> [Int] -> Bool
    check _ [] = True
    check i (x:xs)
      | even i    = even x && check (i + 1) xs
      | otherwise = odd x && check (i + 1) xs

--9. 

safeDiv :: Int -> Int -> Maybe Int
safeDiv _ 0 = Nothing
safeDiv x y = Just (div x y)

-- 10. 
-- Ez egy gusztustalan szutyok feladat 

helper :: String -> String -> [String] -> [String]
helper current [] acc = acc ++ [current]
helper current (c:cs) acc = case c of
  ';' -> helper "" cs (acc ++ [current])
  _ -> helper (current ++ [c]) cs acc

parseCSV :: String -> [String]
parseCSV s = helper "" s []

--11. 

c :: (a -> b -> c) -> (b -> a -> c)
c f a b = f b a


--12. 

selectUnless :: (t -> Bool) -> (t -> Bool) -> [t] -> [t]
selectUnless f1 f2 [] = []
selectUnless f1 f2 (x:xs)
 | f1 x && not (f2 x) = x : selectUnless f1 f2 xs
 | otherwise = selectUnless f1 f2 xs

--13. 

w :: (a -> a -> a) -> a -> a
w f a = f a a

--14. 

ntimes :: (a -> a -> a) -> a -> Int -> a
ntimes _ e 1 = e
ntimes f e n = e `f` ntimes f e (n-1)

--15. 

data Binary = On | Off deriving (Show, Eq)

switch :: Binary -> Binary
switch On = Off
switch Off = On

--16. 

bxor :: [Binary] -> [Binary] -> [Binary]
bxor [] [] = []
bxor (x:xs) (y:ys)
 | x == y = On : bxor xs ys
 | otherwise = Off : bxor xs ys
