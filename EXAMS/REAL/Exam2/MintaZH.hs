module MintaZH where

import Data.List

-- | 1. feladat Verseny

points :: Integral a => [(String, a, a)] -> [(String, a)]
points [] = []
points ((name,time,faults):contenders)
  | faults < 100 && ( calculatedPoint > 0) = (name,calculatedPoint) : points contenders
  | otherwise = points contenders
  where
    calculatedPoint = 100 - time `div` 2 - faults

-- | 2. feladat Ryuk almái

type Apple = (Bool, Int)
type Tree = [Apple]
type Garden = [Tree]

ryuksApples :: Garden -> Int
ryuksApples garden = length [ () | tree <- garden, (erett, height) <- tree, erett, height <= 3 ]

-- | 3. feladat Szöveg a szövegben

doesContain :: String -> String -> Bool
doesContain "" _ = True
doesContain _ "" = False
doesContain (x:xs) (y:ys)
  | x == y = doesContain xs ys
  | otherwise = doesContain (x:xs) ys

-- | 4. feladat Barbie
-- Ez is egy fos feladat
barbie :: [String] -> String
barbie skirts = case filter (\(i, c) -> c == "rozsaszin" || (even i && c /= "fekete")) (zip [1..] skirts) of
                    [] -> "farmer"
                    ((_, c):_) -> c

-- | 5. Első Teljesülő predikátum

firstValid :: [a -> Bool] -> a -> Maybe Int
firstValid preds x = go preds 0
  where
    go [] _ = Nothing
    go (p:ps) idx
      | p x       = Just idx
      | otherwise = go ps (idx + 1)

-- | 6. Alkalmazott szűrés

combineListsIf :: (a -> b -> Bool) -> (a -> b -> c) -> [a] -> [b] -> [c]
combineListsIf _ _ [] _ = []
combineListsIf _ _ _ [] = []
combineListsIf p f (x:xs) (y:ys)
  | p x y = f x y : combineListsIf p f xs ys
  | otherwise = combineListsIf p f xs ys

-- | 7. feladat Tömegközlekedés

data Line = Tram Integer [String] | Bus Integer [String] deriving (Show, Eq)

whichBusStop :: String -> [Line] -> [Integer]
whichBusStop _ [] = []
whichBusStop street lines = [ id | Bus id streets <- lines, street `elem` streets ]

-- | 8. Színházi helyfoglalás

isReservable :: Int -> String -> Bool
isReservable 0 _ = True
isReservable _ "" = False
isReservable seats spaces
  | freeSpaces seats `isPrefixOf` spaces = True -- True == True, bocs xd
  | otherwise = isReservable seats (drop 1 spaces)
  where
    freeSpaces :: Int -> String
    freeSpaces n = replicate n 'x'

{- isReservable :: Int -> String -> Bool
isReservable 0 _ = True
isReservable _ "" = False
isReservable n spaces = replicate n 'x' `isInfixOf` spaces -}
-- Ez a megoldás sokkal egyszerűbb, de valamiért nem az isInfixOf függvényt ajánlották 🤔

