module Hazi3 where

--1a. Feladat

isSingleton :: [a] -> Bool
isSingleton [] = False
isSingleton [x] = True
isSingleton _ = False

--1b. Feladat

exactly2OrAtLeast4 :: [a] -> Bool
exactly2OrAtLeast4 [] = False
exactly2OrAtLeast4 [a] = False
exactly2OrAtLeast4 [a,b] = True
exactly2OrAtLeast4 [a,b,c] = False
exactly2OrAtLeast4 _ = True


--2. Feladat

firstTwoElements :: [a] -> [a]
firstTwoElements [] = []
firstTwoElements [a] = []
firstTwoElements (x:y:xs) = [x,y]

--3. Feladat

withoutThird :: [a] -> [a]
withoutThird [] = []
withoutThird [a] = [a]
withoutThird [a,b] = [a,b]
withoutThird (x:y:z:xs) = x:y:xs

--4. Feladat

quadrupleToList :: (a,a,a,a) -> [a]
quadrupleToList (a,b,c,d) = [a,b,c,d]

--5. Feladat

insertSecond :: a -> [a] -> [a]
insertSecond elem [] = []
insertSecond elem [x] = [x,elem]
insertSecond elem (x:xs) = x:elem:xs

--6. Feladat

firstPairToList :: [(a,a)] -> [a]
firstPairToList [] = []
firstPairToList [(a,b)] = [a,b]
firstPairToList ((a,b):xs) = [a,b]
