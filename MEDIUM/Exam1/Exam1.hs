module Exam1 where

--1. 

filterNames :: [(String, Int)] -> Char -> Int -> [String]
filterNames xs c n = [x | (x,y) <- xs, head x == c, n < y]

--2. 

applyEvenOdd :: [Int] -> (Int -> Int) -> (Int -> Int) -> [Int]
applyEvenOdd [] _ _ = []
applyEvenOdd (x:xs) f1 f2
  | even x = f1 x : applyEvenOdd xs f1 f2
  | otherwise = f2 x : applyEvenOdd xs f1 f2

--3. 

interleave :: [a] -> [a] -> [a]
interleave xs [] = xs
interleave [] ys = ys
interleave (x:xs) (y:ys) = x : y : interleave xs ys

--4. 

filterChars :: String -> [Char] -> String
filterChars "" _ = ""
filterChars _ [] = []
filterChars (c:xs) ys
 | c `elem` ys = c : filterChars xs ys
 | otherwise = filterChars xs ys

--5. 

data CalendarEvent = Meeting String Int | RecurringMeeting String Int Int | Task String Int

totalMeetingTime :: [CalendarEvent] -> Int
totalMeetingTime [] = 0
totalMeetingTime xs = sum[ x | Meeting s x <- xs] + sum[ x*y | RecurringMeeting s x y <- xs ]