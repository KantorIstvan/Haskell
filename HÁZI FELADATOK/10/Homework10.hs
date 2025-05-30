module Homework10 where

import Data.Char

type Line = String
type File = [Line]

testFile0 :: File
testFile0 = ["asd  qwe", "-- Foo", "", "\thello world "]

--1. Feladat

countWordsInLine :: Line -> Int
countWordsInLine line = length (words line)

countWords :: File -> Int
countWords file = sum (map countWordsInLine file)

countChars :: File -> Int
countChars file = sum (map length file)

--2. Feladat

capitalizeWord :: String -> String
capitalizeWord [] = []
capitalizeWord (c:cs) = toUpper c : cs

capitalizeWordsInLine :: Line -> Line
capitalizeWordsInLine line = unwords (map capitalizeWord (words line))

--3. Feladat

isComment :: Line -> Bool
isComment ('-':'-':_) = True
isComment _ = False

dropComments :: File -> File
dropComments = filter (not . isComment)

numberLines :: File -> File
numberLines = zipWith (\ n line -> show n ++ ": " ++ line) [1..]

dropTrailingWhitespaces :: Line -> Line
dropTrailingWhitespaces line = reverse (dropWhile isSpace (reverse line))

replaceTab :: Int -> Char -> [Char]
replaceTab n '\t' = replicate n ' '
replaceTab _ c    = [c]

replaceTabs :: Int -> File -> File
replaceTabs n = map (concatMap (replaceTab n))